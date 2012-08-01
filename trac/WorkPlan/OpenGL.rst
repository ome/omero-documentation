Deprecated Page

Open GL
-------

Description
-----------

Offer option to view images using OpenGL and ``BufferedImage``

Usage
-----

How to turn OpenGL on or off

-  Open the ``imviewer.xml`` in ``config`` folder.
-  Set the following entry to ``false`` to use ``BufferedImage``, to
   ``true`` to use OpenGL

   ::

        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          * Information indicating to use or not openGL. 
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
           <entry name="/library/opengl" type="boolean">false</entry>

Breakdown
---------

#. Modify Main View **DONE**
#. Modify Split view. **DONE** *known issue when applying masks with
   jogl.*
#. Modify Projected view **DONE**
#. Modify Lens View (2 days)
#. Modify Interaction OpenGL and SwingX (2 days)
#. Review platform and graphics card. (3 days)

-  Browser as OpenGL Viewer (HCS related) (7 week)
-  Picking in Browser (> 16 days)
