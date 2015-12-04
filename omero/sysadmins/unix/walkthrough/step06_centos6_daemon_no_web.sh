#!/bin/bash

cp omero-init.d /etc/init.d/omero
chmod a+x /etc/init.d/omero

chkconfig --del omero
chkconfig --add omero
