#!/bin/bash

cp omero-init.d /etc/init.d/omero
chmod a+x /etc/init.d/omero

cp omero-web-init.d /etc/init.d/omero-web
chmod a+x /etc/init.d/omero-web

update-rc.d -f omero remove
update-rc.d -f omero defaults 98 02
update-rc.d -f omero-web remove
update-rc.d -f omero-web defaults 98 02
