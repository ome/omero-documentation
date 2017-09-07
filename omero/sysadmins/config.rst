.. This file is auto-generated from omero.properties. DO NOT EDIT IT

Configuration properties glossary
=================================

.. contents::
  :depth: 1
  :local:

.. _introduction_configuration:

Introduction
------------

The primary form of configuration is via the use of key/value properties,
stored in :file:`etc/grid/config.xml` and read on server startup. Backing up
and copying these properties is as easy as copying this file to a new server
version.

The :source:`etc/omero.properties` file of your distribution defines all the
default configuration properties used by the server. Changes made to the file
are *not* recognized by the server. Instead, configuration options can be set
using the :program:`omero config set` command:

::

    $ bin/omero config set <parameter> <value>

When supplying a value with spaces or multiple elements, use **single
quotes**. The quotes will not be saved as part of the value (see below).

To remove a configuration option (to return to default values where
mentioned), simply omit the value:

::

    $ bin/omero config set <parameter>

These options will be stored in a file: ``etc/grid/config.xml`` which
you can read for reference. **DO NOT** edit this file directly.

You can also review all your settings by using:

::

    $ bin/omero config get

which should return values without quotation marks.

A final useful option of :program:`omero config edit` is:

::

    $ bin/omero config edit

which will allow for editing the configuration in a system-default text
editor.

.. note::
    Please use the **escape sequence** ``\"`` for nesting double quotes (e.g.
    ``"[\"foo\", \"bar\"]"``) or wrap with ``'`` (e.g. ``'["foo",
    "bar"]'``).

Examples of doing this are on the
:doc:`server installation page <unix/server-installation>`, as well as the
:doc:`LDAP installation <server-ldap>` page.

.. _core_configuration:

Mandatory properties
--------------------

The following properties need to be correctly set for all installations of the
OMERO.server. Depending on your set-up, default values may be sufficient.

- :property:`omero.data.dir`
- :property:`omero.db.host`
- :property:`omero.db.name`
- :property:`omero.db.pass`


.. _fs_configuration:

Binary repository
-----------------

.. property:: omero.checksum.supported

omero.checksum.supported
^^^^^^^^^^^^^^^^^^^^^^^^
Checksum algorithms supported by the server for new file uploads,
being any comma-separated non-empty subset of:

- Adler-32
- CRC-32
- MD5-128
- Murmur3-32
- Murmur3-128
- SHA1-160
- File-Size-64

In negotiation with clients, this list is interpreted as being in
descending order of preference.

Default: `SHA1-160, MD5-128, Murmur3-128, Murmur3-32, CRC-32, Adler-32, File-Size-64`

.. property:: omero.data.dir

omero.data.dir
^^^^^^^^^^^^^^

Default: `/OMERO/`

.. property:: omero.fs.repo.path

omero.fs.repo.path
^^^^^^^^^^^^^^^^^^
Template for FS managed repository paths.
Allowable elements are:

::

   %user%         bob
   %userId%       4
   %group%        bobLab
   %groupId%      3
   %year%         2011
   %month%        01
   %monthname%    January
   %day%          01
   %time%         15-13-54.014
   %institution%  University of Dundee
   %hash%         0D2D8DB7
   %increment%    14
   %subdirs%      023/613
   %session%      c3fdd5d8-831a-40ff-80f2-0ba5baef448a
   %sessionId%    592
   %perms%        rw----
   /              path separator
   //             end of root-owned directories

These are described further at :doc:`fs-upload-configuration`

The path must be unique per fileset to prevent upload conflicts,
which is why %time% includes milliseconds.

A // may be used as a path separator: the directories preceding
it are created with root ownership, the remainder are the user's.
At least one user-owned directory must be included in the path.

The template path is created below :property:`omero.managed.dir`,
e.g. :file:`/OMERO/ManagedRepository/${omero.fs.repo.path}/`

Default: `%user%_%userId%//%year%-%month%/%day%/%time%`

.. property:: omero.fs.repo.path_rules

omero.fs.repo.path_rules
^^^^^^^^^^^^^^^^^^^^^^^^
Rules to apply to judge the acceptability of FS paths for writing into
:property:`omero.managed.dir`, being any comma-separated non-empty subset of:

- Windows required
- Windows optional
- UNIX required
- UNIX optional
- local required
- local optional

Minimally, the "required" appropriate for the server is recommended.
Also applying "optional" rules may make sysadmin tasks easier,
but may be more burdensome for users who name their files oddly.
"local" means "Windows" or "UNIX" depending on the local platform,
the latter being applied for Linux and Mac OS X.

Default: `Windows required, UNIX required`

.. property:: omero.managed.dir

omero.managed.dir
^^^^^^^^^^^^^^^^^

Default: `${omero.data.dir}/ManagedRepository`


.. _client_configuration:

Client
------

.. property:: omero.client.browser.thumb_default_size

omero.client.browser.thumb_default_size
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The default thumbnail size

Default: `96`

.. property:: omero.client.download_as.max_size

omero.client.download_as.max_size
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Clients disable download as jpg/png/tiff above max pixel count.

Default: `144000000`

.. property:: omero.client.scripts_to_ignore

omero.client.scripts_to_ignore
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Server-side scripts used in IScript service Clients shouldn't display.

Default: `/omero/figure_scripts/Movie_Figure.py,
/omero/figure_scripts/Split_View_Figure.py,
/omero/figure_scripts/Thumbnail_Figure.py,
/omero/figure_scripts/ROI_Split_Figure.py,
/omero/export_scripts/Make_Movie.py,
/omero/import_scripts/Populate_ROI.py`

.. property:: omero.client.ui.menu.dropdown.colleagues.enabled

omero.client.ui.menu.dropdown.colleagues.enabled
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Flag to show/hide colleagues

Default: `true`

.. property:: omero.client.ui.menu.dropdown.colleagues.label

omero.client.ui.menu.dropdown.colleagues.label
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Client dropdown menu colleagues label.

Default: `Members`

.. property:: omero.client.ui.menu.dropdown.everyone.enabled

omero.client.ui.menu.dropdown.everyone.enabled
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Flag to show/hide all users.

Default: `true`

.. property:: omero.client.ui.menu.dropdown.everyone.label

omero.client.ui.menu.dropdown.everyone.label
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Client dropdown menu all users label.

Default: `All Members`

.. property:: omero.client.ui.menu.dropdown.leaders.enabled

omero.client.ui.menu.dropdown.leaders.enabled
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Flag to show/hide leader.

Default: `true`

.. property:: omero.client.ui.menu.dropdown.leaders.label

omero.client.ui.menu.dropdown.leaders.label
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Client dropdown menu leader label.

Default: `Owners`

.. property:: omero.client.ui.tree.orphans.description

omero.client.ui.tree.orphans.description
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Description of the "Orphaned images" container.

Default: `This is a virtual container with orphaned images. These images are not linked anywhere. Just drag them to the selected container.`

.. property:: omero.client.ui.tree.orphans.enabled

omero.client.ui.tree.orphans.enabled
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Flag to show/hide "Orphaned images" container. Only accept "true" or "false"

Default: `true`

.. property:: omero.client.ui.tree.orphans.name

