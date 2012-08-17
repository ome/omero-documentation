30. CLI testing
~~~~~~~~~~~~~~~

[Updated for 4.3.2]

This first scenario is for a preliminary set of CLI testing is to cover
the basic set of CLI that are used. You can investigate and see the full
range of the various commands available using the -h or --help option:

**Pre-requisites for this test:**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Run the following as root user from python dist/bin/omero to setup a new
user account and group

-  omero login -s $OMERO\_HOST -p $ROUTER -u root -w ome
-  omero group add web\_group --perms=rwrw-- \| \| echo "Web Group
   already exists?"
-  omero user add web\_user Web User web\_group --userpassword abc \| \|
   echo "Web User already exists?"
-  omero logout

-  omero config set omero.web.database\_engine 'sqlite3'
-  omero config set omero.web.server\_list ''$OMERO\_HOST'", '$ROUTER',
   "omero?'
-  omero config set omero.web.debug True
-  omero web unittest --config=$ICE\_CONFIG --test=webadmin

Confirmation of the technical setup

-  bin/omero config set omero.web.database\_engine sqlite3
-  $ bin/omero web unittest --test=webadmin --config=[Ice location]
   ice.config
-  PATH to ice.config
-  OMERO/dist/ice.config

    **Command line tests**

-  Move to

   -  cd omero
   -  bin/omero -h

-  Config test

   -  $ bin/omero config def
   -  Returns = default
   -  $ bin/omero config get
   -  Returns =
   -  $ bin/omero config set example "my first value"
   -  $ bin/omero config get
   -  Returns = example=my first value

-  **User Test**

   -  **$ bin/omero import**
   -  testing the full set of option with bin/omero user these are:

      -  add
      -  list
      -  password

-  **Web cmd test**

   -  For each test run bin/omero web with the additional command.
   -  Start - the OMERO.web server
   -  Run the command status and confirm the status of the web server
      has started.
   -  Run the command config and confirm a output config template for
      server
   -  Run the command gateway and execute the code below (See
      ` PythonClientBeginners <http://trac.openmicroscopy.org.uk/ome/wiki/PythonClientBeginners>`_
      for additional information.)

      ::

          from omero.gateway import BlitzGateway
          conn = BlitzGateway("USER", "PASSWORD", host="SERVER_YOU_WANT_TO_TEST", port=4064)
          conn.connect()
          for p in conn.listProjects(
              print p.getName()
              for dataset in p.listChildren(
                  print "  ", dataset.getName()

-  Run the command stop
-  Run the command config and confirm the status of the web server has
   stopped.

-  **Shell cmd test**

   -  Run bin/omero shell to start IPython
   -  ensure IPython starts.
   -  Once in execute the following commands ensuring they return the
      correct information.

      -  import Ice
      -  import omero
      -  omero.model.ImageI() [This command imports an image]
      -  client.sf.getAdminContext().getEventContext() [The expected
         output of this command is the return of the current login info]

-  **Group cmd test**
-  For each test run bin/omero group with the additional command.

   -  Run the command add private cmdtest
   -  Run the command list and view the current groups
   -  Run the command insert and ensure the user is added to the group

See
` http://trac.openmicroscopy.org.uk/ome/wiki/OmeroCli <http://trac.openmicroscopy.org.uk/ome/wiki/OmeroCli>`_
for further information on the range of commands.
