.. _rst_tutorial_insight-managing-data:

Managing Data
=============

Back to OMERO.insight,

-  Launch the OMERO.insight application.
-  Connect to the server (see [Getting Started] (getting-started)).

Once successfully logged in, the default view of the Data Manager will
pop up on screen. The Data Manager serves as the major portal for the
user into his/her data hierarchies.

Create Objects
--------------

To create a new Project (resp. Dataset),

-  Expand the Hierarchies browser
-  Click on the icon.

The following window will pop up on screen

After pressing the ``Create`` button, a new Project (resp. Dataset)
``e.g. Monday Acquisition`` is created in the OMERO server, and
displayed in the Inspector

To add a new Dataset to the Project ``Monday Acquisition``:

-  Select the Project, then either

-  Right-click on the selected Project. Then select New Dataset... from
   the pop-up menu.
-  Or click on the icon.

-  The ``Create`` dialog will pop up.
-  Once created, the new Dataset will appear under the selected Project.

To create:

-  Tag or Tag Set, expand the Tags browser and click on the icon.
-  Plate, expand the Screens browser and click on the icon.

Manage
------

Using the Inspector, the user can

-  Cut (i.e. unlink) Datasets (resp. Images) from a Project (resp.
   Dataset).
-  Copy or Paste Datasets (resp. Images) to a Project (resp. Dataset).
   This is NOT a deep copy i.e. a link between the Dataset (resp. Image)
   and the Project (resp. Dataset) is created. We view the possibility
   as a feature. The user can add the same Dataset (resp. Image) to
   several Projects (resp. Datasets) and only have one Dataset (resp.
   Image) to handle.
-  Delete Project, Dataset, Image, etc.

Same options are available for Plate, Screen, Tag Set and Tag.

Working Area
------------

The Working area is built and displayed when browsing data e.g. a Plate

-  Browsing a Project (resp. Dataset, Plate):

   -  Select the Project (resp. Dataset, Plate) in the Inspector.
   -  Click on the icon.

-  Expanding a Dataset, a Tag or a time interval.

Working Area tool bar explained

The user can then filter the displayed images.

Handle Metadata and Edit Object
-------------------------------

OMERO offers the option to handle various types of annotation.

-  Rating
-  Comments
-  Tags
-  Attachments (PDF, Word, Excel, etc.)

How to add, view metadata

-  Select the Project, Dataset, Plate, or the Image(s) in the Inspector
   or Working Area
-  Go to the Metadata Browser i.e. Right-hand side.

-  To Edit the image's name, click on the icon next to the name.

Managing Image Attachments
--------------------------

Attachments can be downloaded, viewed, and deleted by clicking the
double arrow beside each one. Note that unlinking an attachment from an
image will remove the link between the two, but will NOT delete the
attachment from the server.

View Acquisition Metadata
-------------------------

The acquisition metadata read at import is displayed in the Right-hand
panel under the Acquisition tab.

Image Preview
-------------

The Preview tab on the Right-hand panel provides a mini preview window
of your image and allows you to tune some of the rendering settings
without having to launch the full image viewer.

Search
------

Full text searching. You can also use wild-cards in your search e.g.
\*.dv will find all files ending with '.dv'.
