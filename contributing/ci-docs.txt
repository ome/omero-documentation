Documentation jobs
------------------

All documentation jobs are listed under the :jenkinsview:`Docs <Docs>` view
tab of Jenkins.

.. list-table::
	:header-rows: 1

	-	* Job task
		* OMERO 5.x series

	-	* Builds the latest OMERO documentation for publishing
		* :term:`OMERO-DEV-latest-docs`

	-	* Builds the OMERO documentation for review
		* :term:`OMERO-DEV-merge-docs`

	-	* Builds the auto-generated OMERO documentation
		* :term:`OMERO-DEV-latest-docs-autogen`

	-	* Builds the auto-generated OMERO documentation for review
		* :term:`OMERO-DEV-merge-docs-autogen`

.. list-table::
	:header-rows: 1

	-	* Job task
		* Bio-Formats 5.x series

	-	* Builds the latest Bio-Formats documentation for publishing
		* :term:`BIOFORMATS-DEV-latest-docs`

	-	* Builds the Bio-Formats documentation for review
		* :term:`BIOFORMATS-DEV-merge-docs`

	-	* Builds the auto-generated Bio-Formats documentation
		* :term:`BIOFORMATS-DEV-latest-docs-autogen`

	-	* Builds the auto-generated Bio-Formats documentation for review
		* :term:`BIOFORMATS-DEV-merge-docs-autogen`

The OME Model, OME help and OME Contributing documentation sets are
independent of the current OMERO/Bio-Formats version.

.. list-table::
	:header-rows: 1

	-	* Job task
		*

	-	* Build the latest OME Model documentation
		* :term:`MODEL-latest-docs`

	-	* Publish OME Contributing documentation
		* :term:`CONTRIBUTING-latest-docs`

	-	* Review OME Model documentation PRs
		* :term:`MODEL-merge-docs`

	-	* Review OME Contributing documentation PRs
		* :term:`CONTRIBUTING-merge-docs`

	-	* Review OME help documentation PRs
		* :term:`OME-help-staging`

	-	* Publish OME help documentation
		* :term:`OME-help-release`

Since OMERO.figure came under the management of the wider OME team, there are
also builds to manage its GitHub pages website, which operate the same way as
the help builds.

.. list-table::
	:header-rows: 1

	-	* Job task
		*

	-	* Review PRs opened against the OME Website
		* :term:`WWW-merge`

	-	* Review PRs opened against the OMERO.figure website
		* :term:`FIGURE-help-staging`

	-	* Publish the OMERO.figure website
		* :term:`FIGURE-help-staging`

	-	* Review PRs opened against the OME help website
		* :term:`OME-help-staging`

	-	* Publish the OME help website
		* :term:`OME-help-release`

OME Files comprises OME Files C++ and OME CMake Super-Build Sphinx manuals,
which are taken from separate repositories but built and hosted as a bundle.

.. list-table::
	:header-rows: 1

	-	* Job task
		*

	-	* Publish OME Files documentation
		* :term:`OME-FILES-CPP-DEV-release-bundle-docs`

	-	* Review OME Files documentation PRs
		* :term:`OME-FILES-CPP-DEV-merge-docs`


Configuration
^^^^^^^^^^^^^

For all jobs building documentation using Sphinx, the HTML documentation theme
hosted at https://github.com/openmicroscopy/sphinx_theme repository is copied
to the relevant :file:`themes/` folder. The following environment variables
are then used:

- the Sphinx building options, :envvar:`SPHINXOPTS`, is set to
  ``-W -D html_theme=sphinx_theme``

- the release number of the documentation is set by :envvar:`OMERO_RELEASE`,
  :envvar:`BF_RELEASE` or by the relevant POM

- the source code links use :envvar:`SOURCE_USER` and :envvar:`SOURCE_BRANCH`

- for the Bio-Formats and OMERO sets of documentation, the name of the
  Jenkins job is set by :envvar:`JENKINS_JOB`.

OMERO 5.x series
^^^^^^^^^^^^^^^^

The branch for the 5.x series of the OMERO documentation is develop.

