#!/bin/bash
cp wheels/*.whl jupyter
docker build --rm -t emm/jupyter ./jupyter
rm jupyter/*.whl