omero.client.ui.tree.orphans.name
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Name of the "Orphaned images" container located in client tree data manager.

Default: `Orphaned Images`

.. property:: omero.client.ui.tree.type_order

omero.client.ui.tree.type_order
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Client tree type order rank list
first type is ranked 1 (the highest), last is the lowest
if set to 'false' empty list allows mixing all types and
sorting them by default client ordering strategy

Default: `tagset,
tag,
project,
dataset,
screen,
plate,
acquisition,
image`

.. property:: omero.client.viewer.initial_zoom_level

omero.client.viewer.initial_zoom_level
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Initial client image viewer zoom level for big images

Default: `0`

.. property:: omero.client.viewer.interpolate_pixels

omero.client.viewer.interpolate_pixels
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Client viewers interpolate pixels by default.

Default: `true`

.. property:: omero.client.viewer.roi_limit

omero.client.viewer.roi_limit
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Client viewers roi limit.

Default: `2000`

.. property:: omero.client.web.host

omero.client.web.host
^^^^^^^^^^^^^^^^^^^^^
Absolute omeroweb host http(s)://your_domain/prefix/

Default: `[empty]`


.. _db_configuration:

Database
--------

.. property:: omero.db.authority

omero.db.authority
^^^^^^^^^^^^^^^^^^
The string that will be used as the base for LSIDs
in all exported OME objects including OME-XML and
OME-TIFF. It's usually not necessary to modify this
value since the database UUID (stored in the database)
is sufficient to uniquely identify the source.

Default: `export.openmicroscopy.org`

.. property:: omero.db.dialect

omero.db.dialect
^^^^^^^^^^^^^^^^
Implementation of the org.hibernate.dialect.Dialect interface which will
be used to convert HQL queries and save operations into SQL SELECTs and
DML statements.

(PostgreSQL default)

Default: `ome.util.PostgresqlDialect`

.. property:: omero.db.driver

omero.db.driver
^^^^^^^^^^^^^^^
JDBC driver used to access the database. Other drivers can be configured
which wrap this driver to provide logging, monitoring, etc.

(PostgreSQL default)

Default: `org.postgresql.Driver`

.. property:: omero.db.host

omero.db.host
^^^^^^^^^^^^^
The host name of the machine on which the database server is running.
A TCP port must be accessible from the server on which OMERO is running.

Default: `localhost`

.. property:: omero.db.name

omero.db.name
^^^^^^^^^^^^^
The name of the database instance to which OMERO will connect.

Default: `omero`

.. property:: omero.db.pass

omero.db.pass
^^^^^^^^^^^^^
The password to use to connect to the database server

Default: `omero`

.. property:: omero.db.patch

omero.db.patch
^^^^^^^^^^^^^^
The patch version of the database which is in use.
This value need not match the patch version of the
server that is is being used with. Any changes by
developers to the database schema will result in
a bump to this value.

Default: `3`

.. property:: omero.db.poolsize

omero.db.poolsize
^^^^^^^^^^^^^^^^^
Sets the number of database server connections which
will be used by OMERO. Your database installation
will need to be configured to accept *at least* as
many, preferably more, connections as this value.

Default: `10`

.. property:: omero.db.port

omero.db.port
^^^^^^^^^^^^^
TCP port on which the database server is listening for connections.
Used by the JDBC driver to access the database. Use of a local UNIX
socket is not supported.

(PostgreSQL default)

Default: `5432`

.. property:: omero.db.prepared_statement_cache_size

omero.db.prepared_statement_cache_size
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `10`

.. property:: omero.db.profile

omero.db.profile
^^^^^^^^^^^^^^^^
Default values for the current profile will be
hard-coded into the hibernate.properties file
in the `model-*.jar`. By using a different jar,
you can modify the defaults.

Note: some other properties are defined in
the file :file:`etc/profiles/${omero.db.profile}`
Especially of importance is :property:`omero.db.port`

Default: `psql`

.. property:: omero.db.sql_action_class

omero.db.sql_action_class
^^^^^^^^^^^^^^^^^^^^^^^^^
Implementation of the ome.util.SqlAction interface which will be used to
perform all direct SQL actions, i.e. without Hibernate.

(PostgreSQL default)

Default: `ome.util.actions.PostgresSqlAction`

.. property:: omero.db.statistics

omero.db.statistics
^^^^^^^^^^^^^^^^^^^
Whether JMX statistics are collected
for DB usage (by Hibernate, etc)

Default: `true`

.. property:: omero.db.user

omero.db.user
^^^^^^^^^^^^^
The username to use to connect to the database server

Default: `omero`

.. property:: omero.db.version

omero.db.version
^^^^^^^^^^^^^^^^
Version of the database which is in use. This
value typically matches the major.minor version
of the server that it is being used with. Typically,
only developers will change this version to bump
to a new major version.

Default: `OMERO5.4DEV`


.. _grid_configuration:

Grid
----

.. property:: omero.cluster.read_only

omero.cluster.read_only
^^^^^^^^^^^^^^^^^^^^^^^

Default: `false`

.. property:: omero.cluster.redirector

omero.cluster.redirector
^^^^^^^^^^^^^^^^^^^^^^^^

Default: `nullRedirector`

.. property:: omero.grid.registry_timeout

omero.grid.registry_timeout
^^^^^^^^^^^^^^^^^^^^^^^^^^^
registry_timeout is the milliseconds which
the registry and other services will wait
on remote services to respond.

Default: `5000`


.. _ice_configuration:

Ice
---

.. property:: Ice.IPv6

Ice.IPv6
^^^^^^^^
Disable IPv6 by setting to 0. Only needed in
certain situations.

Default: `1`


.. _jvm_configuration:

JVM
---

.. property:: omero.jvmcfg.append

omero.jvmcfg.append
^^^^^^^^^^^^^^^^^^^
Contains other parameters which should be passed to the
JVM. The value of "append" is treated as if it were on
the command line so will be separated on whitespace.
For example, '-XX:-PrintGC -XX:+UseCompressedOops' would
results in two new arguments.
Note that when using `config set` from the command line
one may need to give a prior `--` option to prevent a value
starting with `-` from already being parsed as an option,
and values may need quoting to prevent whitespace or other
significant characters from being interpreted prematurely.

Default: `[empty]`

.. property:: omero.jvmcfg.heap_dump

omero.jvmcfg.heap_dump
^^^^^^^^^^^^^^^^^^^^^^
Toggles on or off heap dumps on OOMs. Default is "off".
The special value "tmp" will create the heap dumps in
your temp directory.

Default: `[empty]`

.. property:: omero.jvmcfg.heap_size

omero.jvmcfg.heap_size
^^^^^^^^^^^^^^^^^^^^^^
Explicit value for the `-Xmx` argument, e.g.
"1g"

Default: `[empty]`

.. property:: omero.jvmcfg.max_system_memory

omero.jvmcfg.max_system_memory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Suggestion for strategies as to the maximum memory
that they will use for calculating JVM settings (MB).

Default: `48000`

.. property:: omero.jvmcfg.min_system_memory

omero.jvmcfg.min_system_memory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Suggestion for strategies as to the minimum memory
that they will use for calculating JVM settings (MB).

