#!/usr/bin/env bash
set -eu
docker build -t kasperskytte/asmc-prediction .
docker run -it --gpus all --rm -v $(realpath .):/tf -u $(id -u):$(id -g) kasperskytte/asmc-prediction python main.py
