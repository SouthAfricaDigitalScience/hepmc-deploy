#!/bin/bash -e
# Copyright 2016 C.S.I.R. Meraka Institute
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

. /etc/profile.d/modules.sh
module add ci
module add cmake
module  add  gcc/${GCC_VERSION}
cd ${WORKSPACE}/build-${BUILD_NUMBER}

make install
mkdir -p ${REPO_DIR}
mkdir -p modules
(
cat <<MODULE_FILE
#%Module1.0
## $NAME modulefile
##
proc ModulesHelp { } {
    puts stderr "       This module does nothing but alert the user"
    puts stderr "       that the [module-info name] module is not available"
}

module-whatis   "$NAME $VERSION."
setenv       HEPMC_VERSION       $VERSION
setenv       HEPMC_DIR           /data/ci-build/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION-gcc-${GCC_VERSION}
prepend-path PATH                           $::env(HEPMC_DIR)/bin
prepend-path LD_LIBRARY_PATH   $::env(HEPMC_DIR)/lib
setenv CPPFLAGS            "-I$::env(HEPMC_DIR)/include $CFLAGS"
setenv LDFLAGS           "-L$::env(HEPMC_DIR)/lib $LDFLAGS"
MODULE_FILE
) > modules/$VERSION-gcc-${GCC_VERSION}

mkdir -vp ${HEP}/${NAME}
cp -v modules/$VERSION-gcc-${GCC_VERSION} ${HEP}/${NAME}
echo "is the module available ?"
module  avail ${NAME}
echo "Checking the module"
module add ${NAME}/${VERSION}-gcc-${GCC_VERSION}

echo "checking examples"

echo  "basic tree"
basic_tree.exe

echo "wrapper"
hepevt_wrapper_example.exe
