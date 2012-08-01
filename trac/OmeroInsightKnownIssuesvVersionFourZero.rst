Version 4.0 and 4.1

Deprecated Page

Limitation and known issues related to the 4.0 and 4.1 versions.

Limitations
-----------

-  **Import**. It is preferable not to import more than 1000 image files
   in a single import.
-  **Importer**. Under older Ubuntu installations the 'import folder'
   option currently does not work.
-  Turned off the history feature in the Viewer? (Beta4.0 and Beta4.1.x
   release) to avoid the Java heap space exception below.
-  Only possible to view compressed version of large images (i.e. >
   3kx3k)
-  Delete a large number of objects can take time e.g. a large dataset
   or a plate. Clicking twice in quick succession on the **Delete**
   button may generate the following exception.

::

    java.lang.Exception: org.openmicroscopy.shoola.env.data.DSAccessException: Cannot access data.
    Cannot delete the image: omero.rtypes$RLongI@3a579b


    at org.openmicroscopy.shoola.env.data.OMEROGateway.handleException(OMEROGateway.java:449)


    at org.openmicroscopy.shoola.env.data.OMEROGateway.deleteImage(OMEROGateway.java:4402)


    at org.openmicroscopy.shoola.env.data.OmeroDataServiceImpl.delete(OmeroDataServiceImpl.java:213)


    at org.openmicroscopy.shoola.env.data.OmeroDataServiceImpl.delete(OmeroDataServiceImpl.java:1248)


    at org.openmicroscopy.shoola.env.data.views.calls.DataObjectRemover$1.doCall(DataObjectRemover.java:75)


    at org.openmicroscopy.shoola.env.data.views.BatchCall.doStep(BatchCall.java:145)


    at org.openmicroscopy.shoola.util.concur.tasks.CompositeTask.doStep(CompositeTask.java:226)


    at org.openmicroscopy.shoola.env.data.views.CompositeBatchCall.doStep(CompositeBatchCall.java:126)


    at org.openmicroscopy.shoola.util.concur.tasks.ExecCommand.exec(ExecCommand.java:165)


    at org.openmicroscopy.shoola.util.concur.tasks.ExecCommand.run(ExecCommand.java:274)


    at org.openmicroscopy.shoola.util.concur.tasks.AsyncProcessor$Runner.run(AsyncProcessor.java:91)


    at java.lang.Thread.run(Unknown Source)


    Caused by: omero.ValidationException


    serverStackTrace = "ome.conditions.ValidationException: No row with the given identifier exists: [ome.model.core.PlaneInfo#170892593]; nested exception is org.hibernate.ObjectNotFoundException: No row with the given identifier exists: [ome.model.core.PlaneInfo#170892593]

Reported problems
-----------------

Find below, a list of known problems that I have reported and we are
currently addressing.

-  The following error has been reported while zooming in and out an
   image. The problem is due to a memory problem in Java. If you see the
   problem, you may want to try the ``OpenGL`` preview version of the
   Beta4.1.1 client.

   ::

       java.lang.OutOfMemoryError: Java heap space

           at java.awt.image.DataBufferInt.<init>(Unknown Source)

           at java.awt.image.Raster.createPackedRaster(Unknown Source)

           at java.awt.image.DirectColorModel.createCompatibleWritableRaster(Unknown Source)

           at java.awt.image.BufferedImage.<init>(Unknown Source)

           at org.openmicroscopy.shoola.util.image.geom.Factory.magnifyImage(Factory.java:249)

           at org.openmicroscopy.shoola.agents.imviewer.browser.BrowserModel.createDisplayedImage(BrowserModel.java:529)

-  The following error can happen if you have big Regions of Interest,
   too many of them or move them too quickly. The Beta4.1 version will
   fix the problem

   ::

       java.lang.Exception: java.lang.Exception: No data available.
           at org.openmicroscopy.shoola.agents.measurement.MeasurementViewerLoader.handleNullResult(MeasurementViewerLoader.java:97)
           at org.openmicroscopy.shoola.env.data.events.DSCallAdapter.eventFired(DSCallAdapter.java:87)
           at org.openmicroscopy.shoola.env.data.views.BatchCallMonitor$1.run(BatchCallMonitor.java:124)
           at java.awt.event.InvocationEvent.dispatch(InvocationEvent.java:209)
           at java.awt.EventQueue.dispatchEvent(EventQueue.java:461)
           at java.awt.EventDispatchThread.pumpOneEventForHierarchy(EventDispatchThread.java:269)
           at java.awt.EventDispatchThread.pumpEventsForHierarchy(EventDispatchThread.java:190)
           at java.awt.EventDispatchThread.pumpEventsForHierarchy(EventDispatchThread.java:180)
           at java.awt.Dialog$1.run(Dialog.java:535)
           at java.awt.Dialog$2.run(Dialog.java:563)
           at java.security.AccessController.doPrivileged(Native Method)
           at java.awt.Dialog.show(Dialog.java:561)
           at java.awt.Component.show(Component.java:1302)
           at java.awt.Component.setVisible(Component.java:1255)

-  The following error has been reported on Windows while editing the
   name of an element e.g. a project, an image.

   ::

       java.lang.ArrayIndexOutOfBoundsException: 15


       at sun.font.FontDesignMetrics.charsWidth(Unknown Source)


       at javax.swing.text.Utilities.getTabbedTextOffset(Unknown Source)


       at javax.swing.text.Utilities.getTabbedTextOffset(Unknown Source)


       at javax.swing.text.Utilities.getTabbedTextOffset(Unknown Source)


       at javax.swing.text.PlainView.viewToModel(Unknown Source)


       at javax.swing.plaf.basic.BasicTextUI$RootView.viewToModel(Unknown Source)


       at javax.swing.plaf.basic.BasicTextUI.viewToModel(Unknown Source)


       at javax.swing.text.DefaultCaret.positionCaret(Unknown Source)


       at javax.swing.text.DefaultCaret.adjustCaret(Unknown Source)


       at javax.swing.text.DefaultCaret.adjustCaretAndFocus(Unknown Source)


       at javax.swing.text.DefaultCaret.mousePressed(Unknown Source)


       at java.awt.AWTEventMulticaster.mousePressed(Unknown Source)


       at java.awt.AWTEventMulticaster.mousePressed(Unknown Source)


       at java.awt.Component.processMouseEvent(Unknown Source)
       ...

This is a Java bug. Upgrading your Java version should fix the issue.
