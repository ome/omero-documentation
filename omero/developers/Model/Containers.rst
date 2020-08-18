Folders in the OMERO model
==========================

OMERO offers both Projects that contain only Datasets and Datasets that
contain only Images. Images may thus be organized within a two-level
container hierarchy.

Reflecting the :model_doc:`June 2016 release <schemas/june-2016.html>`
of the :model_doc:`OME Data Model <developers/model-overview.html>`,
OMERO 5.3's object model adds a new kind of container, the Folder. In
many respects they are rather like Datasets: for example, Folders have a
description, they may be annotated and they may contain Images. However,
they are different from Datasets in important respects.

Folders may contain:

- Images
- Regions of Interest (ROIs)
- other Folders

or a heterogeneous mix of the above.

For organizing data one may use Folder hierarchies of arbitrary depth.
Just as an Image may be in multiple Datasets at once, the same Folder
may be in multiple Folders at once. However, there is an acyclicity
constraint: a Folder may *not* contain itself, even indirectly.

The OMERO graphical clients offer very limited support for Folders. At
present Folders may be most useful for those working with their data via
the |OmeroApi| and its gateways or with the :doc:`OMERO.cli obj plugin
</developers/cli/obj>`. The :help_legacy:`measurement tool
<measurement-tool.pdf>` in OMERO.insight shows the Folders that ROIs
are in. OMERO.web is yet to provide support for Folders.
