Deprecated Page

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Not on milestone page <#Notonmilestonepage>`_

   #. `Bugs in #6065 <#Bugsin6065>`_
   #. `Other bugs <#Otherbugs>`_
   #. `Stories <#Stories>`_
   #. `Tasks <#Tasks>`_

#. `Copy of milestone as of 2011/08/12 09:13:11
   follows <#Copyofmilestoneasof2011081209:13:11follows>`_

   #. `Deliverables <#Deliverables>`_

      #. `Bio-Formats <#Bio-Formats>`_
      #. `OMERO.web <#OMERO.web>`_
      #. `Internal tasks <#Internaltasks>`_
      #. `Specification <#Specification>`_
      #. `Documentation <#Documentation>`_

   #. `Investigations <#Investigations>`_

      #. `OMERO <#OMERO>`_
      #. `OMERO.fs (req #2128) <#OMERO.fsreq2128>`_
      #. `Permissions (req #320) <#Permissionsreq320>`_
      #. `Patient/medical data (req
         #4625) <#Patientmedicaldatareq4625>`_
      #. `Schema Development <#SchemaDevelopment>`_

#. `Ticket Review Notes = (11:00 Chris, Josh, JMB, Ola, Will, Scott,
   Andrew @
   … <#TicketReviewNotes11:00ChrisJoshJMBOlaWillScottAndrew10:30>`_

Not on milestone page
---------------------

Bugs in `#6065 </ome/ticket/6065>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  `#6189 </ome/ticket/6189>`_: Bug: liff excitation wavelength ( Owner:
   mlinkert-x )
-  `#6247 </ome/ticket/6247>`_: Bug: Importer - no Original Metadata
-  `#6249 </ome/ticket/6249>`_: Bug: No processor available ( Owner:
   jburel Remaining Time: 0.15 )
-  `#6285 </ome/ticket/6285>`_: ImageJ-plugin with IJ 1.44 ( Owner:
   jburel )
-  `#6324 </ome/ticket/6324>`_: Insight Image "Download..." ( Owner:
   jburel )
-  `#6419 </ome/ticket/6419>`_: Bug: getIFD can throw NPE ( Owner:
   cxallan )
-  `#6424 </ome/ticket/6424>`_: Bug: confusing pattern for password
   provider ome/services/db-\*.xml
-  `#6469 </ome/ticket/6469>`_: Delete Plate, keep images ( Owner:
   jburel )

Other bugs
~~~~~~~~~~

-  `#2971 </ome/ticket/2971>`_: Bug: ScreenLogin?.logout throws when
   communicator is destroyed
-  `#4437 </ome/ticket/4437>`_: BUG: Tags and Tag Sets creation
-  `#4482 </ome/ticket/4482>`_: Bug: client tests moved from
   components/client are broken
-  `#4627 </ome/ticket/4627>`_: BUG: In saved reports accepted/assigned
   mismatch
-  `#4684 </ome/ticket/4684>`_: Bug: tests change passwords leading to
   other failed tests
-  `#5320 </ome/ticket/5320>`_: BUG: Tagging many images feresh entire
   website
-  `#5382 </ome/ticket/5382>`_: BUG: Right-click menu - Insight
   thumbnails
-  `#5518 </ome/ticket/5518>`_: BUG: Insight Inconsistant channel
   previews
-  `#5550 </ome/ticket/5550>`_: BUG: Thumbnail for very small images
-  `#5703 </ome/ticket/5703>`_: Bug: Input window per channel
-  `#5749 </ome/ticket/5749>`_: BUG: Delete handler
   ObjectNotExistException?
-  `#5777 </ome/ticket/5777>`_: Bug: Column separator set in insight
   importer
-  `#5828 </ome/ticket/5828>`_: Bug: TB reused after exception in
   omero.gateway
-  `#5868 </ome/ticket/5868>`_: Bug:Connection issue when switching
   between share and data
-  `#5883 </ome/ticket/5883>`_: BUG: OOM in inight viewing large images
-  `#5911 </ome/ticket/5911>`_: Bug:load images by period
-  `#5912 </ome/ticket/5912>`_: Bug: Web additional channels shown on
   .sdt file
