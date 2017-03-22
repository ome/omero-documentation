What's new for OMERO 5.3 for users
==================================

Updates and new features for OMERO 5.3 include:

- ROI Folders in OMERO.insight and the |CLI| which allow you to organize your
  ROIs into a hierarchical tree structure of folders so they can be sorted
  e.g. by phenotypes or ontologies. Support for these is still upcoming for
  OMERO.web. There are also some permissions issues in OMERO.insight meaning
  that at present, even in groups where the permissions should allow this, you
  cannot add ROIs created by other people to Folders. You can perform this
  action using the CLI however, and OMERO.insight will then display the Folder
  contents correctly
- support for lookup tables (LUT) and reverse/inverted intensity rendering
- support for histograms
- the clients UI for viewing Screen Plate Well data has been redesigned to
  show the spatial layout of fields within each Well
- Wells can now be annotated in the clients
- Wells can also be searched by annotations, and a new script allows you to
  migrate existing annotations from Images to Wells (see
  :help:`utility scripts <scripts.html#utility>`)
- the new 'Open With...' functionality allows images to be opened with
  OMERO.figure or other plugins directly from OMERO.web (coming soon is a new
  web-based full image viewer - OMERO.iviewer)
- ability to filter by ratings in OMERO.web
- updated Bio-Formats bringing improved file format support including support
  for JPEG-XR compressed CZI data

See the :help:`User help website <>` for information on how to incorporate
these new features into your current workflows. There is also a
`short demo movie <http://downloads.openmicroscopy.org/movies/omero-5-3/mov/OMERO.web-5.3.0.mov>`_ for the new features of OMERO.web.

Note that thumbnail caching is still being worked on for OMERO.web. If you
have an issue with out-of-sync thumbnails you should refresh your entire
browser window rather than just using the OMERO.web refresh function.