Default: `3414`

.. property:: omero.jvmcfg.percent

omero.jvmcfg.percent
^^^^^^^^^^^^^^^^^^^^
Used only by the percent strategy. An integer between 0
and 100 which is the percent of active memory that will
be used by the service.

Default: `[empty]`

.. property:: omero.jvmcfg.perm_gen

omero.jvmcfg.perm_gen
^^^^^^^^^^^^^^^^^^^^^
Explicit value for the MaxPermSize argument
to the JVM, e.g. "500M". Ignored for Java8+

Default: `[empty]`

.. property:: omero.jvmcfg.strategy

omero.jvmcfg.strategy
^^^^^^^^^^^^^^^^^^^^^
Memory strategy which will be used by default.
Options include: percent, manual

Default: `percent`

.. property:: omero.jvmcfg.system_memory

omero.jvmcfg.system_memory
^^^^^^^^^^^^^^^^^^^^^^^^^^
Manual override of the total system memory that
OMERO will *think* is present on the local OS (MB).
If unset, an attempt will be made to detect the actual
amount: first by using the Python library `psutil` and
if that is not installed, by running a Java tool. If
neither works, 4.0GB is assumed.

Default: `[empty]`


.. _ldap_configuration:

LDAP
----

.. property:: omero.ldap.base

omero.ldap.base
^^^^^^^^^^^^^^^
LDAP server base search DN, i.e. the filter that is applied
to all users. (can be empty in which case any LDAP user is
valid)

Default: `ou=example,
o=com`

.. property:: omero.ldap.config

omero.ldap.config
^^^^^^^^^^^^^^^^^
Enable or disable LDAP (`true` or `false`).

Default: `false`

.. property:: omero.ldap.group_filter

omero.ldap.group_filter
^^^^^^^^^^^^^^^^^^^^^^^

Default: `(objectClass=groupOfNames)`

.. property:: omero.ldap.group_mapping

omero.ldap.group_mapping
^^^^^^^^^^^^^^^^^^^^^^^^

Default: `name=cn`

.. property:: omero.ldap.new_user_group

omero.ldap.new_user_group
^^^^^^^^^^^^^^^^^^^^^^^^^
Without a prefix the "new_user_group" property specifies
the name of a single group which all new users will be
added to. Other new_user_group strings are prefixed with
``:x:`` and specify various lookups which should take
place to find one or more target groups for the new user.

``:ou:`` uses the final organizational unit of a user's dn
as the single OMERO group e.g. ``omero.ldap.new_user_group=:ou:``


``:attribute:`` uses all the values of the specified
attribute as the name of multiple OMERO groups. e.g.
``omero.ldap.new_user_group=:attribute:memberOf``

Like ``:attribute:``, ``:filtered_attribute:`` uses all the
values of the specified attribute as the name of
multiple OMERO groups but the attribute must pass
the same filter as ``:query:`` does. e.g.
``omero.ldap.new_user_group=:filtered_attribute:memberOf``

Similar to ``:attribute:``, ``:dn_attribute:`` uses all the
values of the specified attribute as the DN of
multiple OMERO groups. e.g.
``omero.ldap.new_user_group=:dn_attribute:memberOf``

A combination of filtered_attribute and dn_attribute,
``:filtered_dn_attribute:`` uses all of the values of the
specified attribute as the DN of multiple OMERO groups
but the attribute must pass the same filter as ``:query:``
e.g. ``omero.ldap.new_user_group=:filtered_dn_attribute:memberOf``

``:query:`` performs a query for groups. The "name"
property will be taken as defined by omero.ldap.group_mapping
and the resulting filter will be AND'ed with the value
group_filter (above) e.g.
``omero.ldap.new_user_group=:query:(member=@{dn})``

``:bean:`` looks in the server's context for a
bean with the given name which implements
``ome.security.auth.NewUserGroupBean`` e.g.
``omero.ldap.new_user_group=:bean:myNewUserGroupMapperBean``


Default: `default`

.. property:: omero.ldap.new_user_group_owner

omero.ldap.new_user_group_owner
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A query element to check if user who is being created
via the new_user_group setting should be made a
"manager", i.e. owner, of the queried group. E.g.
``omero.ldap.new_user_group_owner=(owner=@{dn})``
will use the 'manager' attribute to set the 'owner'
flag in the database. This query element is appened
to any query used by new_user_group with an AND.

This property is not used by new_user_group type
'default' and only potentially by ``:bean:``.

Default: `[empty]`

.. property:: omero.ldap.password

omero.ldap.password
^^^^^^^^^^^^^^^^^^^
LDAP server bind password (if required; can be empty)

Default: `[empty]`

.. property:: omero.ldap.referral

omero.ldap.referral
^^^^^^^^^^^^^^^^^^^
Available referral options are: "ignore", "follow", or "throw"
as per the JNDI referral documentation.

Default: `ignore`

.. property:: omero.ldap.sync_on_login

omero.ldap.sync_on_login
^^^^^^^^^^^^^^^^^^^^^^^^
Whether or not values from LDAP will be
synchronized to OMERO on each login. This includes
not just the username, email, etc, but also the
groups that the user is a member of.

.. note::
   Admin actions carried out in the clients may
   not survive this synchronization e.g. LDAP
   users removed from an LDAP group in the UI
   will be re-added to the group when logging in
   again after the synchronization.


Default: `false`

.. property:: omero.ldap.urls

omero.ldap.urls
^^^^^^^^^^^^^^^
Set the URL of the LDAP server. A |SSL| URL for this
property would be of the form: ldaps://ldap.example.com:636

Default: `ldap://localhost:389`

.. property:: omero.ldap.user_filter

omero.ldap.user_filter
^^^^^^^^^^^^^^^^^^^^^^

Default: `(objectClass=person)`

.. property:: omero.ldap.user_mapping

omero.ldap.user_mapping
^^^^^^^^^^^^^^^^^^^^^^^

Default: `omeName=cn,
firstName=givenName,
lastName=sn,
email=mail,
institution=department,
middleName=middleName`

.. property:: omero.ldap.username

omero.ldap.username
^^^^^^^^^^^^^^^^^^^
LDAP server bind DN (if required; can be empty)

Default: `[empty]`


.. _mail_configuration:

Mail
----

.. property:: omero.mail.bean

omero.mail.bean
^^^^^^^^^^^^^^^
Mail sender properties

Default: `defaultMailSender`

.. property:: omero.mail.config

omero.mail.config
^^^^^^^^^^^^^^^^^
Enable or disable mail sender (`true` or `false`).

Default: `false`

.. property:: omero.mail.from

omero.mail.from
^^^^^^^^^^^^^^^
the email address used for the "from" field

Default: `omero@${omero.mail.host}`

.. property:: omero.mail.host

omero.mail.host
^^^^^^^^^^^^^^^
the hostname of smtp server

Default: `localhost`

.. property:: omero.mail.password

omero.mail.password
^^^^^^^^^^^^^^^^^^^
the password to connect to the smtp server (if required; can be empty)

Default: `[empty]`

.. property:: omero.mail.port

