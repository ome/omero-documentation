How to Build an Agent's View
============================

In this section, we explain how a view of the agent is created. All our
agents follow the same approach. If you want to see the code while
reading the notes, go to
:source:`components/insight/SRC/org/openmicroscopy/shoola/agents/treeviewer/view`.

Let's go back to our example ``MyBrowserAgent`` (see `How To Build An
Agent </ome/wiki/OmeroInsightHowToBuildAgent>`_).

#. Create a ``view`` package in the ``mybrowser`` package.
#. Create the following classes ``MyBrowser`` (I/F),
   ``MyBrowserComponent``, ``MyBrowserModel``, ``MyBrowserControl``, and
   ``MyBrowserUI``. If you browse the source code, you will notice that
   we usually have a class used as a toolbar and a class used as a
   status bar. Both classes are initialised by the ``BrowserUI``. For
   clarity, they have been omitted in the following diagram.
#. Create a ``MyBrowserFactory``. This class keeps trach of the
   ``MyBrowser`` instances created and not yet discarded. A component is
   only created if none of the tracked ones is displaying the data
   otherwise the existing component is recycled.

`|image1| </ome/attachment/wiki/OmeroInsightHowToBuildAgentView/AgentView.png>`_

Typical life-cycle of an Agent View
-----------------------------------

The object is first created using the ``MyBrowserFactory``

::

    //Somewhere in the MyBrowserFactory code

        /** The sole instance. */
        private static final MyBrowserFactory  singleton = new MyBrowserFactory();
        
        /**
         * Returns a viewer to display the specified images.
         * 
         * @param images The <code>ImageData</code> objects.
         */
        public static MyBrowser getViewer(Set<ImageData> images)
        {
            MyBrowserModel model = new MyBrowserModel(images);
            return singleton.getViewer(model);
        }


        /**
         * Creates or recycles a viewer component for the specified 
         * <code>model</code>.
         * 
         * @param model The component's Model.
         * @return A {@link MyBrowser} for the specified <code>model</code>.  
         */
        private MyBrowser getViewer(MyBrowserModel model)
        {
            Iterator v = viewers.iterator();
            MyBrowserComponent comp;
            while (v.hasNext()) {
                comp = (MyBrowserComponent) v.next();
                if (model.isSameDisplay(comp.getModel())) {
                    comp.refresh(); //refresh the view.
                    return comp;
                }
            }
            comp = new MyBrowserComponent(model);
            comp.initialize();
            comp.addChangeListener(this);
            viewers.add(comp);
            return comp;
        }

After creation, the object is in the ``MyBrowser#NEW`` state and is
waiting for the ``MyBrowser#activate()`` method to be called. Such a
call usually triggers of the objects on the server. The object is now in
the ``MyBrowser#LOADING`` state. After all the data have been retrieved,
the object is the ``MyBrowser#READY`` state and the data display is
built and set on screen.

When the user quits the window, the ``MyBrower#discard()`` method is
invoked and the object transitions to the ``MyBrowser#DISCARDED`` state.
At which point, all clients should de-reference the component to allow
for garbage collection.

`|image2| </ome/attachment/wiki/OmeroInsightHowToBuildAgentView/AgentViewInit.png>`_

Attachments
~~~~~~~~~~~

-  `AgentView.png </ome/attachment/wiki/OmeroInsightHowToBuildAgentView/AgentView.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroInsightHowToBuildAgentView/AgentView.png>`_
   (61.5 KB) - added by *bwzloranger* `17
   ago.
-  `AgentViewInit.png </ome/attachment/wiki/OmeroInsightHowToBuildAgentView/AgentViewInit.png>`_
   `|image4| </ome/raw-attachment/wiki/OmeroInsightHowToBuildAgentView/AgentViewInit.png>`_
   (49.4 KB) - added by *bwzloranger* `17
   ago.
