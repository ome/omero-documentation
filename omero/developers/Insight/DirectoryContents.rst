Directory contents
==================

.. note:: With the release of OMERO 5.3.0, the OMERO.insight desktop client
    has entered **maintenance mode**, meaning it will only be updated if a
    major bug is discovered. Instead, the OME team will be focusing on
    developing the web clients. As a result, coding against this client is no
    longer recommended.

The repository of the software artifacts is organized as follows:

-  ``build``: This directory contains the tools to compile, run, test,
   and deliver the application.

-  ``config``: Various configuration files required by the application
   to run.

-  ``docgen``: Documentation artifacts that are used to build actual
   documents. These are organized in two sub-directories: javadoc and
   xdocs. The former only contains resources (like CSS files) to
   generate programmer's documentation -- the actual documentation
   contents are obtained from the source code. The latter contains both
   resources (like stylesheets and DHTML code) to generate all other
   kinds of documentation (like design and users documents) and the
   actual documentation contents in the form of XML/HTML files.

-  ``launch``: Launcher scripts and installation instructions bundled
   with the default application distribution file. Its sub-dirs contain
   further resources to build platform-specific distributions.

-  ``SRC``: Contains the application source files.

-  ``TEST``: The test code.

-  ``README``: The README file.
