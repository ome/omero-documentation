OMERO jobs
----------

.. list-table::
    :header-rows: 1

    -   * Job task
        * DEV series

    -   * Builds the latest OMERO artifacts
        * :term:`OMERO-DEV-latest`

    -   * Deploys the latest OMERO server
        * :term:`OMERO-DEV-latest-deploy`

    -   * Deploys the latest OMERO web
        * :term:`WEB-DEV-latest-deploy`

    -   * Updates submodules
        * :term:`OMERO-DEV-latest-submods`

    -   * Runs the daily OMERO merge builds
        * :term:`OMERO-DEV-merge-daily`

    -   * Merges the PRs
        * :term:`OMERO-DEV-merge-push`

    -   * Builds the merge OMERO artifacts
        * :term:`OMERO-DEV-merge-build`

    -   * Deploys the merge OMERO server
        * :term:`OMERO-DEV-merge-deploy`

    -   * Deploys the merge OMERO web
        * :term:`WEB-DEV-merge-deploy`

    -   * Runs the OMERO integration tests
        * | :term:`OMERO-DEV-merge-integration`
          | :term:`OMERO-DEV-merge-integration-broken`
          | :term:`OMERO-DEV-merge-integration-java`
          | :term:`OMERO-DEV-merge-integration-python`
       
    -   * Deploys the integration OMERO web and runs Robot tests using first server from the list
        * :term:`WEB-DEV-integration-deploy`

    -   * Runs the OMERO.matlab tests
        * :term:`OMERO-DEV-merge-matlab`

    -   * Runs the robot framework tests
        * :term:`OMERO-DEV-merge-robotframework`

    -   * Pushes SNAPSHOTS to Maven
        * | :term:`OMERO-DEV-latest-maven`
          | :term:`OMERO-DEV-merge-maven`

.. _deployment_servers:

Deployment servers and web
^^^^^^^^^^^^^^^^^^^^^^^^^^

The table below lists all the hostnames, ports and URLs of the OMERO.web
clients of the deployment jobs described above:

.. list-table::
    :header-rows: 1
    :widths: 10,20,20,10,20,40

    -   * Series
        * Deployment job (server)
        * Hostname
        * Port
        * Deployment job (web)
        * Webclient

    -   * DEV
        * :term:`OMERO-DEV-merge-deploy`
        * eel.openmicroscopy.org
        * 4064
        * :term:`WEB-DEV-merge-deploy`
        * http://web-dev-merge.openmicroscopy.org/webclient/login/

    -   * DEV
        * :term:`OMERO-DEV-latest-deploy`
        * eel.openmicroscopy.org
        * 14064
        * :term:`WEB-DEV-latest-deploy`
        * http://web-dev-latest.openmicroscopy.org/webclient/login/

    -   * DEV
        * :term:`OMERO-DEV-merge-integration`
        * eel.openmicroscopy.org
        * 24064
        * :term:`WEB-DEV-integration-deploy`
        * http://web-dev-integration.openmicroscopy.org/webclient/login/


5.4.x series
^^^^^^^^^^^^

The branch for the 5.4.x series of OMERO is develop. All jobs are listed
under the :jenkinsview:`DEV` view tab of Jenkins.

