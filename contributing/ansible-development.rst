Ansible roles development
=========================

.. _Ansible: https://www.ansible.com/

This document describes the conventions and process used by the OME team for
developing, maintaining and releasing its Ansible_ roles.

The set of rules and procedures described below applies to the official
OME roles registered in https://github.com/ome/ansible-roles.

Source code
-----------

The source code of a Java library should be maintained under version control
using Git_ and hosted on GitHub_. Each directory layout should follow the 
standard
`Ansible role layout <https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-directory-structure>`_::

    defaults/           # Default variables
    handlers/           # Handlers
    meta/               # Role metadaa
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

Ansible roles must follow PEP440_ rules for versioning. Additionally final
releases must be compliant with `Semantic Versioning`_ i.e. the version must
be expressed as `MAJOR.MINOR.PATCH` and:

- the MAJOR version must be incremented when you make incompatible API changes,
- the MINOR version must be incremented when you add functionality in a
  backwards-compatible manner, and
- the PATCH version must be incremented when you make backwards-compatible bug
  fixes.

Release tags must be expressed as `MAJOR.MINOR.PATCH` with no prefix.

Development releases or pre-releases must follow the PEP440_ standard e.g.
`MAJOR.MINOR.PATCH.dev1`, `MAJOR.MINOR.PATCHa1` `MAJOR.MINOR.PATHrc1`.

Testing and Continuous Integration
----------------------------------

.. _Molecule: https://molecule.readthedocs.io/

For each Ansible role, a :file:`molecule` folder should be configured allowing
the testing of the role using  Molecule_. One or multiple scenarios should be
configured using at least a Docker driver if possible.

Continuous Integration of Ansible roles is performed using Travis CI.

.. note::
   OME Ansible roles are getting progressively upgraded to Molecule 2.x. New
   roles should be configured using Molecule 2.x.

Distribution
------------

All OME Ansible roles should be deployed to
`Ansible Galaxy <https://galaxy.ansible.com>`_ under the
`openmicroscopy <https://galaxy.ansible.com/openmicroscopy/>`_  organization.

Ansible playbooks can consume these roles using a :file:`requirements.yml`
file - see
https://github.com/openmicroscopy/prod-playbooks/blob/master/requirements.yml 
and https://github.com/IDR/deployment/blob/master/ansible/requirements.yml
for examples of such files.

Release process
---------------

Deployment of a role release happens using the
`Travis integration <https://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html#travis-integrations>`_.

A PGP-signed tag should be created for the released version e.g.
using :command:`scc tag-release` or :command:`git tag -s` and pushed to the
upstream repository::

    $ git tag -s x.y.z -m "<tag message>"
    $ git push origin x.y.z
