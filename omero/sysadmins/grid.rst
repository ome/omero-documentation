OMERO.grid
==========

To unify the various components of OMERO,
OMERO.grid was developed to monitor and control
processes over numerous remote systems. Based on ZeroC_'s IceGrid framework,
OMERO.grid provides management access,
distributed background processing, log handling and several other
features.

Terminology
-----------

Please notice that ZeroC uses a specific naming scheme for IceGrid elements
and actors. A *server* in the context of this document is not a host
computer - it is a process running inside an IceGrid node, servicing
incoming requests. A *host* is a computer on which IceGrid elements get
deployed. For more details, see :zerocdoc:`Terminology <display/Ice/Terminology>`.

Getting started
---------------

Requirements
^^^^^^^^^^^^

The normal OMERO installation actually makes use of OMERO.grid internally.
If you have followed the instructions under :doc:`unix/server-installation`
you will have everything you need to start working with OMERO.grid.

The standard install should also be used to install other hosts in the grid,
such as a computation-only host. Some elements can be omitted for a
computation-only host such as PostgreSQL, Apache/nginx, etc.

Running OMERO.web and/or starting up the full OMERO.server instance is not
required in such a case (only the basic requirements to run :omerocmd:`node`
are needed, i.e. ZeroC Ice and Python modules for OMERO scripts).

.. _icegrid_tools:

IceGrid Tools
^^^^^^^^^^^^^

If you would like to explore your IceGrid configuration, use

::

    bin/omero admin ice

It provides full access to the :command:`icegridadmin` console described in
the ZeroC manual. Specific commands can also be executed:

::

    bin/omero admin ice help
    bin/omero admin ice application list
    bin/omero admin ice application describe OMERO
    bin/omero admin ice server list

Further, by running :command:`java -jar ice-gridgui.jar`
the GUI provided by ZeroC can be used to administer OMERO.grid. This
JAR is provided in the OMERO source code under :file:`lib/repository`.

.. seealso::

    :zerocdoc:`icegridadmin Command Line Tool <display/Ice/icegridadmin+Command+Line+Tool>`
        Chapter of the ZeroC_ manual about the :command:`icegridadmin` CLI
    :zerocdoc:`IceGrid GUI Tool <display/Ice/IceGrid+GUI+Tool>`
        Chapter of the ZeroC_ manual about the IceGrid GUI tool


How it works
------------

:zerocdoc:`IceGrid <display/Ice/IceGrid>` is a location and activation
service, which functions as a central registry to manage all your OMERO
server processes. OMERO.grid provides server components
which use the registry to communicate with one another. Other than a
minimal amount of configuration and starting a single daemon on each
host machine, OMERO.grid manages the complexity
of all your computing resources.

Deployment descriptors
^^^^^^^^^^^^^^^^^^^^^^

All the resources for a single OMERO site are described by one
**application descriptor**. OMERO ships with several example descriptors
under :file:`etc/grid`. These
descriptors describe what processes will be started on what nodes,
identified by simple names. For example the :source:`default descriptor <etc/templates/grid/default.xml>`, used if
no other file is specified, defines the ``master`` node. As you will see,
these files are critical both for the correct
functioning of your server as well as its security.

The deployment descriptors provided define which server instances are started
on which nodes. The default descriptor configures the ``master`` node to
start the :doc:`/developers/server-blitz` server, the Glacier2 router for
firewalling, as well as a single processor - ``Processor0``. The master node
is also configured via :file:`etc/master.cfg` to host the
registry, though this process can be started elsewhere.

Deployment commands
^^^^^^^^^^^^^^^^^^^

The ``master`` node must be started first to provide the registry. This is
done via the :omerocmd:`admin start` command which uses the default
descriptor:

::

    bin/omero admin start

The deploy command looks for any changes to the defined descriptor
and restarts only those servers which have modifications:

::

    bin/omero admin deploy

