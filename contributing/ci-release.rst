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
    -   * Run the OMERO integration tests
        * :jenkinsjob:`OMERO-DEV-release-integration`

.. list-table::
    :header-rows: 1

    -   * Job task
        * Bio-Formats   
    -   * Trigger the Bio-Formats release jobs
        * :jenkinsjob:`BIOFORMATS-DEV-release-trigger`
    -   * Tags the Bio-Formats source code repository
        * :jenkinsjob:`BIOFORMATS-DEV-release-push`
    -   * Build the Bio-Formats download artifacts
        * :jenkinsjob:`BIOFORMATS-DEV-release`
    -   * Generate the Bio-Formats downloads page
        * :jenkinsjob:`BIOFORMATS-DEV-release-downloads`


Deployment servers
^^^^^^^^^^^^^^^^^^

The table below lists all the hostnames, ports and URLs of the OMERO.web
clients of the deployment jobs described above:

.. list-table::
    :header-rows: 1
    :widths: 10,20,20,10,40

    -   * Series
        * Deployment job
        * Hostname
        * Port
        * Webclient

    -   * DEV
        * :term:`OMERO-DEV-release-integration`
        * seabass.openmicroscopy.org
        * 24064
        * https://seabass.openmicroscopy.org/5.2


Bio-Formats
^^^^^^^^^^^

.. glossary::

    :jenkinsjob:`BIOFORMATS-DEV-release-trigger`

        This job triggers the Bio-Formats release jobs. Prior
        to running it, its variables need to be properly configured:

        - :envvar:`RELEASE` is the Bio-Formats release number.

        #. Triggers :term:`BIOFORMATS-DEV-release-push`
        #. Triggers :term:`BIOFORMATS-DEV-release`

    :jenkinsjob:`BIOFORMATS-DEV-release-push`

        This job creates a tag on the `develop` branch

        #. Runs `scc tag-release $RELEASE` and pushes the tag to the
           snoopycrimecop fork of bioformats.git_

    :jenkinsjob:`BIOFORMATS-DEV-release`

        This job builds the Java downloads artifacts of Bio-Formats

        #. Checks out the :envvar:`RELEASE` tag of the
           snoopycrimecop fork of bioformats.git_
        #. |buildBF|
        #. |copyreleaseartifacts|
        #. Triggers :term:`BIOFORMATS-DEV-release-downloads`

    :jenkinsjob:`BIOFORMATS-DEV-release-downloads`

        This job builds the Bio-Formats Java downloads page

        #. Checks out the `develop` branch of
           https://github.com/openmicroscopy/ome-release.git
        #. Runs `make clean bf`

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
        #. Triggers :term:`OMERO-DEV-release-integration`
        #. Triggers :term:`OMERO-DEV-release`

        See :jenkinsjob:`the build graph <OMERO-DEV-release-trigger/lastSuccessfulBuild/BuildGraph>`

    :jenkinsjob:`OMERO-DEV-release-push`

        This job creates a tag on the `develop` branch

        #. Runs `scc tag-release $RELEASE` and pushes the tag to the
           snoopycrimecop fork of openmicroscopy.git_

    :jenkinsjob:`OMERO-DEV-release`

        This matrix job builds the OMERO components with Ice 3.5

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

    :jenkinsjob:`OMERO-DEV-release-integration`

        This job runs the integration tests

        #. Checks out the :envvar:`RELEASE` tag of the
           snoopycrimecop fork of openmicroscopy.git_
        #. Builds OMERO.server and starts it
        #. Runs the OMERO.java, OMERO.py and OMERO.web integration tests
        #. Archives the results
        #. Triggers downstream collection jobs:
           :term:`OMERO-DEV-release-integration-broken`,
           :term:`OMERO-DEV-release-integration-java`,
           :term:`OMERO-DEV-release-integration-python`,
           :term:`OMERO-DEV-release-integration-web`,
           :term:`OMERO-DEV-release-training`,
           :term:`OMERO-DEV-release-robotframework`

    :jenkinsjob:`OMERO-DEV-release-integration-broken`

        This job collects the OMERO.java broken test results

        #. Receives TestNG results under
           :file:`components/tools/OmeroJava/target/reports/broken` from
           :term:`OMERO-DEV-release-integration`
        #. Generates TestNG report

    :jenkinsjob:`OMERO-DEV-release-integration-java`

        This job collects the OMERO.java integration test results

        #. Receives TestNG results under
           :file:`components/tools/OmeroJava/target/reports/integration` from
           :term:`OMERO-DEV-release-integration`
        #. Generates TestNG report

    :jenkinsjob:`OMERO-DEV-release-integration-python`

        This job collects the OMERO.py integration test results

        #. Receives pytest results under
           :file:`components/tools/OmeroPy/target/reports` from
           :term:`OMERO-DEV-release-integration`
        #. Generates pytest report

    :jenkinsjob:`OMERO-DEV-release-integration-web`

        This job collects the OMERO.web integration test results

        #. Receives pytest results under
           :file:`components/tools/OmeroWeb/target/reports` from
           :term:`OMERO-DEV-release-integration`
        #. Generates pytest report

    :jenkinsjob:`OMERO-DEV-release-training`

        This job runs the Java, MATLAB and Python training examples under
        :file:`examples/Training`

    :jenkinsjob:`OMERO-DEV-release-robotframework`

        This job runs the robot framework tests of OMERO

        #. Checks out the :envvar:`RELEASE` tag of the
           snoopycrimecop fork of openmicroscopy.git_
        #. Runs the robot framework tests and collect the results


Documentation release jobs are documented on :doc:`ci-docs`.