omero.mail.port
^^^^^^^^^^^^^^^
the port of smtp server

Default: `25`

.. property:: omero.mail.smtp.auth

omero.mail.smtp.auth
^^^^^^^^^^^^^^^^^^^^
see javax.mail.Session properties

Default: `false`

.. property:: omero.mail.smtp.connectiontimeout

omero.mail.smtp.connectiontimeout
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `60000`

.. property:: omero.mail.smtp.debug

omero.mail.smtp.debug
^^^^^^^^^^^^^^^^^^^^^

Default: `false`

.. property:: omero.mail.smtp.socketFactory.class

omero.mail.smtp.socketFactory.class
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `javax.net.SocketFactory`

.. property:: omero.mail.smtp.socketFactory.fallback

omero.mail.smtp.socketFactory.fallback
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `false`

.. property:: omero.mail.smtp.socketFactory.port

omero.mail.smtp.socketFactory.port
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `${omero.mail.port}`

.. property:: omero.mail.smtp.starttls.enable

omero.mail.smtp.starttls.enable
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `false`

.. property:: omero.mail.smtp.timeout

omero.mail.smtp.timeout
^^^^^^^^^^^^^^^^^^^^^^^

Default: `60000`

.. property:: omero.mail.transport.protocol

omero.mail.transport.protocol
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
other smtp parameters; see org.springframework.mail.javamail.JavaMailSenderImpl

Default: `smtp`

.. property:: omero.mail.username

omero.mail.username
^^^^^^^^^^^^^^^^^^^
the username to connect to the smtp server (if required; can be empty)

Default: `[empty]`


.. _metrics_configuration:

Metrics
-------

.. property:: omero.metrics.bean

omero.metrics.bean
^^^^^^^^^^^^^^^^^^
Which bean to use:
nullMetrics does nothing
defaultMetrics uses the properties defined below

Default: `defaultMetrics`

.. property:: omero.metrics.graphite

omero.metrics.graphite
^^^^^^^^^^^^^^^^^^^^^^
Address for Metrics to send server data

Default: `[empty]`

.. property:: omero.metrics.slf4j_minutes

omero.metrics.slf4j_minutes
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Number of minutes to periodically print to slf4j
0 or lower disables the printout.

Default: `60`


.. _performance_configuration:

Performance
-----------

.. property:: omero.sessions.maximum

omero.sessions.maximum
^^^^^^^^^^^^^^^^^^^^^^

Default: `0`

.. property:: omero.sessions.sync_force

omero.sessions.sync_force
^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `1800000`

.. property:: omero.sessions.sync_interval

omero.sessions.sync_interval
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `120000`

.. property:: omero.sessions.timeout

omero.sessions.timeout
^^^^^^^^^^^^^^^^^^^^^^
Sets the duration of inactivity in milliseconds after which
a login is required.

Default: `600000`

.. property:: omero.threads.cancel_timeout

omero.threads.cancel_timeout
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `5000`

.. property:: omero.threads.idle_timeout

omero.threads.idle_timeout
^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `5000`

.. property:: omero.threads.max_threads

omero.threads.max_threads
^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `50`

.. property:: omero.threads.min_threads

omero.threads.min_threads
^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `5`

.. property:: omero.throttling.method_time.error

omero.throttling.method_time.error
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Time in milliseconds after which a single method invocation
will print a ERROR statement to the server log. If ERRORs
are frequently being printed to your logs, you may want to
increase this value after checking that no actual problem
exists. Values of more than 60000 (1 minute) are not advised.

Default: `20000`

.. property:: omero.throttling.method_time.error.indexer

omero.throttling.method_time.error.indexer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Value for the indexer is extended to 1 day

Default: `86400000`

.. property:: omero.throttling.method_time.warn

omero.throttling.method_time.warn
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Time in milliseconds after which a single method invocation
will print a WARN statement to the server log.

Default: `5000`

.. property:: omero.throttling.method_time.warn.indexer

omero.throttling.method_time.warn.indexer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Value for the indexer is extended to 1 hour

Default: `3600000`

.. property:: omero.throttling.objects_read_interval

omero.throttling.objects_read_interval
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `1000`

.. property:: omero.throttling.objects_written_interval

omero.throttling.objects_written_interval
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `1000`

.. property:: omero.throttling.servants_per_session

omero.throttling.servants_per_session
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `10000`


.. _pixeldata_configuration:

Pixeldata
---------

.. property:: omero.pixeldata.backoff

omero.pixeldata.backoff
^^^^^^^^^^^^^^^^^^^^^^^
Name of the spring bean which will be used
to calculate the backoff (in ms) that users
should wait for an image to be ready to view.

Default: `ome.io.nio.SimpleBackOff`

.. property:: omero.pixeldata.batch

omero.pixeldata.batch
^^^^^^^^^^^^^^^^^^^^^
Number of instances indexed per indexing.
(Ignored by pixelDataEventLogQueue)

Default: `50`

.. property:: omero.pixeldata.cron

omero.pixeldata.cron
^^^^^^^^^^^^^^^^^^^^
Polling frequency of the pixeldata processing. Set empty to disable
pixeldata processing.

.. |cron| replace::
  Cron Format: seconds minutes hours day-of-month month day-of-week year
  (optional). For example, "0,30 * * * * ?" is equivalent to running every
  30 seconds. For more information download the latest *1.x version* of
  the `Quartz Job Scheduler`_ and review
  :file:`docs/api/org/quartz/CronExpression.html` within the distribution.

.. _Quartz Job Scheduler:
  http://www.quartz-scheduler.org/downloads/

|cron|

Default: `*/4 * * * * ?`

.. property:: omero.pixeldata.dispose

omero.pixeldata.dispose
^^^^^^^^^^^^^^^^^^^^^^^
Whether the PixelData.dispose() method should
try to clean up ByteBuffer instances which may
lead to memory exceptions. See ticket #11675
for more information. Note: the property is
set globally for the JVM.

Default: `true`

.. property:: omero.pixeldata.event_log_loader

omero.pixeldata.event_log_loader
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
EventLogLoader that will be used for loading EventLogs for
the action "PIXELDATA". Choices include: pixelDataEventLogQueue
and the older pixelDataPersistentEventLogLoader

Default: `pixelDataEventLogQueue`

.. property:: omero.pixeldata.max_plane_height

omero.pixeldata.max_plane_height
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
With :property:`omero.pixeldata.max_plane_width`, specifies
the plane size cutoff above which a pixel pyramid will be
generated by the pixeldata service unless subresolutions
can be read from the file format.
These values will be ignored for floating or double pixel
data types where no pyramid will be generated.

Default: `3192`

.. property:: omero.pixeldata.max_plane_width

omero.pixeldata.max_plane_width
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
With :property:`omero.pixeldata.max_plane_height`, specifies
the plane size cutoff above which a pixel pyramid will be
generated by the pixeldata service unless subresolutions
can be read from the file format.
These values will be ignored for floating or double pixel
data types where no pyramid will be generated.

Default: `3192`

.. property:: omero.pixeldata.memoizer_wait

omero.pixeldata.memoizer_wait
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Maximum time in milliseconds that file parsing
can take without the parsed metadata being
cached to BioFormatsCache.

