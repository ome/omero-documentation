Making Protocols Available On-line
==================================

This tutorial shows you how to make a collection of protocols available
on-line, so that other users can access them directly via OMERO.editor.

-  Start by putting the protocol xml files in a folder on-line, e.g. by
   using an ` FTP
   client <http://en.wikipedia.org/wiki/Comparison_of_FTP_clients>`_.
   For example, the default folder used for OMERO.editor demo files is
   :snapshot:`here omero/editor/demoFiles/beta4/>`

- If you want to present the files nicely, in a web page with file
   descriptions, links etc. you can use the one :snapshot:`here
   omero/editor/demoFiles/beta4/index.html>` as a starting point. It's
   easiest to put this in the same folder as the protocol files, but
   as long as the links work, it doesn't matter.

-  Users who want to access these files directly through OMERO.editor
   need to edit their Editor configuration:

   -  Go to the OMERO-clients/config folder and open the editor.xml file
      in a text editor.
   -  Find the lines:

::
      <!-- The 'home page' of online demo files -->
      <entry
      name="/demo/index">http://cvs.openmicroscopy.org.uk/snapshots/omero/editor/demoFiles/beta4/index.html
      </entry>

   -  Edit the URL in the second line, to point to the folder or web
      page that you just created. Save the file.

-  In OMERO.editor, click the "Open On-line File" button. The page you
   created should be shown in the dialog, allowing you to choose the
   linked files to download and open in OMERO.editor.
