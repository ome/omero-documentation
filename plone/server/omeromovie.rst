OmeroMovie
==========

A short decription on how to create movies from OMERO.

Creating a movie from OMERO\ `<https://trac.openmicroscopy.org.uk/omero/wiki/OmeroMovie#CreatingamoviefromOMERO>`_
-------------------------------------------------------------------------------------------------------------------

Omero provides a script to make Mpeg or Quicktime movies from any image
in the server. These movies are created by a script called makemovie.py,
this script has a number of options: these include: selecting a range of
Z,T planes, the channels to display. The movie can also show information
overlayed over the image: z-section, scale bar and timing.

The resulting movie will then be uploaded to the server by the script
and become a file attachment to the source image.

Viewing the Movie\ ` <https://trac.openmicroscopy.org.uk/omero/wiki/OmeroMovie#ViewingtheMovie>`_
-------------------------------------------------------------------------------------------------

The make movie script allows you to save the movie in two different
formats, a DivX encoded AVI and Quicktime movie. To view the AVI you may
need to install a divX codec from ` DivX <http://www.divx.com/>`_. It
should be noted that the DivX avi is normally 1/3 to 1/10 the size of
the Quicktime movie.

Installing the make movie script
--------------------------------

The make movie script currently uses the
` mencoder <http://www.mplayerhq.hu/design7/dload.html>`_ utility to
encode the movies, this command should be in the path of the
computer(icegrid node) running the script.

You can find windows installs for mencoder at
`http://sourceforge.net/projects/mplayer-win32/files/MPlayer%20\_%20MEncoder/revision%2029355/MPlayer-p4-svn-29355.7z/download <http://sourceforge.net/projects/mplayer-win32/files/MPlayer%20_%20MEncoder/revision%2029355/MPlayer-p4-svn-29355.7z/download>`_

We have `Mac OSX installs for mencoder <http://cvs.openmicroscopy.org.uk/snapshots/mencoder/mac/>`_
which were originally provided
`here <http://stefpause.com/apple/mac/mplayer-os-x-10rc1-and-mencoder-binaries/>`_.
Unzip and put the mencoder in the PATH available to the server, e.g.
/usr/local/bin/ . You may need to restart the server for this to take
effect.

There are also macports, rpms and debs for mencoder.

Make movie also uses\ ` Python Imaging
Library <http://www.pythonware.com/products/pil/>`_ and
` numpy <http://www.scipy.org/Download>`_.

Make Movie command arguments\ `<https://trac.openmicroscopy.org.uk/omero/wiki/OmeroMovie#MakeMoviecommandarguments>`_
---------------------------------------------------------------------------------------------------------------------

A detailed list of the commands accepted by the script are:

-  imageId: This id of the image to create the movie from
-  output: The name of the output file, sans the extension
-  zStart: The starting z-section to create the movie from
-  zEnd: The final z-section
-  tStart: The starting timepoint to create the movie
-  tEnd: The final timepoint.
-  channels: The list of channels to use in the movie(index, from 0)
-  splitView: Should we show the split view in the movie(not available
   yet)
-  showTime: Show the average time of the aquisition of the channels in
   the frame.
-  showPlaneInfo: Show the time and z-section of the current frame.
-  fps: The number of frames per second of the movie
-  scalebar: The scalebar size in microns, if <=0 will not show scale
   bar.
-  format: The format of the movie to be created currently supports
   'video/mpeg', 'video/quicktime'
-  overlayColour: The colour of the overlays, scalebar, time, as
   int(RGB)
-  fileAnnotation: The fileAnnotation id of the uploaded movie. (return
   value from script)