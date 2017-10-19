Consortium jobs
---------------

This section lists all CI jobs used for building and deploying the partner
projects.  All jobs are listed under the :jenkinsview:`Release` view tab of
Jenkins.

.. list-table::
	:header-rows: 1

	-	* Partner project
		* Latest jobs
		* Release jobs

	-	* OMERO.mtools
		*
		* :term:`MTOOLS-release-downloads`

OMERO.mtools
^^^^^^^^^^^^

.. glossary::

	:jenkinsjob:`MTOOLS-release-downloads`

		This job is used to build the OMERO.mtools downloads page

		#. Merge PRs opened against `develop`
		#. Build the OMERO.mtools downloads pages using :command:`make mtools`
		#. Copy the OMERO.mtools downloads page over SSH to
		   :file:`/ome/www/download.openmicroscopy.org/mtools/RELEASE`