-  `#5997 </ome/ticket/5997>`_: Bug: hudson selenium fails due to port
   issues
-  `#6000 </ome/ticket/6000>`_: Bug: hudson fails to auto-install ant on
   Windows
-  `#6017 </ome/ticket/6017>`_: Bug: failing test
   testMultiProcessSession
-  `#6018 </ome/ticket/6018>`_: Bug: Failing test testDatasetWrapper
-  `#6037 </ome/ticket/6037>`_: Bug: Failing test testCloseSession
-  `#6038 </ome/ticket/6038>`_: Bug: Failing test testBatchCopy
-  `#6039 </ome/ticket/6039>`_: Bug: Failing gatewaytest testSaveAs
-  `#6041 </ome/ticket/6041>`_: Bug: Failing test3138 login timing
-  `#6100 </ome/ticket/6100>`_: Bug: web birds eye view does not update
   on settings change
-  `#6122 </ome/ticket/6122>`_: Bug: web reset-settings on IE8
-  `#6235 </ome/ticket/6235>`_: BUG: Web Experimenter details - Feedback
   3864
-  `#6236 </ome/ticket/6236>`_: BUG: Web: Add share - Feedback 3867
-  `#6333 </ome/ticket/6333>`_: BUG:cxd import - Feedback 3870
-  `#6415 </ome/ticket/6415>`_: BUG: Insight java.lang.RuntimeException?
-  `#6462 </ome/ticket/6462>`_: Bug: Tree and middle panel
   synchronization
-  `#6477 </ome/ticket/6477>`_: BUG: TypeError?: int() argument must be
   a string or a number, not 'NoneType?'
-  `#6481 </ome/ticket/6481>`_: BUG: QA copyright

Stories
~~~~~~~

-  `#2719 </ome/ticket/2719>`_ Ontology support
-  `#3215 </ome/ticket/3215>`_ Import and attachments
-  `#3940 </ome/ticket/3940>`_ Insight build
-  `#5194 </ome/ticket/5194>`_ Python API
-  `#6166 </ome/ticket/6166>`_ Educational use of OMERO
-  `#5698 </ome/ticket/5698>`_ Copyright consistency
-  `#6167 </ome/ticket/6167>`_ Insight transform support
-  `#6199 </ome/ticket/6199>`_ Open Astex Viewer
-  `#6250 </ome/ticket/6250>`_ Tiling support
-  `#4550 </ome/ticket/4550>`_ Preference settings
-  `#5042 </ome/ticket/5042>`_ Drive space usage units
-  `#6220 </ome/ticket/6220>`_ JPEG 2000 follow-on
-  `#6250 </ome/ticket/6250>`_ Tiling support

Tasks
~~~~~

-  `#6405 </ome/ticket/6405>`_ Test configurable FS lite formats
-  `#3256 </ome/ticket/3256>`_ LIM: support of large pixel range
-  `#4302 </ome/ticket/4302>`_ SCM: Point all docs/examples to
   spec.o.org/<release>
-  `#5978 </ome/ticket/5978>`_ Test PG 9.0 install for documentation
-  `#6010 </ome/ticket/6010>`_ RFE: Speed up TIFF and BigTIFF file
   parsing
-  `#6157 </ome/ticket/6157>`_ Script to validate
-  `#6301 </ome/ticket/6301>`_ Abstract for Poster - ASCB 2011
-  `#3480 </ome/ticket/3480>`_ Adding existing user to a new group with
   OMERO.insight.
-  `#4210 </ome/ticket/4210>`_ RFE: Add signal handling for restarting
   DB connections
-  `#4443 </ome/ticket/4443>`_ RFE: Multi-selection and annotations
-  `#4853 </ome/ticket/4853>`_ Restrict the size of byte-arrays that can
   be requested by users
-  `#5166 </ome/ticket/5166>`_ RFE:Delete comment can't use IDelete
-  `#5396 </ome/ticket/5396>`_ Parse ROIs from .vsi files
-  `#5652 </ome/ticket/5652>`_ RFE: pre-import data & list specific
   images
-  `#5664 </ome/ticket/5664>`_ LIM: Web re-login producing wrong screen.
-  `#5690 </ome/ticket/5690>`_ LIM: session state is not immediately
   updated
