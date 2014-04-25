echo hello world

max=20
for i in `seq 3 $max`
do
    echo "$i" >> test
    nohup python word2vec.py GoogleNews-vectors-negative300.bin input/input.training.phrase2word.description_description 3 temp3 "$i"
    nohup java -jar ~/project/outputs_bk/task-3-scorer.jar /home/chenditc/project/SemEval-2014_Task-3-2/keys/training/phrase2word.train.gs.tsv temp3 >> test3
done
