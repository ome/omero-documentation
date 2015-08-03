#!/bin/bash

set -e -u -x

source settings.env

chmod go-rwx ~omero/OMERO.server/etc ~omero/OMERO.server/var

# Optionally restrict accesss to the OMERO data directory
#chmod go-rwx "$OMERO_DATA_DIR"

