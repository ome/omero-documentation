#!/bin/bash

cp omero-init.d /etc/init.d/omero
chmod a+x /etc/init.d/omero

update-rc.d -f omero remove
update-rc.d -f omero defaults 98 02
