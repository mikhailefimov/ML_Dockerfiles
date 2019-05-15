#!/usr/bin/env bash
(sleep 5 && xdg-open http://127.0.0.1:8888) &
docker run --runtime nvidia --rm -it -p 8888:8888 -v $(pwd):/notebooks emm/jupyter