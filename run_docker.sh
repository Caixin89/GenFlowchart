#!/bin/zsh

docker run \
    -v "$PWD/Patent Images":"/home/zhengxin.chai/GenFlowchart/Patent Images" \
    -v "$PWD/patent pdfs":"/home/zhengxin.chai/GenFlowchart/patent pdfs" \
    -v $PWD/GenFlowchart.ipynb:/home/zhengxin.chai/GenFlowchart/GenFlowchart.ipynb \
    -p 8888:8888 \
    genflowchart