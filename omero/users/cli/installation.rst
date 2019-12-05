Installation
------------

.. note:: The the CLI is currently untested on Windows
    but may be supported in the future.

We recommend installing in a Python virtual environment.
Since OMERO5.6, only Python 3 is supported::

    python3.6 -mvenv venv
    . venv/bin/activate
    pip install omero-py

    # omero command is now available
    omero login

The |CLI| installed in this way provides all functionalities except import.
Import requires jars in the OMERO.server package.
See :doc:`/sysadmins/unix/server-installation`.
