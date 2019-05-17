#!/usr/bin/env bash
JUPYTER_PORT=8888
TOKEN=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 48)
(sleep 5 && xdg-open http://127.0.0.1:${JUPYTER_PORT}?token=${TOKEN}) &
docker run --runtime nvidia --rm -it -p ${JUPYTER_PORT}:8888 --user "$(id -u)" --group-add users -v $(pwd):/home/jovyan/work emm/jupyter start-notebook.sh  --notebook-dir=/home/jovyan/work --no-browser --NotebookApp.token="'${TOKEN}'"