Default: `0`

.. property:: omero.pixeldata.repetitions

omero.pixeldata.repetitions
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Instead, it is possible to tell the server
to run more pixeldata repetitions, each of
which gets completely committed before the
next. This will only occur when there is
a substantial backlog of pixels to process.

(Ignored by pixelDataEventLogQueue; uses threads instead)

Default: `1`

.. property:: omero.pixeldata.threads

omero.pixeldata.threads
^^^^^^^^^^^^^^^^^^^^^^^
How many pixel pyramids will be generated
at a single time. The value should typically
not be set to higher than the number of
cores on the server machine.

Default: `2`

.. property:: omero.pixeldata.tile_height

omero.pixeldata.tile_height
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `256`

.. property:: omero.pixeldata.tile_sizes_bean

omero.pixeldata.tile_sizes_bean
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Default sizes for tiles are provided by a
ome.io.nio.TileSizes implementation. By default
the bean ("configuredTileSizes") uses the properties
provided here.

Default: `configuredTileSizes`

.. property:: omero.pixeldata.tile_width

omero.pixeldata.tile_width
^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `256`


.. _policy_configuration:

Policy
------

.. property:: omero.policy.bean

omero.policy.bean
^^^^^^^^^^^^^^^^^
Instance of the PolicyService interface which
will be responsible for checking certain server
actions made by a user.

Default: `defaultPolicyService`

.. property:: omero.policy.binary_access

omero.policy.binary_access
^^^^^^^^^^^^^^^^^^^^^^^^^^
Configuration for the policy of whether users
can access binary files from disk. Binary access
includes all attempts to download a file from the
UI.

The individual components of the string include:

- write - whether or not users who have WRITE
  access to the objects can access the binary.
  This includes group and system administrators.

- read - whether or not users who have READ
  access to the objects can access the binary.

- image - whether or not images are to be considered
  accessible as a rule.

- plate - whether or not plates and contained HCS
  objects are to be considered accessible as a rule.
  This includes wells, well samples, and plate runs.

Though the order of the components of the property
are not important, the order that they are listed above
roughly corresponds to their priority. E.g. a -write
value will override +plate.

Example 1: "-read,+write,+image,-plate" only owners
of an image and admins can download it.

Example 2: "-read,-write,-image,-plate" no downloading
is possible.

Configuration properties of the same name can be applied
to individual groups as well. E.g. adding,
omero.policy.binary_access=-read to a group, you can
prevent group-members from downloading original files.

Configuration is pessimistic: if there is a negative
*either* on the group *or* at the server-level, the
restriction will be applied. A missing value at the
server restricts the setting but allows the server
to override.


Default: `+read,
+write,
+image`


.. _ports_configuration:

Ports
-----

.. property:: omero.ports.prefix

omero.ports.prefix
^^^^^^^^^^^^^^^^^^
The prefix to apply to all port numbers (SSL, TCP, registry) used by the
server

Default: `[empty]`

.. property:: omero.ports.registry

omero.ports.registry
^^^^^^^^^^^^^^^^^^^^
The IceGrid registry port number to use

Default: `4061`

.. property:: omero.ports.ssl

omero.ports.ssl
^^^^^^^^^^^^^^^
The Glacier2 SSL port number to use

Default: `4064`

.. property:: omero.ports.tcp

omero.ports.tcp
^^^^^^^^^^^^^^^
The Glacier2 TCP port number to use

Default: `4063`


.. _scripts_configuration:

Scripts
-------

.. property:: omero.launcher.jython

omero.launcher.jython
^^^^^^^^^^^^^^^^^^^^^
Executable on the PATH which will be used for scripts
with the mimetype 'text/x-jython'.

Default: `jython`

.. property:: omero.launcher.matlab

omero.launcher.matlab
^^^^^^^^^^^^^^^^^^^^^
Executable on the PATH which will be used for scripts
with the mimetype 'text/x-matlab'.

Default: `matlab`

.. property:: omero.launcher.python

omero.launcher.python
^^^^^^^^^^^^^^^^^^^^^
Executable on the PATH which will be used for scripts
with the mimetype 'text/x-python'.

No value implies use sys.executable

Default: `[empty]`

.. property:: omero.process.jython

omero.process.jython
^^^^^^^^^^^^^^^^^^^^
Server implementation which will be used for scripts
with the mimetype 'text/x-jython'. Changing this value
requires that the appropriate class has been installed
on the server.

Default: `omero.processor.ProcessI`

.. property:: omero.process.matlab

omero.process.matlab
^^^^^^^^^^^^^^^^^^^^
Server implementation which will be used for scripts
with the mimetype 'text/x-matlab'. Changing this value
requires that the appropriate class has been installed
on the server.

Default: `omero.processor.MATLABProcessI`

.. property:: omero.process.python

omero.process.python
^^^^^^^^^^^^^^^^^^^^
Server implementation which will be used for scripts
with the mimetype 'text/x-python'. Changing this value
requires that the appropriate class has been installed
on the server.

Default: `omero.processor.ProcessI`

.. property:: omero.scripts.cache.cron

omero.scripts.cache.cron
^^^^^^^^^^^^^^^^^^^^^^^^
Frequency to reload script params. By default,
once a day at midnight.

|cron|

Default: `0 0 0 * * ?`

.. property:: omero.scripts.cache.spec

omero.scripts.cache.spec
^^^^^^^^^^^^^^^^^^^^^^^^
Guava LoadingCache spec for configuring how
many script JobParams will be kept in memory
for how long.

For more information, see
http://google.github.io/guava/releases/17.0/api/docs/com/google/common/cache/CacheBuilderSpec.html

Default: `maximumSize=1000`

.. property:: omero.scripts.timeout

omero.scripts.timeout
^^^^^^^^^^^^^^^^^^^^^

Default: `3600000`


.. _search_configuration:

Search
------

.. property:: omero.search.analyzer

omero.search.analyzer
^^^^^^^^^^^^^^^^^^^^^
Analyzer used both index and to parse queries

Default: `ome.services.fulltext.FullTextAnalyzer`

.. property:: omero.search.batch

omero.search.batch
^^^^^^^^^^^^^^^^^^
Size of the batches to process events per indexing.
Larger batches can speed up indexing, but at the cost of memory.

Default: `5000`

.. property:: omero.search.bridges

omero.search.bridges
^^^^^^^^^^^^^^^^^^^^
Extra bridge classes, comma-separated, to be invoked on each indexing.
Bridges are used to parse more information out of the data.

Default: `[empty]`

.. property:: omero.search.cron

omero.search.cron
^^^^^^^^^^^^^^^^^
Polling frequency of the indexing. Set empty to disable search indexing.

|cron|

Default: `*/2 * * * * ?`

.. property:: omero.search.event_log_loader

omero.search.event_log_loader
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `eventLogQueue`

.. property:: omero.search.excludes

omero.search.excludes
^^^^^^^^^^^^^^^^^^^^^
Indexing takes place on all EventLogs as they occur in the database.
The types listed here will be skipped if they appear in the "entityType"
field of the EventLog table.

