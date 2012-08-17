.. _server/install_macosx:

OMERO.server Mac OS X Manual Installation Walkthrough
=====================================================

.. topic:: Overview

    This walkthrough is a list of the commands used to install OMERO on a
    clean Mac OS 10.6 Snow Leopard (or 10.5 Leopard) by manually downloading
    and configuring the required components.

It is not a substitute for the general :ref:`server/installation` page
but is here to give a feel for the process.

Prerequisites
~~~~~~~~~~~~~

On a completely clean machine the first step is to install Xcode from
`Apple <https://developer.apple.com/technologies/tools/>`_.

Starting with the basics, you need a text editor. I downloaded
TextWrangler from
`http://www.barebones.com/products/TextWrangler/ <http://www.barebones.com/products/TextWrangler/>`_.
If you go to the menu :menuselection:`TextWrangler --> Install Command Line Tools...` this
will allow you to use the 'edit' command in the Terminal.

You also need Java (at least 1.5), which comes as standard on OS X 10.6
and 10.5.

PostgreSQL 8.4
~~~~~~~~~~~~~~

Download PostgreSQL 8.4 or later from
`the PostgreSQL downloads page <http://www.postgresql.org/download/macosx>`_.
Run the postgres installer, choosing the default port of
5432. To add the PostgreSQL to the PATH, you need to edit the profile of
the bash shell (Terminal).

Make sure you are in your home directory, then open .profile in a text
editor.

::

    $ pwd
    /Users/will
    $ edit .profile

If the file didn't exist before, this will create the file. Now add the
following line and save.

::

    export PATH=$PATH:/Library/PostgreSQL/8.4/bin/

You may need to restart the Terminal for this change to take effect.

ICE
~~~

Now for ICE. You need
`Ice-3.3.1 <http://www.zeroc.com/download_3_3_1.html>`_. I unzipped the
Ice-3.3.1-bin-macosx.tar.gz on my Desktop...

Now I need to move it into the /opt/ directory. I needed to create this
as it didn't exist. See if it's there.

::

    $ cd ../../
    $ ls -al
    drwxr-xr-x   3 will    admin       102 19 Oct 12:13 opt

If it's not in the listed folders create it, then move the Ice folder
into opt. You will have to do 'sudo' to have permissions to create and
move stuff into this root folder.

::

    $ sudo mkdir /opt
    $ cd Users/will/
    $ sudo mv Desktop/Ice-3.3.1/ /opt

Now you need to edit the .profile again, to include the various
components of Ice. Add these lines to the .profile, editing the location
of your Ice directory as appropriate in the first line:

::

    export ICE_HOME=/opt/Ice-3.3.1
    export PATH=$PATH:$ICE_HOME/bin
    export PYTHONPATH=$ICE_HOME/python:$PYTHONPATH
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ICE_HOME/lib

Python
~~~~~~

Now, check you have Python (and what version) by typing python
--version:

::

    $ python --version
    Python 2.5.1
    $

Python Imaging Library, Matplotlib (numpy, mencoder etc)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These Python components are not required for the majority of OMERO
server and client functionality, so they can be omitted if you want a
simpler install process and installed later as necessary. The Python
Imaging Library (PIL) is used for creating Figures for export (e.g.
exporting movie) and Matplotlib is used for some charts (server usage
figure) on the web client. Matplotlib requires numpy, which will also be
needed for the PyTables functionality currently being developed.

I installed PIL using `these
instructions <http://www.p16blog.com/p16/2008/05/appengine-installing-pil-on-os-x-1053.html>`_,
downloading from
`here <http://pythonmac.org/packages/py25-fat/index.html>`__.

To get matplotlib, go to their
`web-site <http://matplotlib.sourceforge.net/>`_ and click the download
button, which takes you
`here <http://sourceforge.net/projects/matplotlib/files/matplotlib/matplotlib-0.99.1/>`__.
I downloaded the matplotlib-0.99.1.1-py2.5-macosx10.5.dmg and installed
from there.

For the movie export to work, you need the mencoder command installed.
Follow the instructions for Mac on the :ref:`movie page <server/omeromovie>`. I
unzipped the :snapshot:`mencoder.zip <mencoder/mac/>`
in my Downloads folder, then moved it to usr/local/bin:

::

    sudo mv /Users/will/Downloads/mencoder /usr/local/bin/mencoder

OMERO
~~~~~

I downloaded the server, moved the folder to Desktop and renamed it
omero.

Followed the database configuration steps as described. In this case I
used the "default" names suggested on the install page for user:
"db\_user" with password "db\_password" and database name
"omero\_database".

::

    $ sudo -u postgres createuser -P -D -R -S db_user
    Enter password for new role:       # db_password
    Enter it again:       # db_password
    $ sudo -u postgres createdb -O db_user omero_database
    $ sudo -u postgres createlang plpgsql omero_database
    createlang: language "plpgsql" is already installed in database "omero_database"
    $ psql -h localhost -U db_user -l
    Password for user db_user: 
            List of databases
       Name         |  Owner   | Encoding 
    ----------------+----------+----------
     omero_database | db_user  | UTF8
     postgres       | postgres | UTF8
     template0      | postgres | UTF8
     template1      | postgres | UTF8
     (4 rows)

Your table might be slightly different but you should see that the omero
database exists.

Made the /OMERO directory (as root), then allow the regular user to
write to it.

::

    $ sudo mkdir /OMERO
    $ whoami
    will
    $ sudo chown -R will /OMERO

Now edit any configurations for connecting to the database.

::

    $ cd Desktop/omero
    $ bin/omero config set omero.db.name omero_database
    $ bin/omero config set omero.db.user db_user
    $ bin/omero config set omero.db.pass db_password

Then set-up the db as described:

::

    $ bin/omero db script
    Please enter omero.db.version [OMERO4.3]: 
    Please enter omero.db.patch [0]: 
    Please enter password for OMERO root user:       # root_password
    Please re-enter password for OMERO root user:       # root_password
    Saving to /Users/will/Desktop/omero/OMERO4.3__0.sql

Then enter the name of the .sql (see last line above) in the next
command, to create the database:

::

    $ psql -h localhost -U db_user omero_database < OMERO4.3__0.sql

Now START the server!

::

    $ bin/omero admin start

At this point, you should be able to download the OMERO clients and log
in using the 'root' username and password 'root\_password'.

OMERO.web
~~~~~~~~~

If you want to use the web-client to connect to the server or the
web-admin to add new users, read on for instructions on how I set up the
development server.

::

    $ bin/omero config set omero.web.application_server development
    $ bin/omero web syncmedia

Now start web

::

    $ bin/omero web start
    Starting django development webserver... 
    Validating models...
    0 errors found

    Django version 1.1.1, using settings 'omeroweb.settings'
    Development server is running at http://0.0.0.0:4080/
    Quit the server with CONTROL-C.

And at this point I was able to go to the localhost on this machine and
log in as root user at http://localhost:4080/webadmin/

To stop web server simply hit CONTROL-C