#!/bin/bash

cp omero-systemd.service /etc/systemd/system/omero.service
cp omero-web-systemd.service /etc/systemd/system/omero-web.service

systemctl daemon-reload

systemctl enable omero.service
systemctl enable omero-web.service
