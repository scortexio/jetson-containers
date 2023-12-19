#!/usr/bin/env bash

/usr/src/tensorrt/bin/trtexec --help

# TODO: Actually recompile TensorRT for python3.10 so that it works
# python3 -c "import tensorrt; print('TensorRT version:', tensorrt.__version__)"