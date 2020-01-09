Installation
------------

.. note:: The |CLI| is currently untested on Windows
    but may be supported in the future.

Since OMERO 5.6, only Python 3 is supported.
We assume that you have already installed Python 3.6.

We recommend installing omero-py and the |CLI| plugins
in a Python virtual environment.
You can either create one using ``venv`` or ``conda`` (preferred).
If you opt for Conda_, you will need
to install it first, see `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_ for more details.

To create a virtual env and install ``omero-py`` using venv::

    python3.6 -m venv py3_venv
    . py3_venv/bin/activate
    pip install omero-py

To create a virtual env and install ``omero-py`` using conda (preferred)::

    conda create -n myenv python=3.6
    conda activate myenv
    conda install -c ome zeroc-ice36-python 
    conda install -c ome omero-py 

The ``omero`` command is now available::

    omero login

The |CLI| installed in this way provides all functionalities except the ``import`` functionality.

The ``import`` functionality requires to have a supported version of Java e.g. Java, 11 Ice |iceversion| installed
and also requires JARs in the OMERO.server package to be available under
the :envvar:`OMERODIR` directory.

To install Java and Ice, go to :doc:`/sysadmins/unix/server-installation` and select the walk-through corresponding to your OS.

To make the JARs available, you need to:

#. download the OMERO.server zip from under artifacts at :downloads:`downloads page <>`
#. unzip the zip file 
#. set ``$OMERODIR`` to the unzipped directory::

    export OMERODIR=/path/to/OMERO.server-x.x.x-ice36-bxx

The ``import`` functionality is now available::

    omero import /path/to/image.tiff
