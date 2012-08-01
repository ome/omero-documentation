Workflows for Testing OMERO
---------------------------

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Workflows for Testing OMERO <#WorkflowsforTestingOMERO>`_

   #. `OMERO 4.3. Summer 2010 <#OMERO4.3.Summer2010>`_

#. `Import Who is doing what <#ImportWhoisdoingwhat>`_
#. `Platforms to Test (with suggested
   testers) <#PlatformstoTestwithsuggestedtesters>`_

   #. `1. [TestingScenarios/ImportProjectDatasetImages Import
      Project/Dataset? … <#a1.ImportProjectDatasetImages>`_
   #. `2. [TestingScenarios/ImportScreenPlateWellImages Import
      Screen/Plate/Well? … <#a2.ImportScreenPlateWellImages>`_
   #. `2.1 [TestingScenarios/DeleteScreenPlateWellImages Delete
      Screen/Plate/Well? … <#a2.1DeleteScreenPlateWellImages>`_
   #. `2.2 [TestingScenarios/WebScreenPlateWellImages Web
      Screen/Plate/Well? … <#a2.2WebScreenPlateWellImages>`_
   #. `3. Import QA System <#a3.ImportQASystem>`_
   #. `4. Manage and Organise <#a4.ManageandOrganise>`_
   #. `4.1 [TestingScenarios/CreatingaNewDatasetUsingTheSelectedImages
      Creating … <#a4.1CreatingaNewDatasetUsingtheSelectedImages>`_
   #. `4.2 [TestingScenarios/DeleteImageDatasetProject Delete Image
      Dataset … <#a4.2DeleteImageDatasetProject>`_
   #. `5. Cross Platform <#a5.CrossPlatform>`_
   #. `6. Image Rendering <#a6.ImageRendering>`_
   #. `7. Annotate Images <#a7.AnnotateImages>`_
   #. `7.1 Delete Annotated Images <#a7.1DeleteAnnotatedImages>`_
   #. `8. Attach <#a8.Attach>`_
   #. `8.1 Delete Attachment <#a8.1DeleteAttachment>`_
   #. `9. Tagging <#a9.Tagging>`_
   #. `9.1 Delete Tagging <#a9.1DeleteTagging>`_
   #. `10. Editor <#a10.Editor>`_
   #. `10.1 Delete Editor File <#a10.1DeleteEditorFile>`_
   #. `11. Drawing/Viewing ROIs <#a11.DrawingViewingROIs>`_
   #. `11.1 Viewing ROIs in web <#a11.1ViewingROIsinweb>`_
   #. `12. Measuring ROIs <#a12.MeasuringROIs>`_
   #. `12.1 Delete ROIs <#a12.1DeleteROIs>`_
   #. `13. Preview Pane <#a13.PreviewPane>`_
   #. `14. Sharing (web) <#a14.Sharingweb>`_
   #. `15. Export Imagej <#a15.ExportImagej>`_
   #. `15.1 [TestingScenarios/ExportImagejUserWorkflow Export/ImageJ
      user … <#a15.1ExportImageJuserworkflow>`_
   #. `16. Insight Import <#a16.InsightImport>`_
   #. `16.1 Insight Import Tagging <#a16.1InsightImportTagging>`_
   #. `17. Insight-Web Comparison <#a17.Insight-WebComparison>`_

