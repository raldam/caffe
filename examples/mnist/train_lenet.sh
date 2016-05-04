#!/usr/bin/env sh

# change the following numbers
# batch should also change lenet_train_test.prototxt
# gpu should change the two simutanously
# L should also change in lenet_solver.prototxt

batch_size="64"
gpuids="0,1,2,3"
ngpu="4"
L="3"

COMM="50"

outnamebase="yang/batch"$batch_size"_L"$L"_GPU"$ngpu"_COMM"$COMM
echo $outnamebase

./build/tools/caffe train --communication_cost $COMM \
    --solver=examples/mnist/lenet_solver.prototxt --gpu $gpuids 2>&1 | tee $outnamebase".log"

cat $outnamebase".log" | grep "Test .* loss" > $outnamebase".testloss"
