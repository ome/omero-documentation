Creating containers and annotations
-----------------------------------

The :program:`omero obj` command allows users to create and update OMERO objects. A
complete :doc:`/developers/Model/EveryObject` is available for reference.

This command can be used to create containers, i.e. projects, datasets,
screens and folders. It can also be used to create annotations, and, combined
with the :program:`omero upload` command, file annotations. These annotations can
then be attached to containers or imported images and plates. This page gives
a few examples of some simple but fairly common workflows.

Creating containers
^^^^^^^^^^^^^^^^^^^

Create a dataset with a name::

    $ omero obj new Dataset name=NewDVSet
    Dataset:51

And then update that dataset to add a description::

    $ omero obj update Dataset:51 description='A dataset for new DV images'
    Dataset:51

Create a screen with a name and description::

    $ omero obj new Screen name=Screen001 description='A short description'

To create a project/dataset hierarchy a link must be created between the two
containers::

    $ omero obj new Project name=NewImages
    Project:101
    $ omero obj new ProjectDatasetLink parent=Project:101 child=Dataset:51
    ProjectDatasetLink:221

If you are comfortable using the command line then you can capture the command
outputs to feed in to other commands, for example::

    $ dataset=$(omero obj new Dataset name=dataset-1)
    $ project=$(omero obj new Project name=project-1)
    $ omero obj new ProjectDatasetLink parent=$project child=$dataset
    ProjectDatasetLink:222

Creating and attaching annotations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a comment annotation and attach it to a dataset::

    $ omero obj new CommentAnnotation textValue='Hello World!'
    CommentAnnotation:2
    $ omero obj new DatasetAnnotationLink parent=Dataset:51 child=CommentAnnotation:2
    DatasetAnnotationLink:2

Upload a file and then use it as file annotation on an image::

    $ omero upload analysis.csv
    OriginalFile:275
    $ omero obj new FileAnnotation file=OriginalFile:275
    FileAnnotation:5
    $ omero obj new ImageAnnotationLink parent=Image:51 child=FileAnnotation:5
    ImageAnnotationLink:2
