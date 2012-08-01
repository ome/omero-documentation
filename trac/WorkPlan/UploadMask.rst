Deprecated Page

Upload Mask
-----------

Description
-----------

This feature will take an image uploaded from the user and create a
number or ROI from it equal to the number of different colours in the
image

Usage
-----

For the ROIService Calls `UploadMask </ome/wiki/WorkPlan/UploadMask>`_
the following code is a demonstration of how to use the service using
python.

::

    /**
    * @param imageId the id of the image to attach the roi.
    * etc…..
    */
    public void uploadMask(long imageId, int z, int t, byte[] image)
    Example call
    im = Image.open("image.bmp")
    file = StringIO.StringIO();
    im.save(file, "BMP”)
    roiService.uploadMask(image.getId().getValue(), 1, 3,
    file.getvalue());

The Load mask methods of the Pojos can be used using Java

::

    public class main
    {

        /**
         * @param args
         */
        public static void main(String[] args)
        {
            client omeroClient = new client("localhost");
            List<ROIData> roiList;
            try
            {
                ServiceFactoryPrx session = omeroClient.createSession("root","ome");
                IQueryPrx iQuery = session.getQueryService();
                Image serverImage  =  (Image)iQuery.findByQuery("from Image as i left outer join fetch i.pixels as p where i.id = 1516", null);
                ImageData image = new ImageData(serverImage);
                File file = new File("Image.bmp");
                BufferedImage bufferImage = ImageIO.read(file);
                LoadMask mask = new LoadMask();
                mask.addMaskShape(bufferImage, 0, 0);
                mask.addMaskShape(bufferImage, 1, 0);
                mask.addMaskShape(bufferImage, 2, 0);
                roiList = mask.getROIForImage(image);
                System.err.println("ROICount : " + roiList.size());
                for(ROIData roi : roiList)
                {
                    System.err.println(roi.getShapeCount());
                }
            } catch (Exception e)
            {
                e.printStackTrace();
            }
            
        }

    }

Breakdown
~~~~~~~~~

#. `#1749 </ome/ticket/1749>`_ Create client side loadMask functions.
   **DONE**

   #. Should use pojos to protect methods from change of implementation,
      (e.g. `OmeroTables </ome/wiki/OmeroTables>`_)

#. `#1749 </ome/ticket/1749>`_ Create uploadMask function in ROIService
   **DONE** **REVIEW**

   #. Create new mask object ROI in pojos **DONE**

#. [STRIKEOUT:insight:#1140] Create mask ROI object in measurement tool
   **DONE**

   #. Add createMask function to loadROIFromServer **DONE**
