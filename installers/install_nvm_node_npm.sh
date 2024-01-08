#!/bin/bash
set -e  # exit on first error

cd /tmp && rm -rf nvm && git clone --depth 1 https://github.com/nvm-sh/nvm.git
cd nvm && bash install.sh

eval "$(cat ~/.bashrc | tail -n +10)"

nvm install node 
nvm use stable


npm install -g cnpm --registry=https://registry.npm.taobao.org
