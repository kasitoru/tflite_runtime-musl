#!/bin/bash
# Copyright 2021 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../../../.."

TOOLCHAINS_DIR=$(realpath tensorflow/lite/tools/cmake/toolchains)
mkdir -p ${TOOLCHAINS_DIR}

case $1 in
	armhf)
    ARMCC_ROOT=${TOOLCHAINS_DIR}/armv7l-linux-musleabihf-cross
    if [[ ! -d ${ARMCC_ROOT} ]]; then
      curl -LO https://more.musl.cc/10/x86_64-linux-musl/armv7l-linux-musleabihf-cross.tgz >&2
      tar zxvf armv7l-linux-musleabihf-cross.tgz -C ${TOOLCHAINS_DIR} >&2
      rm armv7l-linux-musleabihf-cross.tgz
      echo '#define __BEGIN_DECLS extern "C" {' >> "${ARMCC_ROOT}/armv7l-linux-musleabihf/include/features.h"
      echo '#define __END_DECLS }' >> "${ARMCC_ROOT}/armv7l-linux-musleabihf/include/features.h"
      echo '#define __THROW' >> "${ARMCC_ROOT}/armv7l-linux-musleabihf/include/features.h"
      echo '#define __nonnull(params)' >> "${ARMCC_ROOT}/armv7l-linux-musleabihf/include/features.h"
    fi
    echo "ARMCC_FLAGS=\"-march=armv7-a -mfpu=neon-vfpv4 -funsafe-math-optimizations \
      -isystem ${ARMCC_ROOT}/armv7l-linux-musleabihf/include/c++/10.2.1 \
      -isystem ${ARMCC_ROOT}/armv7l-linux-musleabihf/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/armv7l-linux-musleabihf/10.2.1/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/armv7l-linux-musleabihf/10.2.1/include-fixed \
      -isystem \"\${CROSSTOOL_PYTHON_INCLUDE_PATH}\" \
      -isystem /usr/include\""
    echo "ARMCC_PREFIX=${ARMCC_ROOT}/bin/armv7l-linux-musleabihf-"
		;;
	aarch64)
    ARMCC_ROOT=${TOOLCHAINS_DIR}/aarch64-linux-musl-cross
    if [[ ! -d ${ARMCC_ROOT} ]]; then
      curl -LO https://more.musl.cc/10/x86_64-linux-musl/aarch64-linux-musl-cross.tgz >&2
      tar zxvf aarch64-linux-musl-cross.tgz -C ${TOOLCHAINS_DIR} >&2
      rm aarch64-linux-musl-cross.tgz
    fi
    echo "ARMCC_FLAGS=\"-funsafe-math-optimizations \
      -isystem ${ARMCC_ROOT}/aarch64-linux-musl/include/c++/10.2.1 \
      -isystem ${ARMCC_ROOT}/aarch64-linux-musl/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/aarch64-linux-musl/10.2.1/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/aarch64-linux-musl/10.2.1/include-fixed \
      -isystem \"\${CROSSTOOL_PYTHON_INCLUDE_PATH}\" \
      -isystem /usr/include\""
    echo "ARMCC_PREFIX=${ARMCC_ROOT}/bin/aarch64-linux-musl-"
		;;
	rpi0)
    ARMCC_ROOT=${TOOLCHAINS_DIR}/armv6-linux-musleabihf-cross
    if [[ ! -d ${ARMCC_ROOT} ]]; then
      curl -LO https://more.musl.cc/10/x86_64-linux-musl/armv6-linux-musleabihf-cross.tgz >&2
      tar zxvf armv6-linux-musleabihf-cross.tgz -C ${TOOLCHAINS_DIR} >&2
      rm armv6-linux-musleabihf-cross.tgz
      echo '#define __BEGIN_DECLS extern "C" {' >> "${ARMCC_ROOT}/armv6-linux-musleabihf/include/features.h"
      echo '#define __END_DECLS }' >> "${ARMCC_ROOT}/armv6-linux-musleabihf/include/features.h"
      echo '#define __THROW' >> "${ARMCC_ROOT}/armv6-linux-musleabihf/include/features.h"
      echo '#define __nonnull(params)' >> "${ARMCC_ROOT}/armv6-linux-musleabihf/include/features.h"
    fi
    echo "ARMCC_FLAGS=\"-march=armv6 -mfpu=vfp -funsafe-math-optimizations \
      -isystem ${ARMCC_ROOT}/armv6-linux-musleabihf/include/c++/10.2.1 \
      -isystem ${ARMCC_ROOT}/armv6-linux-musleabihf/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/armv6-linux-musleabihf/10.2.1/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/armv6-linux-musleabihf/10.2.1/include-fixed \
      -isystem \"\${CROSSTOOL_PYTHON_INCLUDE_PATH}\" \
      -isystem /usr/include\""
    echo "ARMCC_PREFIX=${ARMCC_ROOT}/bin/armv6-linux-musleabihf-"
		;;
	*)
		echo "Usage: download_toolchains.sh [armhf|aarch64|rpi0]" >&2
    exit
		;;
  esac

echo "download_toolchains.sh completed successfully." >&2
