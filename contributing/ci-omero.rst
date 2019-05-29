OMERO jobs
----------

.. _deployment_servers:

Deployments
^^^^^^^^^^^

The table below lists all the hostnames, ports and URLs of the OMERO.web
clients of the deployment jobs described above:

.. list-table::
    :header-rows: 1
    :widths: 10,20,20,10,20,40

    -   * Series
        * OMERO.server deployment job
        * Hostname
        * Port
        * OMERO.web deployment job
        * Webclient

    -   * Merge 
        * :term:`OMERO-server`
        * merge-ci.openmicroscopy.org
        * 4064
        * :term:`OMERO-web`
        * https://merge-ci.openmicroscopy.org/web/


Jobs
^^^^

.. list-table::
    :header-rows: 1

    -   * Job task
        * Merge jobs

    -   * Merges the PRs and couple versions
        * | :term:`OMERO-gradle-plugins-push`
          | :term:`OMERO-build-push`
          | :term:`OMERO-push`
          | :term:`OMERO-insight-push`
          | :term:`OMERO-matlab-push`

    -   * Builds the OMERO artifacts
        * | :term:`OMERO-gradle-plugins-build`
          | :term:`OMERO-build-build`
          | :term:`OMERO-build`
          | :term:`OMERO-insight-build`
          | :term:`OMERO-matlab-build`

    -   * Deploy OMERO
        * | :term:`OMERO-server`
          | :term:`OMERO-web`

    -   * Runs the OMERO integration tests
        * :term:`OMERO-test-integration`

.. glossary::


    :mergecijob:`OMERO-gradle-plugins-push`
    :mergecijob:`OMERO-build-push`
    :mergecijob:`OMERO-push`
    :mergecijob:`OMERO-insight-push`
    :mergecijob:`OMERO-matlab-push`

        These jobs merge all the PRs opened against the development branches
        and couple the component versions for the following repositories:

        - https://github.com/ome/omero-gradle-plugins
        - https://github.com/ome/omero-build
        - https://github.com/openmicroscopy/openmicroscopy
        - https://github.com/ome/omero-insight
        - https://github.com/ome/omero-matlab

    :mergecijob:`OMERO-gradle-plugins-build`
    :mergecijob:`OMERO-build-build`
    :mergecijob:`OMERO-build`
    :mergecijob:`OMERO-insight-build`
    :mergecijob:`OMERO-matlab-build`

        These jobs build the OMERO server components, the OMERO bundles and the
        OMERO clients from the integration branches created by the push jobs.

    :mergecijob:`OMERO-server`

        This job deploys the server (see :ref:`deployment_servers`) created by
        :term:`OMERO-build`.

    :mergecijob:`OMERO-web`

        This job deploys the Web application (see :ref:`deployment_servers`)
        created by :term:`OMERO-build`.

    :mergecijob:`OMERO-test-integration`

        This job deploys an OMERO.server and runs the OMERO.java, OMERO.py
        and OMERO.web integration tests.
