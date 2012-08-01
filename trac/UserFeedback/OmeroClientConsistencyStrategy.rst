Deprecated Page

**OMERO Client Consistency Work**

This work covers the requirements of:

-  `#3476 </ome/ticket/3476>`_ Web UI review.
-  `#4494 </ome/ticket/4494>`_: Implementation Strategy for OMERO Client
   Consistency.
-  `#2818 </ome/ticket/2818>`_: Usability Improvements

The development work shall adhere to the following points to be able to
chart the evolution of the changes in the client.

-  Screenshots will be made each time of changes when making changes in
   the interface to record the changes in the design of the interface.
-  Gretzy shall be used for having a current working prototype of the
   changes that have been made in the web client. This is to provide
   Scott and the OMERO team with a clear indication of what else needs
   to be done.

Current Status - March 3rd

The work has so far completed 4 sections of the presentation policy
document the layout, data manager, including a specific review of the
metadata panel and the beginning of the review of the actions. This has
subsequently identified:

-  The action to form a generic template layout of the OMERO client and
   then the actions permitted within the layout. The consistency of the
   actions allowed in the layout is still ongoing work.

-  The development work has investigated the jsTree demo
   (`#3844 </ome/ticket/3844>`_) and put forward the left panel layout
   proposal (Screenshot `#4367 </ome/ticket/4367>`_).

-  The first set of changes in the Metadata Panel has been implemented.
   This has covered Rename and reorder tabs to match Insight, Add basic
   metadata, Display Rating, Allow adding of Comments in-line, and
   remove the channel label from tabs. (Screenshot
   `#4458 </ome/ticket/4458>`_)

A first review of the icons in the Clients has been made against the
icons being used on the OMERO web site features web page. The outcomes
so far have been:

-  The Icon review document (`#4354 </ome/ticket/4354>`_ )
-  There have been 3 recommended changes to icons (Attach, Annotate, and
   Movie Maker) in the OMERO web feature page for consistency with the
   clients.
-  The change of the delete icon in the Web client.
-  The consistency for the direction of arrows indicating the import and
   export of data.

There is an outstanding issue of visually recording
recommendations/changes made in Insight this is only currently recorded
in the tickets. The screenshot shall now be documented when the changes
are recommended.

**Moving Forward Sprints 7 & 8.**

The documentation work shall complete the review the consistency of the
actions with a generic layout. The focus is on reviewing the action
between the left and central Data Manager panels. The next phase of the
documentation shall review the consistency of the icon grouping within
the layout. This documentation work is dependent on the continuation of
reviewing the icon groups in the data manager in Insight and the web.

**Sprint 7 - Outcomes**

Will:

-  (`#4485 </ome/ticket/4485>`_): Load Preview viewport when needed.

-(`#4598 </ome/ticket/4598>`_): Provide the rating functionality in the
web client- 1st Phase.

-  (`#4605 </ome/ticket/4605>`_): Ordering of acquisition label panels.
-  (`#4608 </ome/ticket/4608>`_): Consistency of the layout for channel
   labeling.
-  (`#4632 </ome/ticket/4632>`_): Annotation Display in Web

Ola: `#4599 </ome/ticket/4599>`_ - Provide the contained in dataset view
in the web.

-  **The remaining focus in this sprint is on Big Images.**

Scott:

-        (`#4299 </ome/ticket/4299>`_) The documentation work shall
   complete the reviews of the image viewer and image preview.
   (Outstanding icon and action review - to break ticket down)
-       (Task `#4589 </ome/ticket/4589>`_) Update the documentation of
   the ticket numbers created for the right hand panel.
-        The review of consistent actions between the left and central
   panel shall be completed. This is to provide the information for the
   requirement of actions starting in sprint 8.
   (`#4695 </ome/ticket/4695>`_) User Story created)

**Sprint 8 Outcomes.**

Will:

-       `#4607 </ome/ticket/4607>`_ show LotNumber? serial number for
   Detector, Objective, Light-Source.
-  `#4609 </ome/ticket/4609>`_: Missing field in Channel.
-  `#4596 </ome/ticket/4596>`_: Consistent location of acquisition
   files.
-  `#4612 </ome/ticket/4612>`_: Show and hide unset field.

Ola: The focus is on the implementation of the revised view of the tree

    view in the left hand panel. (This may be in sprint 9 because of the
    big image work.)

-        (`#4616 </ome/ticket/4616>`_): BUG: Delete Tag webclient.
-        (`#4604 </ome/ticket/4604>`_): Comment editable on the content.
-        Ola on holiday for half of sprint.

Scott:

-        (`#4769 </ome/ticket/4769>`_) The review of the icons being
   used in the data manager. The main

    focus for this sprint shall be on the right panel, and the central
    panel.

-        A review of the interface changes made so far.
-  A completed review of sole actions possible in the left hand panel.

**NOTE** The tickets below are outstanding. The schedule work for the
image viewer/personal information will now be after the 4.3 and so the
tickets have been moved out of the 4.3 release.

-        The documentation work shall complete the review of the section
   on

personal information.

-  (`#4299 </ome/ticket/4299>`_) Image Viewer review.
-  (`#4636 </ome/ticket/4636>`_) The review for the mini-viewer
   (right-hand side on both clients).

A meeting before the end of sprint 8 will be made to review the finished
work and prepare the next sections of work. The previsional agenda:

-  Review of document of action in left and central Data Manager
   panels.( `#4481 </ome/ticket/4481>`_).
-  Consistency requirements in moving forward with rating.
-  Determine the cut off point for 4.3 and what else will and will not
   be done.
-  Schedule for Testing.(This shall be previewing the changes to the
   range of known internal users)

The meeting has been rescheduled for the start of sprint 9 when Ola is
back.

