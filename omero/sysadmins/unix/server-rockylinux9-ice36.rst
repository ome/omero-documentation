.. walkthroughs are generated using a bash script, see
.. https://github.com/ome/omero-install

OMERO.server installation on RHEL 9/Rocky Linux 9
=================================================

This is an example walkthrough for installing OMERO on RHEL 9/Rocky Linux 9, using
a dedicated local system user. You can use this as a guide
for setting up your own test server. For production use you should also read
the pages listed under :ref:`index-optimizing-server`.
This guide will install Python 3.9.
Since 5.6, a new :envvar:`OMERODIR` variable is used, you should first unset :envvar:`OMERO_HOME`
(if set) before beginning the installation process.

This guide describes how to install using the **recommended** versions for
Java, Ice, PostgreSQL.
This should be read in conjunction with :doc:`../version-requirements`.

This guide **does not** describe how to install OMERO.web.
To deploy OMERO.web, please read
:doc:`install-web/walkthrough/omeroweb-install-rockylinux9-ice3.6`.

These instructions assume your Linux distribution is configured with a UTF-8
locale (this is normally the default).

For convenience in this walkthrough, we will use the **omero-server system user** and the main OMERO configuration options have
been defined as environment variables. When following this walkthrough you can
either use your own values, or alternatively create :file:`settings.env` for example under ``/tmp`` e.g. ``/tmp/settings.env`` containing the variables below and source it when required:

.. literalinclude:: walkthrough/settings.env
   :start-after: Substitute