#. `OMERO 4.3 <#OMERO4.3>`_

   #. `18. [TestingScenarios/ClientServerCompatibility Client-server
      … <#a18.Client-servercompatibility>`_
   #. `19. Permissions <#a19.Permissions>`_
   #. `19.1 Delete Permissions <#a19.1DeletePermissions>`_
   #. `20. Collaborative Tagging <#a20.CollaborativeTagging>`_
   #. `21. User Script-writing <#a21.UserScript-writing>`_
   #. `21.a User Script-writing <#a21.aUserScript-writing>`_
   #. `21.1 [TestingScenarios/TestExportScripts Test Export Scripts -
      Insight AND … <#a21.1TestExportScripts-InsightANDweb>`_
   #. `21.2 [TestingScenarios/TestFigureScripts Test Figure Scripts -
      Insight AND … <#a21.2TestFigureScripts-InsightANDweb>`_
   #. `21.3 [TestingScenarios/TestUtilScripts Test Util Scripts -
      Insight AND … <#a21.3TestUtilScripts-InsightANDweb>`_
   #. `22. Delete Image and binary
      data <#a22.DeleteImageandbinarydata>`_
   #. `22.1 [TestingScenarios/DeleteImageAndBinaryDataLinuxServer Delete
      Image … <#a22.1DeleteImageandbinarydataLinuxserver>`_
   #. `22.2 [TestingScenarios/DeleteImageAndBinaryDataLinuxServer Delete
      Image … <#a22.2DeleteImageandbinarydataMacOSserver>`_
   #. `22.3 [TestingScenarios/DeleteImageAndBinaryDataWindowServer
      Delete Image … <#a22.3DeleteImageandbinarydataWindowsserver>`_
   #. `23. Web Admin Testing <#a23.WebAdminTesting>`_
   #. `23.1 Insight Admin Testing <#a23.1InsightAdminTesting>`_
   #. `24. OME-XML & OME-TIFF Export
      Testing <#a24.OME-XMLOME-TIFFExportTesting>`_
   #. `24.1 [TestingScenarios/OmeTiffExportTestingOne OME-TIFF Export
      Testing 1 … <#a24.1OME-TIFFExportTesting1Pending>`_
   #. `24.2 [TestingScenarios/OmeXmlOmeTiffExportTesting OME-XML &
      OME-TIFF … <#a24.2OME-XMLOME-TIFFExportTestingPending>`_
   #. `24.3  OME-TIFF Export Testing 2 <#a24.3OME-TIFFExportTesting2>`_
   #. `25. Big Image Upgrade Testing <#a25.BigImageUpgradeTesting>`_
   #. `25.1 [TestingScenarios/BigImageUpgradeTestingMacServer Big Image
      Upgrade … <#a25.1BigImageUpgradeTestingMacServer>`_
   #. `25.2 [TestingScenarios/BigImageUpgradeTestingWindowsServer Big
      Image … <#a25.2BigImageUpgradeTestingWindowsServer>`_
   #. `26. Web Mobile <#a26.WebMobile>`_
   #. `26.a Mobile Image-viewer? <#a26.aMobileImage-viewer>`_
   #. `27. Publishing Options <#a27.PublishingOptions>`_
   #. `28.1 Big Image Viewer <#a28.1BigImageViewer>`_
   #. `28.2 [TestingScenarios/BigImageViewerPartTwo Big Image Viewer 2
      … <#a28.2BigImageViewer2ticket:6313>`_
   #. `29. LDAP testing <#a29.LDAPtesting>`_
   #. `30. CLI testing <#a30.CLItesting>`_
   #. `31. DropBox? Tests <#a31.DropBoxTests>`_
   #. `31.1 DropBox Mac OS server <#a31.1DropBoxMacOSserver>`_
   #. `31.2 DropBox Windows server <#a31.2DropBoxWindowsserver>`_
   #. `31.3 DropBox Linux server <#a31.3DropBoxLinuxserver>`_
   #. `32 Omero.data.dir Files <#a32Omero.data.dirFiles>`_
   #. `33 Omero Search <#a33OmeroSearch>`_
   #. `33.1 Omero Search-Groups <#a33.1OmeroSearch-Groups>`_
   #. `33.2 Omero Search-Filter <#a33.2OmeroSearch-Filter>`_
   #. `34. Web Open Astex Viewer <#a34.WebOpenAstexViewer>`_
   #. `35. Bio-Formats ImageJ Plugin <#a35.Bio-FormatsImageJPlugin>`_
   #. `36. VM Testing <#a36.VMTesting>`_
   #. `37. [TestingScenarios/FileFormatMetadataValidation File Format
      Metadata … <#a37.FileFormatMetadataValidation>`_

OMERO 4.3. Summer 2010
~~~~~~~~~~~~~~~~~~~~~~

