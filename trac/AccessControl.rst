Deprecated Page

**NOTE:**

    This page is now deprecated and superseded by the new Permissions
    page found
    ` here <http://www.openmicroscopy.org.uk/site/support/omero4/server/permissions/>`_.

-  `Introduction </ome/wiki/AccessControl#_Introduction>`_
-  `Security by Example </ome/wiki/AccessControl#_Security_by_Example>`_

   -  `Filesystem as a reference
      point </ome/wiki/AccessControl#_Filesystem_as_a_reference_point>`_
   -  `Object-Oriented
      Filesystem </ome/wiki/AccessControl#_Object_Oriented_Filesystem>`_
   -  `Omero Security </ome/wiki/AccessControl#_Omero_Security>`_
   -  `Back to the
      filesystem </ome/wiki/AccessControl#_Back_to_the_filesystem>`_

Introduction
============

    The core of Omero access control is that each row in the database
    (every object) has an experimenter, a group, and a permissions?
    field. Though it is recorded elsewhere which experimenter created an
    object, having the experimenter on each row simplifies and speeds up
    implementing public-vs.-private data at the cost of redundancy.
    Permissions permit flexible control over information similar to the
    access control permissions for Unix filesystems,

    Permissions currently allow for setting the rights granted to
    individuals when they fall into three categories. When user id of
    the current user equals the owner field of an object, then the USER
    rights are applied. Simiarly, when a user is a member of the group
    which is set in the group field, then the GROUP rights are applied.
    Otherwise, the WORLD rights are applied. (Note: unlike the Unix
    filesystem Omero checks if any of the roles apply rather than using
    the first role that applies)

    The rights that can be applied to each of these roles are currently:

-  READ - the object will be returned when graphs of objects are
   requested from the server (and no exception wil be thrown if the
   object is loaded by id)
-  WRITE - fields (single- and collection-valued) of the object can be
   changed
-  USE - other objects can reference this object.

    This style of access control is more difficult in the graph-based
    metadata of OME as compared to the strict hierarchy of a filesystem.
    You can imagine it'd be like a filesystem in which you must control
    who access your files not just from the top down but also from the
    bottom up.

Security by Example
===================

    Perhaps it is easier to understand with examples. To get a feel for
    how this works, we'll walk through the Unix filesystem, the Unix
    filesystem as Object-Oriented system, Omero, and Omero as a
    filesystem.

Filesystem as a reference point
-------------------------------

    The operations available when working with files include: creating
    files, reading/moving/deleting files, reading/moving/deleting (i.e.
    listing) directories, changing the permissions, etc.

::

    /Filesystem>ls -ltrAG
    total 0
    -rw-r--r--  1 josh 0 2006-01-25 20:21 File1
    -rw-r--r--  1 josh 0 2006-01-25 20:21 File2
    /Filesystem>mkdir DirA
    /Filesystem>touch DirA/File3
    /Filesystem>ls -ltrAG DirA
    total 0
    -rw-r--r--  1 josh 0 2006-01-25 20:32 File3
    /Filesystem>umask
    0022
    /Filesystem>umask 0000
    /Filesystem>touch File4
    /Filesystem>ls -ltrAG
    total 4.0K
    -rw-r--r--  1 josh    0 2006-01-25 20:21 File1
    -rw-r--r--  1 josh    0 2006-01-25 20:21 File2
    drwxr-xr-x  2 josh 4.0K 2006-01-25 20:22 DirA
    -rw-rw-rw-  1 josh    0 2006-01-25 20:23 File4
    /Filesystem>

    Above we see that the /Filesystem directory has two files (File1 and
    File2) in it. We then make a directory, and "touch" (or create an
    empty) file in that directory which we list. After that comes
    something more interesting for access control: we change our umask
    from 0022 to 0000. That means that files which are created, rather
    than not being writeable by members of my and other groups, will be
    open for anyone to change. This can be seen by the listing of File4
    : "-rw-rw-rw-".

    The goal of access control in Omero is to provide equally easy
    specification of the visibility and mutability of your data.

Object-Oriented Filesystem
--------------------------

    Since OMERO is written in an object-oriented language, let's look at
    how one would do the previous with objects. (Output suppressed)

::

    // let: 
    //  * "this" be the current shell
    //  * "usr" be the current user

    attr = "-ltrAG"
    pwd = this.currentDir()
    pwd.list(attr)
    dirA = new Directory(pwd, "DirA")
    file3 = new File(dirA, "File3")
    this.currentDir().list(attr)
    usr.setUmask(0000)
    file4 = new File(pwd, "File4")

Omero Security
--------------

    That may be somewhat contrived but it's roughly how we'll work with
    our data model objects. Instead of files and directories we'll be
    working with objects defined in a microscopy vocabulary (or
    ontology). The "this" is our
    **`ServiceFactory </ome/wiki/ServiceFactory>`_** which provides
    access to all the Omero services and the "user" is whoever is logged
    in to that `ServiceFactory </ome/wiki/ServiceFactory>`_.

::

    Login login = new Login("user","password");
    ServiceFactory services = new ServiceFactory(login);

    dataset1 = new Dataset("Interesting images")
    img1 = new Image("MyBestImageEver")
    img1.addDataset(dataset1)

    services.setUmask( new Permissions( Permissions.PRIVATE ));
    services.getUpdateService().saveObject( dataset1 );

    We've now created a dataset and an image which are viewable only my
    the user "user" (**and** the PI of "user"'s group. See Roles? for
    more information) Other users who view a list of all available
    datasets will see no "Interesting images" dataset, and if someone
    specifically requests the "Interesting images" dataset, a
    **SecurityViolation?** will be raised.

Back to the filesystem
----------------------

    That's at least how the code behind the security system works. What
    this means for the user trying to understand the various permissions
    is that Omero access control is a lot like a filesystem, but one
    must constantly keep in mind that each single "file" (piece of
    metadata) can be accessed from many different directories.

    Imagine that our "/Filesytem" from above contains Omero "Types"

::

    /Types>ls -ltrAG
    total 20K
    drwxr-xr-x  2 root 4.0K 2006-01-25 20:38 Images
    drwxr-xr-x  2 root 4.0K 2006-01-25 20:38 Datasets
    drwxr-xr-x  2 root 4.0K 2006-01-25 20:38 Projects
    drwxr-xr-x  2 root 4.0K 2006-01-25 20:38 Annotations
    drwxr-xr-x  2 root 4.0K 2006-01-25 20:38 Experimenters
    ...

    All directories are owner by root and have permissions as to who can
    create files in them. The Experimenters directory, for example,
    doesn't have write permissions set because for GROUP and WORLD
    because only administrators can create experimenters.

    In each of the directories are files representing a single entry in
    the database.

::

    /Types/Image>ls -ltrAG
    total 0
    -rw-------  1 josh 0 2006-01-25 20:40 Image1
    -rw-r--r--  1 jason 0 2006-01-25 20:40 Image2
    -rw-r--r--  1 chris 0 2006-01-25 20:40 Image3
    -rw-r--r--  1 josh 0 2006-01-25 20:40 Image100

    Within the files are links to other files in other directories. When
    counting and listing all available files in "Image", for example,
    you can see how many and their names, but when retrieving them, some
    (those without read permissions like Image1) will produce silent
    errors and be omitted from the output. And if a user tries to
    forcefully open a file ("cat Image1") then an error will result.
