#!/usr/bin/env python
# -*- coding: utf-8 -*-
import logging
import sys
import os
import heapq
import time
import threading
import re
import numpy
import scipy.spatial.distance 
from numpy import linalg as LA
from sklearn.cluster import KMeans

try:
    from queue import Queue
except ImportError:
    from Queue import Queue

from numpy import exp, dot, zeros, outer, random, dtype, get_include, float32 as REAL,\
    uint32, seterr, array, uint8, vstack, argsort, fromstring, sqrt, newaxis, ndarray, empty

logger = logging.getLogger("gensim.models.word2vec")

from gensim import utils, matutils  # utility fnc for pickling, common scipy operations etc
from gensim._six import iteritems, itervalues, string_types
from gensim._six.moves import xrange
from gensim.models.word2vec import Word2Vec  

def alignmentSimilarity(words1, words2, model):
    scores = []
    while len(words1) != 0 and len(words2) != 0:
	for word1 in words1:
	    maxScore = 0
	    maxWord = None
	    for word2 in words2:
		tempScore = 0.0
		try:
		    tempScore = model.similarity(word1, word2) 
		except:
		    tempScore = 0.0
		if (tempScore > maxScore):
		    maxWord = word2
		    maxScore = tempScore
	    words1.remove(word1)
	    if (maxWord != None):
		words2.remove(maxWord)
	    scores.append(maxScore)

    sum = 0
    scores = sorted(scores, reverse=True)
    for i in range(0, len(scores)):
	sum += scores[i]
	if (i > 1 and i > 0.2*len(scores)):
	    sum = sum / i
	    break

    return sum
	
def vectorSumSimilarity(words1, words2, model):
    words1 = removeStopWords(words1)
    words2 = removeStopWords(words2)

    vector1 = numpy.zeros(300);
    vector2 = numpy.zeros(300);

    for word1 in words1:
        try:
            tempVector = model[word1]
            vector1 += tempVector
        except:
            continue

    for word2 in words2:
        try:
            tempVector = model[word2]
            vector2 += tempVector
        except:
            continue

    if (LA.norm(vector1) == 0):
        vector1 = numpy.ones(300)
    if (LA.norm(vector2) == 0):
        vector2 = numpy.ones(300)

    return 1- (scipy.spatial.distance.cosine(vector1, vector2))

# This funtion is taking a list of words and find the centroids of those words,
# Reoresent words and centroid by vectors.
def clusterText(words, n_cluster, model):
    words_vector = []
    for word in words:
        try:
            tempVector = model[word]
            words_vector.append(tempVector) 
        except:
            continue

    words_vector = numpy.array(words_vector)

    if (n_cluster > len(words_vector)):
        n_cluster = len(words_vector)

    # create knn model
    knnModel = KMeans(init='k-means++', n_clusters= n_cluster, n_init=10)
    knnModel.fit(words_vector)
    centroids = knnModel.cluster_centers_

    return centroids

def removeStopWords(inputWords):
    stopwordFile = open("stopwords2").read()
    stopwords = stopwordFile.split("\n")
    outputWords = []
    for word in inputWords:
        if word not in stopwords:
            outputWords.append(word)

    return outputWords


def clusterSimilarity1(words1, words2, model, clusterNumber):
    words1 = removeStopWords(words1)
    words2 = removeStopWords(words2)

    try:
        centroids = clusterText(words1,clusterNumber,model)
    except:
        return 0

    scores = []
    for centroid in centroids:
        maxScore = 0.0
        for word2 in words2:
            try:
                tempVector = model[word2]
                tempScore = 1- (scipy.spatial.distance.cosine(centroid, tempVector))
                if tempScore > maxScore:
                    maxScore = tempScore
            except:
                continue
        scores.append(maxScore)
    
    sum = 0.0
    for score in scores:
        sum += score

    return sum/len(scores)

def clusterSimilarity2(words1, words2, model, clusterNumber):
    words1 = removeStopWords(words1)
    words2 = removeStopWords(words2)

    try:
        centroids = clusterText(words2,clusterNumber,model)
    except:
        return 0

    scores = []
    for centroid in centroids:
        maxScore = 0.0
        for word1 in words1:
            try:
                tempVector = model[word1]
                tempScore = 1- (scipy.spatial.distance.cosine(centroid, tempVector))
                if tempScore > maxScore:
                    maxScore = tempScore
            except:
                continue
        scores.append(maxScore)
    
    sum = 0.0
    for score in scores:
        sum += score

    return sum/len(scores)


if __name__ == "__main__":

    # check and process cmdline input
    program = os.path.basename(sys.argv[0])
    if len(sys.argv) < 2:
	print "please specify 1. vector file 2. input file 3.algorithm 4.output file 5 cluster number (optional)"
        sys.exit(1)
    infile = sys.argv[1]
    inputFile = sys.argv[2]
    algorithm = int(sys.argv[3])
    outputFile = sys.argv[4]

    seterr(all='raise')  # don't ignore numpy errors

    model = Word2Vec.load_word2vec_format(infile, binary=True)

    inputfile = open(inputFile).read()
    testSet = inputfile.split("\n")

    results = [];
    for testString in testSet:
        if (testString==""):
            continue
        words1 = testString.split("\t")[0]
        words2 = testString.split("\t")[1]

        if (algorithm == 1):
            results.append(alignmentSimilarity(re.split('\W+', words1), re.split('\W+', words2), model))
        elif (algorithm == 2):
            results.append(vectorSumSimilarity(re.split('\W+', words1), re.split('\W+', words2), model))
        elif (algorithm == 3):
            clusterNumber = int(sys.argv[5])
            results.append(clusterSimilarity1(re.split('\W+', words1), re.split('\W+', words2), model, clusterNumber))
        elif (algorithm == 4):
            clusterNumber = int(sys.argv[5])
            results.append(clusterSimilarity2(re.split('\W+', words1), re.split('\W+', words2), model, clusterNumber))




    output = open(outputFile, "w")
    for result in results:
        output.write(str(result) + "\n")

