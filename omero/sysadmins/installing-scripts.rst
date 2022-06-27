OMERO.scripts
=============

OMERO.scripts are the OME version of plugins, allowing you to extend the 
functionality of OMERO. Official core OMERO.scripts come bundled with every 
OMERO.server release but you can also add new scripts you have written 
yourself or found via the repositories forked from 
:omero_subs_github_repo_root:`ome/omero-user-scripts <omero-user-scripts/network/members>`.

Prerequisites
-------------

.. add content - numpy, scripy etc

Uploading and managing scripts
------------------------------

:doc:`/developers/scripts/user-guide` describes the workflow for developing 
and uploading scripts as an Admin. **Any scripts you add to the lib/scripts/ 
directory as a server admin will be considered 'trusted' and automatically 
detected by OMERO, allowing them to be run on the server from the clients or 
command line by any of your users.**

Once in the directory, scripts cannot be automatically updated and any 
additional ones will be lost when you upgrade your server installation. 
Therefore, we recommend you use a Github repository to manage your scripts. If 
you are not familiar with :devs_doc:`using git <using-git.html>`, you can use 
the `GitHub app for your OS <https://docs.github.com/en/get-started/quickstart/set-up-git>`_
(available for Mac and Windows but not Linux). The basic workflow is:

-  fork our 
   :omero_subs_github_repo_root:`omero-user-script <omero-user-scripts>`
   repository
-  clone it in your lib/scripts directory

   ::

           cd lib/scripts; 
           git clone git@github.com:YOURGITUSERNAME/omero-user-scripts.git YOUR_SCRIPTS

-  save the scripts you want to use into the appropriate sub-directory in your 
   cloned location lib/scripts/YOUR_SCRIPTS

Then when you upgrade your OMERO.server installation, provided your Github 
repository is up to date with all your latest script versions (i.e. all your 
local changes are committed), you just need to repeat the ``git clone`` step. 
Those scripts will then be automatically detected by your new server 
installation and available for use from the clients and command line as 
before.
