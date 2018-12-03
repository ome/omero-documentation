Installation
------------

.. note:: The end of Windows support for OMERO.server means that the CLI is
    unsupported on this platform too.

Check you have Python_ installed by typing::

    $ python --version
    Python 2.7.9

Additionally, Ice_ must be installed on your machine::

    $ python -c "import Ice"

Check the :ref:`server requirements <server-requirements>` for the minimum and
maximum supported versions.

The |CLI| is currently bundled:

- with the OMERO.server including all functionalities of the |CLI|
- with the OMERO.python including all functionalities of the |CLI| except for
  the import functionality

Download the version corresponding to your system from the
:downloads:`OMERO downloads <>` page.

.. note::
    The |CLI| is bundled with the OMERO.server but that does not imply you
    must use that directory as a server. You can download the server zip to a
    number of machines and use the |CLI| commands from each machine to access
    an existing OMERO instance.

Once the correct bundle is downloaded, the Python libraries of the |CLI| are
located under the :file:`lib/python` directory and the executable is under
the :file:`bin` directory. To start the |CLI| in shell mode:

.. parsed-literal::

    $ bin/omero
    OMERO Python Shell. Version |release|-ice36
    Type "help" for more information, "quit" or Ctrl-D to exit
    omero>
