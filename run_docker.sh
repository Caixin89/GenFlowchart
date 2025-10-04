#!/bin/bash

docker run \
    --rm \
    -d \
    --env-file .env \
    -v "$PWD/Patent Images":"/home/zhengxin.chai/GenFlowchart/Patent Images" \
    -v "$PWD/patent pdfs":"/home/zhengxin.chai/GenFlowchart/patent pdfs" \
    -v "$PWD/Flowchart Data.xlsx":"/home/zhengxin.chai/GenFlowchart/Flowchart Data.xlsx" \
    -v $PWD/GenFlowchart.ipynb:/home/zhengxin.chai/GenFlowchart/GenFlowchart.ipynb \
    -v $PWD/outputs:/home/zhengxin.chai/GenFlowchart/outputs \
    -p 8888:8888 \
    --gpus all \
    genflowchart
