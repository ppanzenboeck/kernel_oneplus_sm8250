# Copyright (c) 2022, Devang Chaudhary <devangsingh369@gmail.com>

clear

export KBUILD_BUILD_HOST=$(uname -a | awk '{print $2}')
export C_PATH="$HOME/toolchains/neutron-16"
export GZIP_DIR="$HOME/toolchains/neutron-gzip"
export COREUTILS_DIR="$HOME/toolchains/neutron-coreutils"
export PATH="$COREUTILS_DIR/bin:$GZIP_DIR/bin:$C_PATH/bin:$PATH"
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
export CROSS_COMPILE_COMPAT=arm-linux-gnueabi-
export CROSS_COMPILE_ARM32=arm-linux-gnueabi-
make O=out ARCH=arm64 PATH="$COREUTILS_DIR/bin:$GZIP_DIR/bin:$C_PATH/bin:$PATH" \
          LLVM=1 \
          LLVM_IAS=1 \
          CC=clang \
          AR=llvm-ar \
          NM=llvm-nm \
          LD=ld.lld \
          STRIP=llvm-strip \
          OBJCOPY=llvm-objcopy \
          OBJDUMP=llvm-objdump \
          OBJSIZE=llvm-size \
          HOSTCC=clang \
          HOSTCXX=clang++ \
          HOSTAR=llvm-ar \
          HOSTLD=ld.lld \
          CROSS_COMPILE=aarch64-linux-gnu- \
          CROSS_COMPILE_COMPAT=arm-linux-gnueabi- \
          CROSS_COMPILE_ARM32=arm-linux-gnueabi- vendor/kona-perf_defconfig

make O=out -j$(nproc --all) \
          PATH="$COREUTILS_DIR/bin:$GZIP_DIR/bin:$C_PATH/bin:$PATH" \
          LLVM=1 \
          LLVM_IAS=1 \
          CC=clang \
          AR=llvm-ar \
          NM=llvm-nm \
          LD=ld.lld \
          STRIP=llvm-strip \
          OBJCOPY=llvm-objcopy \
          OBJDUMP=llvm-objdump \
          OBJSIZE=llvm-size \
          HOSTCC=clang \
          HOSTCXX=clang++ \
          HOSTAR=llvm-ar \
          HOSTLD=ld.lld \
          CROSS_COMPILE=aarch64-linux-gnu- \
          CROSS_COMPILE_COMPAT=arm-linux-gnueabi- \
          CROSS_COMPILE_ARM32=arm-linux-gnueabi-

COMMIT_NAME=$(git show -s --format=%s)
COMMIT_HASH=$(git rev-parse --short HEAD)

mv out/arch/arm64/boot/Image /$HOME/Desktop/AnyKernel3/zImage

rm -r out

  exit 0
}
