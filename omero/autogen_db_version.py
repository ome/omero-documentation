#!/usr/bin/env python
# -*- coding: utf-8 -*-

import glob
import os
import re
import sys


def get_mmp(sqlfile):
    # Ignore non-numeric version components
    m = re.search('.*/?OMERO(\d+)\.(\d+)(\w*)__(\d+)', sqlfile)
    mmp = (int(m.group(1)), int(m.group(2)), m.group(3), int(m.group(4)))
    return mmp


serverdir = sys.argv[1]
required = {'omero.db.version': None, 'omero.db.patch': None}
with open(os.path.join(serverdir, 'etc', 'omero.properties')) as f:
    for line in f.readlines():
        m = re.match('([\w\.]+)=(.*)', line.strip())
        if m and m.group(1) in required:
            required[m.group(1)] = m.group(2)
            print '%s = "%s"' % (m.group(1).replace('.', '_'), m.group(2))

current_dbver = '%s__%s' % (
    required['omero.db.version'], required['omero.db.patch'])
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

print 'current_dbver = "%s"' % current_dbver
print 'previous_dbver = "OMERO%d.%d%s__%d"' % previous_mmp
