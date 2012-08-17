2.2 Web Screen/Plate/Well? Images
---------------------------------

Plate with multiple acquisitions **pre-requisite HCS data already
imported tests this scenario requires images from squig:**

-  available from data\_repo/test\_images

   -  .cellworx
   -  .flex

-  available from data\_repo/test\_images\_scenarios/scenario\_2.2/

   -  .testImportPlateMultiplePlateAcquisitions1508.ome

-  Test for plate with multiple acquisitions

   -  Import the plate .testImportPlateMultiplePlateAcquisitions1508.ome
   -  select a single plate acquisition and view the plate well.
   -  Then select multiple plate acquisitions and ensure no data is
      shown in the central panel. (`#6580 </ome/ticket/6580>`_)
   -  With 3 plate acquisitions selected chose to batch annotate in the
      right hand panel.
   -  Add a comment and confirm that the comment is added to all three
      plates.
   -  Confirm the comments are viewable in insight.

-  Test for plate with multiple field per acquisition

   -  Open the cellworx plate.
   -  Open field # 4
   -  Annotate image H,H
   -  Open field # 3
   -  Annotate image F,F and check image H,H to check there is no
      annotation.

-  Metadata tests

   -  Using the cellworx image tag, attach, and comment on an image.
   -  Open insight and check the same image metadata.
   -  Choose a different image in insight and rate, tag, attach, and
      comment on an image
   -  Open the image in the web client and confirm that the annotations
      are on the image.

-  Image ID test

   -  Using the imported .cellworx image
   -  Move to field 3 and open image DD and check that the image ID in
      the URL matches the image ID in the metadata panel.
