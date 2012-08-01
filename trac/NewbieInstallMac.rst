Deprecated Page

Installing OMERO server on Mac
==============================

Please see
` http://www.openmicroscopy.org.uk/site/support/omero4/server/install-omero-4.2-on-mac-os-x-10.5 <http://www.openmicroscopy.org.uk/site/support/omero4/server/install-omero-4.2-on-mac-os-x-10.5>`_
for a more recent version of this page.

This page is an account of an install of the OMERO 4.1 server on a clean
Mac OS X 10.5 machine, following the instructions
` https://www.openmicroscopy.org.uk/site/support/omero4/server/installation\_4\_1 <https://www.openmicroscopy.org.uk/site/support/omero4/server/installation_4_1>`_
.

Prerequisites
-------------

Starting with the basics, you need a text editor. I downloaded
` TextWrangler <http://www.barebones.com/products/TextWrangler/>`_.

You also need Java (at least 1.5), which comes as standard on OS X 10.5.

PostgreSQL 8.3
~~~~~~~~~~~~~~

I downloaded PostgreSQL from here
` http://www.postgresql.org/download/macosx <http://www.postgresql.org/download/macosx>`_
I went for PostgreSQL 8.4 BUT this required editing some trust
configuration to allow access!?! MUCH easier to download PostgreSQL 8.3,
which is still available. To add the PostgreSQL to the PATH, you need to
edit the profile of the bash shell (Terminal).

In TextWrangler?, go to File > "Open Hidden" and look in your home
directory /User/will for the .bash\_profile file. If it is not there,
create a new file and add this line (edited to your equivalent
location).

::

    export PATH=$PATH:/Library/PostgreSQL/8.4/bin/

Then save this file in your home directory, start Terminal and type the
commands described on
` https://www.openmicroscopy.org.uk/site/support/omero4/server/postgresql <https://www.openmicroscopy.org.uk/site/support/omero4/server/postgresql>`_

ICE
~~~

Now for ICE. I followed the link
` http://www.zeroc.com/download.html <http://www.zeroc.com/download.html>`_
got the Ice-3.3.1-bin-macosx.tar.gz under Binary Archive: MacOS X (Intel
x86) Archive. I unzipped the file and put the folder on my Desktop.

Now I need to move it into the /opt/ directory. I needed to create this
as it didn't exist. See if it's there.

::

    ten-five-eight-2009-08-06:~ will$ cd ../../
    ten-five-eight-2009-08-06:/ will$ ls -al
    drwxr-xr-x   3 will    admin       102 19 Oct 12:13 opt

If it's not in the listed folders create it, then move the Ice folder
into opt

::

    ten-five-eight-2009-08-06:/ will$ mkdir /opt
    ten-five-eight-2009-08-06:/ will$ cd Users/will/
    ten-five-eight-2009-08-06:~ will$ mv Desktop/Ice-3.3.1/ /opt

Now you need to edit the .bash\_profile again, to include the various
components of Ice. Add these lines to the .bash\_profile, editing the
location of you Ice directory as appropriate in the first line:

::

    export ICE_HOME=/opt/Ice-3.3.1
    export PATH=$PATH:$ICE_HOME/bin
    export PYTHONPATH=$ICE_HOME/python:$PYTHONPATH
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ICE_HOME/lib

Python
~~~~~~

Now, check you have Python (and what version) by typing python:

