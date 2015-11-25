#!/bin/bash

useradd -m omero
chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"

echo source \~omero/omero-centos6py27.env >> ~omero/.bashrc