This is a page for collecting workflows for testing OMERO, in order that
we can define what to test for each release, make sure that test
coverage is broad without duplicating lots of tests.

This page may be modeled on how they do it in ` Second
Life <http://wiki.secondlife.com/wiki/Category:Test_Scripts>`_. Content
will be initially created on this page, and may be moved to additional
Test Script pages depending on the amount of content. Some may also be
linked to tickets elsewhere.

To get things started, we'll create scripts from the movies on our
` Feature
List <http://www.openmicroscopy.org.uk/site/products/feature-list>`_

Import Who is doing what
------------------------

List of folders from test\_images\_good

The list is set out as : File formats to import: (Importer to use)

-  Chris: al3d, andor, ariol, avi, bigtiff, bio-rad\_pic, bio-rad\_raw
   (Stand alone importer)
-  Colin: bmp, cellomics, Dicom, DV, DV\_large, eps, fei, fits
   (Insight-importer)
-  J-M: flex, fluoview, fv1000, gatan, gel, gif, ics. imagepro (Cmd line
   importer)
-  Melissa: improvision, ims, ims\_large, ipl, jpeg2000, jpg, khoros
   (Insight-importer)
-  Brian: lei, lei\_martin\_sp2, leica\_stack, leica-tcs, li-flim,
   lif\_martin, mias, scanr, (Insight-importer)
-  : liff, lsm, lsm\_martin, micromanager, micromanager\_2, minc (Stand
   alone importer)
-  Will: mng, multi\_ome-tif, nd2, nikon-jp2, nrrd, oif, ome-tiff (Stand
   alone importer)
-  Andrew: pct, pcx, prairie, psd, quicktime, raw, simplepci (Stand
   alone importer)
-  Ola: slidebook, stk, svs, tif, vevo, visitech, zvi (Insight-importer)
-  Scott: InCell 3000, Hamamatsu .vms, Hamamatsu.ndpi, Olympus SIS Tiff,
   Spider,Trestle, Velocity .mvd2, incell, (Stand alone importer)
-  Josh: perkinelmer-densitometer, nikon-nef, nifti, lim
   (Insight-importer)
-  Jason: ecat7, cellworx, cellr, biorad-gel, aim, (Insight-importer)
-  Carlos:

Sets to ignore: aarhus

Platforms to Test (with suggested testers)
------------------------------------------

Clients should be tested on these platforms:

-  Vista 64:
-  Windows 7: Brian
-  Mac 10.6: Scott, Andrew, Jason, Simon
-  Mac 10.5: Josh, Jean-Marie, Ola
-  Linux 8.10/9.10: Colin
-  Linux 10.04: Chris
-  XP (Virtual Host): Will
-  Firefox/Safari Primary test group (web client - everyone with a Web
   test)
-  Explorer Secondary test group -- Should be version 8+( web client -
   Will, Scott, Ola)
-  Chrome Tertiary test group (web client - Will, Scott, Ola)

Server Testing:

-  Vista 64:
-  Mac 10.6: Brian, Andrew
-  Mac 10.5: Josh, Jean-Marie, Will
-  Linux Ubuntu 9.10: Colin
-  Linux 10.10: Chris
-  Windows 2008: Brian (test 25) (To schedule 1 cycle with all testing
   from windows server)
-  Linux Deb 6: Simon

