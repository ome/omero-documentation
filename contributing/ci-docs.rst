Documentation jobs
------------------

All documentation jobs are listed under the :jenkinsview:`Docs <Docs>` view
tab of Jenkins. A :guilabel:`GitHub`
button in the left-side panel of the job window links to the code repository
the job is building from (alternatively, the console output for the build will
indicate where the changes are being fetched from).

More detail on how and where to edit OME documentation is available on the
:doc:`editing-docs` page.

.. list-table::
	:header-rows: 1

	-	* Job task
		* OMERO 5.x series

	-	* Builds the OMERO documentation for review
		* :term:`OMERO-docs`


The Bio-Formats documentation jobs are described in the :doc:`ci-bio-formats`
section.

The OME Model and OME Contributing documentation sets are
independent of the current OMERO/Bio-Formats version.

.. list-table::
	:header-rows: 1

	-	* Job task
		*

	-	* Publish OME Contributing documentation
		* :term:`CONTRIBUTING-latest-docs`

	-	* Review OME Contributing documentation PRs
		* :term:`CONTRIBUTING-merge-docs`


.. list-table::
	:header-rows: 1

	-	* Job task
		*

	-	* Review PRs opened against the OME Website
		* :term:`WEBSITE-push`

	-	* Review PRs opened against the Presentations website
		* :term:`PRESENTATIONS-merge`


Configuration
^^^^^^^^^^^^^

For all jobs building documentation using Sphinx, the following environment
variables are used:

- the Sphinx building options, :envvar:`SPHINXOPTS`, is set to
  ``-Dsphinx.opts="-W"``

- the release number of the documentation is set by :envvar:`OMERO_RELEASE`,
  :envvar:`BF_RELEASE` or by the relevant POM

- the source code links use :envvar:`SOURCE_USER` and :envvar:`SOURCE_BRANCH`

- for the Bio-Formats and OMERO sets of documentation, the name of the
  Jenkins job is set by :envvar:`JENKINS_JOB`.

Note that the https://github.com/ome/sphinx_theme repository is no
longer used, this hosted the theme to match the old plone website.

OMERO 5.x series
^^^^^^^^^^^^^^^^

The branch for the 5.x series of the OMERO documentation is develop.

.. glossary::

	:mergecijob:`OMERO-docs`

		This job is used to review the PRs opened against the develop branch
		of the OMERO 5.x documentation

		#. |merge|
		#. Pushes the branch to :omedoc_scc_branch:`merge_ci`
		#. |sphinxbuild|
		#. |linkcheck|

OME Contributing
^^^^^^^^^^^^^^^^

The OME Contributing documentation is located in the ome-documentation
repository and is built from the develop branch.

.. glossary::


	:jenkinsjob:`CONTRIBUTING-merge-docs`

		This job is used to review the PRs opened against the develop branch
		of the OME Contributing documentation

		#. |merge|
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

	:mergecijob:`WEBSITE-push`

		This job is used to review the PRs opened against the master branch of
		https://github.com/ome/www.openmicroscopy.org

		#. |merge| and pushes the branch to https://github.com/snoopycrimecop/www.openmicroscopy.org/tree/merge_ci
		#. The GitHub Pages service deploys the staging website content under https://snoopycrimecop.github.io/www.openmicroscopy.org/


	:jenkinsjob:`PRESENTATIONS-merge`

		This job is used to review the PRs opened against the master branch of
		https://github.com/ome/presentations

		#. |merge| and pushes the branch to https://github.com/snoopycrimecop/presentations
		#. The GitHub Pages service deploys the staging website content under https://snoopycrimecop.github.io/presentations/

