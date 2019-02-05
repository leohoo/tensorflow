#!/bin/bash -x

cat Makefile vcxproj.target > MakeVCProj

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../../../.."

make -f tensorflow/lite/tools/make/MakeVCProj vcxproj