+-----------------------------------------+------+
| Testing Scenarios                       |      |
+=========================================+======+
| \* Chris: 1, 10, 10.1                   | \*   |
+-----------------------------------------+------+
| \* Colin: 2, 2.1, 11, 11.1, 16, 22.1    |      |
+-----------------------------------------+------+
| \* J-M: , 12, 12.1, 21.1                |      |
+-----------------------------------------+------+
| \* Scott: 4, 4.1, 4.2, 33, 33.1, 33.2   |      |
+-----------------------------------------+------+
| \* Brian: 5, 14, 22.3 , 25,             |      |
+-----------------------------------------+------+
| \* Donald: 6, 15, 29, 31.2              |      |
+-----------------------------------------+------+
| \* Will: 7, 7.1, 23, 23.1,              |      |
+-----------------------------------------+------+
| \* Andrew: 8, 8.1, 17, 28               |      |
+-----------------------------------------+------+
| \* Ola: 9, 9.1, 32                      |      |
+-----------------------------------------+------+
| \* Melissa: 3, 19, 19.1, 30             |      |
+-----------------------------------------+------+
| \* Simon: 16.1, 21, 21a, 25, 31.3       |      |
+-----------------------------------------+------+
| \* Josh: 13, 21.3, 27,                  |      |
+-----------------------------------------+------+
| \* Jason: 20, 26, 26a                   |      |
+-----------------------------------------+------+
| \* Carlos: 21.2, 22.2, 31.1             |      |
+-----------------------------------------+------+

1. `Import Project/Dataset Images </ome/wiki/TestingScenarios/ImportProjectDatasetImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. `Import Screen/Plate/Well Images </ome/wiki/TestingScenarios/ImportScreenPlateWellImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2.1 `Delete Screen/Plate/Well Images </ome/wiki/TestingScenarios/DeleteScreenPlateWellImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2.2 `Web Screen/Plate/Well Images </ome/wiki/TestingScenarios/WebScreenPlateWellImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

3. `Import QA System </ome/wiki/TestingScenarios/ImportQaSystem>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4. `Manage and Organise </ome/wiki/TestingScenarios/ManageAndOrganise>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4.1 `Creating a New Dataset Using the Selected Images </ome/wiki/TestingScenarios/CreatingaNewDatasetUsingTheSelectedImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4.2 `Delete Image Dataset Project </ome/wiki/TestingScenarios/DeleteImageDatasetProject>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

5. `Cross Platform </ome/wiki/TestingScenarios/CrossPlatform>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

6. `Image Rendering </ome/wiki/TestingScenarios/ImageRendering>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

7. `Annotate Images </ome/wiki/TestingScenarios/AnnotateImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

7.1 `Delete Annotated Images </ome/wiki/TestingScenarios/DeleteAnnotatedImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

8. `Attach </ome/wiki/TestingScenarios/Attach>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

8.1 `Delete Attachment </ome/wiki/TestingScenarios/DeleteAttachment>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

9. `Tagging </ome/wiki/TestingScenarios/Tagging>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

9.1 `Delete Tagging </ome/wiki/TestingScenarios/DeleteTagging>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

10. `Editor </ome/wiki/TestingScenarios/Editor>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

10.1 `Delete Editor File </ome/wiki/TestingScenarios/DeleteEditorFile>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

11. `Drawing/Viewing ROIs </ome/wiki/TestingScenarios/DrawingViewingRois>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

11.1 `Viewing ROIs in web </ome/wiki/TestingScenarios/ViewingRoisInWeb>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

12. `Measuring ROIs </ome/wiki/TestingScenarios/MeasuringRois>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

12.1 `Delete ROIs </ome/wiki/TestingScenarios/DeleteRois>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

13. `Preview Pane </ome/wiki/TestingScenarios/PreviewPane>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

14. `Sharing (web) </ome/wiki/TestingScenarios/Sharing>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

15. `Export Imagej </ome/wiki/TestingScenarios/ExportImagej>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

15.1 `Export/ImageJ user workflow </ome/wiki/TestingScenarios/ExportImagejUserWorkflow>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

16. `Insight Import </ome/wiki/TestingScenarios/InsightImport>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

16.1 `Insight Import Tagging </ome/wiki/TestingScenarios/InsightImportTagging>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

17. `Insight-Web Comparison </ome/wiki/TestingScenarios/InsightWebComparison>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OMERO 4.3
---------

18. `Client-server compatibility </ome/wiki/TestingScenarios/ClientServerCompatibility>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

19. `Permissions </ome/wiki/TestingScenarios/Permissions>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

19.1 `Delete Permissions </ome/wiki/TestingScenarios/DeletePermissions>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

20. `Collaborative Tagging </ome/wiki/TestingScenarios/CollaborativeTagging>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

21. `User Script-writing </ome/wiki/TestingScenarios/UserScriptWriting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

