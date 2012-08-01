Installing `OmeroGrid </ome/wiki/OmeroGrid>`_ on Windows XP
===========================================================

Unlike all other supported platforms, the ``bin/omero`` script and
`OmeroGrid </ome/wiki/OmeroGrid>`_ are not responsible for starting and
stopping the `OmeroBlitz </ome/wiki/OmeroBlitz>`_ server and other
processes. Instead, that job is delegated to the native Windows service
system. A brief explanation of doing this via the ``sc`` command is
provided below.

Limitations
-----------

-  This has only been tested on 32bit installations.
-  The processor.py functionality will not be available on Windows in
   `milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_. See
   `#1004 </ome/ticket/1004>`_ for more information.

Requirements
------------

First, all of the requirements on
`OmeroInstallWindows </ome/wiki/OmeroInstallWindows>`_ should be
fulfilled. The JBoss server should be able to contact a Postgres
installation with an OMERO database. Then,

-  Install Ice 3.2.1 from
   ` ZeroC <http://www.zeroc.com/download_3_2_1.html>`_. The test
   installation used the
   ` Ice-3.2.1-VC80.msi <http://www.zeroc.com/download/Ice/3.2/Ice-3.2.1-VC80.msi>`_
   package.
-  Install Python. The test installation used Python 2.5 from ` Active
   State <http://www.activestate.com/store/activepython/download/>`_.
   2.5 is required.

Configuration
-------------

Because all `OmeroGrid </ome/wiki/OmeroGrid>`_ paths must be absolute
under Windows, several files must be two files must be edited for server
to start properly:

**etc\\Windows.cfg**
    Configuration file appended to the ``icegridnode --Ice.Config=...``
    executable on Windows. Contains paths for log output, and for
    finding ``templates.xml``.
**templates.xml**
    Shared templates used in all `OmeroGrid </ome/wiki/OmeroGrid>`_
    applications. The path definitions for both
    `OmeroBlitz </ome/wiki/OmeroBlitz>`_ and for ``processor.py`` must
    be made absolute.
    `|image1| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_templates.xml.png>`_

Installation
------------

Installation is similar to the non-Windows platforms. From the
installation directory:

::

       python bin\omero admin start
       python bin\omero admin deploy
       ...
       python bin\omero admin stop

The first command installs `OmeroGrid </ome/wiki/OmeroGrid>`_ as a
Windows service with the name ``OMERO.master``, and then calls
``start``. Any further calls to ``admin start`` will fail since the
application is already installed as a Windows service. Simiarly,
``admin stop`` first stops the service, and then calls ``uninstall``.
This can also only be done once.

**All other interaction with the Windows service should take place via
``sc``.**

::

      sc start OMERO.master
      sc stop OMERO.master
      sc delete OMERO.master
      sc query OMERO.master

More information on the permissions necessary for the service, changing
the user it runs as, etc. are available under ``WINDOWS_SERVICE.txt``
under your Ice installation, most likely
``C:\Ice-3.2.1\WINDOWS_SERVICE.txt``

Using Windows GUI tools
-----------------------

Once the ``python bin\omero admin start`` command has installed the
**OMERO.master** service, you can use Windows service tools:

-  From the Control Panel
   `|image2| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_controlpanel.png>`_
-  Open the Administration Tools (here in Classic View)
   `|image3| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_admintools.png>`_

Services Tool
~~~~~~~~~~~~~

-  Then open the Services executable
   `|image4| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_services.png>`_
-  Here you can see OMERO.master running and also stop it
   `|image5| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterrunning.png>`_
-  And can edit its runtime properties
   `|image6| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterproperties.png>`_
-  Like which user it starts as
   `|image7| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterlogon.png>`_

Event Viewier Tools
~~~~~~~~~~~~~~~~~~~

-  Then go back to the Administration Tool window and open the Event
   Viewer
   `|image8| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_eventviewer.png>`_
-  where status events from OMERO.master will registered (though the log
   output from the server is in the configured directory)
   `|image9| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_applicationevents.png>`_
-  The server's running.
   `|image10| </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_blitzactive.png>`_

However, a bug in Windows will prevent the OMERO.master service from
being removed while the service GUI is open. Close the GUI to finish the
operation.

Attachments
~~~~~~~~~~~

-  `winxp\_controlpanel.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_controlpanel.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_controlpanel.png>`_
   (369.7 KB) - added by *jmoore* `4
   ago.
-  `winxp\_admintools.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_admintools.png>`_
   `|image12| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_admintools.png>`_
   (111.1 KB) - added by *jmoore* `4
   ago.
-  `winxp\_services.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_services.png>`_
   `|image13| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_services.png>`_
   (76.0 KB) - added by *jmoore* `4
   ago.
-  `winxp\_masterrunning.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterrunning.png>`_
   `|image14| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterrunning.png>`_
   (71.5 KB) - added by *jmoore* `4
   ago.
-  `winxp\_masterproperties.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterproperties.png>`_
   `|image15| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterproperties.png>`_
   (84.3 KB) - added by *jmoore* `4
   ago.
-  `winxp\_masterlogon.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterlogon.png>`_
   `|image16| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_masterlogon.png>`_
   (84.4 KB) - added by *jmoore* `4
   ago.
-  `winxp\_eventviewer.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_eventviewer.png>`_
   `|image17| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_eventviewer.png>`_
   (75.8 KB) - added by *jmoore* `4
   ago.
-  `winxp\_applicationevents.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_applicationevents.png>`_
   `|image18| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_applicationevents.png>`_
   (71.9 KB) - added by *jmoore* `4
   ago.
-  `winxp\_blitzactive.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_blitzactive.png>`_
   `|image19| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_blitzactive.png>`_
   (77.4 KB) - added by *jmoore* `4
   ago.
-  `winxp\_templates.xml.png </ome/attachment/wiki/OmeroGridInstallWindowsXp/winxp_templates.xml.png>`_
   `|image20| </ome/raw-attachment/wiki/OmeroGridInstallWindowsXp/winxp_templates.xml.png>`_
   (29.7 KB) - added by *jmoore* `4
   ago.
