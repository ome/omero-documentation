Introduction to OMERO.scripts
=============================

OMERO.scripts are the OME version of plugins, allowing you to extend the
functionality of your OMERO installation.

The OMERO scripting service allows scripts to be uploaded to the server so
that image processing and analysis, and other functionality, can be carried
out there rather than on your local machine. Scripts are generally written in
Python, but other languages are also supported, like Jython. MATLAB scripts
are supported natively as well as via a Python wrapper as described in
:doc:`matlab-scripts`.

Scripts can be run from the OMERO clients, using a UI generated from
the script and the results should also be handled where relevant e.g.
allowing users to view OMERO Images or Datasets created by the script, or
download files or images.

.. figure:: /images/omero-scripting-context.png
  :align: center
  :alt: OMERO script context menu

  Scripts menu in OMERO.insight

.. figure:: /images/scriptActivity.png
  :align: center
  :alt: Scripts Running and completed

  Running a script from an OMERO client

.. figure:: /images/scriptUI.png
  :align: center
  :alt: Scripts user interface

  A script user interface


Finding scripts
---------------

`Core scripts <https://github.com/ome/scripts>`_ are bundled with every
OMERO.server release and automatically available to all users. You can find
additional scripts on GitHub by looking for forks of
`ome/omero-user-scripts <https://github.com/ome/omero-user-scripts/network/members>`_. Some examples
include:

- `OMERO scripts <https://github.com/glencoesoftware/omero-user-scripts>`_ -
  Glencoe Software
- `Example scripts <https://github.com/openmicroscopy/omero-example-scripts>`_
  - OME Team
- `Fixing scripts <https://github.com/ppouchin/omero-user-scripts>`_ - Pierre 
  Pouchin
- `GDSC OMERO user scripts <https://github.com/aherbert/omero-user-scripts>`_
  - Alex Herbert
- `QBI-Microscopy scripts <https://github.com/QBI-Microscopy/omero-user-scripts>`_
  - Queensland Brain Institute
- `OMEROscripts <https://github.com/dsudar/OMEROscripts>`_ - Damir Sudar

All of the included scripts and repositories can be downloaded following the
instructions below in order to run the scripts locally (although some of them
are intended as examples only—check the associated README).

Downloading and installing scripts
----------------------------------

The easiest way to make use of scripts is for someone with admin rights to
upload them to the OMERO.server as described in the :doc:`user-guide`. Once a
script has been added under the lib/scripts directory, you can run them from
the OMERO clients or the command line. However, you will not be notified of
any updates to the script, nor will you be able to automatically update them.
This means that when your OMERO installation is upgraded, all your additional
scripts will be lost.

To keep your scripts up to date, we recommend you use a Github repository to
manage your scripts. If you are not familiar with
:devs_doc:`using git <using-git.html>`, you can use the
`GitHub app for your OS <https://help.github.com/articles/set-up-git>`_
(available for Mac and Windows but not Linux). The basic workflow is:

-  fork our
   `omero-user-script <https://github.com/ome/omero-user-scripts>`_
   repository or any other repository you trust (`<https://github.com/ome/omero-user-scripts/network/members>`_)
-  clone it in your lib/scripts directory

   ::

           cd lib/scripts
           git clone git@github.com:YOURGITUSERNAME/omero-user-scripts.git YOUR_SCRIPTS

-  save the scripts you want to use into the appropriate sub-directory in your
   cloned location lib/scripts/YOUR_SCRIPTS

If all you want to do is add scripts from someone else's repository to your
server, you can simply clone that repository in your lib/scripts directory and
the scripts within it will be added to your script list as described in the 
`OMERO-user-script repository readme <https://github.com/ome/omero-user-scripts>`_.

As your new scripts will then show up in the script menu in the clients,
alongside the core 'omero' scripts which are shipped with each release, you
should try to pick unique names to avoid future clashes
e.g. Custom_Scripts/Search_Scripts/original_metadata_search.py:

.. figure:: /images/omero-user-script-menu.png
  :align: center
  :alt: OMERO.web script menu

  Custom scripts in OMERO.web menu


The OME developers use Github to co-ordinate all our development work so
joining the network will help you access help and support, and see what other
people are doing with scripts. Cloning our repository also means you have an
example script to get you started with developing your own.

Developing your own scripts
---------------------------

The easiest way to get started developing scripts for your own site is to fork
the `github.com/ome/omero-user-scripts <https://github.com/ome/omero-user-scripts>`_
repository and clone it somewhere under lib/scripts as described above. Then
go into YOUR_SCRIPTS and rename the existing script to match your needs::

    cd lib/scripts/YOUR_SCRIPTS
    git mv Example.py util_scripts/New_function.py 

Once you have done that, you can edit and test run the script and then when
you are happy with it, you can save it and push it back to your fork for
others to see and share.

:doc:`user-guide` describes the workflows for developing and running your own
scripts. You should use the :doc:`style-guide` to ensure your script interacts
with the OMERO clients in a usable way.

If you are a biologist with no previous programming experience, you may find
the `Python for Biologists 
<https://pythonforbiologists.com/introduction/>`_ free online course helpful.

Contributing back to the community
----------------------------------

If you have modified one of the core scripts or developed your own that you
would like to contribute back to the community, please get in touch. If
the script is likely to have wide appeal, we can look into adding it to the
core scripts that are distributed with an OMERO release.

.. seealso::
    
    :doc:`user-guide`, :doc:`style-guide`, :doc:`advanced` and
    :doc:`matlab-scripts`