21.a `User Script-writing </ome/wiki/TestingScenarios/UserScriptWriting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

21.1 `Test Export Scripts - Insight AND web </ome/wiki/TestingScenarios/TestExportScripts>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

21.2 `Test Figure Scripts - Insight AND web </ome/wiki/TestingScenarios/TestFigureScripts>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

21.3 `Test Util Scripts - Insight AND web </ome/wiki/TestingScenarios/TestUtilScripts>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

22. Delete Image and binary data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario Updated for 4.3.1**

22.1 `Delete Image and binary data Linux server </ome/wiki/TestingScenarios/DeleteImageAndBinaryDataLinuxServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

22.2 `Delete Image and binary data Mac OS server </ome/wiki/TestingScenarios/DeleteImageAndBinaryDataLinuxServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

22.3 `Delete Image and binary data Windows server </ome/wiki/TestingScenarios/DeleteImageAndBinaryDataWindowServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

23. `Web Admin Testing </ome/wiki/TestingScenarios/WebAdminTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

23.1 `Insight Admin Testing </ome/wiki/TestingScenarios/InsightAdminTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

24. OME-XML & OME-TIFF Export Testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

24.1 `OME-TIFF Export Testing 1 Pending </ome/wiki/TestingScenarios/OmeTiffExportTestingOne>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

24.2 `OME-XML & OME-TIFF Export Testing Pending </ome/wiki/TestingScenarios/OmeXmlOmeTiffExportTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

24.3  `OME-TIFF Export Testing 2 </ome/wiki/TestingScenarios/OmeTiffExportTestingTwo>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

25. Big Image Upgrade Testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[**UPDATED for 4.3.2**\ ]

\*NOTE:One of the most important (and hardest to test) scenarios for
4.3:

25.1 `Big Image Upgrade Testing Mac Server </ome/wiki/TestingScenarios/BigImageUpgradeTestingMacServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

25.2 `Big Image Upgrade Testing Windows Server </ome/wiki/TestingScenarios/BigImageUpgradeTestingWindowsServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

26. `Web Mobile </ome/wiki/TestingScenarios/WebMobile>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

26.a Mobile Image-viewer?
~~~~~~~~~~~~~~~~~~~~~~~~~

27. `Publishing Options </ome/wiki/TestingScenarios/PublishingOptions>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

28.1 `Big Image Viewer </ome/wiki/TestingScenarios/BigImageViewer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

28.2 `Big Image Viewer 2 (ticket:6313) </ome/wiki/TestingScenarios/BigImageViewerPartTwo>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

29. `LDAP testing </ome/wiki/TestingScenarios/LdapTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

30. `CLI testing </ome/wiki/TestingScenarios/CommandLineInterfaceTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

31. DropBox? Tests
~~~~~~~~~~~~~~~~~~

31.1 `DropBox Mac OS server </ome/wiki/TestingScenarios/DropBoxMacOsServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

31.2 `DropBox Windows server </ome/wiki/TestingScenarios/DropBoxWindowsServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

31.3 `DropBox Linux server </ome/wiki/TestingScenarios/DropBoxLinuxServer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

32 `Omero.data.dir Files </ome/wiki/TestingScenarios/OmeroDataDirFiles>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

33 `Omero Search </ome/wiki/TestingScenarios/OmeroSearch>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

33.1 `Omero Search-Groups </ome/wiki/TestingScenarios/OmeroSearchGroups>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

33.2 `Omero Search-Filter </ome/wiki/TestingScenarios/OmeroSearchFilter>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

34. `Web Open Astex Viewer </ome/wiki/TestingScenarios/WebOpenAstexViewer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

35. `Bio-Formats ImageJ Plugin </ome/wiki/TestingScenarios/BioFormatsImagejPlugin>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

36. `VM Testing </ome/wiki/TestingScenarios/VirtualMachineTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

37. `File Format Metadata Validation </ome/wiki/TestingScenarios/FileFormatMetadataValidation>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
