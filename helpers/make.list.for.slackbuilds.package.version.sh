#!/bin/bash

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
