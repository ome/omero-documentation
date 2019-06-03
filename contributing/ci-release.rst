Release jobs
------------

The following table lists the main Jenkins jobs used during the release
process. All release jobs should be listed under the :jenkinsview:`Release`
view.

.. list-table::
    :header-rows: 1

    -   * Job task
        * OMERO
    -   * Trigger the OMERO release jobs
        * :jenkinsjob:`OMERO-DEV-release-trigger`
    -   * Tags the OMERO source code repository
        * :jenkinsjob:`OMERO-DEV-release-push`
    -   * Build the OMERO download artifacts
        * :jenkinsjob:`OMERO-DEV-release`
    -   * Generate the OMERO downloads page
        * :jenkinsjob:`OMERO-DEV-release-downloads`
    -   * Deploy the documentation for the decoupled repositories
        * :jenkinsjob:`OMERO-DEV-release-artifacts`

.. list-table::
    :header-rows: 1

    -   * Job task
        * Bio-Formats   
    -   * Build the Bio-Formats download artifacts
        * :jenkinsjob:`BIOFORMATS-DEV-release`


Bio-Formats
^^^^^^^^^^^

.. glossary::

    :jenkinsjob:`BIOFORMATS-DEV-release`

        This job builds the Java downloads artifacts of Bio-Formats

        #. Checks out the v:envvar:`RELEASE` tag of
           https://github.com/openmicroscopy/bioformats
        #. |buildBF|
        #. Downloads the documentation artifacts from OME artifactory
        #. |copyreleaseartifacts|

OMERO
^^^^^

.. glossary::

    :jenkinsjob:`OMERO-DEV-release-trigger`

        This job triggers the OMERO release jobs. Prior to running it, its
        variables need to be properly configured:

        - :envvar:`RELEASE` is the OMERO release number.
        - :envvar:`ANNOUNCEMENT_URL` is the URL of the forum release
          announcement and should be set to the value of the URL of the
          private post until it becomes public.
        - :envvar:`MILESTONE` is the name of the Trac milestone which the
          download pages should be linked to.

        #. Triggers :term:`OMERO-DEV-release-push`
        #. Triggers :term:`OMERO-DEV-release`

        See :jenkinsjob:`the build graph <OMERO-DEV-release-trigger/lastSuccessfulBuild/BuildGraph>`

    :jenkinsjob:`OMERO-DEV-release-push`

        This job creates a tag on the `develop` branch

        #. Runs `scc tag-release $RELEASE` and pushes the tag to the
           snoopycrimecop fork of openmicroscopy.git_

    :jenkinsjob:`OMERO-DEV-release`

        This matrix job builds the OMERO components with Ice 3.6

        #. Checks out the :envvar:`RELEASE` tag of the
           snoopycrimecop fork of openmicroscopy.git_
        #. |buildOMERO|
        #. Executes the `release-hudson` target for the `ome.staging` Maven
           repository
        #. |copyreleaseartifacts|
        #. Triggers :term:`OMERO-DEV-release-downloads`

    :jenkinsjob:`OMERO-DEV-release-downloads`

        This job builds the OMERO downloads page

        #. Checks out the `develop` branch of
           https://github.com/openmicroscopy/ome-release.git
        #. Runs `make clean omero`

    :jenkinsjob:`OMERO-DEV-release-artifacts`
        This job deploys the javadoc and the slice2html documentation

        #. Loops through omero-{model,common,romio,renderer,blitz,gateway-java}
        #. Checks the latest version available on artifacts.openmicroscopy.org
        #. Deploys the documentation in the respective directory


Documentation release jobs are documented on :doc:`ci-docs`.
