#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.images.txt 1 output.images.WTV1.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.images.txt 2 output.images.WTV2.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.OnWN.txt 1 output.OnWN.WTV1.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.OnWN.txt 2 output.OnWN.WTV2.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.tweet-news.txt 1 output.tweet-news.WTV1.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.tweet-news.txt 2 output.tweet-news.WTV2.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 1 output.deft-forum.WTV1.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 2 output.deft-forum.WTV2.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 1 output.headlines.WTV1.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 2 output.headlines.WTV2.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 1 output.deft-news.WTV1.txt &
#  nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 2 output.deft-news.WTV2.txt &

max=20
for i in `seq 3 $max`
do
    echo "$i" >> test

    echo "images" >> test
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.images.txt 3 output.images.WTV1.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.images.txt output.images.WTV1.txt >> test
    
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.images.txt 4 output.images.WTV2.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.images.txt output.images.WTV2.txt >> test

    echo "OnWn" >> test    
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.OnWN.txt 3 output.OnWN.WTV1.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.OnWN.txt output.OnWN.WTV1.txt >> test
    
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.OnWN.txt 4 output.OnWN.WTV2.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.OnWN.txt output.OnWN.WTV2.txt >> test
    
    echo "tweet-news" >> test
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.tweet-news.txt 3 output.tweet-news.WTV1.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.tweet-news.txt output.tweet-news.WTV1.txt >> test
    
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.tweet-news.txt 4 output.tweet-news.WTV2.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.tweet-news.txt output.tweet-news.WTV2.txt >> test
    
    echo "deft-forum" >> test
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 3 output.deft-forum.WTV1.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.deft-forum.txt output.deft-forum.WTV1.txt >> test
    
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-forum.txt 4 output.deft-forum.WTV2.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.deft-forum.txt output.deft-forum.WTV2.txt >> test
    
    echo "headlines" >> test
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.headlines.txt 3 output.headlines.WTV1.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.headlines.txt output.headlines.WTV1.txt >> test
    
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.headlines.txt 4 output.headlines.WTV2.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.headlines.txt output.headlines.WTV2.txt >> test
    
    echo "deft-news" >> test
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-news.txt 3 output.deft-news.WTV1.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.deft-news.txt output.deft-news.WTV1.txt >> test
    
    nohup python word2vec.py ../GoogleNews-vectors-negative300.bin sts-en-test-gs-2014/STS.input.deft-news.txt 4 output.deft-news.WTV2.txt "$i" 
    nohup perl sts-en-test-gs-2014/correlation-noconfidence.pl sts-en-test-gs-2014/STS.gs.deft-news.txt output.deft-news.WTV2.txt >> test
    
done


