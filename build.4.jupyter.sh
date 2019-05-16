#!/bin/bash
cp wheels/*.whl jupyter
chmod 777 jupyter/*.whl
docker build --rm -t emm/jupyter ./jupyter
rm jupyter/*.whl