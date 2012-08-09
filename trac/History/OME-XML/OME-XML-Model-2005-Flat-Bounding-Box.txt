Flat Bounding Box
-----------------

-  `Flat Bounding
   Box </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box#Flat_Bounding_Box>`_

   -  `Introduction </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box#Introduction>`_
   -  `XML </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box#XML>`_
   -  `FAQ </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box#FAQ>`_

      -  `Currently the bounding box is restricted to 5-D. Why not
         extend it to
         N-D? </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box#Currently_the_bounding_box_is_restricted_to_5_D_Why_not_extend_it_to_N_D_>`_
      -  `What is the distinction between Bounding Boxes & Shapes? Do
         the concepts have to be tied together, or can we treat them
         separately? Are Shapes the same as VisBio's
         Glyphs? </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box#What_is_the_distinction_between_Bounding_Boxes_amp_Shapes_Do_the_concepts_have_to_be_tied_together_or_can_we_treat_them_separately_Are_Shapes_the_same_as_VisBio_s_Glyphs_>`_
      -  `Why is a bounding box defined as continuous in XYZ, but
         potentially discontinuous in T &
         C? </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box#Why_is_a_bounding_box_defined_as_continuous_in_XYZ_but_potentially_discontinuous_in_T_amp_C_>`_

Introduction
~~~~~~~~~~~~

    The heart of this model is a 5d bounding box. This bounding box is
    guaranteed to be continous in X,Y, and Z, but may be discontinuous
    across channels and timepoints. This bounding box is accompanied by
    an attribute from the "Shape" family of STs. The members of the
    shape family includes rectangles, binary masks, and 3D
    representations of surfaces. The "Shape" family is designed to be
    extended. 5D Bounding Boxes may be aggregated in a RegionUnion for
    purposes of tracking objects temporally, tracking cell lineage, etc.
    It is called "Flat" because there is little differentiation of types
    of BoundingBoxes, and the model does not allow BoundingBoxes to
    contain other BoundingBoxes.

XML
~~~

` ST
definitions <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/FlatBoundingBox.ome>`_

FAQ
~~~

Currently the bounding box is restricted to 5-D. Why not extend it to N-D?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    The majority of our current use cases are 5-D: X, Y, Z, Timepoint,
    and Channel. We have one 6-D case, and that is spectral lifetime
    imaging. That is an outlier, and AFAIK, currently has no defined use
    case for a bounding box that extends across the spectral and
    lifetime dimensions. The reason not to expand the specification now
    is because we only have hypothetical use cases for bounding boxes
    with dimensionality greater than 5. In our past experience,
    expanding a spec to accomodate hypothetical use cases was wasted
    effort. We will expand the spec. later, as it becomes necessary.

What is the distinction between Bounding Boxes & Shapes? Do the concepts have to be tied together, or can we treat them separately? Are Shapes the same as VisBio's Glyphs?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    A major function of this model is to specify volumes and their
    boundaries in up to 5 dimensions. Every finite volume can be
    approximated with a Bounding Boxes, that is, a hyper-rectangular
    region. A Bounding Box is insufficient to describe many volumes. For
    example, a sphere can be modelled mathematically, and attached to a
    bounding box. The bounding box is superfluous in this example, but
    is beneficial in that it:

-  Provides simple criteria for obtaining original pixel data from the
   image server
-  Allows normalized queries about overlapping regions. (e.g. Does an
   arbitrary volume overlap with this plane?)
-  Allows software that does not support spheres to provide an
   approximation of the volume.

    Spheres is one of many specifications for volumes, and we expect
    more specifications to be defined as developer and user needs
    progress. While the concept of Shapes could be separated from
    Bounding Boxes, I feel that the benefits of combining them outweigh
    any costs. Also, Bounding Box is an incomplete specification without
    Shapes. Shapes are potentially distinct from glyphs. Typically, the
    word glyph describes symbols that are used to mark points and/or
    convey meaning. The use cases to date use shapes to describe the
    boundaries of a volume. Glyphs such as the letter 'V' are not closed
    and do not describe a volume's boundaries. However, in other use
    cases, shapes could define an edge or a line to measure distance
    between two points. In summary, glyphs seem to be a subset of
    Shapes.

Why is a bounding box defined as continuous in XYZ, but potentially discontinuous in T & C?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    Dimensions may be ordered or unordered. All our dimensions are
    represented by discrete sampling, but when dimensions are
    oversampled, they may be treated as continous. An extent of Start to
    End only has meaning on ordered dimensions. A discontinuous range
    makes the most sense on dimensions that are either unordered or
    undersampled. Modern microscopes oversample X and Y based on the
    size of molecules in relation to the wavelength of light. Z is also
    oversampled based on resolution. T is grossly undersampled based on
    rate of molecular activity. In most imaging applications, only X, Y,
    Z, and T are ordered dimensions. C is unordered in most imaging
    methods, including fluorescent images and RGB images of H&E
    histology slides. C is ordered only in spectral and lifetime
    imaging. C has been given extents to accomodate those specific
    imaging techniques. For the majority of imaging techniques, however,
    specifying an extents in C are In summary:

+-------------+---------------------+----------------------------------------+
| Dimension   | Ordered Dimension   | Oversampled and therefore Continuous   |
+-------------+---------------------+----------------------------------------+
| X           | yes                 | yes                                    |
+-------------+---------------------+----------------------------------------+
| Y           | yes                 | yes                                    |
+-------------+---------------------+----------------------------------------+
| Z           | yes                 | yes                                    |
+-------------+---------------------+----------------------------------------+
| T           | yes                 | no                                     |
+-------------+---------------------+----------------------------------------+
| C           | maybe               | no                                     |
+-------------+---------------------+----------------------------------------+

    An enumerated list of values is allowed for undersampled dimensions,
    because current use cases require that enumeration to be attached to
    a static spatial ROI. We have no use case where a static XY ROI
    needs to be attached to a non-contiguous set of Z-planes. All
    current use cases of 2d XY ROIs require the ability to adjust their
    position at each Z-plane, thereby not being static.

