Troubleshooting OMERO
=====================

.. _troubleshooting-password:

Which user account and password do I use where?
-----------------------------------------------

Accounts table, including the example usernames and passwords
used in the installation guides:

============  ==========================  ==========  =============
Account type  Function                    Username    Password
============  ==========================  ==========  =============
System        Administrator/Root
System        (Database) service account  postgres
System        (OMERO) service account     omero_user
Database      Database administrator      postgres
Database      Database user               db_user     db_password
OMERO         OMERO administrator         root        root_password
OMERO         OMERO users
============  ==========================  ==========  =============

.. Note:: These example usernames and passwords are provided to help you 
    follow the installation guide examples. Do not use root_password or 
    db_password; substitute your own passwords.

There are a total of three types of user accounts: system, database and OMERO 
accounts.

System accounts
^^^^^^^^^^^^^^^

These are accounts on your machine or directory server (e.g. LDAP, Active
Directory). One account is used for running the OMERO server (either your own
or one you created specially for running OMERO, referred to here as
“omero_user”). There is also a user called the "root-level user" on the
:doc:`installation page <unix/server-installation>`. A separate
“postgres” user is used for running the database server. The “omero_user”
account runs the OMERO server, and owns the files uploaded to OMERO. This
account must have permission to write to the `/OMERO/` binary repository. Some
operations in the install scripts require the root-level/administrator-level
privileges in order to use another account to perform particular actions e.g.
the “postgres” user to create a database. However **the OMERO.server should
never be run as the root-level/administrator-level user or as the system-level
“postgres” user**.

Database accounts
^^^^^^^^^^^^^^^^^

The PostgreSQL database system contains user and administrative accounts; 
these are completely separate from the system accounts, above, existing only 
inside the database.  The database administrative user (“postgres”) is the 
owner of all the database resources, and can create new users internal to the 
database. A single database account is used at run time by OMERO to talk to 
your database. Therefore, you must configure the
:ref:`database <core_configuration>` values during installation:

::

   $ omero config set omero.db.user db_user
   $ omero config set omero.db.pass db_password

.. Note:: Do **not** use db_user or db_password here; substitute your own 
    username and password.

    A database user may have the same name as an account on your 
    machine, in which case a password might not be necessary.

OMERO accounts
^^^^^^^^^^^^^^

These accounts only exist inside the OMERO system, and are completely separate 
from both the system and database accounts, above.  The first user which you 
will need to configure is the “root” OMERO user (different from any root-level 
Unix account). This is done by setting the password in the database script,
see :doc:`cli/db`.

Other OMERO users can be created via the OMERO.web admin tool. None of the 
passwords have to be the same, in fact they should be different **unless you
are using the LDAP plugin**.

.. _server_fails_to_start:

Server fails to start
---------------------

1. Check that you are able to successfully connect to your PostgreSQL
   installation as outlined on the
   :doc:`PostgreSQL page <unix/server-postgresql>`).
2. Check the permissions on your :property:`omero.data.dir` (:file:`/OMERO` by
   default) as outlined on the :doc:`unix/server-installation` page.
3. Are you on a laptop? If you see an error message mentioning 
   :ticket:`"node master couldn't be reached" <7325>`, you
   may be suffering from a network address swap. Ice does not like to
   have its network changed as can happen if the server is running on a
   laptop on wireless. If you lose connectivity to icegridnode, you may
   have to kill it manually via ``kill PID`` or ``killall icegridnode``
   (under Unix).
4. If you see an error message mentioning
   :ticket:`"Freeze::DatabaseException" <5576>` or 
   :ticket:`"could not lock file: var/registry/\_\_Freeze/lock" <7325>`,
   your icegrid registry may have become corrupted. This is not a
   problem, but it will be necessary to stop OMERO and delete the
   ``var/master`` directory (e.g. ``rm -rf var/master``). When
   restarting OMERO, the registry will be automatically re-created.
5. If you see an error message mentioning "Protocol family unavailable",
   you will need to set the :property:`Ice.IPv6` property with
   :program:`omero config set Ice.IPv6 0`.
