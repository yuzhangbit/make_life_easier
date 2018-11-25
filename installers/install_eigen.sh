#!/bin/bash
set -e  # exit on first error
VERSION="3.3.5"
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
  cd /tmp && rm -r eigen-git-mirror
  git clone --depth 1 --branch 3.3.5 https://github.com/eigenteam/eigen-git-mirror.git
  cd eigen-git-mirror && sudo make install && cd .. && rm -r eigen-git-mirror
}

main