**Meeting outcomes**:

As it stands the consistency work is being consolidated towards the end
of the release. No more additional interface reviews are being conducted
as the focus is completing the existing work that has been raised and
move into testing the changes.

**What will be completed for 4.3**

-  # Edit of image name, comments and tags all within the same panel.
-  `#4590 </ome/ticket/4590>`_ OMERO Interface clients - Right Panel
   Changes the associated tickets under this are to be all completed for
   4.3.
-  `#4695 </ome/ticket/4695>`_ Actions between the Left and Central
   panels. This is dependent on the implementation of the left tree
   panel (`#4602 </ome/ticket/4602>`_). As the global actions will be
   determined from the implementation of this.
-  `#4615 </ome/ticket/4615>`_ Evolution of Tagging Workflow. This shall
   be moved to next cycle. The task single task of
   (`#4616 </ome/ticket/4616>`_) will be completed for 4.3 this is a
   change for the consistency of deleting tags.
-  `#4602 </ome/ticket/4602>`_ Left tree panel new hierarchy layout and
   functionality.
-  Launching an image with a double click (Ticket to be created)

**Areas of testing**

For full testing to start the web is waiting for the completion for the
left hand panel. The testing in the meantime is focused on the tests
that can be completed in the right hand panel.

Planned areas for tests covered in `#4778 </ome/ticket/4778>`_

-  Right hand panel field edits image name, comments, tags,
-  Delete Tag
-  Validation of field sizes
-  `#4780 </ome/ticket/4780>`_ Right hand panel testing.
-  `#4781 </ome/ticket/4781>`_ ROI use in web client.

**Aspects to be considered for the next release.**

With the work undertaken during 4.3 there is work that has been created
and aspects ready to be address in in the in the next release these are:

-  Image viewer.
-  `#4615 </ome/ticket/4615>`_ Tagging workflow changes.
-  `#4634 </ome/ticket/4634>`_ Interaction with image rating.

""Remainder of Sprint 9""

Will:

Ola:

-  `#4788 </ome/ticket/4788>`_ Edit of image name, comments and tags all
   within the same panel.

Scott:

-  `#4843 </ome/ticket/4843>`_ Update for strategy document.
-  A second round of update of tickets. **Moved\ *as no longer required
   for the 4.3 release.***

Sprint 10

Will:

-  `#4597 </ome/ticket/4597>`_: Provide a multi line tool tip.
-  `#5002 </ome/ticket/5002>`_: Active Urls in comments.
-  `#4998 </ome/ticket/4998>`_: Zip bug for batch export script
-  `#4997 </ome/ticket/4997>`_: Split metadata tabs into 3 pages.
-  `#4733 </ome/ticket/4733>`_: Change Pixels Size field.
-  `#3044 </ome/ticket/3044>`_: Web:Multi-selection improvement.
-  `#4986 </ome/ticket/4986>`_: Web toolbar layout - (Follow up question
   )
-  `#4820 </ome/ticket/4820>`_: Web: Show exposure time

Ola:

-  `#4603 </ome/ticket/4603>`_ jsTree integration.
-  `#4599 </ome/ticket/4599>`_ Provide the contained in dataset view in
   the web.
-  `#4700 </ome/ticket/4700>`_: Web: Shift for group selection (fixed in
   `#3044 </ome/ticket/3044>`_)
-  `#4599 </ome/ticket/4599>`_: Provide the contained in dataset view in
   the web
-  `#4616 </ome/ticket/4616>`_: BUG: Delete Tag webclient

Scott:

-  `#4843 </ome/ticket/4843>`_: Update for strategy document
-  `#4811 </ome/ticket/4811>`_ Complete web specific testing scenarios.
-  `#4899 </ome/ticket/4899>`_ Test on Windows browsers. (Specific test
   to integrate from forum into web test)
-  

Sprint 11

Will:

-  `#2181 </ome/ticket/2181>`_: Improve the 404 page at (To determine if
   time allows? )
-  `#4790 </ome/ticket/4790>`_: Web: Change to unlink icon
-  `#4788 </ome/ticket/4788>`_: Web: Changes to edit icon

Ola:

-  `#4606 </ome/ticket/4606>`_ jsTree action integration.
-  `#3008 </ome/ticket/3008>`_: Refresh tree to show datasets
-  `#4871 </ome/ticket/4871>`_: Web: Location of image viewer icon
-  `#4698 </ome/ticket/4698>`_: Web:Selection in central hand panel
   reflected in left panel.
-  `#3096 </ome/ticket/3096>`_: First click on reaching webclient
   shouldn't open a new page (To confirm this will be done)

Scott:

-  Ensure code freeze happens mid-sprint.
-  Web testing (finalise external preview testing users)

The agenda for the 4.3.2 release is in the further consolidation of the
development work that has taken place so far through 4.3.0 and 4.3.1. So
the main focus of requirements for this cycle is on:

-  Orphaned images (`#5992 </ome/ticket/5992>`_)
-  Tree improvement and bug fixes (`#6005 </ome/ticket/6005>`_)
-  Thumbnail bug fixes (`#6116 </ome/ticket/6116>`_)

The outstanding interface/consistency led issues to be taken into
account for moving forward:

-  `#4604 </ome/ticket/4604>`_ Edit of comments (Strong priority
   highlighted at Paris User meeting 2011)
-  `#4470 </ome/ticket/4470>`_ Editing data object
-  `#4634 </ome/ticket/4634>`_ Interaction with image rating
-  `#4615 </ome/ticket/4615>`_ Evolution of Tagging Workflow ?
-  `#6470 </ome/ticket/6470>`_ Change of icon location for downloading
   the image

Note: Please also refer to `#6195 </ome/ticket/6195>`_ for the
additional current backlog of tasks.
