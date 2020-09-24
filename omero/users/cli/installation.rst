Installation
------------

.. note:: The |CLI| is currently untested on Windows
    but may be supported in the future.

Since OMERO 5.6, only Python 3 is supported.
We assume that you have already installed Python 3.6.

We recommend installing client library ``omero-py`` and the |CLI| plugins
in a Python virtual environment.
You can create one using either ``venv`` or ``conda`` (preferred).
If you opt for Conda_, you will need
to install it first, see `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_ for more details.

To install ``omero-py`` using conda (preferred)::

    conda create -n myenv -c ome python=3.6 zeroc-ice36-python omero-py
    conda activate myenv

Alternatively install ``omero-py`` using venv::

    python3.6 -m venv myenv
    . myenv/bin/activate
    pip install omero-py

The ``omero`` command is now available in the terminal where the environment has been activated::

    omero login

If you install ``omero-py>=5.8.0`` the |CLI| provides all functionalities except the ``import`` functionality.


The ``import`` functionality requires a supported version of :ref:`version requirements java`, and some JARs which are automatically downloaded the first time you do an import.

To install Java, go to :doc:`/sysadmins/unix/server-installation`
and select the walkthrough corresponding to your OS.

omero-py < 5.8.0
^^^^^^^^^^^^^^^^

If you are using an older version of ``omero-py`` you must download the JARs manually and place them under the :envvar:`OMERODIR` directory:

#. download the OMERO.server zip from the `Downloads page <https://www.openmicroscopy.org/omero/downloads/>`_
#. unzip the zip file 
#. set ``$OMERODIR`` to the unzipped directory::

    export OMERODIR=/path/to/OMERO.server-x.x.x-ice36-bxx

The ``import`` functionality is now available::

    omero import /path/to/image.tiff
