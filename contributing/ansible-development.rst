Ansible roles development
=========================

.. _Ansible: https://www.ansible.com/

This document describes the conventions and process used by the OME team for
developing, maintaining and releasing its Ansible_ roles.

The set of rules and procedures described below applies to the official
OME roles registered in https://github.com/ome/ansible-roles.

Source code
-----------

The source code of an Ansible role should be maintained under version control
using Git_ and hosted on GitHub_ under the
`openmicroscopy <http://github.com/openmicroscopy/>`__ organization.
The Git repositories should be named as `ansible-role-<ROLENAME>`. Note that
for role name composed of multiple words, setting the `role_name` in
:file:`meta/main.yml` will update hyphens as underscores during import into
Galaxy.

Each directory
layout should minimally follow the standard
`Ansible role layout <https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-directory-structure>`_ including other files and folders for testing and
deployment. A typical role structure is shown below::

    defaults/           # Default variables
    handlers/           # Handlers
    meta/               # Role metadata
        main.yml        # Dependencies and Galaxy metadata
    molecule/           # Test
    tasks/              # Main list of tasks to be executed
        main.yml
    templates/          # Role templates
    .travis.yml         # CI/deployment configuration file
    README.md

Versioning
----------

.. _PEP440: https://www.python.org/dev/peps/pep-0440/#semantic-versioning

Ansible roles must follow the PEP440_ scheme for versioning. Final releases
must also be compliant with `Semantic Versioning`_ i.e. a final version must
be expressed as `MAJOR.MINOR.PATCH` where:

- the MAJOR version must be incremented when incompatible API changes are made,
- the MINOR version must be incremented when functionality is added in a
  backwards-compatible manner, and
- the PATCH version must be incremented when backwards-compatible bug
  fixes are made.

Final releases must be tagged with a tag matching the version i.e. 
`MAJOR.MINOR.PATCH` with no prefix.

Testing and Continuous Integration
----------------------------------

.. _Molecule: https://molecule.readthedocs.io/

For each Ansible role, a :file:`molecule` folder should be configured allowing
the testing to be tested using  Molecule_. One or more scenarios should be
configured using at least a Docker driver if possible. A generic
:file:`molecule` folder can be initialized using the following command::

    molecule init scenario -r ansible-role-<NAME> -s default -d docker


Continuous Integration of Ansible roles is performed using Travis CI.

.. note::

   OME Ansible roles are getting progressively upgraded from Molecule 1.x to 
   Molecule 2.x. New roles must be configured using Molecule 2.x.

Distribution and support
------------------------

All core OME Ansible roles should be deployed to
`Ansible Galaxy <https://galaxy.ansible.com>`_ under the
`openmicroscopy <https://galaxy.ansible.com/openmicroscopy/>`__ organization.
All roles must support RHEL/CentOS 7 as a primary platform. New roles should
also include Ubuntu 18.04 as a supported platform whenever possible.

Ansible playbooks can consume these roles using a :file:`requirements.yml`
file - see
https://github.com/openmicroscopy/prod-playbooks/blob/master/requirements.yml 
and https://github.com/IDR/deployment/blob/master/ansible/requirements.yml
for examples of such files.

The release of an Ansible role and its deployment to Galaxy release happens
by triggering a role import in Galaxy using the
`Travis integration <https://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html#travis-integrations>`_
on each release tag.

A PGP-signed tag of form `x.y.z` should be created for the released version
using :command:`scc tag-release` or :command:`git tag -s` and pushed to the
upstream repository::

    $ git tag -s x.y.z -m "<tag message>"
    $ git push origin x.y.z
