.. _developers/Omero/Modules/Delete:

Deleting in OMERO
-----------------

.. contents::

Deleting data in OMERO is complex due to the highly linked nature of
data in the database. For example, an Image has links to Datasets,
Comments, Tags, Instrument, Acquisition metadata etc. If the image is
deleted, some of this other data should remain and some should be
deleted with the image (since it has no other relevance).

In the 4.2.1 release of OMERO, an improved deleting service was
introduced to fix several problems or requirements related to the delete
functionality (see :ticket:`2615` for tickets):

-  Need a better way to define what gets deleted when certain data gets
   deleted (e.g. Image case above)
-  Need to be able to configure this definition, since different users
   have different needs
-  Deleting large amounts of data (e.g. Plate of HCS data) was too
   memory-intensive (data was loaded from DB during delete)
-  Poor logging of deletes
-  Large deletes (e.g. screen data) take time: Clients need to be able
   to keep working while deletes run 'in the background'
-  Binary data (pixels, thumbnails, files etc) was not removed at delete
   time - required sysadmin to clean up later

Future releases will continue this work (see :ticket:`2911`).

Delete Behavior (Technical)
---------------------------

Configuring what gets delete, is done using an XML file. The technical
specification of delete behavior can be found
:source:`components/server/resources/ome/services/spec.xml`

Delete Image
~~~~~~~~~~~~

The general delete behavior for deleting an Image is to remove every
piece of data from the database that was added when the image was
imported, removed pixel data and thumbnails from disk. In addition, the
following data is deleted:

-  Comments on the image
-  Rating of the image
-  ROIs for this image (see below)
-  Image Rendering settings for yourself and other users

**Optional**\ ** - In the web client and OMERO.insight, you will be
asked whether you also want to delete:

-  Files attached to the image (if not linked elsewhere). In that case,
   the binary data will be removed from disk too.
-  Your own tags on the image, (if not used elsewhere)

The same option is available when deleting dataset, project, plate,
screen.

Delete Dataset or Project
~~~~~~~~~~~~~~~~~~~~~~~~~

When deleting a Project or Dataset, you have the option to also delete
tags and annotations (as for image above). You also can choose whether
to 'delete contents'. This will delete any Datasets (resp. Images) that
are contained in the Project (resp. Dataset). However, Datasets and
Images will not get deleted if they are also contained in other Projects
or Datasets respectively.

If a user decides to delete/keep the annotations (see **Optional**\ **
above) when deleting a Project (resp. Dataset) and its contents, the
rule associated to the annotation will be apply to all objects.

Delete Screen, Plate or Plate Acquisition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When deleting a Screen, you have the option to also delete tags and
annotations. You also can choose whether to 'delete contents'. This will
delete any Plates that are contained in the Screen. However, Plates will
not get deleted if they are also contained in other Screen.

When deleting a Plate, you have the option to also delete tags and
annotations but **NOT** the option to 'delete contents'.

If the Plate has Plate Acquisitions, you can delete one or more Plate
Acquisition at once.

Delete Tag/Attachment
~~~~~~~~~~~~~~~~~~~~~

You can delete a Tag/Attachment, and it will be removed from all images.
However you cannot delete a Tag/Attachment if it has been used by
another user in the same collaborative group. This is to prevent
potential loss of significant amount of annotation effort by other
users. You will need to get the other users to first remove your
Tag/Attachment where they have used it, before you can delete it.

**Known Issue:** if the owner of the Tag/Attachment is also an owner of
the group (e.g. PI), they will be able to delete their Tag/Attachment,
even if others have used it.

Delete in Collaborative Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some more discussion of delete issues in a collaborative group, where
your data are linked to data of other users, can be found on the
:ref:`server/permissions` page.

-  A user cannot remove Images from another user's Dataset, or remove
   Datasets (resp. Plates) from Projects (resp. Screens).
-  A user cannot delete anything that belongs to another user.

Group owner rights
~~~~~~~~~~~~~~~~~~

    An owner of the group, usually a PI, can delete anything that
    belongs to other members of the group.

Edge Cases
~~~~~~~~~~

These are 'known issues' that may cause problems for some users (not for
most). These will be resolved in future depending on priority.

-  Annotations of annotations are not deleted, e.g. a Tag is not deleted
   if a Tag Set is deleted (only true if directly using the API).
-  Other users' ROIs (and associated measurements) are deleted from
   images.
-  Multiply-linked objects are unlinked and not deleted e.g.

   ::

       Project p1 contains two Datasets d1 and d2, Project p2 contains Dataset d1. 
       If the Project p1 is deleted, the Dataset d1 is only unlinked from p1 and not completely deleted.

.. _developers/Omero/Modules/Delete#BinaryData:

Binary Data
~~~~~~~~~~~

When Images, Plates or File Annotations have been successfully deleted
from the database the corresponding binary data is deleted from the
:ref:`server/binary-repository`.
It is possible that some files may not be successfully deleted if they
are locked for any reason. This is a known problem on Windows servers.
In this case the undeleted files can be removed manually via
``bin/omero admin cleanse``
