#!/usr/bin/env python
# -*- coding: utf-8 -*-

import glob
import os
import re
import sys
from path import path
from omero.cli import CLI
from omero.install.config_parser import PropertyParser

def get_mmp(sqlfile):
    m = re.search('.*/?OMERO(\d+)\.(\d+)(\w*)__(\d+)', sqlfile)
    mmp = (int(m.group(1)), int(m.group(2)), m.group(3), int(m.group(4)))
    return mmp


serverdir = path(sys.argv[1])

required = {'omero.db.version': None, 'omero.db.patch': None}
cli = CLI()
property_lines = cli.get_config_property_lines(serverdir)
for property in PropertyParser().parse_lines(property_lines):
    if property.key in required:
        required[property.key] = property.val

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


print 'version_bioformats = "6.1.1"'
print 'version_blitz = "5.5.3"'
print 'version_server = "5.5.4"'
print 'version_romio = "5.5.2"'
print 'version_renderer = "5.5.2"'
print 'version_common = "5.5.2"'
print 'version_model = "5.5.2"'
print 'version_gateway = "5.5.3"'
print 'version_insight = "5.5.2"'
print 'version_matlab = "5.5.0"'
print 'version_dsl_plugin = "5.5.0"'
print 'version_blitz_plugin = "5.5.0"'
print 'version_ice_builder = "1.5.0"'
