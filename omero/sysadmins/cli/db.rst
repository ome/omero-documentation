Database tools
--------------

Rather than try to provide the functionality of a RDBM tool like ``psql``, the
:program:`omero db script` command helps to generate SQL scripts for building
your database. You can then use those scripts from whatever tool is most
comfortable for you::

    $ bin/omero db script --password secretpassword

.. literalinclude:: /downloads/cli/db-script-example.txt

If you do not specify the OMERO root password on the command line you will be
prompted to enter it.
