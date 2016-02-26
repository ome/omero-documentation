#!/bin/bash

OMEROVER=${OMEROVER:-omero}

# Install the OMERO dependencies in a virtual environment
# Create virtual env.
# -p only require if it has been installed with python 2.6

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u
/home/omero/omeroenv/bin/pip install --upgrade pip

# Cap Pillow version due to a limitation in OMERO.figure with v3.0.0
/home/omero/omeroenv/bin/pip2.7 install "Pillow<3.0"

# install omero dependencies
/home/omero/omeroenv/bin/pip2.7 install numpy matplotlib

# Django
/home/omero/omeroenv/bin/pip2.7 install "Django>=1.8,<1.9"

if [ $OMEROVER = omerodev ] || [ $OMEROVER = omeromerge ] ; then
	/home/omero/omeroenv/bin/pip2.7 install omego
fi

deactivate