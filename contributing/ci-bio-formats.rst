Bio-Formats jobs
----------------

.. list-table::
    :header-rows: 1

    -   * Job task
        * Merge jobs

    -   * Merge the PRs and couple versions
        * :term:`BIOFORMATS-push`

    -   * Build the Bio-Formats artifacts
        * | :term:`BIOFORMATS-build`
          | :term:`BIOFORMATS-image`

    -   * Build the Bio-Formats documentation
        * :term:`BIOFORMATS-linkcheck`

    -   * Run the Bio-Formats non-regression tests
        * :term:`BIOFORMATS-test-repo`


.. glossary::

    :mergecijob:`BIOFORMATS-push`

        This job merges all the PRs opened against the development branch of
        https://github.com/ome/bio-formats-build and couples the component
        versions

    :mergecijob:`BIOFORMATS-build`
    :mergecijob:`BIOFORMATS-image`

        This job builds all the Bio-Formats artifacts using Maven and Ant

    :mergecijob:`BIOFORMATS-linkcheck`

        This job runs the linkchecker on the Bio-Formats documentation

    :mergecijob:`BIOFORMATS-test-repo`

        This job consumes the Docker image built by :term:`BIOFORMATS-image`
        and runs the non-regression automated tests against the curated QA
        repository
