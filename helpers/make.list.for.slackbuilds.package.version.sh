#!/bin/bash
# Copyright 2024 Viel Losero.
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# change to CWD
cd $(dirname $0) ; CWD=$(pwd)


rm ${CWD}/../SBO-15.0.packages_versions.txt
rm ${CWD}/slackbuilds.package.version.failed.txt

# 1min 30 s
#time for i in $(find /opt/slackware-repositories/slackbuilds/15.0/ -type f -name "*.SlackBuild" ) ; do PRINT_PACKAGE_NAME=y bash  $i   2>/dev/null   ; done  | grep "\.tgz" > ${CWD}/slackbuilds.package.version.txt
# 45 seg
time find /opt/slackware-repositories/slackbuilds/15.0/ -type f -name *.SlackBuild | parallel "PRINT_PACKAGE_NAME=y bash {} 2>/dev/null | grep '\.tgz' >> ${CWD}/slackbuilds.package.version.unordered.txt || echo {}' ' >>${CWD}/slackbuilds.package.version.failed.txt"

# add packages not ok
for i in $(cat ${CWD}/slackbuilds.package.version.failed.txt) ; do 
  PKGNAM=$(grep '^PRGNAM=' $i | cut -d= -f2)
  VERSION=$(grep '^VERSION=' $i | cut -d- -f2 |tr -d "}")
  BUILD=$(grep '^BUILD=' $i | cut -d- -f2 |tr -d "}")
  TAG=$(grep '^TAG=' $i | cut -d- -f2 |tr -d "}")
  PKGTYPE=$(grep '^PKGTYPE=' $i | cut -d- -f2 |tr -d "}")
  echo "${PKGNAM}-${VERSION}-${BUILD}${TAG}.${PKGTYPE}.asc" >> ${CWD}/slackbuilds.package.version.unordered.txt
done

# order packages
cat ${CWD}/slackbuilds.package.version.unordered.txt | sort > ${CWD}/slackbuilds.package.version.txt && rm ${CWD}/slackbuilds.package.version.unordered.txt

# Add format fot slackworkd.simple.repo.search
date > ${CWD}/../SBO-15.0.packages_versions.txt 
cat ${CWD}/slackbuilds.package.version.txt | sed 's/$/.asc/' |sed 's:^:no  ./build_it/from_source/:' >> ${CWD}/../SBO-15.0.packages_versions.txt 

cd ${CWD}/.. || exit 1

# export gpg publick key armores ascii so put .asc
if [ -e SBO-15.0.packages_versions.txt ] ; then
  if [ ! -e viel.losero.GPG-Key.asc ] ; then 
    echo "Exporting public gpg key"
    gpg2 --armor --export viel.losero@gmail.com > viel.losero.GPG-Key.asc || exit 1
  fi
  # sign the package
  gpg2 --sign --armor --detach-sig --yes SBO-15.0.packages_versions.txt && echo "SBO-15.0.packages_versions.txt signed!!"
fi


LINES=$(find /opt/slackware-repositories/slackbuilds/15.0/ -type f -name "*.SlackBuild" | wc -l)
NAMES=$(cat ${CWD}/slackbuilds.package.version.txt | wc -l)

echo "Package_names not ok: $(cat ${CWD}/slackbuilds.package.version.failed.txt | wc -l)"
echo "Package_names processed: $NAMES"
echo "TOTAL .SlackBuild: $LINES"