6. If you upgraded from a 5.0.2 server or older and copied the entire content
   of the :file:`etc/grid` directory from the old server to the new server,
   you will need to revert the changes made to :file:`templates.xml` to
   :ticket:`generate the new memory settings <12527>`.
7. If OMERO starts up, but fails to respond to connection requests, check
   `netstat -a` for port 4064. If nothing is listening on 4064, you may
   need to specify which network interface to use.
   :program:`omero config set Ice.Default.Host 127.0.0.1`, for example,
   would force OMERO to only listen on localhost. See :zerocdoc:`Proxy
   and Endpoint Syntax
   <ice/3.6/client-side-features/proxies/proxy-and-endpoint-syntax>`
   for more information.

.. _remote_clients_cannot_connect:

Remote clients cannot connect to OMERO installation
---------------------------------------------------

OMERO.web connects but not OMERO.insight
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Admin section of OMERO.web appears to work properly and you may or may not
have created some users, but no matter what you do remote clients will not
speak to OMERO. OMERO.insight gives you an error message similar to the
following despite giving the correct username and password:

.. figure:: /images/login_failure.png
   :align: center
   :width: 35%
   :alt: Login failure

This is often due to firewall misconfiguration on the machine that runs
your OMERO server, affecting the ability of remote clients to locate
it. A common issue is when port ``TCP/4064`` and/or ``TCP/4063`` is not opened,
run ``telnet server-name 4064`` (resp. ``4063``) to check if this is
the case. The output of the command should be:

::

    Trying server-name...
    Connected to server-name.
    Escape character is '^]'

Please see the :doc:`/sysadmins/server-security` page for more information.

SSL connection issues
^^^^^^^^^^^^^^^^^^^^^

Deployment platforms show a trend of making the transport layer security
policy tighter by default. The recommended way to overcome SSL
connection issues for OMERO clients connecting to the server is to
employ the :pypi:`omero-certificates<omero-certificates/>` plugin available from
PyPI_:

.. literalinclude:: unix/walkthrough/walkthrough_debian10.sh
    :start-after: #start-seclevel
    :end-before: #end-seclevel

Restart the OMERO.server as normal for the changes to take effect.

An alternative approach is to add the parameter ``@SECLEVEL=0`` to the
server SSL configuration.

Server crashes with...
----------------------

-  ``X11 connection rejected because of wrong authentication``
-  ``X connection to localhost:10.0 broken (explicit kill or server shutdown).``

OMERO uses image scaling and processing techniques that may be
interfered with when used with |SSH| X11-forwarding. You should disable
|SSH| X11-forwarding in your |SSH| session by using the ``-x`` flag as follows 
before you restart the OMERO.server:

::

    ssh -x my_server.examples.com

.. _out_of_memory_error:

OutOfMemoryError / PermGen space errors in OMERO.server logs
------------------------------------------------------------

Out of memory or permanent generation (PermGen) errors can be caused by
many things. You may be asking too much of the server. Or you may
require an increase in the maximum Java heap or the permanent generation
space. This can be done by modifying the configuration for your
OMERO.server. See :ref:`jvm_memory_settings`.

Similarly, if you are finding out of memory errors in one of the other
process logs (e.g. :file:`Indexer-0.log` or :file:`PixelData-0.log`),
you might try optimizing the JVM memory settings.

Furthermore, under certain conditions access of images greater than 4GB
can be problematic on 32-bit platforms due to certain bugs within the
Java Virtual Machine including `Bug ID: 4724038 <https://bugs.java.com/bugdatabase/view_bug.do?bug_id=4724038>`_. A 64-bit
platform for your OMERO.server is **HIGHLY** recommended.


.. _ulimit:

Too many open files
^^^^^^^^^^^^^^^^^^^

This is most often seen as an error during importing and is caused by the
number of opened files exceeding the limit imposed
by your operating system. It might be due to OMERO leaking file
descriptors; if you are not using the latest version, please upgrade,
since a number of bugs which could cause this behavior have been fixed.
It is also possible for buggy scripts which do not properly release
resources to cause this error.

To view the current per-process limit, run

::

            ulimit -Hn

