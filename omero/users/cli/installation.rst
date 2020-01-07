Installation
------------

.. note:: The |CLI| is currently untested on Windows
    but may be supported in the future.

We recommend installing in a Python virtual environment.
Since OMERO 5.6, only Python 3 is supported::

    python3.6 -mvenv venv
    . venv/bin/activate
    pip install omero-py

    # omero command is now available
    omero login

The |CLI| installed in this way provides all functionalities except import.
Import requires jars in the OMERO.server package to be available under
the ``$OMERODIR`` directory.

You need to download the OMERO.server zip from under artifacts at
:downloads:`downloads page <>`. Unzip the zip file and set ``$OMERODIR``
to the unzipped directory::

    export OMERODIR=/path/to/OMERO.server-x.x.x-ice36-bxx

    # now you can import
    omero import /path/to/image.tiff