Both :omerocmd:`admin start` and :omerocmd:`admin deploy` can optionally
take a path to an application descriptor which must be passed on every
invocation:

::

    bin/omero admin deploy etc/grid/my-site.xml

Two other nodes, then, each provide a single processor, ``Processor1`` and
``Processor2``. These are started via:

To start a node identified by ``NAME``, the following command can be used

::

    bin/omero node start NAME

At this point the node will try and connect to the registry to announce its
presence. If a node with the same name is already started, then registration
will fail, which is important to prevent unauthorized users.

The configuration of your grid, however, is very much up to you. Based
on the example descriptor files (\*.xml) and configuration files
(\*.cfg), it is possible to develop OMERO.grid
installations completely tailored to your computing resources.

The whole grid can be shutdown by stopping the master node via:
:omerocmd:`admin stop`. Each individual node can also be shutdown via:
:omerocmd:`node NAME stop` on that particular node.

Deployment examples
-------------------

Two examples will be presented showing the flexibility of OMERO.grid
deployment and identifying files whose modification is critical for the
deployment to work.

Nodes on a single host
^^^^^^^^^^^^^^^^^^^^^^

The first example will focus on changing the deployed nodes/servers on a
single host. It should serve as an introduction to the concepts. Unless used
for very specific requirements, this type of deployment doesn't yield any
performance gains.

The first change that you will want to make to your application
descriptor is to add additional processors. Take a look at
:source:`etc/templates/grid/default.xml`.
There you can define two new nodes - ``node1`` and ``node2`` by simply adding
a new XML element below the ``master`` node definition:

::

    <node name="node1">
      <server-instance template="ProcessorTemplate" index="1"/>
    </node>

    <node name="node2">
      <server-instance template="ProcessorTemplate" index="2"/>
    </node>

Remember to change the node name and the index number for each subsequent
node definition. The node name and the index number do not need to match. In
fact, the index number can be completely ignored, except for the fact that
it must be unique. The node name, however, is important for properly starting
your new processor.

You will need both a configuration file under ``etc/`` with the same name,
and unless the node name matches the name of your local host, you will
need to specify it on the command line:

::

    bin/omero node node1 start

or with the environment variable ``OMERO_NODE``:

::

    OMERO_NODE=node1 bin/omero node start

After starting up both nodes, you can verify that you now have three
processors running by looking at the output of :omerocmd:`admin diagnostics`.

For more information on using scripts, see the 
:doc:`/developers/scripts/advanced`.

Nodes on multiple hosts
^^^^^^^^^^^^^^^^^^^^^^^

.. warning::
    Before attempting this type of deployment, make sure that the hosts
    can ping each other and that required ports are open and not firewalled.

A more complex deployment example is running multiple nodes on networked
hosts. Initially, the host's loopback IP address (127.0.0.1) is used in the grid configuration files.

For this example, let's presume we have control over two hosts: ``omero-master`` (IP address 192.168.0.1/24) and ``omero-slave`` (IP address 192.168.
0.2/24). The goal is to move the processor server onto another host (``omero-slave``) to reduce the load on the host running the ``master`` node (``omero-master``). The configuration changes required to achieve this are outlined
below.

On host ``omero-master``:

- :file:`etc/grid/default.xml` - remove or comment out from the ``master`` node the ``server-instance`` using the ``ProcessorTemplate``. Below the ``master`` node add an XML element defining a new node:

  ::

      <node name="omero-slave">
        <server-instance template="ProcessorTemplate" index="0" dir=""/>
      </node>

- :file:`etc/internal.cfg` - change the value of ``Ice.Default.Locator`` from 127.0.0.1 to 192.168.0.1
- :file:`etc/master.cfg` - change all occurrances of 127.0.0.1 to 192.168.0.1


On host ``omero-slave``:

