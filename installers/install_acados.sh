#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_ACADOS="${HOME}/acados_install"
mkdir -p ${INSTALL_ACADOS}
mkdir -p ${INSTALL_ACADOS}/bin

main() {
  install_acados
  install_examples_interfaces
  export_source_path
  install_trenderer
}


install_acados()
{
    cd /tmp && rm -rf acados && git clone --recurse-submodules https://github.com/acados/acados.git
    cd acados && rm -rf build && mkdir -p build && cd build
    cmake .. \
          -DACADOS_UNIT_TESTS=TRUE   \
          -DACADOS_WITH_QPOASES=TRUE \
          -DACADOS_WITH_HPMPC=FALSE \
          -DACADOS_WITH_QPDUNES=TRUE \
          -DACADOS_WITH_OSQP=TRUE \
          -DACADOS_PYTHON=TRUE \
          -DACADOS_EXAMPLES=TRUE \
          -DACADOS_INSTALL_DIR="${INSTALL_ACADOS}"
    make -j4
    make install
}

install_examples_interfaces()
{
    cp -rf /tmp/acados/interfaces ${INSTALL_ACADOS}
    cp -rf /tmp/acados/examples ${INSTALL_ACADOS}
}


install_trenderer()
{
    wget https://github.com/acados/tera_renderer/releases/download/v0.0.34/t_renderer-v0.0.34-linux -O ${INSTALL_ACADOS}/bin/t_renderer
    chmod +x ${INSTALL_ACADOS}/bin/t_renderer
}

export_source_path()
{
    echo 'export ACADOS_SOURCE_DIR="${HOME}/acados_install"' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${ACADOS_SOURCE_DIR}/lib' >> ~/.bashrc
}

main