::

    ten-five-eight-2009-08-06:~ will$ python
    Python 2.5.1 (r251:54863, Jun 17 2009, 20:37:34) 
    [GCC 4.0.1 (Apple Inc. build 5465)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> ^D
    ten-five-eight-2009-08-06:~ will$ 

Python Imaging Library and Matplotlib
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Download PIL from here
` http://www.pythonware.com/products/pil/ <http://www.pythonware.com/products/pil/>`_
as instructed. I got the Python Imaging Library 1.1.6 Source Kit (all
platforms) (440k TAR GZ). Change into the download directory and type
``sudo python setup.py install``

::

    ten-five-eight-2009-08-06:~ will$ cd Downloads/Imaging-1.1.6
    ten-five-eight-2009-08-06:Imaging-1.1.6 will$ sudo python setup.py install

You can check this worked by entering the python interactive shell and
typing import Image, which should work with no errors.

::

    ten-five-eight-2009-08-06:Imaging-1.1.6 will$ python
    Python 2.5.1 (r251:54863, Jun 17 2009, 20:37:34) 
    [GCC 4.0.1 (Apple Inc. build 5465)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import Image
    >>> 

I'm going to miss out Matplotlib, since it is only used for the
disk-space pie chart in the web-client, and it also requires numpy.
` http://sourceforge.net/projects/matplotlib/files/ <http://sourceforge.net/projects/matplotlib/files/>`_
and download matplotlib-0.99.1.1-py2.5-macosx10.5.dmg

OMERO
-----

I downloaded the server, moved the folder to Desktop and renamed it
omero. I configured the OMERO\_HOME variable in my .bash\_profile by
adding this line:

::

    export OMERO_HOME=/Users/will/Desktop/omero

Followed the database configuration steps as described...

::

    ten-five-eight-2009-08-06:~ will$ sudo -u postgres createuser -P -D -R -S omero
    Enter password for new role: 
    Enter it again: 
    ten-five-eight-2009-08-06:~ will$ sudo -u postgres createdb -O omero omero
    ten-five-eight-2009-08-06:~ will$ sudo -u postgres createlang plpgsql omero
    createlang: language "plpgsql" is already installed in database "omero"
    ten-five-eight-2009-08-06:~ will$ psql -h localhost -U omero -l
    Password for user omero: 
                                  List of databases
       Name    |  Owner   | Encoding | Collation | Ctype |   Access privileges   
    -----------+----------+----------+-----------+-------+-----------------------
     omero     | omero    | UTF8     | C         | C     | 
     postgres  | postgres | UTF8     | C         | C     | 
     template0 | postgres | UTF8     | C         | C     | =c/postgres
                                                         : postgres=CTc/postgres
     template1 | postgres | UTF8     | C         | C     | =c/postgres
                                                         : postgres=CTc/postgres
    (4 rows)

Made the /OMERO directory (as root), then allow the regular user to
write to it.

::

    ten-five-eight-2009-08-06:omero will$ sudo mkdir /OMERO
    ten-five-eight-2009-08-06:omero will$ whoami
    will
    ten-five-eight-2009-08-06:omero will$ sudo chown -R will /OMERO

Then set-up the db as described:

::

    ten-five-eight-2009-08-06:~ will$ cd Desktop/omero/
    ten-five-eight-2009-08-06:omero will$ bin/omero db script
    Please enter omero.db.version [OMERO4.1]: 
    Please enter omero.db.patch [0]: 
    Please enter password for OMERO root user: 
    Please re-enter password for OMERO root user: 
    Saving to /Users/will/Desktop/omero/OMERO4.1__0.sql
    ten-five-eight-2009-08-06:omero will$ 

Then enter the location of the .sql (see last line above) in the next
command, to create the database:

::

    psql -h localhost -U omero omero < OMERO4.1__0.sql

Now START the server!

::

    bin/omero admin start

I had a few things not work the first time (hadn't set-up database
permissions with bin/omero config set omero.db.pass TopSecret?) so I had
to stop the server with `` bin/omero admin stop ``, fix the problem and
then restart. NB. If you stop the server, sometimes you have to wait a
minute before restarting.

At this point, you should be able to download the OMERO clients and log
in using the 'root' username and password you specified above at the
prompt: "Please enter password for OMERO root user:".

OMERO.web
---------

If you want to use the web-client to connect to the server, read on... I
edited the PYTHONPATH as instructed (by adding this line to
.bash\_profile)

::

    export PYTHONPATH=$PYTHONPATH:~/Desktop/omero/lib/python/

so my PYTHONPATH is now....

::

    ten-five-eight-2009-08-06:~ will$ echo $PYTHONPATH
    /opt/Ice-3.3.1/python::/Users/will/Desktop/omero/lib/python/

Now I'm going to follow the settings instructions. I am using the
current IP of this computer from System Preferences > Sharing > Web
sharing (on).

::

    ten-five-eight-2009-08-06:omero will$ bin/omero web settings
    You just installed OMERO, which means you didn't have settings configured in OMERO.web.
    Please enter the domain you want to run OMERO.web on (http://www.domain.com:8000/)http://10.12.2.40:8000/
    Please enter the Email address you want to send from (omero_admin@example.com): will@dundee.ac.uk
    Please enter the SMTP server host you want to send from (smtp.example.com): smtp.dundee.ac.uk                           
    Optional: please enter the SMTP server port (default 25): 
    Optional: Please enter the SMTP server username: wmoore
    Optional: Password: 
    Optional: TSL? (yes/no): no
    Saving to /Users/will/Desktop/omero/lib/python/omeroweb/custom_settings.py
    ten-five-eight-2009-08-06:omero will$ 

Same with superuser

::

    ten-five-eight-2009-08-06:omero will$ bin/omero web superuser
    Please enter Username for OMERO.web administrator: ome
    Please enter Email address: will@lifesci.dundee.ac.uk
    Please enter password for OMERO.web administrator: 
    Please re-enter password for OMERO.web administrator: 
    Saving to /Users/will/Desktop/omero/lib/python/omeroweb/initial_data.json

    ten-five-eight-2009-08-06:omero will$ bin/omero web syncdb
    Database synchronization... 
    Creating table django_admin_log
    .
    .
    Installing json fixture 'initial_data' from absolute path.
    Installed 7 object(s) from 1 fixture(s)
    OMERO.web was prepared. Please start the application.
    ten-five-eight-2009-08-06:omero will$ 

Now enabled and started web

::

    ten-five-eight-2009-08-06:omero will$ bin/omero admin ice
    Ice 3.3.1  Copyright 2003-2009 ZeroC, Inc.
    >>> server enable Web
    >>> server start Web]
    error: couldn't find server `Web]'
    >>> server start Web
    >>> exit

And at this point I was able to go to the localhost on this machine and
log in as root user at
` http://localhost:8000/webclient/ <http://localhost:8000/webclient/>`_

I still needed to configure the IP so that other machines can connect to
the web-client. Following instructions to edit the three files as
described
` https://www.openmicroscopy.org.uk/site/support/omero4/server/installation\_4\_1 <https://www.openmicroscopy.org.uk/site/support/omero4/server/installation_4_1>`_

::

    ten-five-eight-2009-08-06:omero will$ edit etc/grid/default.xml 
    ten-five-eight-2009-08-06:omero will$ edit etc/grid/templates.xml 
    ten-five-eight-2009-08-06:omero will$ edit lib/python/omero/plugins/server.py

I stopped web server as described and started it again. Can now connect
from other machines to this one, using
` http://10.12.2.40:8000/webclient <http://10.12.2.40:8000/webclient>`_

You can now go to
` http://localhost:8000/webclient <http://localhost:8000/webclient>`_
(or
` http://10.12.2.40:8000/webclient <http://10.12.2.40:8000/webclient>`_
from another machine) and create Scientist (user) accounts, remembering
to check the "Active" checkbox.
