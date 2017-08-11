#!/bin/bash -e
# this should be run after check-build finishes.
. /etc/profile.d/modules.sh
module add deploy
module add gcc/${GCC_VERSION}
module add cmake
cd ${WORKSPACE}/build-${BUILD_NUMBER}

echo "All tests have passed, will now build into ${SOFT_DIR}"
rm -rf *
cmake ../${NAME}${VERSION} \
-DCMAKE_INSTALL_PREFIX=${SOFT_DIR}-gcc-${GCC_VERSION} \
-DHEPMC_BUILD_EXAMPLES=ON \
-DHEPMC_INSTALL_INTERFACES=ON
make
make install

echo "Creating the modules file directory ${LIBRARIES}"
mkdir -p ${HEP}/${NAME}
(
cat <<MODULE_FILE
#%Module1.0
## $NAME modulefile
##
proc ModulesHelp { } {
    puts stderr "       This module does nothing but alert the user"
    puts stderr "       that the [module-info name] module is not available"
}

module-whatis   "$NAME $VERSION : See https://github.com/SouthAfricaDigitalScience/hepmc-deploy"
setenv HEPMC_VERSION       $VERSION
setenv HEPMC_DIR           $::env(CVMFS_DIR)/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION-gcc-${GCC_VERSION}
prepend-path PATH                           $::env(HEPMC_DIR)/bin
prepend-path LD_LIBRARY_PATH   $::env(HEPMC_DIR)/lib
prepend-path CFLAGS            "-I$::env(HEPMC_DIR)/include"
prepend-path LDFLAGS           "-L$::env(HEPMC_DIR)/lib"
MODULE_FILE
) > ${HEP}/${NAME}/${VERSION}-gcc-${GCC_VERSION}

echo "checking modulefile"
module avail ${NAME}
echo "adding module"

module add ${NAME}/${VERSION}-gcc-${GCC_VERSION}
