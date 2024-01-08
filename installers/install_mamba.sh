#!/bin/bash
set -e  # exit on first error

cd /tmp
rm -rf Mambaforge-Linux-x86_64.sh
proxychains axel -a -n 32 https://github.com/conda-forge/miniforge/releases/download/23.11.0-0/Mambaforge-Linux-x86_64.sh

bash Mambaforge-Linux-x86_64.sh