-  `#5802 </ome/ticket/5802>`_ Add further ConcurrencyException?
   handling
-  `#5957 </ome/ticket/5957>`_ Review of this User Story
   `#3545 </ome/ticket/3545>`_
-  `#5965 </ome/ticket/5965>`_ Investigate improving write performance
   in loci.common.\*
-  `#5995 </ome/ticket/5995>`_ Provide jvm memory configurer
-  `#6004 </ome/ticket/6004>`_ Folder selection and Screen
-  `#6013 </ome/ticket/6013>`_ Add support for Bruker MRI data
-  `#6021 </ome/ticket/6021>`_ Python filedescriptor out of range
-  `#6099 </ome/ticket/6099>`_ Some JPEG-2000 files do not open
   correctly
-  `#6117 </ome/ticket/6117>`_ Web: save rendering settings on another
   user's image
-  `#6246 </ome/ticket/6246>`_ Pyxis project
-  `#6376 </ome/ticket/6376>`_ Update ome-io component for 4.3.x
-  `#6377 </ome/ticket/6377>`_ Make "Plugins > OME > Download from OME
   or OMERO" actually really finally work
-  `#6383 </ome/ticket/6383>`_ Web Scripts demo movie
-  `#6388 </ome/ticket/6388>`_ Java client memory config
-  `#6394 </ome/ticket/6394>`_ Remove 'Experimenter' methods from
   BlitzGateway?
-  `#6401 </ome/ticket/6401>`_ Script Data\_Type = Plate
-  `#6410 </ome/ticket/6410>`_ QA does not notify
-  `#6421 </ome/ticket/6421>`_ Remove 'ExperimenterGroup?' methods from
   BlitzGateway?
-  `#1682 </ome/ticket/1682>`_ Flex->Export->Re-import ome.tiff leads to
   color changes
-  `#4212 </ome/ticket/4212>`_ RFE: allow deleting of user scripts
-  `#4619 </ome/ticket/4619>`_ Contact EMAN developers re: MRC pixel
   types
-  `#4643 </ome/ticket/4643>`_ Wrap description text
-  `#5088 </ome/ticket/5088>`_ Content for the external developments
   page
-  `#5112 </ome/ticket/5112>`_ Remove OTF from the Model/Schema?
-  `#5147 </ome/ticket/5147>`_ Add Channels chooser to Make Movie script
   UI
-  `#5155 </ome/ticket/5155>`_ Apache Fix & Google results
-  `#5201 </ome/ticket/5201>`_ RFE: Browse tag set
-  `#5339 </ome/ticket/5339>`_ RFE: Importing SPW under Ubuntu 9.10
-  `#5993 </ome/ticket/5993>`_ Improvements to scenario 30 Command Line
   testing
-  `#5994 </ome/ticket/5994>`_ Provide JMX CLI tools.
-  `#6070 </ome/ticket/6070>`_ RFE: Missing forgotten password option
-  `#6114 </ome/ticket/6114>`_ Insight script dialog modal
-  `#6121 </ome/ticket/6121>`_ Raw Pixels store improvement
-  `#6219 </ome/ticket/6219>`_ Add support for Canon raw files
-  `#6240 </ome/ticket/6240>`_ Layout for ratings
-  `#6242 </ome/ticket/6242>`_ Creation of scenario for collaborative
   ROI use -12.2
-  `#6243 </ome/ticket/6243>`_ Web scenario History
-  `#6245 </ome/ticket/6245>`_ Update Web share scenario
-  `#6318 </ome/ticket/6318>`_ RFE: Insight open-with
-  `#6378 </ome/ticket/6378>`_ RFE: New testing scenario for the
   Bio-Formats ImageJ plugin
-  `#6399 </ome/ticket/6399>`_ Restrict max sizex and sizey
-  `#6420 </ome/ticket/6420>`_ Running scripts from basket
-  `#6445 </ome/ticket/6445>`_ Sort status elements in reverse
   chronological order
-  `#6463 </ome/ticket/6463>`_ Re-organsie scenario page
-  `#6470 </ome/ticket/6470>`_ Change of icon location for downloading
   the image
