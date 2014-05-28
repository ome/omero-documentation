#!/bin/bash

useradd -m omero
chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