Default: `ome.model.annotations.ChannelAnnotationLink,
ome.model.core.Channel,
ome.model.core.PlaneInfo,
ome.model.core.PixelsOriginalFileMap,
ome.model.containers.DatasetImageLink,
ome.model.containers.ProjectDatasetLink,
ome.model.containers.CategoryGroupCategoryLink,
ome.model.containers.CategoryImageLink,
ome.model.display.ChannelBinding,
ome.model.display.QuantumDef,
ome.model.display.Thumbnail,
ome.model.meta.Share,
ome.model.meta.Event,
ome.model.meta.EventLog,
ome.model.meta.GroupExperimenterMap,
ome.model.meta.Node,
ome.model.meta.Session,
ome.model.annotations.RoiAnnotationLink,
ome.model.roi.Roi,
ome.model.roi.Shape,
ome.model.roi.Text,
ome.model.roi.Rectangle,
ome.model.roi.Mask,
ome.model.roi.Ellipse,
ome.model.roi.Point,
ome.model.roi.Path,
ome.model.roi.Polygon,
ome.model.roi.Polyline,
ome.model.roi.Line,
ome.model.screen.ScreenAcquisitionWellSampleLink,
ome.model.screen.ScreenPlateLink,
ome.model.screen.WellReagentLink,
ome.model.stats.StatsInfo`

.. property:: omero.search.include_actions

omero.search.include_actions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
EventLog.action values which will be indexed.
Unless custom code is generating other action
types, this property should not need to be
modified.

Default: `INSERT,
UPDATE,
REINDEX,
DELETE`

.. property:: omero.search.include_types

omero.search.include_types
^^^^^^^^^^^^^^^^^^^^^^^^^^
Whitelist of object types which will be
indexed. All other types will be ignored.
This matches the currently available UI
options but may need to be expanded for
custom search bridges.

Default: `ome.model.core.Image,
ome.model.containers.Project,
ome.model.containers.Dataset,
ome.model.screen.Plate,
ome.model.screen.Screen,
ome.model.screen.PlateAcquisition,
ome.model.screen.Well`

.. property:: omero.search.locking_strategy

omero.search.locking_strategy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `native`

.. property:: omero.search.max_file_size

omero.search.max_file_size
^^^^^^^^^^^^^^^^^^^^^^^^^^
Maximum file size for text indexing (bytes)
If a file larger than this is attached, e.g. to an image, the indexer will
simply ignore the contents of the file when creating the search index.
This should not be set to more than half of the Indexer heap space.

.. note::
  If you set the max file size to greater than 1/2 the size of the
  indexer's heap (256 MB by default), you may encounter Out of Memory
  errors in the Indexer process or you may cause the search index to
  become corrupt. Be sure that you also increase the heap size accordingly
  (see :ref:`out_of_memory_error`).

Default: `131072000`

.. property:: omero.search.max_partition_size

omero.search.max_partition_size
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Number of objects to load in a single
indexing window. The larger this value
the fewer times a single object will be
indexed unnecessarily. Each object uses
roughly 100 bytes of memory.

Default: `1000000`

.. property:: omero.search.maxclause

omero.search.maxclause
^^^^^^^^^^^^^^^^^^^^^^
Maximum number of OR-clauses to which a single search can expand

Default: `4096`

.. property:: omero.search.merge_factor

omero.search.merge_factor
^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `25`

.. property:: omero.search.ram_buffer_size

omero.search.ram_buffer_size
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `64`

.. property:: omero.search.repetitions

omero.search.repetitions
^^^^^^^^^^^^^^^^^^^^^^^^
Instead, it is possible to tell the server
to run more indexing repetitions, each of
which gets completely committed before the
next. This will only occur when there is
a substantial backlog of searches to perform.
(More than 1 hours worth)


Default: `1`

.. property:: omero.search.reporting_loops

omero.search.reporting_loops
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Periodically the completion percentage will be printed.
The calculation can be expensive and so is not done
frequently.

Default: `100`


.. _security_configuration:

Security
--------

.. property:: omero.security.chmod_strategy

omero.security.chmod_strategy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `groupChmodStrategy`

.. property:: omero.security.filter.bitand

omero.security.filter.bitand
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `(int8and(permissions,
%s) = %s)`

.. property:: omero.security.keyStore

omero.security.keyStore
^^^^^^^^^^^^^^^^^^^^^^^
A keystore is a database of private keys and their associated X.509
certificate chains authenticating the corresponding public keys.
A keystore is mostly needed if you are doing client-side certificates
for authentication against your LDAP server.

Default: `[empty]`

.. property:: omero.security.keyStorePassword

omero.security.keyStorePassword
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sets the password of the keystore

Default: `[empty]`

.. property:: omero.security.login_failure_throttle_count

omero.security.login_failure_throttle_count
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `1`

.. property:: omero.security.login_failure_throttle_time

omero.security.login_failure_throttle_time
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Default: `3000`

.. property:: omero.security.password_provider

omero.security.password_provider
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Implementation of PasswordProvider that will be
used to authenticate users. Typically, a chained
password provider will be used so that if one form
of authentication (e.g. LDAP) does not work, other
attempts will be made.

Default: `chainedPasswordProvider`

.. property:: omero.security.password_required

omero.security.password_required
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Controls whether the server will allow creation of user accounts
with an empty password. If set to true (default, strict mode),
empty passwords are disallowed. This still allows the guest user
to interact with the server.

Default: `true`

.. property:: omero.security.trustStore

omero.security.trustStore
^^^^^^^^^^^^^^^^^^^^^^^^^
A truststore is a database of trusted entities and their associated X.509
certificate chains authenticating the corresponding public keys. The
truststore contains the Certificate Authority (CA) certificates and the
certificate(s) of the other party to which this entity intends to send
encrypted (confidential) data. This file must contain the public key
certificates of the CA and the client's public key certificate.

Default: `[empty]`

.. property:: omero.security.trustStorePassword

omero.security.trustStorePassword
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sets the password of the truststore

Default: `[empty]`


.. _web_configuration:

Web
---

.. property:: omero.web.admins

omero.web.admins
^^^^^^^^^^^^^^^^
A list of people who get code error notifications whenever the application identifies a broken link or raises an unhandled exception that results in an internal server error. This gives the administrators immediate notification of any errors, see :doc:`/sysadmins/mail`. Example:``'[["Full Name", "email address"]]'``.

Default: `[]`

.. property:: omero.web.application_server

omero.web.application_server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
OMERO.web is configured to run in Gunicorn as a generic WSGI application by default. If you are using Apache change this to "wsgi" before generating your web server configuration. Available options: "wsgi-tcp" (Gunicorn), "wsgi" (Apache)

Default: `wsgi-tcp`

.. property:: omero.web.application_server.host

omero.web.application_server.host
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Upstream application host

Default: `127.0.0.1`

.. property:: omero.web.application_server.max_requests

omero.web.application_server.max_requests
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The maximum number of requests a worker will process before restarting.

Default: `0`

.. property:: omero.web.application_server.port

omero.web.application_server.port
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Upstream application port

Default: `4080`

.. property:: omero.web.apps

omero.web.apps
^^^^^^^^^^^^^^
Add additional Django applications. For example, see :doc:`/developers/Web/CreateApp`