-  `#6479 </ome/ticket/6479>`_ Fix up FilePattern? to allow files in
   multiple directories

Copy of milestone as of 2011/08/12 09:13:11 follows
---------------------------------------------------

Deliverables
~~~~~~~~~~~~

*Work for deliverables **must** all provide related scenarios for proper
testing before release.*

Bio-Formats
^^^^^^^^^^^

-  Support for a few new formats (`#5004 </ome/ticket/5004>`_,
   `#5146 </ome/ticket/5146>`_, `#5161 </ome/ticket/5161>`_,
   `#4169 </ome/ticket/4169>`_, `#6013 </ome/ticket/6013>`_,
   `#6096 </ome/ticket/6096>`_, `#5916 </ome/ticket/5916>`_,
   `#6219 </ome/ticket/6219>`_)
-  Polishing of formats released in 4.3.0, primarily Volocity and
   cellSens VSI (`#5114 </ome/ticket/5114>`_,
   `#5396 </ome/ticket/5396>`_, `#6159 </ome/ticket/6159>`_,
   `#6279 </ome/ticket/6279>`_, `#6280 </ome/ticket/6280>`_)
-  Performance improvements (`#6237 </ome/ticket/6237>`_,
   `#6010 </ome/ticket/6010>`_, `#5965 </ome/ticket/5965>`_)

OMERO.web
^^^^^^^^^

-  Running Scripts (`#6200 </ome/ticket/6200>`_)
-  SPW improvement (`#1684 </ome/ticket/1684>`_)
-  Orphaned images (`#5992 </ome/ticket/5992>`_)
-  Tree improvement and bug fixes (`#6005 </ome/ticket/6005>`_)
-  Thumbnail bug fixes (`#6116 </ome/ticket/6116>`_)
-  Big image rendering adjustment and bug fixes
   (`#6205 </ome/ticket/6205>`_, `#6100 </ome/ticket/6100>`_)

Internal tasks
^^^^^^^^^^^^^^

-  Finalized VM work (`#2678 </ome/ticket/2678>`_)
-  Improving documentation and new developer training materials
   (`#6380 </ome/ticket/6380>`_)
-  Generally cleaning the backlog

Specification
^^^^^^^^^^^^^

-  Example File Generation (`#3815 </ome/ticket/3815>`_,
   `#6146 </ome/ticket/6146>`_, `#4301 </ome/ticket/4301>`_,
   `#6145 </ome/ticket/6145>`_)
-  Schema Downgrade (`#3819 </ome/ticket/3819>`_)
-  Validation
   (`#6156 </ome/ticket/6156>`_,\ `#6157 </ome/ticket/6157>`_,\ `#6309 </ome/ticket/6309>`_)
-  Fixing and/or deprecating the validator (`#5924 </ome/ticket/5924>`_)
-  Unit Tests and Mocks
   (`#6150 </ome/ticket/6150>`_,\ `#6151 </ome/ticket/6151>`_,\ `#6152 </ome/ticket/6152>`_,\ `#6147 </ome/ticket/6147>`_,\ `#6148 </ome/ticket/6148>`_,\ `#6149 </ome/ticket/6149>`_)

Documentation
^^^^^^^^^^^^^

-  Web site restructuring (`#5155 </ome/ticket/5155>`_,
   `#5157 </ome/ticket/5157>`_)
-  Consolidate ome-xml content onto openmicroscopy.org site
   (`#6384 </ome/ticket/6384>`_,\ `#6385 </ome/ticket/6385>`_,\ `#6386 </ome/ticket/6386>`_)
-  Review ome-xml.org page as moved (`#2296 </ome/ticket/2296>`_)
-  Example files section (`#6308 </ome/ticket/6308>`_)

Investigations
~~~~~~~~~~~~~~

*Investigations take place on topic branches, most likely on the team
git and will likely not be merged into "develop" for release.*

OMERO
^^^^^

-  Exporting downgraded OME-TIFFs (`#3809 </ome/ticket/3809>`_)
-  User/admin configuration options (`#4550 </ome/ticket/4550>`_)

