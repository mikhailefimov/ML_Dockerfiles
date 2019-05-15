#!/usr/bin/env bash
JUPYTER_PORT=8888
(sleep 5 && xdg-open http://127.0.0.1:${JUPYTER_PORT}) &
docker run --runtime nvidia --rm -it -p ${JUPYTER_PORT}:8888  -v $(pwd):/notebooks emm/jupyter