Migrate to a new operation system
=================================

This is an example walkthrough for migrating an OMERO.server to a new operating
system.

Basic steps
-----------

#. Choose a platform. If your current installation platform
   does not match one of the :doc:`recommended platforms <version-requirements>`,
   you may want to choose a new platform as your migration target. See
   `Choosing a platform`_ below.
#. If you chhose to Install OMERO.server and OMERO.web *separately* (optionally, you can install both on a single device):
   It will be preferrable to choose the same platform type for both installations.
#. Once both have been installed, perform an OMERO.server `Backup and restore`_ procedure.


Choosing a platform
-------------------

The two recommended platforms are RHEL/RockyLinux 9 and Ubuntu 22.04.

Installation
------------

The installation walkthroughs provided in the documentation covers a minimum installation only.
For this, check the main :doc:`server <unix/server-installation>` and :doc:`web <unix/install-web/web-deployment>` installation pages.

However, more advanced installation mechanisms are available if you are interested and have familiarity
with the given mechanism:

- `Ansible roles <https://galaxy.ansible.com/ui/standalone/namespaces/5249/>`_ are available for most installation steps. 
  The primary roles, `omero-server <https://galaxy.ansible.com/ui/standalone/roles/ome/omero_server/>`_ and `omero-web <https://galaxy.ansible.com/ui/standalone/roles/ome/omero_web/>`_ allow to install respectively the OMERO.server and OMERO.web.

- `Docker images <https://hub.docker.com/u/openmicroscopy>`_ are also available. We offer production quality images of both `omero-server`
  and `omero-web`.

Please get in touch at https://forum.image.sc/tag/omero if you have any questions.


Backup and restore
------------------

Mininally, you will need to back up and restore the binary repository and the database.


Backup
~~~~~~

- Perform the backups following the :doc:`backup instructions<server-backup-and-restore>`. 
- When ready, copy them to the new operating system::

    rsync -ra --progress db.dump NEW_OPERATING_SYSTEM:/tmp
    rsync -ra --progress OMERO_BINARY_BACKUP NEW_OPERATING_SYSTEM:/tmp


On the new operating system, stop the OMERO.server.

Restore the binary
~~~~~~~~~~~~~~~~~~

- Remove all the directories under ``/OMERO`` e.g. ``sudo rm -rf /OMERO/*``.

- Change ownership and group of the directories under ``OMERO_BINARY_BACKUP`` (but do not change the ownership of the backup diretory containing the ``omero.config`` i.e. ``/tmp/OMERO_BINARY_BACKUP/backup``)::

    sudo chown -R omero-server /tmp/OMERO_BINARY_BACKUP/ManagedRepository/
    sudo chgrp -R managed_repo_group /tmp/OMERO_BINARY_BACKUP/ManagedRepository/

- As the ``omero-server`` user, move the backup directories under ``/tmp/OMERO_BINARY_BACKUP`` (exception ``/tmp/OMERO_BINARY_BACKUP/backup``) to ``/OMERO``, for example::

    sudo -u omero-server -s
    mv /tmp/OMERO_BINARY_BACKUP/ManagedRepository /OMERO/ManagedRepository
 

Restore the database
~~~~~~~~~~~~~~~~~~~~

- Restore the database backup following the :doc:`restore PostgresQL instructions<server-backup-and-restore>`.

Restore the OMERO.server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Restore the backup configuration::

   omero config load /tmp/OMERO_BINARY_BACKUP/backup/omero.config

You should then follow the *Configuration* steps of
:doc:`OMERO.server installation <unix/server-installation>` to adjust your configuration as/if necessary.

Virtual environments update
---------------------------

When installating the OMERO.server on the new operating system, a virtual environment ``/opt/omero/server/venv3`` 
is created. If you have installated some specific packages in the virtual environment on the **previous** operating system, 
the packages will need to be re-installed in virtual environment on the **new** operating system.

The same is true for the OMERO.web virtual environment.

Scripts
-------

If you have added or modified scripts under ``lib/scripts`` on the **previous** operating system,
you will need to back up your modifications and re-implement the modfications under ``lib/scripts`` on the **new** operating system,
See :doc:`Merge script changes <server-upgrade>`

Certificates
------------

See :doc:`Server certificate <server-upgrade>`


Restart your server
-------------------

-  Following a successful migration upgrade, you can start the server.

   .. parsed-literal::

       $ omero admin start

-  If anything goes wrong, please send the output of ``omero admin diagnostics`` to
   the `forum <https://www.openmicroscopy.org/forums>`_.


Reference :doc:`OMERO.server upgrade <server-upgrade>`, :doc:`OMERO.server backup and restore <server-backup-and-restore>`.