which will show the hard limit for the maximum number of file
descriptors (-Sn will show the soft limit). This limit may be increased.
On Linux, see ``/etc/security/limits.conf`` (global PAM per-user limits
configuration); it is also possible to increase the limit in the shell
with

::

            ulimit -n newlimit

providing that you are uid 0 (other users can only increase the soft
limit up to the hard limit). To view the system limit, run

::

            cat /proc/sys/fs/file-max

**We recommend 8K as a minimum number of files limit for production systems,
with 16K being reasonable for bigger machines.**

On Mac OS X, the standard ulimit will not work properly. There are several
different ways of setting the ulimit, depending upon the version of OS X
you are using, but the most common are to edit ``sysctl.conf`` or
``launchd.conf`` to raise the limit. However, note that both of these
methods change the defaults for every process on the system, not just
for a single user or service.

Increasing the number of available filehandles via 'ulimit -n'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ValueError: filedescriptor out of range in select() - this is a known issue in 
Python versions prior to 2.7.0. See
:ticket:`6201` and Python `Issue #3392
<https://bugs.python.org/issue3392>`_ for more details.

Directory exists but is not registered
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Import errors of type ``Directory exists but is not registered: CheckedPath(username_id)``
suggest a server-side issue under the ManagedRepository.

For production servers, this can be caused by a server crash during import
or an issue at the file system level (permissions, renaming). If the
:file:`ManagedRepository/username_id` folder is empty, you should try removing 
it before trying another import.

For development servers, this may be caused by the binary directory not being
cleaned after the database has been wiped.

.. seealso::

    :forum:`Upload problem: Directory exists but is not registered. <viewtopic.php?f=5&t=7537>`

    :forum:`import: Directory exists but is not registered: CheckedPath( <viewtopic.php?f=6&t=7722&p=15264&hilit=CheckedPath#p15264>`

    :ome-devel:`[ome-devel] Directory exists but is not registered: CheckedPath(username_id) <2014-October/003020.html>`

Not enough heap space
^^^^^^^^^^^^^^^^^^^^^

::

            java.lang.OutOfMemoryError: Java heap space

If you get an out of memory error, you can try increasing the maximum Java heap space,
by setting the :envvar:`JAVA_OPTS` variable before running the import command.
For example to set a maximum heap space of 3GB:

::

            $ export JAVA_OPTS=-Xmx3G
            $ omero import ...

Another change that may be required is to adjust the OMERO.server configuration.
Run the following command:

::

  $ omero config set omero.jvmcfg.percent 22 # 15 is the default

Then restart the OMERO.server.

DropBox fails to start: failed to get session
---------------------------------------------

If the main server starts but DropBox fails with the following entry in
``var/log/DropBox.log``,

::

    2011-06-07 03:42:56,775 ERROR [        fsclient.DropBox] (MainThread) Failed to get Session: 

then it may be that the server is taking a relatively long time to
start.

A solution to this is to increase the number of retries and/or the
period (seconds) between retries in ``etc/grid/templates.xml``

::

    <property name="omero.fs.maxRetries"  value="5"/>
    <property name="omero.fs.retryInterval"  value="3"/>

.. _troubleshooting-search:

Search does not return expected results
---------------------------------------

If searching for a specific term does not return the expected results (e.g.
searching for the name of a tag does not return the full list of a user's
images annotated with that tag), there are a few things that may have gone
wrong. See :ref:`search-failures` for more details.


.. _troubleshooting-omeroweb:

OMERO.web issues
----------------

OMERO.web running but status says not started
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you upgraded OMERO but forgot to stop OMERO.web, processes will still be
running. In order to kill stale processes by hand, run::

    $ ps aux | grep django.pid

.. note::
    As Gunicorn is based on the pre-fork worker model it is enough to kill
    the master process, the one with the lowest PID.

OMERO.web not available HTTP 404
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Consult nginx :file:`error.log` for more details.

The most common problem appears when the default configuration for ``location /``
is loaded prior to omeroweb.conf

::

    2016/01/01 00:00:00 [error] 1234#0: *5 "/usr/share/nginx/html/webclient/login/index.html" is not found (2: No such file or directory), client: 1.2.3.4, server

OMERO.web not responding/timeout issues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    [CRITICAL] WORKER TIMEOUT (pid:1234)