- copy or rename :file:`etc/node1.cfg` to :file:`etc/omero-slave.cfg` and change all ``node1`` strings to ``omero-slave`` in :file:`etc/omero-slave.cfg`. Also update the ``IceGrid.Node.Endpoints`` value to ``tcp -h 192.168.0.2``
- :file:`etc/internal.cfg` - change the value of ``Ice.Default.Locator`` from 127.0.0.1 to 192.168.0.1
- :file:`etc/ice.config` - add the line ``Ice.Default.Router=OMERO.Glacier2/router:tcp -p 4063 -h 192.168.0.1``

To apply the changes, start the OMERO instance on the ``omero-master`` node
by using :omerocmd:`admin start`. After that, start the ``omero-slave`` node
by using :omerocmd:`node omero-slave start`. Issuing :omerocmd:`admin diagnostics` on the master node should show a running processor instance and
the ``omero-slave`` node should accept job requests from the master node.

Securing grid resources
-----------------------

More than just making sure no malicious code enters your grid, it is
critical to prevent unauthorized access via the application descriptors
(\*.xml) and configuration (\*.cfg) as mentioned above.

.. _grid-firewall:

Firewall
^^^^^^^^

The simplest and most effective way of preventing unauthorized access is
to have all OMERO.grid resources behind a
firewall. Only the Glacier2 router has a port visible to machines
outside the firewall. If this is possible in your configuration, then
you can leave the internal endpoints unsecured.

|SSL|
^^^^^

Though it is probably unnecessary to use transport encryption within a
firewall, encryption from clients to the Glacier2 router will often be
necessary. For more information on |SSL|, see :ref:`security_ssl`.

Permissions Verifier
^^^^^^^^^^^^^^^^^^^^

The IceSSL plugin can be used both for encrypting the channel as well as
authenticating users. |SSL|-based authentication, however, can be
difficult to configure especially for within the firewall, and so
instead you may want to configure a "permissions verifier" to prevent
non-trusted users from accessing a system within your firewall. From
:source:`master.cfg <etc/templates/master.cfg>`:

::

    IceGrid.Registry.AdminPermissionsVerifier=IceGrid/NullPermissionsVerifier
    #IceGrid.Registry.AdminCryptPasswords=etc/passwd

Here we have defined a "null" permissions verifier which allows anyone
to connect to the registry's administrative endpoints. One simple way of
securing these endpoints is to use the ``AdminCryptPasswords`` property,
which expects a passwd-formatted file at the given relative or absolute path:

::

    mrmypasswordisomero TN7CjkTVoDnb2
    msmypasswordisome   jkyZ3t9JXPRRU

where these values come from using openssl:

::

    $ openssl
    OpenSSL> passwd
    Password: 
    Verifying - Password: 
    TN7CjkTVoDnb2
    OpenSSL> 

Another possibility is to use the :doc:`/developers/server-blitz`
permissions verifier, so that anyone with a proper OMERO account can
access the server.

See :zerocdoc:`Controlling Access to IceGrid Sessions
<display/Ice/Resource+Allocation+using+IceGrid+Sessions>`
of the Ice manual for more information.

Unique node names
^^^^^^^^^^^^^^^^^

Only a limited number of node names are configured in an application
descriptor. For an unauthorized user to fill a slot, they must know the
name (which **is** discoverable with the right code) and be the first to
contact the grid saying "I am Node029", for example. A system
administrator need only then be certain that all the node slots are
taken up by trusted machines and users.

It is also possible to allow "dynamic registration" in which servers are
added to the registry after the fact. In some situations this may be
quite useful, but is disabled by default. Before enabling it, be sure to
have secured your endpoints via one of the methods outlined above.

Absolute paths
^^^^^^^^^^^^^^

The example application descriptors shipped with
OMERO all use relative paths to make installation easier. Once you are
comfortable with configuring OMERO.grid, it
would most likely be safer to configure absolute paths. For example,
specifying that nodes execute under ``/usr/lib/omero`` requires that whoever
starts the node have access to that directory. Therefore, as long
as you control the boxes which can attach to your endpoints (see
:ref:`grid-firewall`), then you can be
relatively certain that no tampering can occur with the installed
binaries.