Default: `[]`

.. property:: omero.web.caches

omero.web.caches
^^^^^^^^^^^^^^^^
OMERO.web offers alternative session backends to automatically delete stale data using the cache session store backend, see :djangodoc:`Django cached session documentation <topics/http/sessions/#using-cached-sessions>` for more details.

Default: `{"default": {"BACKEND": "django.core.cache.backends.dummy.DummyCache"}}`

.. property:: omero.web.chunk_size

omero.web.chunk_size
^^^^^^^^^^^^^^^^^^^^
Size, in bytes, of the “chunk”

Default: `1048576`

.. property:: omero.web.cors_origin_allow_all

omero.web.cors_origin_allow_all
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If True, cors_origin_whitelist will not be used and all origins will be authorized to make cross-site HTTP requests.

Default: `false`

.. property:: omero.web.cors_origin_whitelist

omero.web.cors_origin_whitelist
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A list of origin hostnames that are authorized to make cross-site HTTP requests. Used by the django-cors-headers app as described at https://github.com/ottoyiu/django-cors-headers

Default: `[]`

.. property:: omero.web.databases

omero.web.databases
^^^^^^^^^^^^^^^^^^^


Default: `{}`

.. property:: omero.web.debug

omero.web.debug
^^^^^^^^^^^^^^^
A boolean that turns on/off debug mode.

Default: `false`

.. property:: omero.web.index_template

omero.web.index_template
^^^^^^^^^^^^^^^^^^^^^^^^
Define template used as an index page ``http://your_host/omero/``.If None user is automatically redirected to the login page.For example use 'webclient/index.html'. 

Default: `None`

.. property:: omero.web.logdir

omero.web.logdir
^^^^^^^^^^^^^^^^
A path to the custom log directory.

Default: `/home/omero/OMERO.server/var/log`

.. property:: omero.web.login_logo

omero.web.login_logo
^^^^^^^^^^^^^^^^^^^^
Customize webclient login page with your own logo. Logo images should ideally be 150 pixels high or less and will appear above the OMERO logo. You will need to host the image somewhere else and link to it with the OMERO logo.

Default: `None`

.. property:: omero.web.login_redirect

omero.web.login_redirect
^^^^^^^^^^^^^^^^^^^^^^^^
Redirect to the given location after logging in. It only supports arguments for :djangodoc:`Django reverse function <ref/urlresolvers/#django.core.urlresolvers.reverse>`. For example: ``'{"redirect": ["webindex"], "viewname": "load_template", "args":["userdata"], "query_string": {"experimenter": -1}}'``

Default: `{}`

.. property:: omero.web.login_view

omero.web.login_view
^^^^^^^^^^^^^^^^^^^^


Default: `weblogin`

.. property:: omero.web.middleware

omero.web.middleware
^^^^^^^^^^^^^^^^^^^^
Warning: Only system administrators should use this feature. List of Django middleware classes in the form [{"class": "class.name", "index": FLOAT}]. See https://docs.djangoproject.com/en/1.8/topics/http/middleware/. Classes will be ordered by increasing index

Default: `[{"index": 1, "class": "django.middleware.common.BrokenLinkEmailsMiddleware"},{"index": 2, "class": "django.middleware.common.CommonMiddleware"},{"index": 3, "class": "django.contrib.sessions.middleware.SessionMiddleware"},{"index": 4, "class": "django.middleware.csrf.CsrfViewMiddleware"},{"index": 5, "class": "django.contrib.messages.middleware.MessageMiddleware"}]`

.. property:: omero.web.open_with

omero.web.open_with
^^^^^^^^^^^^^^^^^^^
A list of viewers that can be used to display selected Images or other objects. Each viewer is defined as ``["Name", "url", options]``. Url is reverse(url). Selected objects are added to the url as ?image=:1&image=2Objects supported must be specified in options with e.g. ``{"supported_objects":["images"]}`` to enable viewer for one or more images.

Default: `[["Image viewer", "webgateway", {"supported_objects": ["image"],"script_url": "webclient/javascript/ome.openwith_viewer.js"}]]`

.. property:: omero.web.page_size

omero.web.page_size
^^^^^^^^^^^^^^^^^^^
Number of images displayed within a dataset or 'orphaned' container to prevent from loading them all at once.

Default: `200`

.. property:: omero.web.ping_interval

omero.web.ping_interval
^^^^^^^^^^^^^^^^^^^^^^^
Timeout interval between ping invocations in seconds

Default: `60000`

.. property:: omero.web.pipeline_css_compressor

omero.web.pipeline_css_compressor
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Compressor class to be applied to CSS files. If empty or None, CSS files won't be compressed.

Default: `None`

.. property:: omero.web.pipeline_js_compressor

omero.web.pipeline_js_compressor
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Compressor class to be applied to JavaScript files. If empty or None, JavaScript files won't be compressed.

Default: `None`

.. property:: omero.web.pipeline_staticfile_storage

omero.web.pipeline_staticfile_storage
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The file storage engine to use when collecting static files with the collectstatic management command. See `the documentation <http://django-pipeline.readthedocs.org/en/latest/storages.html>`_ for more details.

Default: `pipeline.storage.PipelineStorage`

.. property:: omero.web.prefix

omero.web.prefix
^^^^^^^^^^^^^^^^
Used as the value of the SCRIPT_NAME environment variable in any HTTP request.

Default: `None`

.. property:: omero.web.public.cache.enabled

omero.web.public.cache.enabled
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Default: `false`

.. property:: omero.web.public.cache.key

omero.web.public.cache.key
^^^^^^^^^^^^^^^^^^^^^^^^^^


Default: `omero.web.public.cache.key`

.. property:: omero.web.public.cache.timeout

omero.web.public.cache.timeout
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Default: `86400`

.. property:: omero.web.public.enabled

omero.web.public.enabled
^^^^^^^^^^^^^^^^^^^^^^^^
Enable and disable the OMERO.web public user functionality.

Default: `false`

.. property:: omero.web.public.get_only

omero.web.public.get_only
^^^^^^^^^^^^^^^^^^^^^^^^^
Restrict public users to GET requests only

Default: `true`

.. property:: omero.web.public.password

omero.web.public.password
^^^^^^^^^^^^^^^^^^^^^^^^^
Password to use during authentication.

Default: `None`

.. property:: omero.web.public.server_id

omero.web.public.server_id
^^^^^^^^^^^^^^^^^^^^^^^^^^
Server to authenticate against.

Default: `1`

.. property:: omero.web.public.url_filter

