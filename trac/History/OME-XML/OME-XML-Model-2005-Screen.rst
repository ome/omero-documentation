Screen Data model
~~~~~~~~~~~~~~~~~

by Josiah Johnston

    A screen examines a large set of treatments, looking for links to
    specific outcomes. Sometimes the target outcomes are known in
    advance, sometimes they aren't. We are interested in image based
    screens. The two formal proposals (` Dataset
    Granularity <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/D_ScreenProposal.ome>`_
    and ` Global
    Granularity <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/G_ScreenProposal.ome>`_)
    written in OME XML are attachments to this page. Biological samples
    (i.e. cells) are stored in wells that are on plates. Typically, each
    well gets a different treatment. Several images will be taken of
    each well, and there are many wells on a plate. Several plates
    containing samples that have received comparable treatments compose
    the data source of a screen. An individual plate may belong to one
    or more screens. For the moment, we will neglect to represent the
    biology (i.e. cell line, age, source, diet) and experimental
    treatments (i.e. chemical compounds, concentration, pH). With this
    simplified view, screens are basically a structured set of images.
    The screen consists of some descriptor fields and several plates.
    The plate consists of some descriptor fields and several wells. A
    well has some descriptor fields and several WellSamples that tie it
    to images. Additionally, a well has a row and column to describe its
    physical location on the plate. The data model needs to support
    simple implementations of two additional things:

-  determination of whether or not a dataset completely represents a
   screen, plate, or well.
-  collecting all images that belong to a screen, plate, or well.

    Two data models have been proposed. One proposes ` Dataset
    Granularity <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/D_ScreenProposal.ome>`_
    and the other proposes ` Global
    Granularity <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/G_ScreenProposal.ome>`_.
    Doug did a great job putting together an article about dataset
    granularity. (Link was
    http://sorger-g51.mit.edu:8010/ht-screens/index.html ) It proposes
    that the three core STs (screen, plate, and well) belong to
    datasets. The substantive critiques of this are:

-  An overabundance of datasets (one per well)
-  Does funny stuff with scoping. It doesn't violate our data model, but
   we haven't drafted a formal description of scoping in our data model.
-  Starts a pattern of attaching metadata underneath a set of images.
   Applied to an experiment, this model puts an experiment underneath a
   dataset. This sort of puts the experiment after the data collection,
   and ties the experimental description to the method of data
   collection. The same experiment could just as easily use a western
   blot or a microarray for data collection at the end. The same goes
   for screens. A solid screen ontology would not presume imaging to be
   the means of data collection.

    The second proposal was put forward by Josiah. Its primary
    difference is to have screens, plates, and wells be global, and
    references tie them to datasets. Critiques of it have been

-  The 3 new STs needed to establish references will add unnecessary
   complexity.

    Shortcomings of both proposals include:

-  Data corruption. One dataset may have multiple screens, or references
   to multiple screens. There's nothing but conventions of usage to
   prevent this.
-  Data duplication. There is two ways to determine what images belong
   to a screen: check out its dataset, or traverse down the
   Screen->Plate->Well->WellSample hierarchy. Having two paths to the
   same result introduces issues of data consistency that, at this
   point, can only be addressed by conventions of usage.

    Personally, I favour my own proposal, the one that keeps the screen
    STs global, and uses references to establish connections to
    datasets.

Screens &amp; OME : Further information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Biological research projects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  ` Mitocheck <http://www.mitocheck.org>`_: ongoing project
-  RNAi screen on drosophila cells, searching for genes that trigger
   cell cycle check points.
-  Comprehensive visual RNAi screens on C. elegans: 2005 project

Applications
^^^^^^^^^^^^

-  Plate Browser: Viewing images and manual sorting
-  Generalized Image classification: automated high throughput detection
   of target phenotypes
-  LSID Browser: Linking to knowledge base of screened compounds

Discussions
^^^^^^^^^^^

-  Everything on this page that includes "Screen" in the subject.

        ` http://lists.openmicroscopy.org.uk/mailman/private/ome-nitpick/2004-August/thread.html <http://lists.openmicroscopy.org.uk/mailman/private/ome-nitpick/2004-August/thread.html>`_