Technical information and other tips
------------------------------------

Processes
^^^^^^^^^

It is important to understand just what processes will be running on your
servers. When you run :omerocmd:`admin start`, :command:`icegridnode` is
executed which starts a
controlling daemon and deploys the proper descriptor. This configuration
is persisted under :file:`var/master` and :file:`var/registry`.

Once the application is loaded, the :command:`icegridnode` daemon process
starts up all the servers which are configured in the descriptor. If one
of the processes fails, it will be restarted. If restart fails,
eventually the server will be "disabled". On shutdown, the :command:`icegridnode` process also shutdowns all the server processes.

Targets
^^^^^^^

In application descriptors, it is possible to surround sections of the
description with ``<target/>`` elements. For example, in
:source:`templates.xml <etc/templates/grid/templates.xml>` the section which
defines the main :doc:`/developers/server-blitz` server includes:

::

    <server id="Blitz-${index}" exe="${JAVA}" activation="always" pwd="${OMERO_HOME}">
      <target name="debug">
        <option>-Xdebug</option>
        <option>-Xrunjdwp:server=y,transport=dt_socket,address=8787,suspend=y</option>
      </target>
      ...

When the application is deployed, if "debug" is added as a target, then
the ``-Xdebug``, etc. options will be passed to the Java runtime. This
will allow remote connection to your server over the configured port.

Multiple targets can be enabled at the same time:

::

    bin/omero admin deploy etc/grid/default.xml debug secure someothertarget

Ice.MessageSizeMax
^^^^^^^^^^^^^^^^^^

Ice imposes an upper limit on all method invocations. This limit,
``Ice.MessageSizeMax``, is configured in your application descriptor
(e.g. :source:`templates.xml <etc/templates/grid/templates.xml>`)
and configuration files (e.g.
:source:`ice.config <etc/templates/ice.config>`). The setting must
be applied to all servers which will be handling the invocation. For
example, a call to ``InteractiveProcessor.execute(omero::RMap inputs)``
which passes the inputs all the way down to :file:`processor.py` will need
to have a sufficiently large ``Ice.MessageSizeMax`` for: the client, the
Glacier2 router, the :doc:`/developers/server-blitz` server, and the Processor.

The default is currently set to 65536 kilobytes which is 64MB.

Logging
^^^^^^^

Currently all output from OMERO.grid is
stored in ``$OMERO_PREFIX/var/log/master.out`` with error messages going
to ``$OMERO_PREFIX/var/log/master.err``. Individual services may also create
their own log files.

Shortcuts
^^^^^^^^^

If the :file:`bin/omero` script is copied or symlinked to another name, then
the script will separate the name on hyphens and execute :file:`bin/omero`
with the second and later parts **prepended** to the argument list.

For example,

::

    ln -s bin/omero bin/omero-admin
    bin/omero-admin start

works identically to:

::

    bin/omero admin start

Symbolic linking
^^^^^^^^^^^^^^^^

Shortcuts allow the :file:`bin/omero` script to function as an init.d script
when named :file:`omero-admin`, and need only be copied to
:file:`/etc/init.d/` to function properly. It will resolve its installation
directory, and execute from there unless :envvar:`OMERO_HOME` is set.

For example,

::

    ln -s $OMERO_PREFIX/bin/omero /usr/local/bin/omero
    omero-admin start

The same works for putting :file:`bin/omero` on your path:

::

    PATH=$OMERO_PREFIX/bin:$PATH

This means that OMERO.grid can be unpacked
anywhere, and as long as the user invoking the commands has the proper
permissions on the ``$OMERO_PREFIX`` directory, it will function normally.

Running as root
^^^^^^^^^^^^^^^

One exception to this rule is that starting OMERO.grid as root may actually
delegate to another user, if the "user" attribute is set on the ``<server/>``
elements in :file:`etc/grid/templates.xml`.

.. seealso:: |OmeroSessions|
