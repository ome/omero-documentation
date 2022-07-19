#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function
import glob
import os
import re
import sys

from pathlib import Path
from pkg_resources import parse_version


def get_mmp(sqlfile):
    m = re.search(r'.*/?OMERO(\d+)\.(\d+)(\w*)__(\d+)', sqlfile)
    if m is None:
        return None
    mmp = (int(m.group(1)), int(m.group(2)), m.group(3), int(m.group(4)))
    return mmp


serverdir = Path(sys.argv[1])

current_mmp = None
current_version = None
directory = os.path.join(serverdir, 'sql', 'psql')
subfolders = [f.path for f in os.scandir(directory) if f.is_dir()]
for f in subfolders:
    ver = os.path.basename(os.path.normpath(f))
    ver = ver.replace("OMERO", "")
    if current_version is None:
        current_version = ver
    else:
        if parse_version(current_version) < parse_version(ver):
            current_version = ver
current_dbver = "OMERO%s" % current_version
current_mmp = get_mmp(current_dbver)

sqlfiles = []
majorminorpatch = []
for f in glob.glob(os.path.join(
        serverdir, 'sql', 'psql', current_dbver, 'OMERO*.sql')):
    mmp = get_mmp(f)
    sql = os.path.basename(f)[:-4]
    majorminorpatch.append(mmp)
    sqlfiles.append(sql)

majorminorpatch = sorted(
    majorminorpatch, key=lambda m: (-m[0], -m[1], m[2], -m[3]))
for previous_mmp in majorminorpatch:
    if previous_mmp[0] < current_mmp[0] or (
            previous_mmp[0] == current_mmp[0] and
            previous_mmp[1] < current_mmp[1]):
        break

print('current_dbver = "%s"' % current_dbver)
print('previous_dbver = "OMERO%d.%d%s__%d"' % previous_mmp)
