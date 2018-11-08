#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR="/tmp"
VERSION="18.04-1523042682"
EXT_NAME="Sozi-extras-media-${VERSION}"
URL="https://github.com/senshu/Sozi/releases/download/v18.04/${EXT_NAME}.zip"



main()
{
  echo "URL:${URL}"
  install_sozi_media_extension
}



install_sozi_media_extension()
{
  ## download zip to temp directory
  cd ${DIR}
  ## clean up before installation
  rm -rf ${EXT_NAME}*
  ## download
  wget ${URL}
  ## extract the content and install them to
  unzip ${EXT_NAME}.zip -d ~/.config/inkscape/extensions
  rm -rf ${EXT_NAME}*
}


main
