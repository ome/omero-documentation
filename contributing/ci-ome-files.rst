OME Files jobs
--------------

All jobs are listed under the :jenkinsview:`Files` view tab of Jenkins.

.. list-table::
        :header-rows: 1

        -       * Job task
                * Development series (0.x.y)

        -       * Builds the latest OME Files C++ components (Unix superbuild)
                * :term:`OME-FILES-CPP-DEV-latest-superbuild`

        -       * Builds the latest OME Files C++ components (Windows superbuild)
                * :term:`OME-FILES-CPP-DEV-latest-win-superbuild`

        -       * Builds the latest OME Files C++ documentation
                * :term:`OME-FILES-CPP-DEV-latest-docs`

        -       * Triggers the building of the merge OME Files C++ components (all merge build jobs)
                * :term:`OME-FILES-CPP-DEV-merge-trigger`

        -       * Merges the ome-cmake-superbuild PRs
                * :term:`OME-FILES-CPP-DEV-merge-push-superbuild`

        -       * Builds the merge OME Files C++ components (Unix)
                * :term:`OME-FILES-CPP-DEV-merge`

        -       * Builds the merge OME Files C++ source releases (Unix)
                * :term:`OME-FILES-CPP-DEV-merge-sourcebuild`

        -       * Builds the merge OME Files C++ components (Unix superbuild)
                * :term:`OME-FILES-CPP-DEV-merge-superbuild`

        -       * Builds the merge OME Files C++ components (Windows superbuild)
                * :term:`OME-FILES-CPP-DEV-merge-win-superbuild`

        -       * Builds the merge OME Files C++ documentation
                * :term:`OME-FILES-CPP-DEV-merge-docs`

Stable series
^^^^^^^^^^^^^

There is not currently a stable (1.0) release of OME Files.

Development series
^^^^^^^^^^^^^^^^^^

The branch for the development series of OME Files is master.

.. glossary::

        :jenkinsjob:`OME-FILES-CPP-DEV-latest-superbuild`

                This job builds the master branches of OME Files components (Unix)

                #. |buildFilesSB|

                See :jenkinsjob:`the build graph <OME-FILES-CPP-DEV-latest-superbuild/lastSuccessfulBuild/BuildGraph>`

        :jenkinsjob:`OME-FILES-CPP-DEV-latest-win-superbuild`

                This job builds the master branches of OME Files components (Windows)

                #. |buildFilesSB|

                See :jenkinsjob:`the build graph <OME-FILES-CPP-DEV-latest-win-superbuild/lastSuccessfulBuild/BuildGraph>`

        :jenkinsjob:`OME-FILES-CPP-DEV-latest-docs`

                This job builds the documentation for master branches of OME Files components

                #. |buildFilesSB|

                See :jenkinsjob:`the build graph <OME-FILES-CPP-DEV-latest-docs/lastSuccessfulBuild/BuildGraph>`


        :jenkinsjob:`OME-FILES-CPP-DEV-merge-trigger`

                This job runs the daily OME Files jobs used for reviewing the PRs
                opened against the master branches of OME Files.

                #. Triggers :term:`OME-FILES-CPP-DEV-merge-push-superbuild`
                #. Triggers downstream merge projects

                See :jenkinsjob:`the build graph <OME-FILES-CPP-DEV-merge-trigger/lastSuccessfulBuild/BuildGraph>`

        :jenkinsjob:`OME-FILES-CPP-DEV-merge-push-superbuild`

                This job merges all the PRs opened against master for each OME Files component

                #. |merge|
                #. Pushes the integration branches as `master_merge_daily`

        :jenkinsjob:`OME-FILES-CPP-DEV-merge`

                This job builds the merge branches of OME Files components (Unix)

                #. Checks out the `master_merge_daily` branches
                #. |buildFiles|

        :jenkinsjob:`OME-FILES-CPP-DEV-merge-sourcebuild`

                This job builds the merge branch of
                ``ome-cmake-superbuild`` using the latest source
                release of all OME Files components (Unix)

                #. Checks out the `master_merge_daily` branch
                #. |buildFilesSB|

        :jenkinsjob:`OME-FILES-CPP-DEV-merge-superbuild`

                This job builds the merge branches of OME Files components (Unix)

                #. Checks out the `master_merge_daily` branches
                #. |buildFilesSB|

        :jenkinsjob:`OME-FILES-CPP-DEV-merge-win-superbuild`

                This job builds the merge branches of OME Files components (Windows)

                #. Checks out the `master_merge_daily` branch
                #. |buildFilesSB|

        :jenkinsjob:`OME-FILES-CPP-DEV-merge-docs`

                This job builds the documentation for merge branches of OME Files components

                #. |buildFilesSB|
                
                See :jenkinsjob:`the build graph <OME-FILES-CPP-DEV-merge-docs/lastSuccessfulBuild/BuildGraph>`

.. _files_breaking:

Breaking jobs
^^^^^^^^^^^^^

Breaking jobs are jobs used to review breaking changes, for instance model
changes. The branch for the breaking series of OME Files is master.

.. glossary::
        :jenkinsjob:`OME-FILES-CPP-DEV-breaking-trigger`

                This job runs the daily OME Files jobs used for
                reviewing the breaking PRs opened against the master
                branches of OME Files.

                #. Triggers :term:`OME-FILES-CPP-DEV-breaking-push-superbuild`
                #. Triggers downstream breaking projects

                See :jenkinsjob:`the build graph <OME-FILES-CPP-DEV-breaking-trigger/lastSuccessfulBuild/BuildGraph>`

        :jenkinsjob:`OME-FILES-CPP-DEV-breaking-push-superbuild`

                This job breakings all the PRs opened against master for each OME Files component

                #. |merge|
                #. Pushes the integration branches as `master_breaking_daily`

        :jenkinsjob:`OME-FILES-CPP-DEV-breaking`

                This job builds the breaking branches of OME Files components (Unix)

                #. Checks out the `master_breaking_daily` branches
                #. |buildFilesSB|