OMERO.web deployed with Gunicorn relies on the operating system to provide
all of the load balancing while handling requests. Adjust the timeout using
:property:`omero.web.wsgi_timeout` and scale the number of
:property:`omero.web.wsgi_workers` starting with (2 x NUM_CORES) + 1 workers.
For more details refer to :ref:`omero_web_configuration`.

Issues with downloading data from OMERO.web
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

An :ref:`omero_web_configuration` is available for testing with nginx
if you are encountering problems with downloads failing. You can also
configure OMERO.web to limit downloads - refer to the :doc:`unix/install-web/web-deployment`
documentation and :ref:`download_restrictions` for further details.

OMERO.web piecharts
^^^^^^^^^^^^^^^^^^^

'Drive space' does not generate pie chart or 'My account' does not show markup 
picture and crop the picture options.

Error message says: 'Piechart could not be displayed. Please check log
file to solve the problem'. Please check ``var/log/OMEROweb.log`` for
more details. There are a few known possibilities:

-  'TclError: no display name and no $DISPLAY environment variable'.
   Turn off the compilation of TCL support in Matplotlib_.
-  'ImportError: No module named Image'. Install Pillow_
   (packages should be available for your distribution). Also double 
   check
   if all of the prerequisites were installed from
   :doc:`OMERO.web deployment <unix/install-web/web-deployment>`.

.. _client_performance:

Troubleshooting performance issues with the clients
---------------------------------------------------

If you are having issues with slowdown and timeouts in the clients, there are
three things to check:

-  your network connection
-  if you are running out of memory (processing large datasets can cause
   problems)
-  whether your server's HOME directory is on a network share

In the final case, two issues arise. Firstly, when performing some operations,
the clients make use of temporary file storage and log directories, as
described in the :ref:`client_directories` section of
:doc:`system-requirements`.
If your home directory is stored on a network, possibly NFS mounted (or
similar), then these temporary files are being written and read over the
network which can slow access down. Secondly, the OMERO.server also accesses
the temporary and log folders of the user the server process is running as. As
the server makes heavier use of these folders than the clients, if the
OMERO.server user directory is stored on a network drive then slow performance
can occur.

To resolve this, define the :envvar:`OMERO_TMPDIR` environment variable
to point at a temporary directory located on the local file system
(e.g. :file:`/tmp/omero`).

Other issues
------------

Connection problems and TCP window scaling on Linux systems
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Later versions of the 2.6 Linux kernel, specifically 2.6.17, have TCP
window scaling enabled by default. If you are having initial logins never
timeout or problems with connectivity in general you can try turning the
feature off as follows:

::

    # echo 0 > /proc/sys/net/ipv4/tcp_window_scaling


Server or clients print "WARNING: Prefs file removed in background..."
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    Nov 12, 2008 3:02:50 PM java.util.prefs.FileSystemPreferences$7 run
    WARNING: Prefs file removed in background /root/.java/.userPrefs/prefs.xml
    Nov 12, 2008 3:02:50 PM java.util.prefs.FileSystemPreferences$7 run
    WARNING: Prefs file removed in background /usr/lib/jvm/java-1.7.0-icedtea-1.7.0.0/jre/.systemPrefs/prefs.xml

These warnings (also sometimes listed as ERRORS) can be safely ignored,
and are solely related to how Java is installed on your system. See
`Bug ID: 4751177 <https://bugs.java.com/bugdatabase/view_bug.do?bug_id=4751177>`_ or
this :ome-users:`ome-users thread <2009-March/001465.html>` on our mailing
list for more information.

Data corruption
^^^^^^^^^^^^^^^

If you are dealing with a data corruption issue, you may find the information
on :ref:`pixelresolutionorder` useful.

PyTables version
^^^^^^^^^^^^^^^^

Version 3.3 of PyTables contains a bug preventing its usage,
see `issue #598 <https://github.com/PyTables/PyTables/issues/598#issuecomment-274154131>`_
.
PyTables on Debian 9 should be installed directly from PyPI_ instead of using ``python-tables``. To install, run:

.. parsed-literal::

    $ pip install 'tables<\ |version_tables_cap|'

