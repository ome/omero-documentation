32 Omero.data.dir Files
-----------------------

**Prerequisite a folder set with ownership permissions and folder
without permissions set.**

-  Modify the omero.data.dir according to
   ` http://openmicroscopy.org/site/support/omero4/server/binary-repository <http://openmicroscopy.org/site/support/omero4/server/binary-repository>`_
   to a new directory you can write to.
-  Run bin/omero admin diagnostics ensuring that new omero.data.dir is
   picked up.
-  Modifiy the omero.data.dir according to
   ` http://openmicroscopy.org/site/support/omero4/server/binary-repository <http://openmicroscopy.org/site/support/omero4/server/binary-repository>`_
   to a new directory you CANNOT write to
-  Run bin/omero admin diagnostics ensuring that new omero.data.dir is
   picked up and a permissions error is displayed.
-  Check that bin/omero admin start (starting the server) produces a
   permissions error.
