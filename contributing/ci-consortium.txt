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


FLIMfit
^^^^^^^

The source code for the FLIMfit is hosted under
https://github.com/imperial-photonics/FLIMfit. Since 4.11.1, the downloads are
hosted at http://flimfit.org/.

OMERO.mtools
^^^^^^^^^^^^

.. glossary::

	:jenkinsjob:`MTOOLS-release-downloads`

		This job is used to build the OMERO.mtools downloads page

		#. Merge PRs opened against `develop`
		#. Build the OMERO.mtools downloads pages using :command:`make mtools`
		#. Copy the OMERO.mtools downloads page over SSH to
		   :file:`/ome/www/download.openmicroscopy.org/mtools/RELEASE`

OMERO.webtagging
^^^^^^^^^^^^^^^^

The source code for OMERO.webtagging is hosted under
https://github.com/MicronOxford/webtagging/. Since 3.0.0, the Web app is released under https://pypi.python.org/pypi/omero-webtagging-tagsearch and
https://pypi.python.org/pypi/omero-webtagging-autotag.