OMERO.fs (req `#2128 </ome/ticket/2128>`_)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Original file binary repository overhaul (`#909 </ome/ticket/909>`_)
-  JPEG 2000 follow-up (`#6220 </ome/ticket/6220>`_)
-  Meeting schedule:

   -  Initial planning (July 11th; Colin & Chris)
   -  Josh returns synchronization (July 19th; Josh, Colin & Chris)
   -  Jean-Marie returns synchronization (August 10th; Jean-Marie, Josh,
      Colin & Chris)
   -  Tuesday meeting presentation (August 16th)

-  **'Branches:**'

   -  ``team/features/909-Proposal`` (team) **IDLE**
   -  ``features/909-Proposal2`` (team) **IN PROGRESS**

Permissions (req `#320 </ome/ticket/320>`_)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Recursive chmod/chown/chgrp etc. (`#3532 </ome/ticket/3532>`_)

Patient/medical data (req `#4625 </ome/ticket/4625>`_)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  FS-based auditing API (`#4652 </ome/ticket/4652>`_)
-  Creation of project view from a central dataset
   (`#6320 </ome/ticket/6320>`_)
-  Support for health data (`#6344 </ome/ticket/6344>`_)
-  **'Branches:**'

   -  ``silo`` (team) **IN PROGRESS**

Schema Development
^^^^^^^^^^^^^^^^^^

-  Final task of Model synchronisation, unification &
   evolution(\ `#2821 </ome/ticket/2821>`_, `#5112 </ome/ticket/5112>`_)
   (\*only if schema release for another reason\*)
-  Support for SPIM data (`#2730 </ome/ticket/2730>`_)
-  Support for Health data (`#6344 </ome/ticket/6344>`_)

Ticket Review Notes = (11:00 Chris, Josh, JMB, Ola, Will, Scott, Andrew @ 10:30)
--------------------------------------------------------------------------------

-  Pushing stories for investigation (Paris2011)

   -  `#2719 </ome/ticket/2719>`_ ontology
   -  `#3215 </ome/ticket/3215>`_ import and attachments
   -  `#6220 </ome/ticket/6220>`_ jpeg 2000
   -  Chris moved rendering changes for OMX/EM:
      `#5550 </ome/ticket/5550>`_, `#3256 </ome/ticket/3256>`_
   -  `#4550 </ome/ticket/4550>`_ Preference settings
   -  `#3809 </ome/ticket/3809>`_ Provide Downgrade support for OME-XML
      & OME-TIFF Versions
   -  `#5924 </ome/ticket/5924>`_ Validator fixes

-  Other pushed stories:

   -  `#6250 </ome/ticket/6250>`_ tiling support
   -  `#6199 </ome/ticket/6199>`_ Open Astex Viewer
   -  `#3940 </ome/ticket/3940>`_ insight build
   -  `#5042 </ome/ticket/5042>`_ pushed

-  to discuss

   -  `#6167 </ome/ticket/6167>`_ transform (probably not; proof of
      concept)

-  Stories that stay

   -  `#4329 </ome/ticket/4329>`_ hudson green

      -  JBurel: There are tests that need to be rewritten
      -  WMoore: Python tests are not running

   -  `#6166 </ome/ticket/6166>`_ Educational use, Scott' ongoing work

      -  JBurel: have to create tickets so people know what they are
         doing.
      -  "ability for 1-2 individuals to draw ROI in insight" (textual
         ROI)

-  Switch to
   ` https://trac.openmicroscopy.org.uk/ome/wiki/TicketReview/432Sprint3 <https://trac.openmicroscopy.org.uk/ome/wiki/TicketReview/432Sprint3>`_
   (Josh)

   -  Goal is to ignore investigations
   -  List all deliverables
   -  And see the size of what we need to test
   -  And when we can deliver it by.

-  Bugs

   -  JBurel:
   -  AlexaT: two stories for bugs in 4.3.2

      -  One is general: `#6065 </ome/ticket/6065>`_
      -  And "bug testing phase 1"
      -  Should we organize them?

   -  JBurel

      -  Example: deleting plate is a new requirement, not a bug
      -  WMoore: was a bug in the web because it ignored your decision

   -  All bugs staying

-  Stories above

-  Jean-Marie kept task list on paper.

-  Done: 10:57
