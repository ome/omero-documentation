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
#. Install OMERO.server and OMERO.web *separately* (not necessary)
   It will be preferrable to choose the same platform for both installations
   if you install OMERO.server and OMERO.web *separately*
#. Once both have been installed, perform a
   :doc:`backup and restore <server-backup-and-restore>` procedure
   and test your installation against the copy of your data.


Choosing a platform
-------------------

The two recommended platforms, RHEL/RockyLinux 9 and Ubuntu 22.04.

Installation
-------------

The installation walkthroughs provided in the documentation try to stick to a minimum installation.
Check the main :doc:`server <unix/server-installation>` and :doc:`web <unix/install-web/web-deployment>` installation pages.

However, more advanced installation mechanisms are available if you are interested and have familiarity
with the given mechanism:

- `Ansible roles <https://galaxy.ansible.com/ui/standalone/namespaces/5249/>`_ are available for most installation steps. The primary
  roles, `omero-server <https://galaxy.ansible.com/ui/standalone/roles/ome/omero_server/>`_ and `omero-web <https://galaxy.ansible.com/ui/standalone/roles/ome/omero_web/>`_ allow to install respectively the OMERO.server and OMERO.web.

- `Docker images <https://hub.docker.com/u/openmicroscopy>`_ are also available. Both the `omero-server`
  and `omero-web` images are considered production quality.

Please get in touch at https://forum.image.sc/c/data if you have any questions.

