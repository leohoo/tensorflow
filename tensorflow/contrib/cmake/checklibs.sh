#!/bin/sh

BUILD_TYPE=Release
if [ ! -z "$1" ]; then BUILD_TYPE=$1; fi

libs="zlibstaticd?.lib libprotobufd?.lib giflib.lib libpng12_staticd?.lib libjpeg.lib lmdb.lib jsoncpp.lib farmhash.lib fft2d.lib highwayhash.lib nsync.lib sqlite.lib snappy.lib re2.lib tf_protos_cc.lib tf_cc_while_loop.lib tf_cc.lib tf_cc_ops.lib tf_cc_framework.lib tf_core_cpu.lib tf_core_direct_session.lib tf_core_framework.lib tf_core_kernels.lib tf_core_lib.lib"
for lib in $libs; do
  LIB=$(echo "$lib" | sed -e 's/[\r\n]//g');
  printf "%30s => " "$LIB"
  FOUND=$(find . -regex ".*/$BUILD_TYPE/$LIB")
  if [ -z "$FOUND" ]; then
    echo -e "\033[35mNOT found.\033[0m";
  else
    echo $FOUND
  fi;
done
