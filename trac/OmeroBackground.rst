Deprecated Page

OMERO Project Background
========================

The ` OME <http://openmicroscopy.org>`_ project builds, releases, and
supports open source image data, metadata, and analysis management
systems. For the last six years, we have been working on the OME server,
a perl-based middleware application. This system is available and
extensively ` documented <http://openmicroscopy.org/software>`_.

The OME Remote Objects Server (OMERO) began as a partial port of the OME
Perl Server (OMEDS and OMEIS) to Java. The use of a Java-based server
provided two major advantages:

-  It replaced our customised object-relational mapping code
   ("DBObject") with existing object-relational mapping (ORM) tools,
   specifically ` Hibernate <http://hibernate.org>`_. This removed the
   burden of maintaining self-written code that was the basis of
   OME-perl: as new Linux versions were released, DBObject became
   incompatible with new versions of various Perl modules. This problem
   was by no means insurmountable, and DBObject was appropriately
   updated, but this significant code maintenance was a burden. Though
   DBObject worked well, there are simply other development teams who
   specialize in ORM and, for instance, have dedicated their efforts to
   providing a tool that can easily switch between different relational
   database management systems.
-  A major goal of the Dundee group was and is the support and provision
   of remote client applications, allowing users to view, manage, and
   analyse images in a location and platform-independent manner. OMERO's
   design allows use of off-the-shelf tools for communication between an
   OME server and remote clients. OME-perl required, again, an interface
   called OME-JAVA, written and maintained by the OME project. This
   supported the `OmeroShoola </ome/wiki/OmeroShoola>`_ client on
   OME-perl, but was very complex, and our choice of data transport
   (XML-RPC), while a common standard, caused severe performance
   problems when large data graphs were passed from server to client.
   Moreover, OME-JAVA provided an interface for Java clients but no
   support for other languages—C++, .NET, Python, etc., that were
   required by the community.
