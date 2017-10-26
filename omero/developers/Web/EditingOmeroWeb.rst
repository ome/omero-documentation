Editing OMERO.web
=================

If you need to make changes to OMERO.web itself, then you
will want to check out the OMERO source code, build the server
and run OMERO.web as described in :doc:`/developers/Web/Deployment`.

You will then have 2 copies of the OMERO.web code -
source code under ``components/tools/OmeroWeb/omeroweb`` and the server
build under ``dist/lib/python/omeroweb``.

In order to avoid a build step during development, you can delete
the omeroweb code under dist and replace it with a sym-link
to the source code::

    $ rm -rf dist/lib/python/omeroweb
    $ ln -s /path/to/openmicroscopy/components/tools/OmeroWeb/omeroweb/ /path/to/openmicroscopy/dist/lib/python


-  From the source omeroweb/ folder, manually run the Django development
   server

   ::

       $ cd ../components/tools/OmeroWeb
       $ python omeroweb/manage.py runserver
       Validating models...

       0 errors found
       December 05, 2013 - 13:39:26
       Django version 1.8, using settings 'omeroweb.settings'
       Starting development server at http://127.0.0.1:8000/
       Quit the server with CONTROL-C.

   .. note:: Default port number is 8000. To specify port, use 
       for example: $ python manage.py runserver 0.0.0.0:4080

