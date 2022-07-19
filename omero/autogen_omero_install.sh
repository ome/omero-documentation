#!/usr/bin/env bash
# This script is used by a Continuous Integration job to auto-generate
# the omero.server installation walkthrough.
# The repository https://github.com/ome/omero-install should be downloaded
# downloaded in the WORKSPACE directory. If it
set -u
set -e
set -x

WORKSPACE=${WORKSPACE:-$(pwd)}
WORKSPACE=${WORKSPACE%/}  # Remove trailing slashes


DIRECTORY=omero/sysadmins/unix/walkthrough

if [ -d "$DIRECTORY" ]; then
    rm -rf $DIRECTORY
fi

mkdir -p $DIRECTORY/osx/
#generate walkthrough for all os
ALL=true bash $WORKSPACE/omero-install/linux/autogenerate.sh
cp walkthrough_*.sh $DIRECTORY
rm walkthrough_*.sh

for f in \
    README.md \
    settings.env \
    setup_\* \
    omero-\* \
    ; do
    cp $WORKSPACE/omero-install/linux/$f $DIRECTORY
done

for f in \
    step* \
    install_* \
    ; do
    cp $WORKSPACE/omero-install/osx/$f $DIRECTORY/osx/
done
