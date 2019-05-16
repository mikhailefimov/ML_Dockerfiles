#!/usr/bin/env bash
JUPYTER_PORT=8888
TOKEN=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 48)
(sleep 5 && xdg-open http://127.0.0.1:${JUPYTER_PORT}?token=${TOKEN}) &
docker run --runtime nvidia --rm -it -p ${JUPYTER_PORT}:8888  -v $(pwd):/notebooks emm/jupyter jupyter notebook --notebook-dir=/notebooks --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token="'${TOKEN}'"