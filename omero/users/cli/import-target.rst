Import targets
==============

The CLI import options ``-d`` or ``-r`` can be used to specify, respectively,
the import target Dataset or Screen by ID. The ``-T, --target`` option adds
more ways of specifying the import target.

The general form of the target argument is::

    <action or Class>[:<discriminator>]:<pattern>

where the discriminator is optional. Thus a target must contain one or two
colons. Any further colons will be read as part of the pattern. If the
discriminator is omitted a default will be used depending on the action or
Class. Currently the following actions and classes are supported: Dataset,
Screen and regex.

Importing to a Dataset or Screen
--------------------------------

For Dataset and Screen the currently supported discriminators are ``name``
and ``id``. If the discriminator is omitted the default used is ``id``. So::

    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:id:2
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:2
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -d 2

will all have the same effect of importing the image to the Dataset with ID 2.

The ``name`` discriminator can be used to select the target by name, and so::

    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:name:Sample01

will import the image to the Dataset with name Sample01. If more than one
Dataset exists with the specified name the most recently created will be used.
If no Dataset exists with the specified name a new Dataset will be created
for the import.

The choice of Dataset can be specified by adding a qualifying character to the
discriminator: ``+`` to use the most recent, ``-`` to use the oldest, ``%`` to
only import if there is a unique target or ``@`` to create a new container
even if one with the correct name already exists.

For example::

    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:+name:Samples
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:-name:Samples
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:%name:Samples
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:@name:Samples

The first case is equivalent to the previous example, the most recent Dataset
will be used. In the second case the oldest Dataset will be used. In the third
case the import should fail if multiple datasets with that name exist. In the
first three cases a new Dataset will be created if none exists. In the last
case a new Dataset should be created even if one or more already exist.

If the name contains spaces or other characters that cannot be used on the
command line the pattern should be enclosed in quotes::

    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:name:"New Dataset"

To import a plate to a Screen target the same syntax can be used as in all the
examples above, for example::

    $ omero import ~/images/bd-pathway/2015-12-01_000/ -T Screen:+name:Pathway

Importing using regular expressions
-----------------------------------

The local path of the file to be imported can be used to specify the target
Dataset or Screen using a regular expression using the action ``regex``. For
this action the only discriminator is ``name`` and if the discriminator is
omitted the qualified form of this ``+name`` will be used. The sequence
``(?<Container1>.*?)`` is a named-capturing group used to specify the Dataset
or Screen name in the regular expression, the specific name ``Container1``
must be used here. For example::

    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T "regex:^.*images/(?<Container1>.*?)"

would use a Dataset with name being the path following ``images/``,
in this case ``dv``.

The ``name`` discriminator can be explicitly used and, as in the previous
section, also qualified::

    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T "regex:+name:^.*images/(?<Container1>.*?)"
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T "regex:-name:^.*images/(?<Container1>.*?)"
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T "regex:%name:^.*images/(?<Container1>.*?)"
    $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T "regex:@name:^.*images/(?<Container1>.*?)"

These each work in the same way as the previous Dataset examples.

In some cases the importable files may be in nested directories, this is often
the case with plates and some multi-image formats. A regular expression can be
used to pick a higher level directory as the Screen or Dataset name. For
example, if several BD Pathway HCS files are under the following paths::

    ~/images/bd-pathway/week-1/2015-12-01_000/
    ~/images/bd-pathway/week-2/2015-12-09_000/
    ~/images/bd-pathway/week-2/2015-12-11_000/

and the intended Screens for the import are ``week-1`` and ``week-2`` then
the following could be used::

    $ omero import ~/images/bd-pathway/ -T "regex:+name:^.*bd-pathway/(?<Container1>[^/]*)/.*"

which would import one Plate into the Screen ``week-1`` and two Plates into
the Screen ``week-2``, creating those Screens if necessary.

A useful way of determining the nested structure to help in constructing
regular expressions is the option ``-f`` which displays the used files but
does not import them::

    $ omero import -f ~/images/bd-pathway/week-1
    ...
    2016-03-30 15:58:56,574 701        [      main] INFO      ome.formats.importer.ImportCandidates - 59 file(s) parsed into 1 group(s) with 1 call(s) to setId in 92ms. (99ms total) [0 unknowns]
    #======================================
    # Group: /Users/colin/images/bd-pathway/week-1/2009-05-01_000/Experiment.exp SPW: true Reader: loci.formats.in.BDReader
    /Users/colin/images/bd-pathway/week-1/2009-05-01_000/Experiment.exp
    /Users/colin/images/bd-pathway/week-1/2009-05-01_000/20X NA 075 Olympus Confocal.geo
    ...
    /Users/colin/images/bd-pathway/week-1/2009-05-01_000/Well D11/DsRed - Confocal - n000000.tif
    /Users/colin/images/bd-pathway/week-1/2009-05-01_000/Well D11/DsRed - Confocal - n000001.tif
    /Users/colin/images/bd-pathway/week-1/2009-05-01_000/Well D11/DsRed - Confocal - n000002.tif
    /Users/colin/images/bd-pathway/week-1/2009-05-01_000/Well D11/Transmitted Light - n000000.tif

which shows that all the files for one particular Plate from the example above
are under::

    /Users/colin/images/bd-pathway/week-1/2009-05-01_000/


For more information on the regular expression syntax that can be used in
templates see:
`java.util.regex.Pattern documentation <https://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html>`_.

Importing to targets across groups
----------------------------------

Currently, in all the above cases the import target must be in the user's
current group for the import to succeed. It is hoped that this limitation can be
removed in a later version of OMERO. This is also pertinent if the target is
likely to be created as it will be created in the current group, which may not
be the group intended.

If no group is specified by using the :option:`omero login -g` option as part of the
import, the current group will be dependent on the user's login status:

-   If the user is currently logged in then their current group will be the one
    they are logged in to.

-   If the user is logged out but has active sessions then the most recent
    session will be used to connect and that will determine the current group.

-   If the user is logged out and has no active sessions then the current group
    will be their default group.

If the user knows which group the import target is in, or needs to be created
in, then one of the following methods can be used to ensure the target group is
the current group for the import:

-   Explicitly log in using the :option:`omero login -g` option before running the import
    command::

        $ omero login -g group_name
        $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:2

-   Provide the :option:`omero login -g` option as part of the import command::

        $ omero import -g group_name ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:2

-   Use :program:`omero sessions group` to switch group before running the import
    command::

        $ omero sessions group 51
        $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:2

-   Use the :option:`omero login -k` option to reconnect to an active session for the
    target group::

        $ omero login -k c41a6f78-ba6e-4caf-aba3-a94378d5484c
        $ omero import ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:2
        # or alternatively
        $ omero import -k c41a6f78-ba6e-4caf-aba3-a94378d5484c ~/images/dv/SMN10ul03_R3D_D3D.dv -T Dataset:2

    The session ID can be found using the :program:`omero sessions list` command.

For further information on the commands :program:`omero login` and
:program:`omero sessions` see :doc:`sessions`.

.. note::

    The :option:`omero login -g` option requires the group name as its argument,
    while the :program:`omero sessions group` subcommand uses either the group
    ID or the group name.

.. seealso:: 
    
    :doc:`/sysadmins/import-scenarios`

    :doc:`/sysadmins/in-place-import`

    :doc:`/sysadmins/dropbox`
    
    :doc:`index`
