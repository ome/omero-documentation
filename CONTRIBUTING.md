# Contributing to OME Documentation

This repository hosts the documentation for OMERO, and **on the** `develop`
**branch only**, the OME Data Model and File Formats documentation and the
guidance for contributing developers. The Bio-Formats documentation is part of
the
[main Bio-Formats repository](https://github.com/openmicroscopy/bioformats).

We welcome contributions from the community to update or improve our
documentation but please read the style guidance in the README before opening
a PR.

## Suggesting a change

* Fork the repository on Github.
* Create a branch for your work. If you want to make changes in
  `/contributing` or `/formats`, or for a future major version of
  OMERO, this should be based on the `develop` branch. For changes for the
  current version of OMERO, base your branch on the latest `dev_x` branch e.g.
  `dev_5_0`.
* Make your commits and open a PR.
* Make sure you explain your changes in the PR description.

## After your PR is open

We aim to review all PRs within 2 working days. Someone will comment whether
the change is fine as-is or request you to make changes before we merge it. If
your formatting is incorrect, the Travis build will fail and indicate the
problem for you.

If your changes are for the current version of OMERO, one of the docs team
will either ask you to rebase your change onto the `develop` branch after
merging, or will do it for you. If you are making a very minor change, you may
open PRs on both branches before review if you wish.