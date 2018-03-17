#!/bin/bash

datadir=data/twitter

function exprand {
    python -c "import random;print('%1.2E'%(10**random.uniform($1, $2)))"
}

if false; then
    echo "lang time"
    for i in $(seq 1 20); do
        learningrate=$(exprand -5 -2)
        decay=$(exprand -6 -3)
        l2=$(exprand -6 -3)
        cmd="--data=$datadir/ --input lang time --full 256 256 --output loc pos country  --learningrate=$learningrate --l2=$l2 --decay=$decay"
        ./submit.sh cpu lt $cmd
    done

    echo "lang time bow"
    for i in $(seq 1 20); do
        learningrate=$(exprand -5 -2)
        decay=$(exprand -6 -3)
        l2=$(exprand -6 -3)
        l1=$(exprand -6 -2)
        cmd="--data=$datadir/ --input lang time bow --full 256 256 --output loc pos country  --learningrate=$learningrate --l2=$l2 --l1=$l1 --decay=$decay"
        ./submit.sh cpu ltb $cmd
        ./submit.sh cpu ltb $cmd --bow_hashsize=18 --bow_layersize=8
    done
fi

if false; then
    echo "lang"
    for i in $(seq 1 10); do
        learningrate=$(exprand -5 0)
        cmd="--data=$datadir/ --input lang --output loc pos country  --learningrate=$learningrate"
        ./submit.sh cpu l $cmd
    done

    echo "time"
    for i in $(seq 1 10); do
        learningrate=$(exprand -5 0)
        cmd="--data=$datadir/ --input time --output loc pos country  --learningrate=$learningrate"
        ./submit.sh cpu t $cmd
    done
fi


if false; then
    name='ltb20'
    for i in $(seq 1 20); do
        learningrate=$(exprand -3 -1)
        decay=$(exprand -6 -3)
        l2=$(exprand -6 -3)
        l1=$(exprand -6 -2)
        cmd="--data=$datadir/ --input lang time bow --learningrate=$learningrate --l2=$l2 --l1=$l1 --decay=$decay --bow_hashsize=20 --bow_layersize=128"
        ./submit.sh cpu $name $cmd
    done
fi

if true; then
    name='ltbc'
    echo $name
    for i in $(seq 1 1); do
        learningrate=$(exprand -4 -2)
        decay=$(exprand -6 -3)
        l2=$(exprand -6 -3)
        l1=$(exprand -6 -2)
        seed=$RANDOM
        cmd="--data=$datadir/ --input lang time cnn --cnn_type=vdcnn --full 2048 2048 --learningrate=$learningrate --l2=$l2 --l1=$l1 --decay=$decay --vdcnn_resnet "
        #cmd="--data=$datadir/ --input lang time cnn --cnn_type=cltcc --full 2048 2048 --learningrate=6.30E-04 --l2=9.05E-06 --l1=6.70E-06 --decay=3.18E-05"
        ./submit.sh gpu $name $cmd
    done
fi
