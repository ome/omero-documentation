#############################
OMERO |release| Documentation
#############################

The OMERO |release| documentation is divided into three parts:

:doc:`users/index` introduces the user-facing client applications and how to
get started, details the CLI client, and indicates where users can access
further help and support.

:doc:`sysadmins/index` includes instructions for installing and configuring an
OMERO server and also information on managing users and data, a task which
full system administrators can now delegate to facility managers or other
trusted users using the new 'restricted administrator' role.

Developers can find more specific and technical information about OMERO in the
:doc:`developers/index`.

.. only:: html

    - :doc:`users/index`
    - :doc:`sysadmins/index`
    - :doc:`developers/index`

Additional online resources can be found at:

- :downloads:`Downloads <>`
- :secvuln:`Security Advisories <>`
- :guide:`Guides <>`
- `OME YouTube channel <https://www.youtube.com/channel/UCyySB9ZzNi8aBGYqcxSrauQ>`_
  for tutorials and presentations
- `Demo server <http://qa.openmicroscopy.org.uk/registry/demo_account/>`_ -
  managed by the main OME team, providing the latest released versions of
  OMERO and plugins for you to try out
- OMERO API documentation - :javadoc_blitz:`OmeroJava API <>`,
  :pythondoc:`OmeroPy API <>`,
  :slicedoc_blitz:`OmeroBlitz / Slice API <>`

OMERO |release| uses the :schema:`June 2016 schema
<Documentation/Generated/OME-2016-06/ome.html>` of the :model_doc:`OME Data
Model <>`. The :doc:`users/history` page details the development of OMERO
functionality over time.

A summary of breaking changes and new features for |release| can be found on
the pages below:

- :doc:`What's new for OMERO users<users/whatsnew>`
- :doc:`What's new for OMERO sysadmins<sysadmins/whatsnew>`
- :doc:`What's new for OMERO developers<developers/whatsnew>`

The source code is hosted on Github. To propose changes and fix
errors, go to the :omedocs:`documentation repository <>`, fork it, edit the
file contents and propose your file changes to the OME team using
`Pull Requests`_. Alternatively, click on "Edit on GitHub" in the
menu.

.. _Pull Requests: https://help.github.com/articles/about-pull-requests/

.. toctree::
    :maxdepth: 1
    :hidden:

    users/index
    sysadmins/index
    developers/index

