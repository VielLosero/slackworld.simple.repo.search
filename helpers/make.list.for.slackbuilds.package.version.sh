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

time for i in $(find /opt/slackware-repositories/slackbuilds/15.0/ -type f -name "*.SlackBuild" ) ; do PRINT_PACKAGE_NAME=y bash  $i   2>/dev/null   ; done  | grep "\.tgz" > ${CWD}/slackbuilds.package.version.txt

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


echo "Package_names not ok: $(echo "$LINES - $NAMES" | bc)"
echo "Package_names ok: $NAMES"
echo "TOTAL package_names: $LINES" 


#
