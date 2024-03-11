#!/bin/bash
#
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

cd $(dirname $0) && CWD=$(pwd)
#TEMP_DIR=$(mktemp -d)
TEMP_DIR=${TEMP_DIR:-/tmp/repocheck}
[[ ! -d $TEMP_DIR ]] &&  mkdir $TEMP_DIR

# remove files on tmp dir to update it
if [ "$UPDATE" == "yes" ] ; then 
  rm $TEMP_DIR/*
fi  

# get CHECKSUM.md5 and CHECKSUM.md5.asc to check signature from repos
# Uncomment or comment desired repos.
#
# PALMO LINUX REPO https://repository.plamolinux.org/pub/linux/Plamo/
# NOTES: Dont have a CHECKSUM.md5 ...
#
# PONCE REPO https://ponce.cc/slackware/
# NOTES: Ponce's repo have signes packages but dont have a CHECKSUMS.md5 file so looking to make a easy list from git.
#
# SLINT REPO https://slackware.uk/slint/
# NOTES: SLINT DONT WORK. SLINT dont sign each package so we can't grep ".asc" like others. I dont want to change the grep to search for package extension because package extension can be a garbaje too. txz tgz tar.gz Reason 2, if someone want to check the package is not easy on SLINT. Download CHECKSUMS.md5.gz.asc  then download CHECKSUMS.md5.gz , unzip , so why they put a CHECKSUMS.md5 and CHECKSUMS.md5.gz file??
#[[ ! -e ${TEMP_DIR}/SLINT-x86_64.CHECKSUMS.md5 ]] && wget -O ${TEMP_DIR}/SLINT-x86_64.CHECKSUMS.md5 https://slackware.uk/slint/x86_64/slint-15.0/CHECKSUMS.md5
#[[ ! -e ${TEMP_DIR}/SLINT-x86_64.CHECKSUMS.md5.asc ]] && wget -O ${TEMP_DIR}/SLINT-x86_64.CHECKSUMS.md5.asc https://slackware.uk/slint/x86_64/slint-15.0/CHECKSUMS.md5.asc
#
# SLACKBUILDS REPO https://slackbuilds.org/slackbuilds/15.0/
# NOTES: Slackbuilds dont have packages, they have tarballs whit the SlackBuild info description, etc. So to see version i will try to do a list of packages seting PRINT_PACKAGE_NAME and upload it to my github and sign it.
[[ ! -e ${TEMP_DIR}/SBO-15.0.CHECKSUMS.md5 ]] && wget -O ${TEMP_DIR}/SBO-15.0.CHECKSUMS.md5 https://raw.githubusercontent.com/VielLosero/slackworld.simple.repo.search/master/SBO-15.0.packages_versions.txt
[[ ! -e ${TEMP_DIR}/SBO-15.0.CHECKSUMS.md5.asc ]] && wget -O ${TEMP_DIR}/SBO-15.0.CHECKSUMS.md5.asc https://raw.githubusercontent.com/VielLosero/slackworld.simple.repo.search/master/SBO-15.0.packages_versions.txt.asc
#
# SLACKEL REPO https://slackware.uk/slackel/
[[ ! -e ${TEMP_DIR}/SLACKEL-i486.CHECKSUMS.md5 ]] && wget -O ${TEMP_DIR}/SLACKEL-i486.CHECKSUMS.md5 https://slackware.uk/slackel/i486/current/CHECKSUMS.md5
[[ ! -e ${TEMP_DIR}/SLACKEL-i486.CHECKSUMS.md5.asc ]] && wget -O ${TEMP_DIR}/SLACKEL-i486.CHECKSUMS.md5.asc https://slackware.uk/slackel/i486/current/CHECKSUMS.md5.asc
[[ ! -e ${TEMP_DIR}/SLACKEL-x86_64.CHECKSUMS.md5 ]] && wget -O ${TEMP_DIR}/SLACKEL-x86_64.CHECKSUMS.md5 https://slackware.uk/slackel/x86_64/current/CHECKSUMS.md5
[[ ! -e ${TEMP_DIR}/SLACKEL-x86_64.CHECKSUMS.md5.asc ]] && wget -O ${TEMP_DIR}/SLACKEL-x86_64.CHECKSUMS.md5.asc https://slackware.uk/slackel/x86_64/current/CHECKSUMS.md5.asc
#
# ALLIEN REPO http://www.slackware.com/~alien/slackbuilds/
[[ ! -e ${TEMP_DIR}/ALIEN-ALL.CHECKSUMS.md5 ]] && wget -O ${TEMP_DIR}/ALIEN-ALL.CHECKSUMS.md5 http://www.slackware.com/~alien/slackbuilds/CHECKSUMS.md5
[[ ! -e ${TEMP_DIR}/ALIEN-ALL.CHECKSUMS.md5.asc ]] && wget -O ${TEMP_DIR}/ALIEN-ALL.CHECKSUMS.md5.asc http://www.slackware.com/~alien/slackbuilds/CHECKSUMS.md5.asc
#
# SLACKWARE REPO https://mirrors.slackware.com/slackware/
[[ ! -e ${TEMP_DIR}/SLACKWARE64-15.0.CHECKSUMS.md5 ]] && wget -O ${TEMP_DIR}/SLACKWARE64-15.0.CHECKSUMS.md5 https://mirrors.slackware.com/slackware/slackware64-15.0/CHECKSUMS.md5
[[ ! -e ${TEMP_DIR}/SLACKWARE64-15.0.CHECKSUMS.md5.asc ]] && wget -O ${TEMP_DIR}/SLACKWARE64-15.0.CHECKSUMS.md5.asc https://mirrors.slackware.com/slackware/slackware64-15.0/CHECKSUMS.md5.asc

# check if sig are ok or delete file.
for file in $(find $TEMP_DIR -name ".asc") ; do
  which gpg2

done

# format file to check for installed packages
[[ ! -e ${TEMP_DIR}/INSTALLED.CHECKSUMS.md5 ]] && cd /var/lib/pkgtools/packages/ && ls -1 | sed 's/$/.asc/' |sed 's:^:no  ./n/a/:'   >  ${TEMP_DIR}/INSTALLED.CHECKSUMS.md5 
cd $CWD

echo +--------------------------------------+
grep "\.asc$" \
  ${TEMP_DIR}/INSTALLED.CHECKSUMS.md5 \
  ${TEMP_DIR}/SBO-15.0.CHECKSUMS.md5 \
  ${TEMP_DIR}/SLACKEL-i486.CHECKSUMS.md5 \
  ${TEMP_DIR}/SLACKEL-x86_64.CHECKSUMS.md5 \
  ${TEMP_DIR}/ALIEN-ALL.CHECKSUMS.md5 \
  ${TEMP_DIR}/SLACKWARE64-15.0.CHECKSUMS.md5 | \
  grep -v "  \./source" | grep -v "  \./testing" |\
  grep -v "  \./source" | grep -v "  \./testing" | grep -v "  \./patches/source/" |\
  cut -d/ -f4- | sed 's: ./::g' | sed 's/.CHECKSUMS.md5:/: /' | \
  cut -d" " -f1,3 | rev | sed 's:/: :' | rev | sed 's/\.asc$//' | grep "$1"

echo +--------------------------------------+