omero.web.public.url_filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Set a URL filter for which the OMERO.web public user is allowed to navigate. The idea is that you can create the public pages yourself (see OMERO.web framework since we do not provide public pages.

Default: `^/(?!webadmin)`

.. property:: omero.web.public.user

omero.web.public.user
^^^^^^^^^^^^^^^^^^^^^
Username to use during authentication.

Default: `None`

.. property:: omero.web.secret_key

omero.web.secret_key
^^^^^^^^^^^^^^^^^^^^
A boolean that sets SECRET_KEY for a particular Django installation.

Default: `None`

.. property:: omero.web.secure

omero.web.secure
^^^^^^^^^^^^^^^^
Force all backend OMERO.server connections to use SSL.

Default: `false`

.. property:: omero.web.secure_proxy_ssl_header

omero.web.secure_proxy_ssl_header
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A tuple representing a HTTP header/value combination that signifies a request is secure. Example ``'["HTTP_X_FORWARDED_PROTO_OMERO_WEB", "https"]'``. For more details see :djangodoc:`secure proxy ssl header <ref/settings/#secure-proxy-ssl-header>`.

Default: `[]`

.. property:: omero.web.server_list

omero.web.server_list
^^^^^^^^^^^^^^^^^^^^^
A list of servers the Web client can connect to.

Default: `[["localhost", 4064, "omero"]]`

.. property:: omero.web.session_cookie_age

omero.web.session_cookie_age
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The age of session cookies, in seconds.

Default: `86400`

.. property:: omero.web.session_cookie_domain

omero.web.session_cookie_domain
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The domain to use for session cookies

Default: `None`

.. property:: omero.web.session_cookie_name

omero.web.session_cookie_name
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The name to use for session cookies

Default: `None`

.. property:: omero.web.session_engine

omero.web.session_engine
^^^^^^^^^^^^^^^^^^^^^^^^
Controls where Django stores session data. See :djangodoc:`Configuring the session engine for more details <ref/settings/#session-engine>`.

Default: `omeroweb.filesessionstore`

.. property:: omero.web.session_expire_at_browser_close

omero.web.session_expire_at_browser_close
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A boolean that determines whether to expire the session when the user closes their browser. See :djangodoc:`Django Browser-length sessions vs. persistent sessions documentation <topics/http/sessions/#browser-length-vs-persistent-sessions>` for more details.

Default: `true`

.. property:: omero.web.static_root

omero.web.static_root
^^^^^^^^^^^^^^^^^^^^^
The absolute path to the directory where collectstatic will collect static files for deployment. If the staticfiles contrib app is enabled (default) the collectstatic management command will collect static files into this directory.

Default: `/home/omero/OMERO.server/lib/python/omeroweb/static`

.. property:: omero.web.static_url

omero.web.static_url
^^^^^^^^^^^^^^^^^^^^
URL to use when referring to static files. Example: ``'/static/'`` or ``'http://static.example.com/'``. Used as the base path for asset  definitions (the Media class) and the staticfiles app. It must end in a slash if set to a non-empty value.

Default: `/static/`

.. property:: omero.web.staticfile_dirs

omero.web.staticfile_dirs
^^^^^^^^^^^^^^^^^^^^^^^^^
Defines the additional locations the staticfiles app will traverse if the FileSystemFinder finder is enabled, e.g. if you use the collectstatic or findstatic management command or use the static file serving view.

Default: `[]`

.. property:: omero.web.template_dirs

omero.web.template_dirs
^^^^^^^^^^^^^^^^^^^^^^^
List of locations of the template source files, in search order. Note that these paths should use Unix-style forward slashes.

Default: `[]`

.. property:: omero.web.thumbnails_batch

omero.web.thumbnails_batch
^^^^^^^^^^^^^^^^^^^^^^^^^^
Number of thumbnails retrieved to prevent from loading them all at once. Make sure the size is not too big, otherwise you may exceed limit request line, see http://docs.gunicorn.org/en/latest/settings.html?highlight=limit_request_line

Default: `50`

.. property:: omero.web.ui.center_plugins

omero.web.ui.center_plugins
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Add plugins to the center panels. Plugins are ``['Channel overlay', 'webtest/webclient_plugins/center_plugin.overlay.js.html', 'channel_overlay_panel']``. The javascript loads data into ``$('#div_id')``.

Default: `[]`

.. property:: omero.web.ui.metadata_panes

omero.web.ui.metadata_panes
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Manage Metadata pane accordion. This functionality is limited to the exiting sections.

Default: `[{"name": "tag", "label": "Tags", "index": 1},{"name": "map", "label": "Key-Value Pairs", "index": 2},{"name": "table", "label": "Tables", "index": 3},{"name": "file", "label": "Attachments", "index": 4},{"name": "comment", "label": "Comments", "index": 5},{"name": "rating", "label": "Ratings", "index": 6},{"name": "other", "label": "Others", "index": 7}]`

.. property:: omero.web.ui.right_plugins

omero.web.ui.right_plugins
^^^^^^^^^^^^^^^^^^^^^^^^^^
Add plugins to the right-hand panel. Plugins are ``['Label', 'include.js', 'div_id']``. The javascript loads data into ``$('#div_id')``.

Default: `[["Acquisition", "webclient/data/includes/right_plugin.acquisition.js.html", "metadata_tab"],["Preview", "webclient/data/includes/right_plugin.preview.js.html", "preview_tab"]]`

.. property:: omero.web.ui.top_links

omero.web.ui.top_links
^^^^^^^^^^^^^^^^^^^^^^
Add links to the top header: links are ``['Link Text', 'link|lookup_view', options]``, where the url is reverse('link'), simply 'link' (for external urls) or lookup_view is a detailed dictionary {"viewname": "str", "args": [], "query_string": {"param": "value" }], E.g. ``'["Webtest", "webtest_index"] or ["Homepage", "http://...", {"title": "Homepage", "target": "new"} ] or ["Repository", {"viewname": "webindex", "query_string": {"experimenter": -1}}, {"title": "Repo"}]'``

Default: `[["Data", "webindex", {"title": "Browse Data via Projects, Tags etc"}],["History", "history", {"title": "History"}],["Help", "http://help.openmicroscopy.org/",{"title":"Open OMERO user guide in a new tab", "target":"new"}]]`

.. property:: omero.web.use_x_forwarded_host

omero.web.use_x_forwarded_host
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Specifies whether to use the X-Forwarded-Host header in preference to the Host header. This should only be enabled if a proxy which sets this header is in use.

Default: `false`

.. property:: omero.web.viewer.view

omero.web.viewer.view
^^^^^^^^^^^^^^^^^^^^^
Django view which handles display of, or redirection to, the desired full image viewer.

Default: `omeroweb.webclient.views.image_viewer`

.. property:: omero.web.webgateway_cache

omero.web.webgateway_cache
^^^^^^^^^^^^^^^^^^^^^^^^^^


Default: `None`

.. property:: omero.web.wsgi_args

omero.web.wsgi_args
^^^^^^^^^^^^^^^^^^^
A string representing Gunicorn additional arguments. Check Gunicorn Documentation http://docs.gunicorn.org/en/latest/settings.html

Default: `None`

.. property:: omero.web.wsgi_timeout

omero.web.wsgi_timeout
^^^^^^^^^^^^^^^^^^^^^^
Workers silent for more than this many seconds are killed and restarted. Check Gunicorn Documentation http://docs.gunicorn.org/en/stable/settings.html#timeout

Default: `60`

.. property:: omero.web.wsgi_workers

omero.web.wsgi_workers
^^^^^^^^^^^^^^^^^^^^^^
The number of worker processes for handling requests. Check Gunicorn Documentation http://docs.gunicorn.org/en/stable/settings.html#workers

Default: `5`