.. glossary::

	:jenkinsjob:`OMERO-DEV-latest-docs`

		This job is used to review the PRs opened against the develop branch
		of the OMERO 5.4.x documentation

		#. |merge|
		#. |sphinxbuild|
		#. |linkcheck|

	:jenkinsjob:`OMERO-DEV-merge-docs`

		This job is used to review the PRs opened against the develop branch
		of the OMERO 5.4.x documentation

		#. |merge|
		#. Pushes the branch to :omedoc_scc_branch:`develop/merge/daily`
		#. |sphinxbuild|
		#. |linkcheck|

	:jenkinsjob:`OMERO-DEV-latest-docs-autogen`

		This job is used to build the latest auto-generated pages for the
		develop branch of the OMERO documentation

		#. Checks out the develop branch of ome-documentation.git_
		#. Downloads the OMERO.server and OMERO.clients from
		   :term:`OMERO-DEV-latest`
		#. Runs the :file:`omero/autogen_docs` autogeneration script
		#. Pushes the auto-generated changes to
		   :omedoc_scc_branch:`develop/latest/autogen`

	:jenkinsjob:`OMERO-DEV-merge-docs-autogen`

		This job is used to review the component auto-generation for the
		develop branch of the OMERO documentation

		#. Checks out :omedoc_scc_branch:`develop/merge/daily`
		#. Downloads the OMERO.server and OMERO.clients from
		   :term:`OMERO-DEV-merge-build`
		#. Runs the :file:`omero/autogen_docs` autogeneration script
		#. Pushes the auto-generated changes to
		   :omedoc_scc_branch:`develop/merge/autogen`

Bio-Formats 5.x series
^^^^^^^^^^^^^^^^^^^^^^

The branch for the 5.x series of the Bio-Formats documentation is develop.

.. glossary::

	:jenkinsjob:`BIOFORMATS-DEV-latest-docs`

		This job is used to build the develop branch of the Bio-Formats
		documentation.

		#. |sphinxbuild|
		#. |linkcheck|

	:jenkinsjob:`BIOFORMATS-DEV-merge-docs`

		This job is used to review the PRs opened against the develop branch
		of the Bio-Formats documentation

		#. |merge|
		#. |sphinxbuild|
		#. |linkcheck|

	:jenkinsjob:`BIOFORMATS-DEV-latest-docs-autogen`

		This job is used to build the latest auto-generated formats and
		readers pages for the develop branch of the Bio-Formats documentation

		#. Builds Bio-Formats using ``ant clean jars``
		#. Runs the auto-generation using ``ant gen-format-pages gen-structure-table gen-meta-support gen-meta-support``
		   from :file:`components/autogen`
		#. Checks for file changes under :file:`docs/sphinx`
		#. Pushes the auto-generated changes to
		   :bf_scc_branch:`develop/latest/autogen`


	:jenkinsjob:`BIOFORMATS-DEV-merge-docs-autogen`

		This job is used to build the merge auto-generated pages for the
		develop branch of the Bio-Formats documentation

		#. Checks out :bf_scc_branch:`develop/merge/daily`
		#. Builds Bio-Formats using ``ant clean jars``
		#. Runs the auto-generation using ``ant gen-format-pages gen-structure-table gen-meta-support gen-meta-support``
		   from :file:`components/autogen`
		#. Checks for file changes under :file:`docs/sphinx`
		#. Pushes the auto-generated changes to 
		   :bf_scc_branch:`develop/merge/autogen`


OME Model and OME Contributing
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The OME Contributing documentation is located in the ome-documentation
repository and is built from the develop branch. The Model documentation is
located in the ome-model repository and is built from the master branch.

.. glossary::

	:jenkinsjob:`MODEL-merge-docs`

		This job is used to review the PRs opened against the master branch
		of the OME Model documentation

		#. |merge|
		#. |sphinxbuild|
		#. |linkcheck|

	:jenkinsjob:`CONTRIBUTING-merge-docs`

		This job is used to review the PRs opened against the develop branch
		of the OME Contributing documentation

		#. |merge|
		#. |sphinxbuild|
		#. |linkcheck|

	:jenkinsjob:`MODEL-latest-docs`

		This job is used to build the master branch of the OME Model
		documentation and publish the official documentation

		#. |sphinxbuild|
		#. |linkcheck|

	:jenkinsjob:`CONTRIBUTING-latest-docs`

		This job is used to build the develop branch of the OME Contributing
		documentation and publish the official documentation

		#. |sphinxbuild|
		#. |linkcheck|

