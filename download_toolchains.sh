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
    ARMCC_ROOT=${TOOLCHAINS_DIR}/armv7-eabihf--musl--stable-2020.02-2
    if [[ ! -d ${ARMCC_ROOT} ]]; then
      curl -LO https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/armv7-eabihf--musl--stable-2020.02-2.tar.bz2 >&2
      tar xvjf armv7-eabihf--musl--stable-2020.02-2.tar.bz2 -C ${TOOLCHAINS_DIR} >&2
      rm armv7-eabihf--musl--stable-2020.02-2.tar.bz2
      echo '#define __BEGIN_DECLS extern "C" {' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
      echo '#define __END_DECLS }' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
      echo '#define __THROW' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
      echo '#define __nonnull(params)' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
    fi
    echo "ARMCC_FLAGS=\"-march=armv7-a -mfpu=neon-vfpv4 -funsafe-math-optimizations \
      -isystem ${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/include/c++/8.4.0 \
      -isystem ${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/arm-buildroot-linux-musleabihf/8.4.0/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/arm-buildroot-linux-musleabihf/8.4.0/include-fixed \
      -isystem ${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include \
      -isystem ${ARMCC_ROOT}/include \
      -isystem \"\${CROSSTOOL_PYTHON_INCLUDE_PATH}\" \
      -isystem /usr/include\""
    echo "ARMCC_PREFIX=${ARMCC_ROOT}/bin/arm-buildroot-linux-musleabihf-"
		;;
	aarch64)
    ARMCC_ROOT=${TOOLCHAINS_DIR}/aarch64--musl--stable-2020.02-2
    if [[ ! -d ${ARMCC_ROOT} ]]; then
      curl -LO https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--musl--stable-2020.02-2.tar.bz2 >&2
      tar xvjf aarch64--musl--stable-2020.02-2.tar.bz2 -C ${TOOLCHAINS_DIR} >&2
      rm aarch64--musl--stable-2020.02-2.tar.bz2
    fi
    echo "ARMCC_FLAGS=\"-funsafe-math-optimizations \
      -isystem ${ARMCC_ROOT}/aarch64-buildroot-linux-musl/include/c++/8.4.0 \
      -isystem ${ARMCC_ROOT}/aarch64-buildroot-linux-musl/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/aarch64-buildroot-linux-musl/8.4.0/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/aarch64-buildroot-linux-musl/8.4.0/include-fixed \
      -isystem ${ARMCC_ROOT}/aarch64-buildroot-linux-musl/sysroot/usr/include \
      -isystem ${ARMCC_ROOT}/include \
      -isystem \"\${CROSSTOOL_PYTHON_INCLUDE_PATH}\" \
      -isystem /usr/include\""
    echo "ARMCC_PREFIX=${ARMCC_ROOT}/bin/aarch64-buildroot-linux-musl-"
		;;
	rpi0)
    ARMCC_ROOT=${TOOLCHAINS_DIR}/armv6-eabihf--musl--stable-2020.02-2
    if [[ ! -d ${ARMCC_ROOT} ]]; then
      curl -LO https://toolchains.bootlin.com/downloads/releases/toolchains/armv6-eabihf/tarballs/armv6-eabihf--musl--stable-2020.02-2.tar.bz2 >&2
      tar xvjf armv6-eabihf--musl--stable-2020.02-2.tar.bz2 -C ${TOOLCHAINS_DIR} >&2
      rm armv6-eabihf--musl--stable-2020.02-2.tar.bz2
      echo '#define __BEGIN_DECLS extern "C" {' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
      echo '#define __END_DECLS }' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
      echo '#define __THROW' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
      echo '#define __nonnull(params)' >> "${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include/features.h"
    fi
    echo "ARMCC_FLAGS=\"-march=armv6 -mfpu=vfp -funsafe-math-optimizations \
      -isystem ${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/include/c++/8.4.0 \
      -isystem ${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/arm-buildroot-linux-musleabihf/8.4.0/include \
      -isystem ${ARMCC_ROOT}/lib/gcc/arm-buildroot-linux-musleabihf/8.4.0/include-fixed \
      -isystem ${ARMCC_ROOT}/arm-buildroot-linux-musleabihf/sysroot/usr/include \
      -isystem ${ARMCC_ROOT}/include \
      -isystem \"\${CROSSTOOL_PYTHON_INCLUDE_PATH}\" \
      -isystem /usr/include\""
    echo "ARMCC_PREFIX=${ARMCC_ROOT}/bin/arm-buildroot-linux-musleabihf-"
		;;
	*)
		echo "Usage: download_toolchains.sh [armhf|aarch64|rpi0]" >&2
    exit
		;;
  esac

echo "download_toolchains.sh completed successfully." >&2