.. glossary::

    :jenkinsjob:`OMERO-DEV-latest`

        This job builds the develop branch of OMERO with Ice 3.5 or 3.6

        #. |buildOMERO|
        #. |archiveOMEROartifacts|

        See :jenkinsjob:`the build graph <OMERO-DEV-latest/lastSuccessfulBuild/BuildGraph>`

    :jenkinsjob:`OMERO-DEV-latest-deploy`

        This job deploys the latest 5.4.x server (see
        :ref:`deployment_servers`)

    :jenkinsjob:`WEB-DEV-latest-deploy`

        This job deploys the latest 5.4.x webclient (see
        :ref:`deployment_servers`)

    :jenkinsjob:`OMERO-DEV-latest-submods`

        This job updates the submodules on the develop branch

        #. |updatesubmodules| and pushes the merge branch to
           :omero_scc_branch:`develop/latest/submodules`
        #. If the submodules are updated, opens a new PR or updates the
           existing develop submodules PR

    :jenkinsjob:`OMERO-DEV-merge-daily`

        This job triggers all the morning merge builds listed below

        #. Triggers :term:`OMERO-DEV-merge-push`
        #. Triggers :term:`OMERO-DEV-merge-build` and
           :term:`OMERO-DEV-merge-integration`
        #. Triggers :term:`OMERO-DEV-merge-deploy`
        #. Triggers :term:`WEB-DEV-merge-deploy`
        #. Triggers other downstream merge jobs

        See :jenkinsjob:`the build graph <OMERO-DEV-merge-daily/lastSuccessfulBuild/BuildGraph>`

    :jenkinsjob:`OMERO-DEV-merge-push`

        This job merges all the PRs opened against develop

        #. |merge|
        #. Pushes the branch to :omero_scc_branch:`develop/merge/daily`

    :jenkinsjob:`OMERO-DEV-merge-build`

        This matrix job builds the OMERO components with Ice 3.5 or 3.6

        #. Checks out :omero_scc_branch:`develop/merge/daily` 
        #. |buildOMERO| for each version of Ice
        #. |archiveOMEROartifacts|

    :jenkinsjob:`OMERO-DEV-merge-deploy`

        This job deploys the merge 5.4.x server (see
        :ref:`deployment_servers`)

    :jenkinsjob:`WEB-DEV-merge-deploy`

        This job deploys the merge 5.4.x web (see
        :ref:`deployment_servers`)

    :jenkinsjob:`OMERO-DEV-merge-integration`

        This job runs the integration tests of OMERO

        #. Checks out :omero_scc_branch:`develop/merge/daily` 
        #. Builds OMERO.server and starts it
        #. Runs the OMERO.java and OMERO.py integration tests
        #. Archives the results
        #. Triggers downstream collection jobs:
           :term:`OMERO-DEV-merge-integration-broken`,
           :term:`OMERO-DEV-merge-integration-java`,
           :term:`OMERO-DEV-merge-integration-python`

    :jenkinsjob:`OMERO-DEV-merge-integration-broken`

        This job collects the OMERO.java broken test results

        #. Receives TestNG results under
           :file:`components/tools/OmeroJava/target/reports/broken` from
           :term:`OMERO-DEV-merge-integration`,
        #. Generates TestNG report

    :jenkinsjob:`OMERO-DEV-merge-integration-java`

        This job collects the OMERO.java integration test results

        #. Receives TestNG results under
           :file:`components/tools/OmeroJava/target/reports/integration` from
           :term:`OMERO-DEV-merge-integration`,
        #. Generates TestNG report

    :jenkinsjob:`OMERO-DEV-merge-integration-python`

        This job collects the OMERO.py integration test results

        #. Receives pytest results under
           :file:`components/tools/OmeroPy/target/reports` from
           :term:`OMERO-DEV-merge-integration`,
        #. Generates pytest report

    :jenkinsjob:`WEB-DEV-integration-deploy`

        This job deploys the merge 5.4.x web (see
        :ref:`deployment_servers`)

    :jenkinsjob:`OMERO-DEV-merge-integration-Python27`

        This job runs Python integration tests of OMERO on Python 2.7

        #. Checks out :omero_scc_branch:`develop/breaking/trigger`
        #. Builds OMERO.server and starts it
        #. Runs the OMERO.py and OMERO.web integration tests
        #. Archives the results

    :jenkinsjob:`OMERO-DEV-merge-matlab`

        This job runs the OMERO.matlab tests

        #. Checks out :omero_scc_branch:`develop/merge/daily` 
        #. Collects the MATLAB artifacts from :term:`OMERO-DEV-merge-build`
        #. Runs the MATLAB unit tests under
           :file:`components/tools/OmeroM/test/unit` and collect the results

    :jenkinsjob:`OMERO-DEV-merge-maven`

        This job is used to generate SNAPSHOT jars and push them to artifactory.

        #. Runs :file:`docs/hudson/OMERO.sh`
        #. Executes the `release-hudson` target for the `ome.unstable` repository.

    :jenkinsjob:`OMERO-DEV-latest-maven`

        The same as :term:`OMERO-DEV-merge-maven`, but pushes to `ome.snapshots`.

    :jenkinsjob:`OMERO-DEV-merge-robotframework`

        This job runs the robot framework tests of OMERO

        #. Checks out :omero_scc_branch:`develop/merge/daily` 
        #. Builds OMERO.server and starts it
        #. Runs the robot framework tests and collect the results

    :jenkinsjob:`OMERO-DEV-merge-homebrew`

        This job tests the installation of OMERO using Homebrew

        #. Cleans :file:`/usr/local`
        #. Installs Homebrew from https://github.com/ome/omero-install
        #. Installs OMERO via :file:`osx/install_homebrew.sh`
