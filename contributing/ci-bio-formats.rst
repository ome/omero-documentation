Bio-Formats jobs
----------------

.. list-table::
    :header-rows: 1

    -   * Job task
        * Merge jobs

    -   * Merges the PRs and couple versions
        * :term:`BIOFORMATS-push`

    -   * Builds the Bio-Formats artifacts
        * | :term:`BIOFORMATS-merge`
          | :term:`BIOFORMATS-image`

    -   * Builds the Bio-Formats documentation
        * :term:`BIOFORMATS-merge-docs`

    -   * Runs the Bio-Formats non-regression tests
        * :term:`BIOFORMATS-test-repo`


.. glossary::

    :mergecijob:`BIOFORMATS-push`

        This jobs merge all the PRs opened against the development branch of
        https://github.com/ome/bio-formats-build and couple the component
        versions

    :mergecijob:`BIOFORMATS-merge`
    :mergecijob:`BIOFORMATS-image`

        This job builds all the Bio-Formats artifacts using Ant

    :mergecijob:`BIOFORMATS-merge-docs`

        This job builds the Bio-Formats documentation and runs the linkchecker

    :mergecijob:`BIOFORMATS-test-repo`

        This job consumes the Docker image built by :term:`BIOFORMATS-image`
        and runs the non-regression automated tests against the curated QA
        repository
