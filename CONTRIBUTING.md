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

## Sign your changes

The sign-off is a simple line at the end of the explanation for the patch, which certifies that you wrote it or otherwise have the right to pass it on as an open-source patch. The rules are pretty simple: if you can certify the below (from developercertificate.org):

```
Developer Certificate of Origin
Version 1.1

Copyright (C) 2004, 2006 The Linux Foundation and its contributors.
660 York Street, Suite 102,
San Francisco, CA 94110 USA

Everyone is permitted to copy and distribute verbatim copies of this
license document, but changing it is not allowed.


Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

(b) The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

(c) The contribution was provided directly to me by some other
    person who certified (a), (b) or (c) and I have not modified
    it.

(d) I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.
```

then you just add a line to every git commit message:

```
OME-DCO-1.1-Signed-off-by: Joe Smith <joe.smith@email.com> (github: github_handle)
```

using your real name (sorry, no pseudonyms or anonymous contributions.)

One way to automate this, is customise your get commit.template by adding a 
prepare-commit-msg hook to your OME source code checkout:

```
curl -o $(git rev-parse --git-dir)/hooks/prepare-commit-msg https://raw.githubusercontent.com/openmicroscopy/ome-documentation/develop/contributing/downloads/prepare-commit-msg.hook 
chmod +x $(git rev-parse --git-dir)/hooks/prepare-commit-msg
git submodule foreach 'curl -o $(git rev-parse --git-dir)/hooks/prepare-commit-msg https://raw.githubusercontent.com/openmicroscopy/ome-documentation/develop/contributing/downloads/prepare-commit-msg.hook'
git submodule foreach 'chmod +x $(git rev-parse --git-dir)/hooks/prepare-commit-msg'

```

## After your PR is open

We aim to review all PRs within 2 working days. Someone will comment whether
the change is fine as-is or request you to make changes before we merge it. If
your formatting is incorrect, the Travis build will fail and indicate the
problem for you.

If your changes are for the current version of OMERO, one of the docs team
will either ask you to rebase your change onto the `develop` branch after
merging, or will do it for you. If you are making a very minor change, you may
open PRs on both branches before review if you wish.