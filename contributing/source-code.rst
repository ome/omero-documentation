Checking out the source code
============================

This section is primarily designed for the core OME developers who want to
check out the main code base using Git. If you need guidance in installing,
configuring and using Git, see the :doc:`using-git` page.

Code locations
--------------

OME code is stored in multiple git repositories, each of which is available
from several locations.

OMERO
^^^^^

The main repository, known as ome.git, is available from:

-  https://github.com/openmicroscopy/openmicroscopy
-  git://openmicroscopy.org/ome.git

Bio-Formats
^^^^^^^^^^^

The Bio-Formats repository is available from:

-  https://github.com/openmicroscopy/bioformats
-  git://openmicroscopy.org/bioformats.git

Other repositories
^^^^^^^^^^^^^^^^^^

Each member of the `GitHub openmicroscopy organization
<https://github.com/openmicroscopy>`_,
as well as anyone else who has clicked the “Fork” button, will have their
own repository. These are listed here:

-  https://github.com/openmicroscopy/openmicroscopy/network/members
-  https://github.com/openmicroscopy/bioformats/network/members

Cloning the source code
-----------------------

Most OME development is currently happening on GitHub, therefore it is highly
suggested that you become familiar with how it works, if not create an account
for yourself.

.. note:: There is extensive guidance on the :doc:`using-git` page and the
    following examples assume you have set up your account using "gh" for your
    personal repositories and "origin" as the official repositories as
    described there.

Start by cloning the official repository for the project you want to work with
e.g.::

        git clone https://github.com/openmicroscopy/openmicroscopy.git

Since the openmicroscopy (OMERO) repository now makes use of submodules, you
first need to initialize all the submodules::

        cd openmicroscopy
        git submodule update --init

Alternatively, with version 1.6.5 of Git and later, you can pass the
``--recursive`` option to git clone and initialize all submodules::

        git clone --recursive https://github.com/openmicroscopy/openmicroscopy.git

.. Note:: The use of submodules does not apply to Bio-Formats, which has all
    code and documentation within a single repository at
    https://github.com/openmicroscopy/bioformats.git

The natural workflow when using GitHub is not just to download someone else’s
repository, but also to create a personal working copy. Go to the repository
page at `<https://github.com/openmicroscopy/openmicroscopy>`_ or
`<https://github.com/openmicroscopy/bioformats>`_ and click on
“Fork”. This will create a copy of the repository in your own personal space
e.g.::

        https://github.com/YOURNAME/bioformats

which can be added to your local repository as another remote::

        git remote add gh git@github.com:YOURNAME/bioformats.git

.. note::
    For the |SSH| transport to work, you will need to follow some of the
    instructions under https://github.com/account/ssh

Depending on which repository you cloned first, either origin/develop or
gh/develop will be the “develop” branch of your own fork of
openmicroscopy/openmicroscopy or openmicroscopy/bioformats. The example below
assumes that “gh” is your own personal GitHub repository, and “origin” is the
official openmicroscopy repository.

You may even want to remove the “develop” branch from your fork since all
branching should happen from the official develop branch. If you’d prefer to
keep a copy of “develop” in “gh”, that is fine, but you may then need to keep
your develop up-to-date with the official develop::

        git checkout develop
        git reset --hard origin/develop   # Warning: This will delete any unsaved changes and commits to develop!
        git push -f gh develop            # Warning: This will replace gh/develop with the official version remotely.