Jekyll websites
^^^^^^^^^^^^^^^

The following set of jobs is used to review or publish the content of the
:doc:`OME Jekyll websites <jekyll>`.

.. glossary::

	:jenkinsjob:`WWW-merge`

		This job is used to review the PRs opened against the master branch of
		https://github.com/openmicroscopy/www.openmicroscopy.org

		#. |merge| and pushes the branch to https://github.com/snoopycrimecop/www.openmicroscopy.org/tree/gh-pages
		#. The GitHub Pages service deploys the staging website content under http://snoopycrimecop.github.io/www.openmicroscopy.org/

	:jenkinsjob:`OME-help-staging`

		This job is used to review the PRs opened against the master branch
		of https://github.com/openmicroscopy/ome-help

		#. |merge| (and also incorporates :omehelp_scc_branch:`cname_staging`
		   to allow	 deployment to a non-GitHub URL) then pushes the resulting
		   branch to :omehelp_scc_branch:`gh-pages`
		#. The GitHub Pages service updates the content of
		   http://help.staging.openmicroscopy.org

	:jenkinsjob:`OME-help-release`

		This job is used to deploy the OME help documentation

		#. Opens a Pull Request from
		   https://github.com/openmicroscopy/ome-help/tree/master
		   to https://github.com/openmicroscopy/ome-help/tree/gh-pages. If
		   this PR is merged, the GitHub Pages service updates the content of
		   http://help.openmicroscopy.org
		#. If the build is promoted,
			#. rysnc the content of :file:`/ome/data_repo/public/help-staging`
			   to :file:`/ome/data_repo/public/help`

	:jenkinsjob:`FIGURE-help-staging`

		This job is used to review the PRs opened against the gh-pages-staging
		branch of https://github.com/ome/omero-figure.

		#. |merge| (and also incorporates :figure_scc_branch:`cname_staging` to
		   allow  deployment to a non-GitHub URL) then pushes the resulting
		   branch to :figure_scc_branch:`gh-pages`
		#. The GitHub Pages service updates the content of
		   http://figure.staging.openmicroscopy.org

	:jenkinsjob:`FIGURE-help-release`

		This job is used to deploy the Figure gh-pages website

		#. Opens a Pull Request from
		   https://github.com/ome/omero-figure/tree/gh-pages-staging
		   to https://github.com/ome/omero-figure/tree/gh-pages. If
		   this PR is merged, the GitHub Pages service updates the content of
		   http://figure.openmicroscopy.org

OME Files
^^^^^^^^^

This bundle of Sphinx documentation has two components: OME Files C++
documentation is located in the ome-files-cpp repository; OME CMake
Super-Build documentation is located in the ome-cmake-superbuild repository.
Both are currently built from the master branches despite the build names.

.. glossary::

     :jenkinsjob:`OME-FILES-CPP-DEV-release-bundle-docs`

	    This job is used to publish the master branches of the OME Files C++
	    and OME CMake Super-Build Sphinx documentation as a single bundle

	    #. |buildFilesSB|
	    #. |deploy-doc| http://www.openmicroscopy.org/site/support/ome-files-cpp/

The merge and latest builds for this documentation set are detailed on the
:doc:`ci-ome-files` page.

Note that because of the bundle nature of these builds, they does not use the
standard Sphinx configuration described above nor report broken links parsed
through the warnings plugin as below.

.. _linkcheck_parser:

Linkcheck output parser
^^^^^^^^^^^^^^^^^^^^^^^

.. _Warnings Plugin: https://wiki.jenkins-ci.org/display/JENKINS/Warnings+Plugin

The :file:`output.txt` file generated by Sphinx ``linkcheck`` builder is
parsed using the `Warnings Plugin`_. Depending on the nature of the links,
warnings are generated as described in the following table:

====== ================ ========
Type   Error code		Priority
====== ================ ========
local					High
broken HTTP Error 404	Normal
broken Anchor not found Normal
broken HTTP Error 403	Low
====== ================ ========

The build is marked as FAILED or UNSTABLE if the number of warnings of a given
category exceeds a threshold. The table below lists the thresholds used for
all the documentation builds:

======== ====== ========
Priority FAILED UNSTABLE
======== ====== ========
High	 0
Normal			0
Low				10
======== ====== ========
