Continuous integration branches and jobs
----------------------------------------

Versioning
^^^^^^^^^^

OME uses semantic versioning as defined in http://semver.org. Each version
number is identified as MAJOR.MINOR.PATCH where MAJOR is the major version
number, MINOR the minor version number and PATCH the patch version number.
Additional pre-release labels are added as extensions of this version number,
e.g. 4.4.0-rc1 or 5.0.0-beta1.

.. glossary::

	Major release

		An increment of the MAJOR version or the MINOR version is typically
		considered as a major release in OME, e.g. 5.0.0 or 5.1.0.

	Point release (patch release)

		An increment of the PATCH version is called a point (or patch) release
		in OME, e.g. 4.4.9.

Development branches
^^^^^^^^^^^^^^^^^^^^

Most of the OME code is split between four repositories: openmicroscopy.git_,
bioformats.git_, scripts.git_, ome-documentation.git_. Each repository
contains several development branches associated with development series:

* The "dev_5_y" branch(es) containing work on the current 5.y.x series.
* The "develop" branch containing work on the next major release series.

Note that only two branches are usually maintained simultaneously. With this
workflow, it is possible to have a point release immediately, while still
working on more major releases by ensuring that (nearly) all commits that are
applied to dev_5_y are applied to develop in order to prevent regressions.

Labels
^^^^^^

Labels are applied to PRs on GitHub under the “Issues” tab of each repository.

Each release series consists of PRs labeled according to the release version,
which also matches the name of the branch they will be merged into e.g. 5.1.x
series PRs will be labeled as "dev_5_1" and be merged into the dev_5_1
branch.

Multiple labels are used in the PR reviewing process:

- the “include” label allows you to include a PR opened by a non-member of the
  OME organization in the merge builds for review.
- the “exclude” label allows you to exclude a PR opened by any user from the
  merge builds.
- the "on hold" label allows you to signal that a PR should not be
  reviewed or merged, even though it is not excluded.

Job names
^^^^^^^^^

All core OME job names take the form
``COMPONENT-VERSION-TYPE-DESCRIPTION``, where:

- ``COMPONENT`` refers to the core OME component, e.g. `OMERO` for
  OMERO or `BIOFORMATS` for Bio-Formats.
- ``VERSION`` is the MAJOR.MINOR version, e.g. `5.0` or `5.1`.
- ``TYPE`` represents the source of the job and can take the following values:

  * `latest`: build from the tip of the development branch, e.g.
    `origin/dev_5_0`;
  * `merge`: build from the tip of the development branch with all
    PRs merged using :ref:`scc merge` with the `org` default filter set;
  * `release`: build from and optionally create a tag at the tip of
    a development branch, e.g. `v5.0.1-rc4`.

- ``DESCRIPTION`` describes the job via a set of dash-separated
  keywords, e.g. `docs-autogen`.
