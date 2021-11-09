# Build TFLite Runtime for ARM boards (with musl libc)

[![Donate](https://img.shields.io/badge/donate-Yandex-red.svg)](https://money.yandex.ru/to/4100110221014297)

This page describes how to build the TensorFlow Lite tflite_runtime Python library for ARM devices using [musl libc](https://musl.libc.org).

## Cross-compilation

1. Clone TensorFlow repository:

```bash
git clone --depth 1 --branch v2.5.0 https://github.com/tensorflow/tensorflow
cd tensorflow
```

2. Install the musl-based toolchains download tool:

```bash
wget https://github.com/kasitoru/tflite_runtime-musl/raw/musl-1.1.24/download_toolchains.sh -O tensorflow/lite/tools/cmake/download_toolchains.sh
```

3. Fix issue https://github.com/tensorflow/tensorflow/issues/47737:

```bash
wget https://github.com/kasitoru/tflite_runtime-musl/raw/v2.5.0/build_pip_package_with_cmake.patch
git apply build_pip_package_with_cmake.patch
rm build_pip_package_with_cmake.patch
```

4. Fix issue https://github.com/google/XNNPACK/issues/981:

```bash
wget https://github.com/kasitoru/tflite_runtime-musl/raw/v2.5.0/xnnpack.patch
git apply xnnpack.patch
rm xnnpack.patch
```

5. Start compiling ([more details](https://www.tensorflow.org/lite/guide/build_cmake_pip#arm_cross_compilation)):

```bash
tensorflow/tools/ci_build/ci_build.sh PI-PYTHON38 \
  tensorflow/lite/tools/pip_package/build_pip_package_with_cmake.sh armhf
```

The binary files will be located in the directory `tensorflow/lite/tools/pip_package/gen/tflite_pip/python3.8/dist/`.

##  References

* Official Build TensorFlow Lite for ARM boards [guide](https://www.tensorflow.org/lite/guide/build_arm)
* Automated cross toolchain builder: [musl-cross-make](https://github.com/richfelker/musl-cross-make)
* Pre-built GCC musl-based toolchains: [muls.cc](http://musl.cc)
* Cross-compilation toolchains for Linux: [toolchains.bootlin.com](https://toolchains.bootlin.com)
