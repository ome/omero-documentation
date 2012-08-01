Deprecated Page

Collaboration between OMERO team, ` The Data Analysis
Group <http://www.compbio.dundee.ac.uk/DAG/>`_ and
` NeSC <http://www.nesc.ac.uk/>`_

The goal of the collaboration is to

-  use OMERO to store the data
-  integrate scripts written by DAG
-  submit job to a cluster using
   ` rapid <http://research.nesc.ac.uk/rapid>`_.

User's Current Workflows
~~~~~~~~~~~~~~~~~~~~~~~~

Currently users using SPCImage have to go through a number of steps to
generate their analysis results.

Here are some more details on the workflow to analyse FLIM FRET data:

#. Launching data corresponding to an acquisition of " No FRET
   conditions"

   #. Draw an ROI around region of interest (cell, part of cell
      (nucleus) , different stage of mitosis...)
   #. Determine background level
   #. Determine if it is necessary to increase binning by looking at the
      average photon count in the ROI.

#. Perform analysis in SPCImage by applying a monoexponential decay
   model and fixing the background value.

   #. From the analysis of a single ROI, k no fret = k2 value is output
      in Excel.
   #. Repeat this analysis of each ROI of a picture and then for n
      acquisitions of the " No FRET conditions"
   #. Save intensity image as tiff; save k no FRET map as tiff

#. Calculate a k no fret= k2 average value from the n k2 values
   analysed.
#. Launch data corresponding to an acquisition of " FRET conditions"

   #. Draw an ROI around region of interest (cell, part of cell
      (nucleus) , different stage of mitosis...)
   #. Determine background level
   #. Determine if it is necessary to increase binning by looking at the
      average photon count in the ROI.

#. Perform analysis in SPCImage by applying a biexponential decay model
   and fixing the background value AND FIXING THE K2 PARAMETER FROM THE
   ANALYSIS (1-3).

   #. From this analysis of a single ROI, k1=k FRET distribution is
      saved manually as a .csv to be latter open in Excel and displayed
      in publication.
   #. In SPCimage, for a single ROI generate E 'fret map which is
      (1-k1/k2\*100) ; each map must have min, max lifetime values range
      set by hand. Displaying E FRET map by using pseudo color
      continuous or discrete is set up by hand. Save this E FRET map
      manually as a tiff file.
   #. Repeat this analysis of each ROI of a picture and then for n
      acquisitions of the " FRET conditions"

#. Perform calculations in Excel (normalisation FRET populations, etc..)
#. Combine results to get averages for different treatments, conditions
   or for different stage of mitosis or cell cycle.

Typically a user will generate 100 fret images per day, each days
acquisiton can take up to 2 days to analyse.
