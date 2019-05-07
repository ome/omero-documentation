.. Content for this page is generated using
.. https://github.com/ome/omero-server/blob/master/src/main/java/ome/services/graphs/GraphPathReport.java

Glossary of all OMERO Model Objects
===================================

Overview
--------

.. include:: EveryObjectOverview.inc

Reference
---------

.. _OMERO model class AcquisitionMode:

AcquisitionMode
"""""""""""""""

Used by: :ref:`LogicalChannel.mode <OMERO model class LogicalChannel>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class AdminPrivilege:

AdminPrivilege
""""""""""""""

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class AffineTransform:

AffineTransform
"""""""""""""""

Used by: :ref:`Shape.transform <OMERO model class Shape>`

Properties:
  | a00: ``double``
  | a01: ``double``
  | a02: ``double``
  | a10: ``double``
  | a11: ``double``
  | a12: ``double``
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Annotation:

Annotation
""""""""""

Subclasses: :ref:`BasicAnnotation <OMERO model class BasicAnnotation>`, :ref:`ListAnnotation <OMERO model class ListAnnotation>`, :ref:`MapAnnotation <OMERO model class MapAnnotation>`, :ref:`TextAnnotation <OMERO model class TextAnnotation>`, :ref:`TypeAnnotation <OMERO model class TypeAnnotation>`

Used by: :ref:`AnnotationAnnotationLink.child <OMERO model class AnnotationAnnotationLink>`, :ref:`AnnotationAnnotationLink.parent <OMERO model class AnnotationAnnotationLink>`, :ref:`ChannelAnnotationLink.child <OMERO model class ChannelAnnotationLink>`, :ref:`DatasetAnnotationLink.child <OMERO model class DatasetAnnotationLink>`, :ref:`DetectorAnnotationLink.child <OMERO model class DetectorAnnotationLink>`, :ref:`DichroicAnnotationLink.child <OMERO model class DichroicAnnotationLink>`, :ref:`ExperimenterAnnotationLink.child <OMERO model class ExperimenterAnnotationLink>`, :ref:`ExperimenterGroupAnnotationLink.child <OMERO model class ExperimenterGroupAnnotationLink>`, :ref:`FilesetAnnotationLink.child <OMERO model class FilesetAnnotationLink>`, :ref:`FilterAnnotationLink.child <OMERO model class FilterAnnotationLink>`, :ref:`FolderAnnotationLink.child <OMERO model class FolderAnnotationLink>`, :ref:`ImageAnnotationLink.child <OMERO model class ImageAnnotationLink>`, :ref:`InstrumentAnnotationLink.child <OMERO model class InstrumentAnnotationLink>`, :ref:`LightPathAnnotationLink.child <OMERO model class LightPathAnnotationLink>`, :ref:`LightSourceAnnotationLink.child <OMERO model class LightSourceAnnotationLink>`, :ref:`NamespaceAnnotationLink.child <OMERO model class NamespaceAnnotationLink>`, :ref:`NodeAnnotationLink.child <OMERO model class NodeAnnotationLink>`, :ref:`ObjectiveAnnotationLink.child <OMERO model class ObjectiveAnnotationLink>`, :ref:`OriginalFileAnnotationLink.child <OMERO model class OriginalFileAnnotationLink>`, :ref:`PlaneInfoAnnotationLink.child <OMERO model class PlaneInfoAnnotationLink>`, :ref:`PlateAcquisitionAnnotationLink.child <OMERO model class PlateAcquisitionAnnotationLink>`, :ref:`PlateAnnotationLink.child <OMERO model class PlateAnnotationLink>`, :ref:`ProjectAnnotationLink.child <OMERO model class ProjectAnnotationLink>`, :ref:`ReagentAnnotationLink.child <OMERO model class ReagentAnnotationLink>`, :ref:`RoiAnnotationLink.child <OMERO model class RoiAnnotationLink>`, :ref:`ScreenAnnotationLink.child <OMERO model class ScreenAnnotationLink>`, :ref:`SessionAnnotationLink.child <OMERO model class SessionAnnotationLink>`, :ref:`ShapeAnnotationLink.child <OMERO model class ShapeAnnotationLink>`, :ref:`WellAnnotationLink.child <OMERO model class WellAnnotationLink>`

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | name: ``text`` (optional)
  | ns: ``text`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class AnnotationAnnotationLink:

AnnotationAnnotationLink
""""""""""""""""""""""""

Used by: :ref:`Annotation.annotationLinks <OMERO model class Annotation>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Arc:

Arc
"""

Properties:
  | annotationLinks: :ref:`LightSourceAnnotationLink <OMERO model class LightSourceAnnotationLink>` (multiple) from :ref:`LightSource <OMERO model class LightSource>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | instrument: :ref:`Instrument <OMERO model class Instrument>` from :ref:`LightSource <OMERO model class LightSource>`
  | lotNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | manufacturer: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | model: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.unit: enumeration of :javadoc:`Power <ome/model/units/Power.html>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.value: ``double`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | serialNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | type: :ref:`ArcType <OMERO model class ArcType>`
  | version: ``integer`` (optional) from :ref:`LightSource <OMERO model class LightSource>`

.. _OMERO model class ArcType:

ArcType
"""""""

Used by: :ref:`Arc.type <OMERO model class Arc>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class BasicAnnotation:

BasicAnnotation
"""""""""""""""

Subclasses: :ref:`BooleanAnnotation <OMERO model class BooleanAnnotation>`, :ref:`NumericAnnotation <OMERO model class NumericAnnotation>`, :ref:`TermAnnotation <OMERO model class TermAnnotation>`, :ref:`TimestampAnnotation <OMERO model class TimestampAnnotation>`

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class Binning:

Binning
"""""""

Used by: :ref:`DetectorSettings.binning <OMERO model class DetectorSettings>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class BooleanAnnotation:

BooleanAnnotation
"""""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | boolValue: ``boolean`` (optional)
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class Channel:

Channel
"""""""

Used by: :ref:`ChannelAnnotationLink.parent <OMERO model class ChannelAnnotationLink>`, :ref:`LogicalChannel.channels <OMERO model class LogicalChannel>`, :ref:`Pixels.channels <OMERO model class Pixels>`

Properties:
  | alpha: ``integer`` (optional)
  | annotationLinks: :ref:`ChannelAnnotationLink <OMERO model class ChannelAnnotationLink>` (multiple)
  | blue: ``integer`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | green: ``integer`` (optional)
  | logicalChannel: :ref:`LogicalChannel <OMERO model class LogicalChannel>`
  | lookupTable: ``text`` (optional)
  | pixels: :ref:`Pixels <OMERO model class Pixels>`
  | red: ``integer`` (optional)
  | statsInfo: :ref:`StatsInfo <OMERO model class StatsInfo>` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ChannelAnnotationLink:

ChannelAnnotationLink
"""""""""""""""""""""

Used by: :ref:`Channel.annotationLinks <OMERO model class Channel>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Channel <OMERO model class Channel>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ChannelBinding:

ChannelBinding
""""""""""""""

Used by: :ref:`CodomainMapContext.channelBinding <OMERO model class CodomainMapContext>`, :ref:`RenderingDef.waveRendering <OMERO model class RenderingDef>`

Properties:
  | active: ``boolean``
  | alpha: ``integer``
  | blue: ``integer``
  | coefficient: ``double``
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | family: :ref:`Family <OMERO model class Family>`
  | green: ``integer``
  | inputEnd: ``double``
  | inputStart: ``double``
  | lookupTable: ``string`` (optional)
  | noiseReduction: ``boolean``
  | red: ``integer``
  | renderingDef: :ref:`RenderingDef <OMERO model class RenderingDef>`
  | spatialDomainEnhancement: :ref:`CodomainMapContext <OMERO model class CodomainMapContext>` (multiple)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ChecksumAlgorithm:

ChecksumAlgorithm
"""""""""""""""""

Used by: :ref:`OriginalFile.hasher <OMERO model class OriginalFile>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class CodomainMapContext:

CodomainMapContext
""""""""""""""""""

Subclasses: :ref:`ContrastStretchingContext <OMERO model class ContrastStretchingContext>`, :ref:`PlaneSlicingContext <OMERO model class PlaneSlicingContext>`, :ref:`ReverseIntensityContext <OMERO model class ReverseIntensityContext>`

Used by: :ref:`ChannelBinding.spatialDomainEnhancement <OMERO model class ChannelBinding>`

Properties:
  | channelBinding: :ref:`ChannelBinding <OMERO model class ChannelBinding>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class CommentAnnotation:

CommentAnnotation
"""""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | textValue: ``text`` (optional) from :ref:`TextAnnotation <OMERO model class TextAnnotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class ContrastMethod:

ContrastMethod
""""""""""""""

Used by: :ref:`LogicalChannel.contrastMethod <OMERO model class LogicalChannel>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class ContrastStretchingContext:

ContrastStretchingContext
"""""""""""""""""""""""""

Properties:
  | channelBinding: :ref:`ChannelBinding <OMERO model class ChannelBinding>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | version: ``integer`` (optional) from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | xend: ``integer``
  | xstart: ``integer``
  | yend: ``integer``
  | ystart: ``integer``

.. _OMERO model class Correction:

Correction
""""""""""

Used by: :ref:`Objective.correction <OMERO model class Objective>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class DBPatch:

DBPatch
"""""""

Properties:
  | currentPatch: ``integer``
  | currentVersion: ``string``
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | finished: ``timestamp`` (optional)
  | message: ``string`` (optional)
  | previousPatch: ``integer``
  | previousVersion: ``string``

.. _OMERO model class Dataset:

Dataset
"""""""

Used by: :ref:`DatasetAnnotationLink.parent <OMERO model class DatasetAnnotationLink>`, :ref:`DatasetImageLink.parent <OMERO model class DatasetImageLink>`, :ref:`ProjectDatasetLink.child <OMERO model class ProjectDatasetLink>`

Properties:
  | annotationLinks: :ref:`DatasetAnnotationLink <OMERO model class DatasetAnnotationLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | imageLinks: :ref:`DatasetImageLink <OMERO model class DatasetImageLink>` (multiple)
  | name: ``text``
  | projectLinks: :ref:`ProjectDatasetLink <OMERO model class ProjectDatasetLink>` (multiple)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class DatasetAnnotationLink:

DatasetAnnotationLink
"""""""""""""""""""""

Used by: :ref:`Dataset.annotationLinks <OMERO model class Dataset>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Dataset <OMERO model class Dataset>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class DatasetImageLink:

DatasetImageLink
""""""""""""""""

Used by: :ref:`Dataset.imageLinks <OMERO model class Dataset>`, :ref:`Image.datasetLinks <OMERO model class Image>`

Properties:
  | child: :ref:`Image <OMERO model class Image>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Dataset <OMERO model class Dataset>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Detector:

Detector
""""""""

Used by: :ref:`DetectorAnnotationLink.parent <OMERO model class DetectorAnnotationLink>`, :ref:`DetectorSettings.detector <OMERO model class DetectorSettings>`, :ref:`Instrument.detector <OMERO model class Instrument>`

Properties:
  | amplificationGain: ``double`` (optional)
  | annotationLinks: :ref:`DetectorAnnotationLink <OMERO model class DetectorAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | gain: ``double`` (optional)
  | instrument: :ref:`Instrument <OMERO model class Instrument>`
  | lotNumber: ``string`` (optional)
  | manufacturer: ``string`` (optional)
  | model: ``string`` (optional)
  | offsetValue: ``double`` (optional)
  | serialNumber: ``string`` (optional)
  | type: :ref:`DetectorType <OMERO model class DetectorType>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | voltage.unit: enumeration of :javadoc:`ElectricPotential <ome/model/units/ElectricPotential.html>` (optional)
  | voltage.value: ``double`` (optional)
  | zoom: ``double`` (optional)

.. _OMERO model class DetectorAnnotationLink:

DetectorAnnotationLink
""""""""""""""""""""""

Used by: :ref:`Detector.annotationLinks <OMERO model class Detector>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Detector <OMERO model class Detector>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class DetectorSettings:

DetectorSettings
""""""""""""""""

Used by: :ref:`LogicalChannel.detectorSettings <OMERO model class LogicalChannel>`

Properties:
  | binning: :ref:`Binning <OMERO model class Binning>` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | detector: :ref:`Detector <OMERO model class Detector>`
  | gain: ``double`` (optional)
  | integration: ``integer`` (optional)
  | offsetValue: ``double`` (optional)
  | readOutRate.unit: enumeration of :javadoc:`Frequency <ome/model/units/Frequency.html>` (optional)
  | readOutRate.value: ``double`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | voltage.unit: enumeration of :javadoc:`ElectricPotential <ome/model/units/ElectricPotential.html>` (optional)
  | voltage.value: ``double`` (optional)
  | zoom: ``double`` (optional)

.. _OMERO model class DetectorType:

DetectorType
""""""""""""

Used by: :ref:`Detector.type <OMERO model class Detector>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Dichroic:

Dichroic
""""""""

Used by: :ref:`DichroicAnnotationLink.parent <OMERO model class DichroicAnnotationLink>`, :ref:`FilterSet.dichroic <OMERO model class FilterSet>`, :ref:`Instrument.dichroic <OMERO model class Instrument>`, :ref:`LightPath.dichroic <OMERO model class LightPath>`

Properties:
  | annotationLinks: :ref:`DichroicAnnotationLink <OMERO model class DichroicAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | instrument: :ref:`Instrument <OMERO model class Instrument>`
  | lotNumber: ``string`` (optional)
  | manufacturer: ``string`` (optional)
  | model: ``string`` (optional)
  | serialNumber: ``string`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class DichroicAnnotationLink:

DichroicAnnotationLink
""""""""""""""""""""""

Used by: :ref:`Dichroic.annotationLinks <OMERO model class Dichroic>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Dichroic <OMERO model class Dichroic>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class DimensionOrder:

DimensionOrder
""""""""""""""

Used by: :ref:`Pixels.dimensionOrder <OMERO model class Pixels>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class DoubleAnnotation:

DoubleAnnotation
""""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | doubleValue: ``double`` (optional)
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class Ellipse:

Ellipse
"""""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | radiusX: ``double`` (optional)
  | radiusY: ``double`` (optional)
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | x: ``double`` (optional)
  | y: ``double`` (optional)

.. _OMERO model class Event:

Event
"""""

Used by: :ref:`AffineTransform.details.creationEvent <OMERO model class AffineTransform>`, :ref:`AffineTransform.details.updateEvent <OMERO model class AffineTransform>`, :ref:`Annotation.details.creationEvent <OMERO model class Annotation>`, :ref:`Annotation.details.updateEvent <OMERO model class Annotation>`, :ref:`AnnotationAnnotationLink.details.creationEvent <OMERO model class AnnotationAnnotationLink>`, :ref:`AnnotationAnnotationLink.details.updateEvent <OMERO model class AnnotationAnnotationLink>`, :ref:`Channel.details.creationEvent <OMERO model class Channel>`, :ref:`Channel.details.updateEvent <OMERO model class Channel>`, :ref:`ChannelAnnotationLink.details.creationEvent <OMERO model class ChannelAnnotationLink>`, :ref:`ChannelAnnotationLink.details.updateEvent <OMERO model class ChannelAnnotationLink>`, :ref:`ChannelBinding.details.creationEvent <OMERO model class ChannelBinding>`, :ref:`ChannelBinding.details.updateEvent <OMERO model class ChannelBinding>`, :ref:`CodomainMapContext.details.creationEvent <OMERO model class CodomainMapContext>`, :ref:`CodomainMapContext.details.updateEvent <OMERO model class CodomainMapContext>`, :ref:`Dataset.details.creationEvent <OMERO model class Dataset>`, :ref:`Dataset.details.updateEvent <OMERO model class Dataset>`, :ref:`DatasetAnnotationLink.details.creationEvent <OMERO model class DatasetAnnotationLink>`, :ref:`DatasetAnnotationLink.details.updateEvent <OMERO model class DatasetAnnotationLink>`, :ref:`DatasetImageLink.details.creationEvent <OMERO model class DatasetImageLink>`, :ref:`DatasetImageLink.details.updateEvent <OMERO model class DatasetImageLink>`, :ref:`Detector.details.creationEvent <OMERO model class Detector>`, :ref:`Detector.details.updateEvent <OMERO model class Detector>`, :ref:`DetectorAnnotationLink.details.creationEvent <OMERO model class DetectorAnnotationLink>`, :ref:`DetectorAnnotationLink.details.updateEvent <OMERO model class DetectorAnnotationLink>`, :ref:`DetectorSettings.details.creationEvent <OMERO model class DetectorSettings>`, :ref:`DetectorSettings.details.updateEvent <OMERO model class DetectorSettings>`, :ref:`Dichroic.details.creationEvent <OMERO model class Dichroic>`, :ref:`Dichroic.details.updateEvent <OMERO model class Dichroic>`, :ref:`DichroicAnnotationLink.details.creationEvent <OMERO model class DichroicAnnotationLink>`, :ref:`DichroicAnnotationLink.details.updateEvent <OMERO model class DichroicAnnotationLink>`, :ref:`Event.containingEvent <OMERO model class Event>`, :ref:`EventLog.event <OMERO model class EventLog>`, :ref:`Experiment.details.creationEvent <OMERO model class Experiment>`, :ref:`Experiment.details.updateEvent <OMERO model class Experiment>`, :ref:`ExperimenterAnnotationLink.details.creationEvent <OMERO model class ExperimenterAnnotationLink>`, :ref:`ExperimenterAnnotationLink.details.updateEvent <OMERO model class ExperimenterAnnotationLink>`, :ref:`ExperimenterGroupAnnotationLink.details.creationEvent <OMERO model class ExperimenterGroupAnnotationLink>`, :ref:`ExperimenterGroupAnnotationLink.details.updateEvent <OMERO model class ExperimenterGroupAnnotationLink>`, :ref:`ExternalInfo.details.creationEvent <OMERO model class ExternalInfo>`, :ref:`Fileset.details.creationEvent <OMERO model class Fileset>`, :ref:`Fileset.details.updateEvent <OMERO model class Fileset>`, :ref:`FilesetAnnotationLink.details.creationEvent <OMERO model class FilesetAnnotationLink>`, :ref:`FilesetAnnotationLink.details.updateEvent <OMERO model class FilesetAnnotationLink>`, :ref:`FilesetEntry.details.creationEvent <OMERO model class FilesetEntry>`, :ref:`FilesetEntry.details.updateEvent <OMERO model class FilesetEntry>`, :ref:`FilesetJobLink.details.creationEvent <OMERO model class FilesetJobLink>`, :ref:`FilesetJobLink.details.updateEvent <OMERO model class FilesetJobLink>`, :ref:`Filter.details.creationEvent <OMERO model class Filter>`, :ref:`Filter.details.updateEvent <OMERO model class Filter>`, :ref:`FilterAnnotationLink.details.creationEvent <OMERO model class FilterAnnotationLink>`, :ref:`FilterAnnotationLink.details.updateEvent <OMERO model class FilterAnnotationLink>`, :ref:`FilterSet.details.creationEvent <OMERO model class FilterSet>`, :ref:`FilterSet.details.updateEvent <OMERO model class FilterSet>`, :ref:`FilterSetEmissionFilterLink.details.creationEvent <OMERO model class FilterSetEmissionFilterLink>`, :ref:`FilterSetEmissionFilterLink.details.updateEvent <OMERO model class FilterSetEmissionFilterLink>`, :ref:`FilterSetExcitationFilterLink.details.creationEvent <OMERO model class FilterSetExcitationFilterLink>`, :ref:`FilterSetExcitationFilterLink.details.updateEvent <OMERO model class FilterSetExcitationFilterLink>`, :ref:`Folder.details.creationEvent <OMERO model class Folder>`, :ref:`Folder.details.updateEvent <OMERO model class Folder>`, :ref:`FolderAnnotationLink.details.creationEvent <OMERO model class FolderAnnotationLink>`, :ref:`FolderAnnotationLink.details.updateEvent <OMERO model class FolderAnnotationLink>`, :ref:`FolderImageLink.details.creationEvent <OMERO model class FolderImageLink>`, :ref:`FolderImageLink.details.updateEvent <OMERO model class FolderImageLink>`, :ref:`FolderRoiLink.details.creationEvent <OMERO model class FolderRoiLink>`, :ref:`FolderRoiLink.details.updateEvent <OMERO model class FolderRoiLink>`, :ref:`Image.details.creationEvent <OMERO model class Image>`, :ref:`Image.details.updateEvent <OMERO model class Image>`, :ref:`ImageAnnotationLink.details.creationEvent <OMERO model class ImageAnnotationLink>`, :ref:`ImageAnnotationLink.details.updateEvent <OMERO model class ImageAnnotationLink>`, :ref:`ImagingEnvironment.details.creationEvent <OMERO model class ImagingEnvironment>`, :ref:`ImagingEnvironment.details.updateEvent <OMERO model class ImagingEnvironment>`, :ref:`Instrument.details.creationEvent <OMERO model class Instrument>`, :ref:`Instrument.details.updateEvent <OMERO model class Instrument>`, :ref:`InstrumentAnnotationLink.details.creationEvent <OMERO model class InstrumentAnnotationLink>`, :ref:`InstrumentAnnotationLink.details.updateEvent <OMERO model class InstrumentAnnotationLink>`, :ref:`Job.details.creationEvent <OMERO model class Job>`, :ref:`Job.details.updateEvent <OMERO model class Job>`, :ref:`JobOriginalFileLink.details.creationEvent <OMERO model class JobOriginalFileLink>`, :ref:`JobOriginalFileLink.details.updateEvent <OMERO model class JobOriginalFileLink>`, :ref:`LightPath.details.creationEvent <OMERO model class LightPath>`, :ref:`LightPath.details.updateEvent <OMERO model class LightPath>`, :ref:`LightPathAnnotationLink.details.creationEvent <OMERO model class LightPathAnnotationLink>`, :ref:`LightPathAnnotationLink.details.updateEvent <OMERO model class LightPathAnnotationLink>`, :ref:`LightPathEmissionFilterLink.details.creationEvent <OMERO model class LightPathEmissionFilterLink>`, :ref:`LightPathEmissionFilterLink.details.updateEvent <OMERO model class LightPathEmissionFilterLink>`, :ref:`LightPathExcitationFilterLink.details.creationEvent <OMERO model class LightPathExcitationFilterLink>`, :ref:`LightPathExcitationFilterLink.details.updateEvent <OMERO model class LightPathExcitationFilterLink>`, :ref:`LightSettings.details.creationEvent <OMERO model class LightSettings>`, :ref:`LightSettings.details.updateEvent <OMERO model class LightSettings>`, :ref:`LightSource.details.creationEvent <OMERO model class LightSource>`, :ref:`LightSource.details.updateEvent <OMERO model class LightSource>`, :ref:`LightSourceAnnotationLink.details.creationEvent <OMERO model class LightSourceAnnotationLink>`, :ref:`LightSourceAnnotationLink.details.updateEvent <OMERO model class LightSourceAnnotationLink>`, :ref:`Link.details.creationEvent <OMERO model class Link>`, :ref:`Link.details.updateEvent <OMERO model class Link>`, :ref:`LogicalChannel.details.creationEvent <OMERO model class LogicalChannel>`, :ref:`LogicalChannel.details.updateEvent <OMERO model class LogicalChannel>`, :ref:`MicrobeamManipulation.details.creationEvent <OMERO model class MicrobeamManipulation>`, :ref:`MicrobeamManipulation.details.updateEvent <OMERO model class MicrobeamManipulation>`, :ref:`Microscope.details.creationEvent <OMERO model class Microscope>`, :ref:`Microscope.details.updateEvent <OMERO model class Microscope>`, :ref:`NamespaceAnnotationLink.details.creationEvent <OMERO model class NamespaceAnnotationLink>`, :ref:`NamespaceAnnotationLink.details.updateEvent <OMERO model class NamespaceAnnotationLink>`, :ref:`NodeAnnotationLink.details.creationEvent <OMERO model class NodeAnnotationLink>`, :ref:`NodeAnnotationLink.details.updateEvent <OMERO model class NodeAnnotationLink>`, :ref:`OTF.details.creationEvent <OMERO model class OTF>`, :ref:`OTF.details.updateEvent <OMERO model class OTF>`, :ref:`Objective.details.creationEvent <OMERO model class Objective>`, :ref:`Objective.details.updateEvent <OMERO model class Objective>`, :ref:`ObjectiveAnnotationLink.details.creationEvent <OMERO model class ObjectiveAnnotationLink>`, :ref:`ObjectiveAnnotationLink.details.updateEvent <OMERO model class ObjectiveAnnotationLink>`, :ref:`ObjectiveSettings.details.creationEvent <OMERO model class ObjectiveSettings>`, :ref:`ObjectiveSettings.details.updateEvent <OMERO model class ObjectiveSettings>`, :ref:`OriginalFile.details.creationEvent <OMERO model class OriginalFile>`, :ref:`OriginalFile.details.updateEvent <OMERO model class OriginalFile>`, :ref:`OriginalFileAnnotationLink.details.creationEvent <OMERO model class OriginalFileAnnotationLink>`, :ref:`OriginalFileAnnotationLink.details.updateEvent <OMERO model class OriginalFileAnnotationLink>`, :ref:`Pixels.details.creationEvent <OMERO model class Pixels>`, :ref:`Pixels.details.updateEvent <OMERO model class Pixels>`, :ref:`PixelsOriginalFileMap.details.creationEvent <OMERO model class PixelsOriginalFileMap>`, :ref:`PixelsOriginalFileMap.details.updateEvent <OMERO model class PixelsOriginalFileMap>`, :ref:`PlaneInfo.details.creationEvent <OMERO model class PlaneInfo>`, :ref:`PlaneInfo.details.updateEvent <OMERO model class PlaneInfo>`, :ref:`PlaneInfoAnnotationLink.details.creationEvent <OMERO model class PlaneInfoAnnotationLink>`, :ref:`PlaneInfoAnnotationLink.details.updateEvent <OMERO model class PlaneInfoAnnotationLink>`, :ref:`Plate.details.creationEvent <OMERO model class Plate>`, :ref:`Plate.details.updateEvent <OMERO model class Plate>`, :ref:`PlateAcquisition.details.creationEvent <OMERO model class PlateAcquisition>`, :ref:`PlateAcquisition.details.updateEvent <OMERO model class PlateAcquisition>`, :ref:`PlateAcquisitionAnnotationLink.details.creationEvent <OMERO model class PlateAcquisitionAnnotationLink>`, :ref:`PlateAcquisitionAnnotationLink.details.updateEvent <OMERO model class PlateAcquisitionAnnotationLink>`, :ref:`PlateAnnotationLink.details.creationEvent <OMERO model class PlateAnnotationLink>`, :ref:`PlateAnnotationLink.details.updateEvent <OMERO model class PlateAnnotationLink>`, :ref:`Project.details.creationEvent <OMERO model class Project>`, :ref:`Project.details.updateEvent <OMERO model class Project>`, :ref:`ProjectAnnotationLink.details.creationEvent <OMERO model class ProjectAnnotationLink>`, :ref:`ProjectAnnotationLink.details.updateEvent <OMERO model class ProjectAnnotationLink>`, :ref:`ProjectDatasetLink.details.creationEvent <OMERO model class ProjectDatasetLink>`, :ref:`ProjectDatasetLink.details.updateEvent <OMERO model class ProjectDatasetLink>`, :ref:`ProjectionDef.details.creationEvent <OMERO model class ProjectionDef>`, :ref:`ProjectionDef.details.updateEvent <OMERO model class ProjectionDef>`, :ref:`QuantumDef.details.creationEvent <OMERO model class QuantumDef>`, :ref:`QuantumDef.details.updateEvent <OMERO model class QuantumDef>`, :ref:`Reagent.details.creationEvent <OMERO model class Reagent>`, :ref:`Reagent.details.updateEvent <OMERO model class Reagent>`, :ref:`ReagentAnnotationLink.details.creationEvent <OMERO model class ReagentAnnotationLink>`, :ref:`ReagentAnnotationLink.details.updateEvent <OMERO model class ReagentAnnotationLink>`, :ref:`RenderingDef.details.creationEvent <OMERO model class RenderingDef>`, :ref:`RenderingDef.details.updateEvent <OMERO model class RenderingDef>`, :ref:`Roi.details.creationEvent <OMERO model class Roi>`, :ref:`Roi.details.updateEvent <OMERO model class Roi>`, :ref:`RoiAnnotationLink.details.creationEvent <OMERO model class RoiAnnotationLink>`, :ref:`RoiAnnotationLink.details.updateEvent <OMERO model class RoiAnnotationLink>`, :ref:`Screen.details.creationEvent <OMERO model class Screen>`, :ref:`Screen.details.updateEvent <OMERO model class Screen>`, :ref:`ScreenAnnotationLink.details.creationEvent <OMERO model class ScreenAnnotationLink>`, :ref:`ScreenAnnotationLink.details.updateEvent <OMERO model class ScreenAnnotationLink>`, :ref:`ScreenPlateLink.details.creationEvent <OMERO model class ScreenPlateLink>`, :ref:`ScreenPlateLink.details.updateEvent <OMERO model class ScreenPlateLink>`, :ref:`Session.events <OMERO model class Session>`, :ref:`SessionAnnotationLink.details.creationEvent <OMERO model class SessionAnnotationLink>`, :ref:`SessionAnnotationLink.details.updateEvent <OMERO model class SessionAnnotationLink>`, :ref:`Shape.details.creationEvent <OMERO model class Shape>`, :ref:`Shape.details.updateEvent <OMERO model class Shape>`, :ref:`ShapeAnnotationLink.details.creationEvent <OMERO model class ShapeAnnotationLink>`, :ref:`ShapeAnnotationLink.details.updateEvent <OMERO model class ShapeAnnotationLink>`, :ref:`StageLabel.details.creationEvent <OMERO model class StageLabel>`, :ref:`StageLabel.details.updateEvent <OMERO model class StageLabel>`, :ref:`StatsInfo.details.creationEvent <OMERO model class StatsInfo>`, :ref:`StatsInfo.details.updateEvent <OMERO model class StatsInfo>`, :ref:`Thumbnail.details.creationEvent <OMERO model class Thumbnail>`, :ref:`Thumbnail.details.updateEvent <OMERO model class Thumbnail>`, :ref:`TransmittanceRange.details.creationEvent <OMERO model class TransmittanceRange>`, :ref:`TransmittanceRange.details.updateEvent <OMERO model class TransmittanceRange>`, :ref:`Well.details.creationEvent <OMERO model class Well>`, :ref:`Well.details.updateEvent <OMERO model class Well>`, :ref:`WellAnnotationLink.details.creationEvent <OMERO model class WellAnnotationLink>`, :ref:`WellAnnotationLink.details.updateEvent <OMERO model class WellAnnotationLink>`, :ref:`WellReagentLink.details.creationEvent <OMERO model class WellReagentLink>`, :ref:`WellReagentLink.details.updateEvent <OMERO model class WellReagentLink>`, :ref:`WellSample.details.creationEvent <OMERO model class WellSample>`, :ref:`WellSample.details.updateEvent <OMERO model class WellSample>`

Properties:
  | containingEvent: :ref:`Event <OMERO model class Event>` (optional)
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | experimenter: :ref:`Experimenter <OMERO model class Experimenter>`
  | experimenterGroup: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`
  | logs: :ref:`EventLog <OMERO model class EventLog>` (multiple)
  | session: :ref:`Session <OMERO model class Session>`
  | status: ``string`` (optional)
  | time: ``timestamp``
  | type: :ref:`EventType <OMERO model class EventType>`

.. _OMERO model class EventLog:

EventLog
""""""""

Used by: :ref:`Event.logs <OMERO model class Event>`

Properties:
  | action: ``string``
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | entityId: ``long``
  | entityType: ``string``
  | event: :ref:`Event <OMERO model class Event>`

.. _OMERO model class EventType:

EventType
"""""""""

Used by: :ref:`Event.type <OMERO model class Event>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Experiment:

Experiment
""""""""""

Used by: :ref:`Image.experiment <OMERO model class Image>`, :ref:`MicrobeamManipulation.experiment <OMERO model class MicrobeamManipulation>`

Properties:
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | microbeamManipulation: :ref:`MicrobeamManipulation <OMERO model class MicrobeamManipulation>` (multiple)
  | type: :ref:`ExperimentType <OMERO model class ExperimentType>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ExperimentType:

ExperimentType
""""""""""""""

Used by: :ref:`Experiment.type <OMERO model class Experiment>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Experimenter:

Experimenter
""""""""""""

Used by: :ref:`AffineTransform.details.owner <OMERO model class AffineTransform>`, :ref:`Annotation.details.owner <OMERO model class Annotation>`, :ref:`AnnotationAnnotationLink.details.owner <OMERO model class AnnotationAnnotationLink>`, :ref:`Channel.details.owner <OMERO model class Channel>`, :ref:`ChannelAnnotationLink.details.owner <OMERO model class ChannelAnnotationLink>`, :ref:`ChannelBinding.details.owner <OMERO model class ChannelBinding>`, :ref:`CodomainMapContext.details.owner <OMERO model class CodomainMapContext>`, :ref:`Dataset.details.owner <OMERO model class Dataset>`, :ref:`DatasetAnnotationLink.details.owner <OMERO model class DatasetAnnotationLink>`, :ref:`DatasetImageLink.details.owner <OMERO model class DatasetImageLink>`, :ref:`Detector.details.owner <OMERO model class Detector>`, :ref:`DetectorAnnotationLink.details.owner <OMERO model class DetectorAnnotationLink>`, :ref:`DetectorSettings.details.owner <OMERO model class DetectorSettings>`, :ref:`Dichroic.details.owner <OMERO model class Dichroic>`, :ref:`DichroicAnnotationLink.details.owner <OMERO model class DichroicAnnotationLink>`, :ref:`Event.experimenter <OMERO model class Event>`, :ref:`Experiment.details.owner <OMERO model class Experiment>`, :ref:`ExperimenterAnnotationLink.details.owner <OMERO model class ExperimenterAnnotationLink>`, :ref:`ExperimenterAnnotationLink.parent <OMERO model class ExperimenterAnnotationLink>`, :ref:`ExperimenterGroupAnnotationLink.details.owner <OMERO model class ExperimenterGroupAnnotationLink>`, :ref:`ExternalInfo.details.owner <OMERO model class ExternalInfo>`, :ref:`Fileset.details.owner <OMERO model class Fileset>`, :ref:`FilesetAnnotationLink.details.owner <OMERO model class FilesetAnnotationLink>`, :ref:`FilesetEntry.details.owner <OMERO model class FilesetEntry>`, :ref:`FilesetJobLink.details.owner <OMERO model class FilesetJobLink>`, :ref:`Filter.details.owner <OMERO model class Filter>`, :ref:`FilterAnnotationLink.details.owner <OMERO model class FilterAnnotationLink>`, :ref:`FilterSet.details.owner <OMERO model class FilterSet>`, :ref:`FilterSetEmissionFilterLink.details.owner <OMERO model class FilterSetEmissionFilterLink>`, :ref:`FilterSetExcitationFilterLink.details.owner <OMERO model class FilterSetExcitationFilterLink>`, :ref:`Folder.details.owner <OMERO model class Folder>`, :ref:`FolderAnnotationLink.details.owner <OMERO model class FolderAnnotationLink>`, :ref:`FolderImageLink.details.owner <OMERO model class FolderImageLink>`, :ref:`FolderRoiLink.details.owner <OMERO model class FolderRoiLink>`, :ref:`GroupExperimenterMap.child <OMERO model class GroupExperimenterMap>`, :ref:`Image.details.owner <OMERO model class Image>`, :ref:`ImageAnnotationLink.details.owner <OMERO model class ImageAnnotationLink>`, :ref:`ImagingEnvironment.details.owner <OMERO model class ImagingEnvironment>`, :ref:`Instrument.details.owner <OMERO model class Instrument>`, :ref:`InstrumentAnnotationLink.details.owner <OMERO model class InstrumentAnnotationLink>`, :ref:`Job.details.owner <OMERO model class Job>`, :ref:`JobOriginalFileLink.details.owner <OMERO model class JobOriginalFileLink>`, :ref:`LightPath.details.owner <OMERO model class LightPath>`, :ref:`LightPathAnnotationLink.details.owner <OMERO model class LightPathAnnotationLink>`, :ref:`LightPathEmissionFilterLink.details.owner <OMERO model class LightPathEmissionFilterLink>`, :ref:`LightPathExcitationFilterLink.details.owner <OMERO model class LightPathExcitationFilterLink>`, :ref:`LightSettings.details.owner <OMERO model class LightSettings>`, :ref:`LightSource.details.owner <OMERO model class LightSource>`, :ref:`LightSourceAnnotationLink.details.owner <OMERO model class LightSourceAnnotationLink>`, :ref:`Link.details.owner <OMERO model class Link>`, :ref:`LogicalChannel.details.owner <OMERO model class LogicalChannel>`, :ref:`MicrobeamManipulation.details.owner <OMERO model class MicrobeamManipulation>`, :ref:`Microscope.details.owner <OMERO model class Microscope>`, :ref:`NamespaceAnnotationLink.details.owner <OMERO model class NamespaceAnnotationLink>`, :ref:`NodeAnnotationLink.details.owner <OMERO model class NodeAnnotationLink>`, :ref:`OTF.details.owner <OMERO model class OTF>`, :ref:`Objective.details.owner <OMERO model class Objective>`, :ref:`ObjectiveAnnotationLink.details.owner <OMERO model class ObjectiveAnnotationLink>`, :ref:`ObjectiveSettings.details.owner <OMERO model class ObjectiveSettings>`, :ref:`OriginalFile.details.owner <OMERO model class OriginalFile>`, :ref:`OriginalFileAnnotationLink.details.owner <OMERO model class OriginalFileAnnotationLink>`, :ref:`Pixels.details.owner <OMERO model class Pixels>`, :ref:`PixelsOriginalFileMap.details.owner <OMERO model class PixelsOriginalFileMap>`, :ref:`PlaneInfo.details.owner <OMERO model class PlaneInfo>`, :ref:`PlaneInfoAnnotationLink.details.owner <OMERO model class PlaneInfoAnnotationLink>`, :ref:`Plate.details.owner <OMERO model class Plate>`, :ref:`PlateAcquisition.details.owner <OMERO model class PlateAcquisition>`, :ref:`PlateAcquisitionAnnotationLink.details.owner <OMERO model class PlateAcquisitionAnnotationLink>`, :ref:`PlateAnnotationLink.details.owner <OMERO model class PlateAnnotationLink>`, :ref:`Project.details.owner <OMERO model class Project>`, :ref:`ProjectAnnotationLink.details.owner <OMERO model class ProjectAnnotationLink>`, :ref:`ProjectDatasetLink.details.owner <OMERO model class ProjectDatasetLink>`, :ref:`ProjectionDef.details.owner <OMERO model class ProjectionDef>`, :ref:`QuantumDef.details.owner <OMERO model class QuantumDef>`, :ref:`Reagent.details.owner <OMERO model class Reagent>`, :ref:`ReagentAnnotationLink.details.owner <OMERO model class ReagentAnnotationLink>`, :ref:`RenderingDef.details.owner <OMERO model class RenderingDef>`, :ref:`Roi.details.owner <OMERO model class Roi>`, :ref:`RoiAnnotationLink.details.owner <OMERO model class RoiAnnotationLink>`, :ref:`Screen.details.owner <OMERO model class Screen>`, :ref:`ScreenAnnotationLink.details.owner <OMERO model class ScreenAnnotationLink>`, :ref:`ScreenPlateLink.details.owner <OMERO model class ScreenPlateLink>`, :ref:`Session.owner <OMERO model class Session>`, :ref:`Session.sudoer <OMERO model class Session>`, :ref:`SessionAnnotationLink.details.owner <OMERO model class SessionAnnotationLink>`, :ref:`Shape.details.owner <OMERO model class Shape>`, :ref:`ShapeAnnotationLink.details.owner <OMERO model class ShapeAnnotationLink>`, :ref:`ShareMember.child <OMERO model class ShareMember>`, :ref:`StageLabel.details.owner <OMERO model class StageLabel>`, :ref:`StatsInfo.details.owner <OMERO model class StatsInfo>`, :ref:`Thumbnail.details.owner <OMERO model class Thumbnail>`, :ref:`TransmittanceRange.details.owner <OMERO model class TransmittanceRange>`, :ref:`Well.details.owner <OMERO model class Well>`, :ref:`WellAnnotationLink.details.owner <OMERO model class WellAnnotationLink>`, :ref:`WellReagentLink.details.owner <OMERO model class WellReagentLink>`, :ref:`WellSample.details.owner <OMERO model class WellSample>`

Properties:
  | annotationLinks: :ref:`ExperimenterAnnotationLink <OMERO model class ExperimenterAnnotationLink>` (multiple)
  | config: list (multiple)
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | email: ``string`` (optional)
  | firstName: ``string``
  | groupExperimenterMap: :ref:`GroupExperimenterMap <OMERO model class GroupExperimenterMap>` (multiple)
  | institution: ``string`` (optional)
  | lastName: ``string``
  | ldap: ``boolean``
  | middleName: ``string`` (optional)
  | omeName: ``string``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ExperimenterAnnotationLink:

ExperimenterAnnotationLink
""""""""""""""""""""""""""

Used by: :ref:`Experimenter.annotationLinks <OMERO model class Experimenter>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ExperimenterGroup:

ExperimenterGroup
"""""""""""""""""

Used by: :ref:`AffineTransform.details.group <OMERO model class AffineTransform>`, :ref:`Annotation.details.group <OMERO model class Annotation>`, :ref:`AnnotationAnnotationLink.details.group <OMERO model class AnnotationAnnotationLink>`, :ref:`Channel.details.group <OMERO model class Channel>`, :ref:`ChannelAnnotationLink.details.group <OMERO model class ChannelAnnotationLink>`, :ref:`ChannelBinding.details.group <OMERO model class ChannelBinding>`, :ref:`CodomainMapContext.details.group <OMERO model class CodomainMapContext>`, :ref:`Dataset.details.group <OMERO model class Dataset>`, :ref:`DatasetAnnotationLink.details.group <OMERO model class DatasetAnnotationLink>`, :ref:`DatasetImageLink.details.group <OMERO model class DatasetImageLink>`, :ref:`Detector.details.group <OMERO model class Detector>`, :ref:`DetectorAnnotationLink.details.group <OMERO model class DetectorAnnotationLink>`, :ref:`DetectorSettings.details.group <OMERO model class DetectorSettings>`, :ref:`Dichroic.details.group <OMERO model class Dichroic>`, :ref:`DichroicAnnotationLink.details.group <OMERO model class DichroicAnnotationLink>`, :ref:`Event.experimenterGroup <OMERO model class Event>`, :ref:`Experiment.details.group <OMERO model class Experiment>`, :ref:`ExperimenterAnnotationLink.details.group <OMERO model class ExperimenterAnnotationLink>`, :ref:`ExperimenterGroupAnnotationLink.details.group <OMERO model class ExperimenterGroupAnnotationLink>`, :ref:`ExperimenterGroupAnnotationLink.parent <OMERO model class ExperimenterGroupAnnotationLink>`, :ref:`ExternalInfo.details.group <OMERO model class ExternalInfo>`, :ref:`Fileset.details.group <OMERO model class Fileset>`, :ref:`FilesetAnnotationLink.details.group <OMERO model class FilesetAnnotationLink>`, :ref:`FilesetEntry.details.group <OMERO model class FilesetEntry>`, :ref:`FilesetJobLink.details.group <OMERO model class FilesetJobLink>`, :ref:`Filter.details.group <OMERO model class Filter>`, :ref:`FilterAnnotationLink.details.group <OMERO model class FilterAnnotationLink>`, :ref:`FilterSet.details.group <OMERO model class FilterSet>`, :ref:`FilterSetEmissionFilterLink.details.group <OMERO model class FilterSetEmissionFilterLink>`, :ref:`FilterSetExcitationFilterLink.details.group <OMERO model class FilterSetExcitationFilterLink>`, :ref:`Folder.details.group <OMERO model class Folder>`, :ref:`FolderAnnotationLink.details.group <OMERO model class FolderAnnotationLink>`, :ref:`FolderImageLink.details.group <OMERO model class FolderImageLink>`, :ref:`FolderRoiLink.details.group <OMERO model class FolderRoiLink>`, :ref:`GroupExperimenterMap.parent <OMERO model class GroupExperimenterMap>`, :ref:`Image.details.group <OMERO model class Image>`, :ref:`ImageAnnotationLink.details.group <OMERO model class ImageAnnotationLink>`, :ref:`ImagingEnvironment.details.group <OMERO model class ImagingEnvironment>`, :ref:`Instrument.details.group <OMERO model class Instrument>`, :ref:`InstrumentAnnotationLink.details.group <OMERO model class InstrumentAnnotationLink>`, :ref:`Job.details.group <OMERO model class Job>`, :ref:`JobOriginalFileLink.details.group <OMERO model class JobOriginalFileLink>`, :ref:`LightPath.details.group <OMERO model class LightPath>`, :ref:`LightPathAnnotationLink.details.group <OMERO model class LightPathAnnotationLink>`, :ref:`LightPathEmissionFilterLink.details.group <OMERO model class LightPathEmissionFilterLink>`, :ref:`LightPathExcitationFilterLink.details.group <OMERO model class LightPathExcitationFilterLink>`, :ref:`LightSettings.details.group <OMERO model class LightSettings>`, :ref:`LightSource.details.group <OMERO model class LightSource>`, :ref:`LightSourceAnnotationLink.details.group <OMERO model class LightSourceAnnotationLink>`, :ref:`Link.details.group <OMERO model class Link>`, :ref:`LogicalChannel.details.group <OMERO model class LogicalChannel>`, :ref:`MicrobeamManipulation.details.group <OMERO model class MicrobeamManipulation>`, :ref:`Microscope.details.group <OMERO model class Microscope>`, :ref:`NamespaceAnnotationLink.details.group <OMERO model class NamespaceAnnotationLink>`, :ref:`NodeAnnotationLink.details.group <OMERO model class NodeAnnotationLink>`, :ref:`OTF.details.group <OMERO model class OTF>`, :ref:`Objective.details.group <OMERO model class Objective>`, :ref:`ObjectiveAnnotationLink.details.group <OMERO model class ObjectiveAnnotationLink>`, :ref:`ObjectiveSettings.details.group <OMERO model class ObjectiveSettings>`, :ref:`OriginalFile.details.group <OMERO model class OriginalFile>`, :ref:`OriginalFileAnnotationLink.details.group <OMERO model class OriginalFileAnnotationLink>`, :ref:`Pixels.details.group <OMERO model class Pixels>`, :ref:`PixelsOriginalFileMap.details.group <OMERO model class PixelsOriginalFileMap>`, :ref:`PlaneInfo.details.group <OMERO model class PlaneInfo>`, :ref:`PlaneInfoAnnotationLink.details.group <OMERO model class PlaneInfoAnnotationLink>`, :ref:`Plate.details.group <OMERO model class Plate>`, :ref:`PlateAcquisition.details.group <OMERO model class PlateAcquisition>`, :ref:`PlateAcquisitionAnnotationLink.details.group <OMERO model class PlateAcquisitionAnnotationLink>`, :ref:`PlateAnnotationLink.details.group <OMERO model class PlateAnnotationLink>`, :ref:`Project.details.group <OMERO model class Project>`, :ref:`ProjectAnnotationLink.details.group <OMERO model class ProjectAnnotationLink>`, :ref:`ProjectDatasetLink.details.group <OMERO model class ProjectDatasetLink>`, :ref:`ProjectionDef.details.group <OMERO model class ProjectionDef>`, :ref:`QuantumDef.details.group <OMERO model class QuantumDef>`, :ref:`Reagent.details.group <OMERO model class Reagent>`, :ref:`ReagentAnnotationLink.details.group <OMERO model class ReagentAnnotationLink>`, :ref:`RenderingDef.details.group <OMERO model class RenderingDef>`, :ref:`Roi.details.group <OMERO model class Roi>`, :ref:`RoiAnnotationLink.details.group <OMERO model class RoiAnnotationLink>`, :ref:`Screen.details.group <OMERO model class Screen>`, :ref:`ScreenAnnotationLink.details.group <OMERO model class ScreenAnnotationLink>`, :ref:`ScreenPlateLink.details.group <OMERO model class ScreenPlateLink>`, :ref:`SessionAnnotationLink.details.group <OMERO model class SessionAnnotationLink>`, :ref:`Shape.details.group <OMERO model class Shape>`, :ref:`ShapeAnnotationLink.details.group <OMERO model class ShapeAnnotationLink>`, :ref:`Share.group <OMERO model class Share>`, :ref:`StageLabel.details.group <OMERO model class StageLabel>`, :ref:`StatsInfo.details.group <OMERO model class StatsInfo>`, :ref:`Thumbnail.details.group <OMERO model class Thumbnail>`, :ref:`TransmittanceRange.details.group <OMERO model class TransmittanceRange>`, :ref:`Well.details.group <OMERO model class Well>`, :ref:`WellAnnotationLink.details.group <OMERO model class WellAnnotationLink>`, :ref:`WellReagentLink.details.group <OMERO model class WellReagentLink>`, :ref:`WellSample.details.group <OMERO model class WellSample>`

Properties:
  | annotationLinks: :ref:`ExperimenterGroupAnnotationLink <OMERO model class ExperimenterGroupAnnotationLink>` (multiple)
  | config: list (multiple)
  | description: ``text`` (optional)
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | groupExperimenterMap: :ref:`GroupExperimenterMap <OMERO model class GroupExperimenterMap>` (multiple)
  | ldap: ``boolean``
  | name: ``string``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ExperimenterGroupAnnotationLink:

ExperimenterGroupAnnotationLink
"""""""""""""""""""""""""""""""

Used by: :ref:`ExperimenterGroup.annotationLinks <OMERO model class ExperimenterGroup>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ExternalInfo:

ExternalInfo
""""""""""""

Used by: :ref:`AcquisitionMode.details.externalInfo <OMERO model class AcquisitionMode>`, :ref:`AdminPrivilege.details.externalInfo <OMERO model class AdminPrivilege>`, :ref:`AffineTransform.details.externalInfo <OMERO model class AffineTransform>`, :ref:`Annotation.details.externalInfo <OMERO model class Annotation>`, :ref:`AnnotationAnnotationLink.details.externalInfo <OMERO model class AnnotationAnnotationLink>`, :ref:`ArcType.details.externalInfo <OMERO model class ArcType>`, :ref:`Binning.details.externalInfo <OMERO model class Binning>`, :ref:`Channel.details.externalInfo <OMERO model class Channel>`, :ref:`ChannelAnnotationLink.details.externalInfo <OMERO model class ChannelAnnotationLink>`, :ref:`ChannelBinding.details.externalInfo <OMERO model class ChannelBinding>`, :ref:`ChecksumAlgorithm.details.externalInfo <OMERO model class ChecksumAlgorithm>`, :ref:`CodomainMapContext.details.externalInfo <OMERO model class CodomainMapContext>`, :ref:`ContrastMethod.details.externalInfo <OMERO model class ContrastMethod>`, :ref:`Correction.details.externalInfo <OMERO model class Correction>`, :ref:`DBPatch.details.externalInfo <OMERO model class DBPatch>`, :ref:`Dataset.details.externalInfo <OMERO model class Dataset>`, :ref:`DatasetAnnotationLink.details.externalInfo <OMERO model class DatasetAnnotationLink>`, :ref:`DatasetImageLink.details.externalInfo <OMERO model class DatasetImageLink>`, :ref:`Detector.details.externalInfo <OMERO model class Detector>`, :ref:`DetectorAnnotationLink.details.externalInfo <OMERO model class DetectorAnnotationLink>`, :ref:`DetectorSettings.details.externalInfo <OMERO model class DetectorSettings>`, :ref:`DetectorType.details.externalInfo <OMERO model class DetectorType>`, :ref:`Dichroic.details.externalInfo <OMERO model class Dichroic>`, :ref:`DichroicAnnotationLink.details.externalInfo <OMERO model class DichroicAnnotationLink>`, :ref:`DimensionOrder.details.externalInfo <OMERO model class DimensionOrder>`, :ref:`Event.details.externalInfo <OMERO model class Event>`, :ref:`EventLog.details.externalInfo <OMERO model class EventLog>`, :ref:`EventType.details.externalInfo <OMERO model class EventType>`, :ref:`Experiment.details.externalInfo <OMERO model class Experiment>`, :ref:`ExperimentType.details.externalInfo <OMERO model class ExperimentType>`, :ref:`Experimenter.details.externalInfo <OMERO model class Experimenter>`, :ref:`ExperimenterAnnotationLink.details.externalInfo <OMERO model class ExperimenterAnnotationLink>`, :ref:`ExperimenterGroup.details.externalInfo <OMERO model class ExperimenterGroup>`, :ref:`ExperimenterGroupAnnotationLink.details.externalInfo <OMERO model class ExperimenterGroupAnnotationLink>`, :ref:`ExternalInfo.details.externalInfo <OMERO model class ExternalInfo>`, :ref:`Family.details.externalInfo <OMERO model class Family>`, :ref:`FilamentType.details.externalInfo <OMERO model class FilamentType>`, :ref:`Fileset.details.externalInfo <OMERO model class Fileset>`, :ref:`FilesetAnnotationLink.details.externalInfo <OMERO model class FilesetAnnotationLink>`, :ref:`FilesetEntry.details.externalInfo <OMERO model class FilesetEntry>`, :ref:`FilesetJobLink.details.externalInfo <OMERO model class FilesetJobLink>`, :ref:`Filter.details.externalInfo <OMERO model class Filter>`, :ref:`FilterAnnotationLink.details.externalInfo <OMERO model class FilterAnnotationLink>`, :ref:`FilterSet.details.externalInfo <OMERO model class FilterSet>`, :ref:`FilterSetEmissionFilterLink.details.externalInfo <OMERO model class FilterSetEmissionFilterLink>`, :ref:`FilterSetExcitationFilterLink.details.externalInfo <OMERO model class FilterSetExcitationFilterLink>`, :ref:`FilterType.details.externalInfo <OMERO model class FilterType>`, :ref:`Folder.details.externalInfo <OMERO model class Folder>`, :ref:`FolderAnnotationLink.details.externalInfo <OMERO model class FolderAnnotationLink>`, :ref:`FolderImageLink.details.externalInfo <OMERO model class FolderImageLink>`, :ref:`FolderRoiLink.details.externalInfo <OMERO model class FolderRoiLink>`, :ref:`Format.details.externalInfo <OMERO model class Format>`, :ref:`GroupExperimenterMap.details.externalInfo <OMERO model class GroupExperimenterMap>`, :ref:`Illumination.details.externalInfo <OMERO model class Illumination>`, :ref:`Image.details.externalInfo <OMERO model class Image>`, :ref:`ImageAnnotationLink.details.externalInfo <OMERO model class ImageAnnotationLink>`, :ref:`ImagingEnvironment.details.externalInfo <OMERO model class ImagingEnvironment>`, :ref:`Immersion.details.externalInfo <OMERO model class Immersion>`, :ref:`Instrument.details.externalInfo <OMERO model class Instrument>`, :ref:`InstrumentAnnotationLink.details.externalInfo <OMERO model class InstrumentAnnotationLink>`, :ref:`Job.details.externalInfo <OMERO model class Job>`, :ref:`JobOriginalFileLink.details.externalInfo <OMERO model class JobOriginalFileLink>`, :ref:`JobStatus.details.externalInfo <OMERO model class JobStatus>`, :ref:`LaserMedium.details.externalInfo <OMERO model class LaserMedium>`, :ref:`LaserType.details.externalInfo <OMERO model class LaserType>`, :ref:`LightPath.details.externalInfo <OMERO model class LightPath>`, :ref:`LightPathAnnotationLink.details.externalInfo <OMERO model class LightPathAnnotationLink>`, :ref:`LightPathEmissionFilterLink.details.externalInfo <OMERO model class LightPathEmissionFilterLink>`, :ref:`LightPathExcitationFilterLink.details.externalInfo <OMERO model class LightPathExcitationFilterLink>`, :ref:`LightSettings.details.externalInfo <OMERO model class LightSettings>`, :ref:`LightSource.details.externalInfo <OMERO model class LightSource>`, :ref:`LightSourceAnnotationLink.details.externalInfo <OMERO model class LightSourceAnnotationLink>`, :ref:`Link.details.externalInfo <OMERO model class Link>`, :ref:`LogicalChannel.details.externalInfo <OMERO model class LogicalChannel>`, :ref:`Medium.details.externalInfo <OMERO model class Medium>`, :ref:`MicrobeamManipulation.details.externalInfo <OMERO model class MicrobeamManipulation>`, :ref:`MicrobeamManipulationType.details.externalInfo <OMERO model class MicrobeamManipulationType>`, :ref:`Microscope.details.externalInfo <OMERO model class Microscope>`, :ref:`MicroscopeType.details.externalInfo <OMERO model class MicroscopeType>`, :ref:`Namespace.details.externalInfo <OMERO model class Namespace>`, :ref:`NamespaceAnnotationLink.details.externalInfo <OMERO model class NamespaceAnnotationLink>`, :ref:`Node.details.externalInfo <OMERO model class Node>`, :ref:`NodeAnnotationLink.details.externalInfo <OMERO model class NodeAnnotationLink>`, :ref:`OTF.details.externalInfo <OMERO model class OTF>`, :ref:`Objective.details.externalInfo <OMERO model class Objective>`, :ref:`ObjectiveAnnotationLink.details.externalInfo <OMERO model class ObjectiveAnnotationLink>`, :ref:`ObjectiveSettings.details.externalInfo <OMERO model class ObjectiveSettings>`, :ref:`OriginalFile.details.externalInfo <OMERO model class OriginalFile>`, :ref:`OriginalFileAnnotationLink.details.externalInfo <OMERO model class OriginalFileAnnotationLink>`, :ref:`PhotometricInterpretation.details.externalInfo <OMERO model class PhotometricInterpretation>`, :ref:`Pixels.details.externalInfo <OMERO model class Pixels>`, :ref:`PixelsOriginalFileMap.details.externalInfo <OMERO model class PixelsOriginalFileMap>`, :ref:`PixelsType.details.externalInfo <OMERO model class PixelsType>`, :ref:`PlaneInfo.details.externalInfo <OMERO model class PlaneInfo>`, :ref:`PlaneInfoAnnotationLink.details.externalInfo <OMERO model class PlaneInfoAnnotationLink>`, :ref:`Plate.details.externalInfo <OMERO model class Plate>`, :ref:`PlateAcquisition.details.externalInfo <OMERO model class PlateAcquisition>`, :ref:`PlateAcquisitionAnnotationLink.details.externalInfo <OMERO model class PlateAcquisitionAnnotationLink>`, :ref:`PlateAnnotationLink.details.externalInfo <OMERO model class PlateAnnotationLink>`, :ref:`Project.details.externalInfo <OMERO model class Project>`, :ref:`ProjectAnnotationLink.details.externalInfo <OMERO model class ProjectAnnotationLink>`, :ref:`ProjectDatasetLink.details.externalInfo <OMERO model class ProjectDatasetLink>`, :ref:`ProjectionAxis.details.externalInfo <OMERO model class ProjectionAxis>`, :ref:`ProjectionDef.details.externalInfo <OMERO model class ProjectionDef>`, :ref:`ProjectionType.details.externalInfo <OMERO model class ProjectionType>`, :ref:`Pulse.details.externalInfo <OMERO model class Pulse>`, :ref:`QuantumDef.details.externalInfo <OMERO model class QuantumDef>`, :ref:`Reagent.details.externalInfo <OMERO model class Reagent>`, :ref:`ReagentAnnotationLink.details.externalInfo <OMERO model class ReagentAnnotationLink>`, :ref:`RenderingDef.details.externalInfo <OMERO model class RenderingDef>`, :ref:`RenderingModel.details.externalInfo <OMERO model class RenderingModel>`, :ref:`Roi.details.externalInfo <OMERO model class Roi>`, :ref:`RoiAnnotationLink.details.externalInfo <OMERO model class RoiAnnotationLink>`, :ref:`Screen.details.externalInfo <OMERO model class Screen>`, :ref:`ScreenAnnotationLink.details.externalInfo <OMERO model class ScreenAnnotationLink>`, :ref:`ScreenPlateLink.details.externalInfo <OMERO model class ScreenPlateLink>`, :ref:`Session.details.externalInfo <OMERO model class Session>`, :ref:`SessionAnnotationLink.details.externalInfo <OMERO model class SessionAnnotationLink>`, :ref:`Shape.details.externalInfo <OMERO model class Shape>`, :ref:`ShapeAnnotationLink.details.externalInfo <OMERO model class ShapeAnnotationLink>`, :ref:`ShareMember.details.externalInfo <OMERO model class ShareMember>`, :ref:`StageLabel.details.externalInfo <OMERO model class StageLabel>`, :ref:`StatsInfo.details.externalInfo <OMERO model class StatsInfo>`, :ref:`Thumbnail.details.externalInfo <OMERO model class Thumbnail>`, :ref:`TransmittanceRange.details.externalInfo <OMERO model class TransmittanceRange>`, :ref:`Well.details.externalInfo <OMERO model class Well>`, :ref:`WellAnnotationLink.details.externalInfo <OMERO model class WellAnnotationLink>`, :ref:`WellReagentLink.details.externalInfo <OMERO model class WellReagentLink>`, :ref:`WellSample.details.externalInfo <OMERO model class WellSample>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | entityId: ``long``
  | entityType: ``string``
  | lsid: ``string`` (optional)
  | uuid: ``string`` (optional)

.. _OMERO model class Family:

Family
""""""

Used by: :ref:`ChannelBinding.family <OMERO model class ChannelBinding>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Filament:

Filament
""""""""

Properties:
  | annotationLinks: :ref:`LightSourceAnnotationLink <OMERO model class LightSourceAnnotationLink>` (multiple) from :ref:`LightSource <OMERO model class LightSource>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | instrument: :ref:`Instrument <OMERO model class Instrument>` from :ref:`LightSource <OMERO model class LightSource>`
  | lotNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | manufacturer: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | model: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.unit: enumeration of :javadoc:`Power <ome/model/units/Power.html>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.value: ``double`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | serialNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | type: :ref:`FilamentType <OMERO model class FilamentType>`
  | version: ``integer`` (optional) from :ref:`LightSource <OMERO model class LightSource>`

.. _OMERO model class FilamentType:

FilamentType
""""""""""""

Used by: :ref:`Filament.type <OMERO model class Filament>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class FileAnnotation:

FileAnnotation
""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | file: :ref:`OriginalFile <OMERO model class OriginalFile>` (optional)
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class Fileset:

Fileset
"""""""

Used by: :ref:`FilesetAnnotationLink.parent <OMERO model class FilesetAnnotationLink>`, :ref:`FilesetEntry.fileset <OMERO model class FilesetEntry>`, :ref:`FilesetJobLink.parent <OMERO model class FilesetJobLink>`, :ref:`Image.fileset <OMERO model class Image>`

Properties:
  | annotationLinks: :ref:`FilesetAnnotationLink <OMERO model class FilesetAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | images: :ref:`Image <OMERO model class Image>` (multiple)
  | jobLinks: :ref:`FilesetJobLink <OMERO model class FilesetJobLink>` (multiple)
  | templatePrefix: ``text``
  | usedFiles: :ref:`FilesetEntry <OMERO model class FilesetEntry>` (multiple)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilesetAnnotationLink:

FilesetAnnotationLink
"""""""""""""""""""""

Used by: :ref:`Fileset.annotationLinks <OMERO model class Fileset>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Fileset <OMERO model class Fileset>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilesetEntry:

FilesetEntry
""""""""""""

Used by: :ref:`Fileset.usedFiles <OMERO model class Fileset>`, :ref:`OriginalFile.filesetEntries <OMERO model class OriginalFile>`

Properties:
  | clientPath: ``text``
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | fileset: :ref:`Fileset <OMERO model class Fileset>`
  | originalFile: :ref:`OriginalFile <OMERO model class OriginalFile>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilesetJobLink:

FilesetJobLink
""""""""""""""

Used by: :ref:`Fileset.jobLinks <OMERO model class Fileset>`

Properties:
  | child: :ref:`Job <OMERO model class Job>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Fileset <OMERO model class Fileset>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Filter:

Filter
""""""

Used by: :ref:`FilterAnnotationLink.parent <OMERO model class FilterAnnotationLink>`, :ref:`FilterSetEmissionFilterLink.child <OMERO model class FilterSetEmissionFilterLink>`, :ref:`FilterSetExcitationFilterLink.child <OMERO model class FilterSetExcitationFilterLink>`, :ref:`Instrument.filter <OMERO model class Instrument>`, :ref:`LightPathEmissionFilterLink.child <OMERO model class LightPathEmissionFilterLink>`, :ref:`LightPathExcitationFilterLink.child <OMERO model class LightPathExcitationFilterLink>`

Properties:
  | annotationLinks: :ref:`FilterAnnotationLink <OMERO model class FilterAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | emissionFilterLink: :ref:`FilterSetEmissionFilterLink <OMERO model class FilterSetEmissionFilterLink>` (multiple)
  | excitationFilterLink: :ref:`FilterSetExcitationFilterLink <OMERO model class FilterSetExcitationFilterLink>` (multiple)
  | filterWheel: ``string`` (optional)
  | instrument: :ref:`Instrument <OMERO model class Instrument>`
  | lotNumber: ``string`` (optional)
  | manufacturer: ``string`` (optional)
  | model: ``string`` (optional)
  | serialNumber: ``string`` (optional)
  | transmittanceRange: :ref:`TransmittanceRange <OMERO model class TransmittanceRange>` (optional)
  | type: :ref:`FilterType <OMERO model class FilterType>` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilterAnnotationLink:

FilterAnnotationLink
""""""""""""""""""""

Used by: :ref:`Filter.annotationLinks <OMERO model class Filter>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Filter <OMERO model class Filter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilterSet:

FilterSet
"""""""""

Used by: :ref:`FilterSetEmissionFilterLink.parent <OMERO model class FilterSetEmissionFilterLink>`, :ref:`FilterSetExcitationFilterLink.parent <OMERO model class FilterSetExcitationFilterLink>`, :ref:`Instrument.filterSet <OMERO model class Instrument>`, :ref:`LogicalChannel.filterSet <OMERO model class LogicalChannel>`, :ref:`OTF.filterSet <OMERO model class OTF>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | dichroic: :ref:`Dichroic <OMERO model class Dichroic>` (optional)
  | emissionFilterLink: :ref:`FilterSetEmissionFilterLink <OMERO model class FilterSetEmissionFilterLink>` (multiple)
  | excitationFilterLink: :ref:`FilterSetExcitationFilterLink <OMERO model class FilterSetExcitationFilterLink>` (multiple)
  | instrument: :ref:`Instrument <OMERO model class Instrument>`
  | lotNumber: ``string`` (optional)
  | manufacturer: ``string`` (optional)
  | model: ``string`` (optional)
  | serialNumber: ``string`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilterSetEmissionFilterLink:

FilterSetEmissionFilterLink
"""""""""""""""""""""""""""

Used by: :ref:`Filter.emissionFilterLink <OMERO model class Filter>`, :ref:`FilterSet.emissionFilterLink <OMERO model class FilterSet>`

Properties:
  | child: :ref:`Filter <OMERO model class Filter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`FilterSet <OMERO model class FilterSet>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilterSetExcitationFilterLink:

FilterSetExcitationFilterLink
"""""""""""""""""""""""""""""

Used by: :ref:`Filter.excitationFilterLink <OMERO model class Filter>`, :ref:`FilterSet.excitationFilterLink <OMERO model class FilterSet>`

Properties:
  | child: :ref:`Filter <OMERO model class Filter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`FilterSet <OMERO model class FilterSet>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FilterType:

FilterType
""""""""""

Used by: :ref:`Filter.type <OMERO model class Filter>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Folder:

Folder
""""""

Used by: :ref:`Folder.childFolders <OMERO model class Folder>`, :ref:`Folder.parentFolder <OMERO model class Folder>`, :ref:`FolderAnnotationLink.parent <OMERO model class FolderAnnotationLink>`, :ref:`FolderImageLink.parent <OMERO model class FolderImageLink>`, :ref:`FolderRoiLink.parent <OMERO model class FolderRoiLink>`

Properties:
  | annotationLinks: :ref:`FolderAnnotationLink <OMERO model class FolderAnnotationLink>` (multiple)
  | childFolders: :ref:`Folder <OMERO model class Folder>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | imageLinks: :ref:`FolderImageLink <OMERO model class FolderImageLink>` (multiple)
  | name: ``text``
  | parentFolder: :ref:`Folder <OMERO model class Folder>` (optional)
  | roiLinks: :ref:`FolderRoiLink <OMERO model class FolderRoiLink>` (multiple)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FolderAnnotationLink:

FolderAnnotationLink
""""""""""""""""""""

Used by: :ref:`Folder.annotationLinks <OMERO model class Folder>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Folder <OMERO model class Folder>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FolderImageLink:

FolderImageLink
"""""""""""""""

Used by: :ref:`Folder.imageLinks <OMERO model class Folder>`, :ref:`Image.folderLinks <OMERO model class Image>`

Properties:
  | child: :ref:`Image <OMERO model class Image>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Folder <OMERO model class Folder>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class FolderRoiLink:

FolderRoiLink
"""""""""""""

Used by: :ref:`Folder.roiLinks <OMERO model class Folder>`, :ref:`Roi.folderLinks <OMERO model class Roi>`

Properties:
  | child: :ref:`Roi <OMERO model class Roi>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Folder <OMERO model class Folder>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Format:

Format
""""""

Used by: :ref:`Image.format <OMERO model class Image>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class GenericExcitationSource:

GenericExcitationSource
"""""""""""""""""""""""

Properties:
  | annotationLinks: :ref:`LightSourceAnnotationLink <OMERO model class LightSourceAnnotationLink>` (multiple) from :ref:`LightSource <OMERO model class LightSource>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | instrument: :ref:`Instrument <OMERO model class Instrument>` from :ref:`LightSource <OMERO model class LightSource>`
  | lotNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | manufacturer: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | map: list (multiple)
  | model: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.unit: enumeration of :javadoc:`Power <ome/model/units/Power.html>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.value: ``double`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | serialNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | version: ``integer`` (optional) from :ref:`LightSource <OMERO model class LightSource>`

.. _OMERO model class GroupExperimenterMap:

GroupExperimenterMap
""""""""""""""""""""

Used by: :ref:`Experimenter.groupExperimenterMap <OMERO model class Experimenter>`, :ref:`ExperimenterGroup.groupExperimenterMap <OMERO model class ExperimenterGroup>`

Properties:
  | child: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | owner: ``boolean``
  | parent: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Illumination:

Illumination
""""""""""""

Used by: :ref:`LogicalChannel.illumination <OMERO model class LogicalChannel>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Image:

Image
"""""

Used by: :ref:`DatasetImageLink.child <OMERO model class DatasetImageLink>`, :ref:`Fileset.images <OMERO model class Fileset>`, :ref:`FolderImageLink.child <OMERO model class FolderImageLink>`, :ref:`ImageAnnotationLink.parent <OMERO model class ImageAnnotationLink>`, :ref:`Pixels.image <OMERO model class Pixels>`, :ref:`Roi.image <OMERO model class Roi>`, :ref:`WellSample.image <OMERO model class WellSample>`

Properties:
  | acquisitionDate: ``timestamp`` (optional)
  | annotationLinks: :ref:`ImageAnnotationLink <OMERO model class ImageAnnotationLink>` (multiple)
  | archived: ``boolean`` (optional)
  | datasetLinks: :ref:`DatasetImageLink <OMERO model class DatasetImageLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | experiment: :ref:`Experiment <OMERO model class Experiment>` (optional)
  | fileset: :ref:`Fileset <OMERO model class Fileset>` (optional)
  | folderLinks: :ref:`FolderImageLink <OMERO model class FolderImageLink>` (multiple)
  | format: :ref:`Format <OMERO model class Format>` (optional)
  | imagingEnvironment: :ref:`ImagingEnvironment <OMERO model class ImagingEnvironment>` (optional)
  | instrument: :ref:`Instrument <OMERO model class Instrument>` (optional)
  | name: ``text``
  | objectiveSettings: :ref:`ObjectiveSettings <OMERO model class ObjectiveSettings>` (optional)
  | partial: ``boolean`` (optional)
  | pixels: :ref:`Pixels <OMERO model class Pixels>` (multiple)
  | rois: :ref:`Roi <OMERO model class Roi>` (multiple)
  | series: ``integer`` (optional)
  | stageLabel: :ref:`StageLabel <OMERO model class StageLabel>` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | wellSamples: :ref:`WellSample <OMERO model class WellSample>` (multiple)

.. _OMERO model class ImageAnnotationLink:

ImageAnnotationLink
"""""""""""""""""""

Used by: :ref:`Image.annotationLinks <OMERO model class Image>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Image <OMERO model class Image>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ImagingEnvironment:

ImagingEnvironment
""""""""""""""""""

Used by: :ref:`Image.imagingEnvironment <OMERO model class Image>`

Properties:
  | airPressure.unit: enumeration of :javadoc:`Pressure <ome/model/units/Pressure.html>` (optional)
  | airPressure.value: ``double`` (optional)
  | co2percent: ``double`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | humidity: ``double`` (optional)
  | map: list (multiple)
  | temperature.unit: enumeration of :javadoc:`Temperature <ome/model/units/Temperature.html>` (optional)
  | temperature.value: ``double`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Immersion:

Immersion
"""""""""

Used by: :ref:`Objective.immersion <OMERO model class Objective>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class ImportJob:

ImportJob
"""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | imageDescription: ``text``
  | imageName: ``text``
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`

.. _OMERO model class IndexingJob:

IndexingJob
"""""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`

.. _OMERO model class Instrument:

Instrument
""""""""""

Used by: :ref:`Detector.instrument <OMERO model class Detector>`, :ref:`Dichroic.instrument <OMERO model class Dichroic>`, :ref:`Filter.instrument <OMERO model class Filter>`, :ref:`FilterSet.instrument <OMERO model class FilterSet>`, :ref:`Image.instrument <OMERO model class Image>`, :ref:`InstrumentAnnotationLink.parent <OMERO model class InstrumentAnnotationLink>`, :ref:`LightSource.instrument <OMERO model class LightSource>`, :ref:`OTF.instrument <OMERO model class OTF>`, :ref:`Objective.instrument <OMERO model class Objective>`

Properties:
  | annotationLinks: :ref:`InstrumentAnnotationLink <OMERO model class InstrumentAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | detector: :ref:`Detector <OMERO model class Detector>` (multiple)
  | dichroic: :ref:`Dichroic <OMERO model class Dichroic>` (multiple)
  | filter: :ref:`Filter <OMERO model class Filter>` (multiple)
  | filterSet: :ref:`FilterSet <OMERO model class FilterSet>` (multiple)
  | lightSource: :ref:`LightSource <OMERO model class LightSource>` (multiple)
  | microscope: :ref:`Microscope <OMERO model class Microscope>` (optional)
  | objective: :ref:`Objective <OMERO model class Objective>` (multiple)
  | otf: :ref:`OTF <OMERO model class OTF>` (multiple)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class InstrumentAnnotationLink:

InstrumentAnnotationLink
""""""""""""""""""""""""

Used by: :ref:`Instrument.annotationLinks <OMERO model class Instrument>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Instrument <OMERO model class Instrument>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class IntegrityCheckJob:

IntegrityCheckJob
"""""""""""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`

.. _OMERO model class Job:

Job
"""

Subclasses: :ref:`ImportJob <OMERO model class ImportJob>`, :ref:`IndexingJob <OMERO model class IndexingJob>`, :ref:`IntegrityCheckJob <OMERO model class IntegrityCheckJob>`, :ref:`MetadataImportJob <OMERO model class MetadataImportJob>`, :ref:`ParseJob <OMERO model class ParseJob>`, :ref:`PixelDataJob <OMERO model class PixelDataJob>`, :ref:`ScriptJob <OMERO model class ScriptJob>`, :ref:`ThumbnailGenerationJob <OMERO model class ThumbnailGenerationJob>`, :ref:`UploadJob <OMERO model class UploadJob>`

Used by: :ref:`FilesetJobLink.child <OMERO model class FilesetJobLink>`, :ref:`JobOriginalFileLink.parent <OMERO model class JobOriginalFileLink>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | finished: ``timestamp`` (optional)
  | groupname: ``string``
  | message: ``string``
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple)
  | scheduledFor: ``timestamp``
  | started: ``timestamp`` (optional)
  | status: :ref:`JobStatus <OMERO model class JobStatus>`
  | submitted: ``timestamp``
  | type: ``string``
  | username: ``string``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class JobOriginalFileLink:

JobOriginalFileLink
"""""""""""""""""""

Used by: :ref:`Job.originalFileLinks <OMERO model class Job>`

Properties:
  | child: :ref:`OriginalFile <OMERO model class OriginalFile>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Job <OMERO model class Job>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class JobStatus:

JobStatus
"""""""""

Used by: :ref:`Job.status <OMERO model class Job>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Label:

Label
"""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | x: ``double`` (optional)
  | y: ``double`` (optional)

.. _OMERO model class Laser:

Laser
"""""

Properties:
  | annotationLinks: :ref:`LightSourceAnnotationLink <OMERO model class LightSourceAnnotationLink>` (multiple) from :ref:`LightSource <OMERO model class LightSource>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | frequencyMultiplication: ``integer`` (optional)
  | instrument: :ref:`Instrument <OMERO model class Instrument>` from :ref:`LightSource <OMERO model class LightSource>`
  | laserMedium: :ref:`LaserMedium <OMERO model class LaserMedium>`
  | lotNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | manufacturer: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | model: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | pockelCell: ``boolean`` (optional)
  | power.unit: enumeration of :javadoc:`Power <ome/model/units/Power.html>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.value: ``double`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | pulse: :ref:`Pulse <OMERO model class Pulse>` (optional)
  | pump: :ref:`LightSource <OMERO model class LightSource>` (optional)
  | repetitionRate.unit: enumeration of :javadoc:`Frequency <ome/model/units/Frequency.html>` (optional)
  | repetitionRate.value: ``double`` (optional)
  | serialNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | tuneable: ``boolean`` (optional)
  | type: :ref:`LaserType <OMERO model class LaserType>`
  | version: ``integer`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | wavelength.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | wavelength.value: ``double`` (optional)

.. _OMERO model class LaserMedium:

LaserMedium
"""""""""""

Used by: :ref:`Laser.laserMedium <OMERO model class Laser>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class LaserType:

LaserType
"""""""""

Used by: :ref:`Laser.type <OMERO model class Laser>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class LightEmittingDiode:

LightEmittingDiode
""""""""""""""""""

Properties:
  | annotationLinks: :ref:`LightSourceAnnotationLink <OMERO model class LightSourceAnnotationLink>` (multiple) from :ref:`LightSource <OMERO model class LightSource>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`LightSource <OMERO model class LightSource>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`LightSource <OMERO model class LightSource>`
  | instrument: :ref:`Instrument <OMERO model class Instrument>` from :ref:`LightSource <OMERO model class LightSource>`
  | lotNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | manufacturer: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | model: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.unit: enumeration of :javadoc:`Power <ome/model/units/Power.html>` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | power.value: ``double`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | serialNumber: ``string`` (optional) from :ref:`LightSource <OMERO model class LightSource>`
  | version: ``integer`` (optional) from :ref:`LightSource <OMERO model class LightSource>`

.. _OMERO model class LightPath:

LightPath
"""""""""

Used by: :ref:`LightPathAnnotationLink.parent <OMERO model class LightPathAnnotationLink>`, :ref:`LightPathEmissionFilterLink.parent <OMERO model class LightPathEmissionFilterLink>`, :ref:`LightPathExcitationFilterLink.parent <OMERO model class LightPathExcitationFilterLink>`, :ref:`LogicalChannel.lightPath <OMERO model class LogicalChannel>`

Properties:
  | annotationLinks: :ref:`LightPathAnnotationLink <OMERO model class LightPathAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | dichroic: :ref:`Dichroic <OMERO model class Dichroic>` (optional)
  | emissionFilterLink: :ref:`LightPathEmissionFilterLink <OMERO model class LightPathEmissionFilterLink>` (multiple)
  | excitationFilterLink: :ref:`LightPathExcitationFilterLink <OMERO model class LightPathExcitationFilterLink>` (multiple)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class LightPathAnnotationLink:

LightPathAnnotationLink
"""""""""""""""""""""""

Used by: :ref:`LightPath.annotationLinks <OMERO model class LightPath>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`LightPath <OMERO model class LightPath>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class LightPathEmissionFilterLink:

LightPathEmissionFilterLink
"""""""""""""""""""""""""""

Used by: :ref:`LightPath.emissionFilterLink <OMERO model class LightPath>`

Properties:
  | child: :ref:`Filter <OMERO model class Filter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`LightPath <OMERO model class LightPath>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class LightPathExcitationFilterLink:

LightPathExcitationFilterLink
"""""""""""""""""""""""""""""

Used by: :ref:`LightPath.excitationFilterLink <OMERO model class LightPath>`

Properties:
  | child: :ref:`Filter <OMERO model class Filter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`LightPath <OMERO model class LightPath>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class LightSettings:

LightSettings
"""""""""""""

Used by: :ref:`LogicalChannel.lightSourceSettings <OMERO model class LogicalChannel>`, :ref:`MicrobeamManipulation.lightSourceSettings <OMERO model class MicrobeamManipulation>`

Properties:
  | attenuation: ``double`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | lightSource: :ref:`LightSource <OMERO model class LightSource>`
  | microbeamManipulation: :ref:`MicrobeamManipulation <OMERO model class MicrobeamManipulation>` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | wavelength.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | wavelength.value: ``double`` (optional)

.. _OMERO model class LightSource:

LightSource
"""""""""""

Subclasses: :ref:`Arc <OMERO model class Arc>`, :ref:`Filament <OMERO model class Filament>`, :ref:`GenericExcitationSource <OMERO model class GenericExcitationSource>`, :ref:`Laser <OMERO model class Laser>`, :ref:`LightEmittingDiode <OMERO model class LightEmittingDiode>`

Used by: :ref:`Instrument.lightSource <OMERO model class Instrument>`, :ref:`Laser.pump <OMERO model class Laser>`, :ref:`LightSettings.lightSource <OMERO model class LightSettings>`, :ref:`LightSourceAnnotationLink.parent <OMERO model class LightSourceAnnotationLink>`

Properties:
  | annotationLinks: :ref:`LightSourceAnnotationLink <OMERO model class LightSourceAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | instrument: :ref:`Instrument <OMERO model class Instrument>`
  | lotNumber: ``string`` (optional)
  | manufacturer: ``string`` (optional)
  | model: ``string`` (optional)
  | power.unit: enumeration of :javadoc:`Power <ome/model/units/Power.html>` (optional)
  | power.value: ``double`` (optional)
  | serialNumber: ``string`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class LightSourceAnnotationLink:

LightSourceAnnotationLink
"""""""""""""""""""""""""

Used by: :ref:`LightSource.annotationLinks <OMERO model class LightSource>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`LightSource <OMERO model class LightSource>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Line:

Line
""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | markerEnd: ``string`` (optional)
  | markerStart: ``string`` (optional)
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | x1: ``double`` (optional)
  | x2: ``double`` (optional)
  | y1: ``double`` (optional)
  | y2: ``double`` (optional)

.. _OMERO model class Link:

Link
""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ListAnnotation:

ListAnnotation
""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class LogicalChannel:

LogicalChannel
""""""""""""""

Used by: :ref:`Channel.logicalChannel <OMERO model class Channel>`

Properties:
  | channels: :ref:`Channel <OMERO model class Channel>` (multiple)
  | contrastMethod: :ref:`ContrastMethod <OMERO model class ContrastMethod>` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | detectorSettings: :ref:`DetectorSettings <OMERO model class DetectorSettings>` (optional)
  | emissionWave.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | emissionWave.value: ``double`` (optional)
  | excitationWave.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | excitationWave.value: ``double`` (optional)
  | filterSet: :ref:`FilterSet <OMERO model class FilterSet>` (optional)
  | fluor: ``string`` (optional)
  | illumination: :ref:`Illumination <OMERO model class Illumination>` (optional)
  | lightPath: :ref:`LightPath <OMERO model class LightPath>` (optional)
  | lightSourceSettings: :ref:`LightSettings <OMERO model class LightSettings>` (optional)
  | mode: :ref:`AcquisitionMode <OMERO model class AcquisitionMode>` (optional)
  | name: ``text`` (optional)
  | ndFilter: ``double`` (optional)
  | otf: :ref:`OTF <OMERO model class OTF>` (optional)
  | photometricInterpretation: :ref:`PhotometricInterpretation <OMERO model class PhotometricInterpretation>` (optional)
  | pinHoleSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | pinHoleSize.value: ``double`` (optional)
  | pockelCellSetting: ``integer`` (optional)
  | samplesPerPixel: ``integer`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class LongAnnotation:

LongAnnotation
""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | longValue: ``long`` (optional)
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class MapAnnotation:

MapAnnotation
"""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | mapValue: list (multiple)
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class Mask:

Mask
""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | bytes: ``binary`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | height: ``double`` (optional)
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | pixels: :ref:`Pixels <OMERO model class Pixels>` (optional)
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | width: ``double`` (optional)
  | x: ``double`` (optional)
  | y: ``double`` (optional)

.. _OMERO model class Medium:

Medium
""""""

Used by: :ref:`ObjectiveSettings.medium <OMERO model class ObjectiveSettings>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class MetadataImportJob:

MetadataImportJob
"""""""""""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`
  | versionInfo: list (multiple)

.. _OMERO model class MicrobeamManipulation:

MicrobeamManipulation
"""""""""""""""""""""

Used by: :ref:`Experiment.microbeamManipulation <OMERO model class Experiment>`, :ref:`LightSettings.microbeamManipulation <OMERO model class LightSettings>`

Properties:
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | experiment: :ref:`Experiment <OMERO model class Experiment>`
  | lightSourceSettings: :ref:`LightSettings <OMERO model class LightSettings>` (multiple)
  | type: :ref:`MicrobeamManipulationType <OMERO model class MicrobeamManipulationType>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class MicrobeamManipulationType:

MicrobeamManipulationType
"""""""""""""""""""""""""

Used by: :ref:`MicrobeamManipulation.type <OMERO model class MicrobeamManipulation>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Microscope:

Microscope
""""""""""

Used by: :ref:`Instrument.microscope <OMERO model class Instrument>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | lotNumber: ``string`` (optional)
  | manufacturer: ``string`` (optional)
  | model: ``string`` (optional)
  | serialNumber: ``string`` (optional)
  | type: :ref:`MicroscopeType <OMERO model class MicroscopeType>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class MicroscopeType:

MicroscopeType
""""""""""""""

Used by: :ref:`Microscope.type <OMERO model class Microscope>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Namespace:

Namespace
"""""""""

Used by: :ref:`NamespaceAnnotationLink.parent <OMERO model class NamespaceAnnotationLink>`

Properties:
  | annotationLinks: :ref:`NamespaceAnnotationLink <OMERO model class NamespaceAnnotationLink>` (multiple)
  | description: ``text`` (optional)
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | display: ``boolean`` (optional)
  | displayName: ``text`` (optional)
  | keywords: list (optional)
  | multivalued: ``boolean`` (optional)
  | name: ``text``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class NamespaceAnnotationLink:

NamespaceAnnotationLink
"""""""""""""""""""""""

Used by: :ref:`Namespace.annotationLinks <OMERO model class Namespace>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Namespace <OMERO model class Namespace>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Node:

Node
""""

Used by: :ref:`NodeAnnotationLink.parent <OMERO model class NodeAnnotationLink>`, :ref:`Session.node <OMERO model class Session>`

Properties:
  | annotationLinks: :ref:`NodeAnnotationLink <OMERO model class NodeAnnotationLink>` (multiple)
  | conn: ``text``
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | down: ``timestamp`` (optional)
  | scale: ``integer`` (optional)
  | sessions: :ref:`Session <OMERO model class Session>` (multiple)
  | up: ``timestamp``
  | uuid: ``string``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class NodeAnnotationLink:

NodeAnnotationLink
""""""""""""""""""

Used by: :ref:`Node.annotationLinks <OMERO model class Node>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Node <OMERO model class Node>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class NumericAnnotation:

NumericAnnotation
"""""""""""""""""

Subclasses: :ref:`DoubleAnnotation <OMERO model class DoubleAnnotation>`, :ref:`LongAnnotation <OMERO model class LongAnnotation>`

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class OTF:

OTF
"""

Used by: :ref:`Instrument.otf <OMERO model class Instrument>`, :ref:`LogicalChannel.otf <OMERO model class LogicalChannel>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | filterSet: :ref:`FilterSet <OMERO model class FilterSet>` (optional)
  | instrument: :ref:`Instrument <OMERO model class Instrument>`
  | objective: :ref:`Objective <OMERO model class Objective>`
  | opticalAxisAveraged: ``boolean``
  | path: ``string``
  | pixelsType: :ref:`PixelsType <OMERO model class PixelsType>`
  | sizeX: ``integer``
  | sizeY: ``integer``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Objective:

Objective
"""""""""

Used by: :ref:`Instrument.objective <OMERO model class Instrument>`, :ref:`OTF.objective <OMERO model class OTF>`, :ref:`ObjectiveAnnotationLink.parent <OMERO model class ObjectiveAnnotationLink>`, :ref:`ObjectiveSettings.objective <OMERO model class ObjectiveSettings>`

Properties:
  | annotationLinks: :ref:`ObjectiveAnnotationLink <OMERO model class ObjectiveAnnotationLink>` (multiple)
  | calibratedMagnification: ``double`` (optional)
  | correction: :ref:`Correction <OMERO model class Correction>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | immersion: :ref:`Immersion <OMERO model class Immersion>`
  | instrument: :ref:`Instrument <OMERO model class Instrument>`
  | iris: ``boolean`` (optional)
  | lensNA: ``double`` (optional)
  | lotNumber: ``string`` (optional)
  | manufacturer: ``string`` (optional)
  | model: ``string`` (optional)
  | nominalMagnification: ``double`` (optional)
  | serialNumber: ``string`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | workingDistance.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | workingDistance.value: ``double`` (optional)

.. _OMERO model class ObjectiveAnnotationLink:

ObjectiveAnnotationLink
"""""""""""""""""""""""

Used by: :ref:`Objective.annotationLinks <OMERO model class Objective>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Objective <OMERO model class Objective>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ObjectiveSettings:

ObjectiveSettings
"""""""""""""""""

Used by: :ref:`Image.objectiveSettings <OMERO model class Image>`

Properties:
  | correctionCollar: ``double`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | medium: :ref:`Medium <OMERO model class Medium>` (optional)
  | objective: :ref:`Objective <OMERO model class Objective>`
  | refractiveIndex: ``double`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class OriginalFile:

OriginalFile
""""""""""""

Used by: :ref:`FileAnnotation.file <OMERO model class FileAnnotation>`, :ref:`FilesetEntry.originalFile <OMERO model class FilesetEntry>`, :ref:`JobOriginalFileLink.child <OMERO model class JobOriginalFileLink>`, :ref:`OriginalFileAnnotationLink.parent <OMERO model class OriginalFileAnnotationLink>`, :ref:`PixelsOriginalFileMap.parent <OMERO model class PixelsOriginalFileMap>`, :ref:`Roi.source <OMERO model class Roi>`

Properties:
  | annotationLinks: :ref:`OriginalFileAnnotationLink <OMERO model class OriginalFileAnnotationLink>` (multiple)
  | atime: ``timestamp`` (optional)
  | ctime: ``timestamp`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | filesetEntries: :ref:`FilesetEntry <OMERO model class FilesetEntry>` (multiple)
  | hash: ``text`` (optional)
  | hasher: :ref:`ChecksumAlgorithm <OMERO model class ChecksumAlgorithm>` (optional)
  | mimetype: ``string`` (optional)
  | mtime: ``timestamp`` (optional)
  | name: ``text``
  | path: ``text``
  | pixelsFileMaps: :ref:`PixelsOriginalFileMap <OMERO model class PixelsOriginalFileMap>` (multiple)
  | repo: ``string`` (optional)
  | size: ``long`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class OriginalFileAnnotationLink:

OriginalFileAnnotationLink
""""""""""""""""""""""""""

Used by: :ref:`OriginalFile.annotationLinks <OMERO model class OriginalFile>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`OriginalFile <OMERO model class OriginalFile>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ParseJob:

ParseJob
""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | params: ``binary`` (optional)
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`

.. _OMERO model class Path:

Path
""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | d: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`

.. _OMERO model class PhotometricInterpretation:

PhotometricInterpretation
"""""""""""""""""""""""""

Used by: :ref:`LogicalChannel.photometricInterpretation <OMERO model class LogicalChannel>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class PixelDataJob:

PixelDataJob
""""""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`

.. _OMERO model class Pixels:

Pixels
""""""

Used by: :ref:`Channel.pixels <OMERO model class Channel>`, :ref:`Image.pixels <OMERO model class Image>`, :ref:`Mask.pixels <OMERO model class Mask>`, :ref:`Pixels.relatedTo <OMERO model class Pixels>`, :ref:`PixelsOriginalFileMap.child <OMERO model class PixelsOriginalFileMap>`, :ref:`PlaneInfo.pixels <OMERO model class PlaneInfo>`, :ref:`RenderingDef.pixels <OMERO model class RenderingDef>`, :ref:`Thumbnail.pixels <OMERO model class Thumbnail>`

Properties:
  | channels: :ref:`Channel <OMERO model class Channel>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | dimensionOrder: :ref:`DimensionOrder <OMERO model class DimensionOrder>`
  | image: :ref:`Image <OMERO model class Image>`
  | methodology: ``string`` (optional)
  | physicalSizeX.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | physicalSizeX.value: ``double`` (optional)
  | physicalSizeY.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | physicalSizeY.value: ``double`` (optional)
  | physicalSizeZ.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | physicalSizeZ.value: ``double`` (optional)
  | pixelsFileMaps: :ref:`PixelsOriginalFileMap <OMERO model class PixelsOriginalFileMap>` (multiple)
  | pixelsType: :ref:`PixelsType <OMERO model class PixelsType>`
  | planeInfo: :ref:`PlaneInfo <OMERO model class PlaneInfo>` (multiple)
  | relatedTo: :ref:`Pixels <OMERO model class Pixels>` (optional)
  | settings: :ref:`RenderingDef <OMERO model class RenderingDef>` (multiple)
  | sha1: ``string``
  | significantBits: ``integer`` (optional)
  | sizeC: ``integer``
  | sizeT: ``integer``
  | sizeX: ``integer``
  | sizeY: ``integer``
  | sizeZ: ``integer``
  | thumbnails: :ref:`Thumbnail <OMERO model class Thumbnail>` (multiple)
  | timeIncrement.unit: enumeration of :javadoc:`Time <ome/model/units/Time.html>` (optional)
  | timeIncrement.value: ``double`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | waveIncrement: ``integer`` (optional)
  | waveStart: ``integer`` (optional)

.. _OMERO model class PixelsOriginalFileMap:

PixelsOriginalFileMap
"""""""""""""""""""""

Used by: :ref:`OriginalFile.pixelsFileMaps <OMERO model class OriginalFile>`, :ref:`Pixels.pixelsFileMaps <OMERO model class Pixels>`

Properties:
  | child: :ref:`Pixels <OMERO model class Pixels>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`OriginalFile <OMERO model class OriginalFile>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class PixelsType:

PixelsType
""""""""""

Used by: :ref:`OTF.pixelsType <OMERO model class OTF>`, :ref:`Pixels.pixelsType <OMERO model class Pixels>`

Properties:
  | bitSize: ``integer`` (optional)
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class PlaneInfo:

PlaneInfo
"""""""""

Used by: :ref:`Pixels.planeInfo <OMERO model class Pixels>`, :ref:`PlaneInfoAnnotationLink.parent <OMERO model class PlaneInfoAnnotationLink>`

Properties:
  | annotationLinks: :ref:`PlaneInfoAnnotationLink <OMERO model class PlaneInfoAnnotationLink>` (multiple)
  | deltaT.unit: enumeration of :javadoc:`Time <ome/model/units/Time.html>` (optional)
  | deltaT.value: ``double`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | exposureTime.unit: enumeration of :javadoc:`Time <ome/model/units/Time.html>` (optional)
  | exposureTime.value: ``double`` (optional)
  | pixels: :ref:`Pixels <OMERO model class Pixels>`
  | positionX.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | positionX.value: ``double`` (optional)
  | positionY.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | positionY.value: ``double`` (optional)
  | positionZ.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | positionZ.value: ``double`` (optional)
  | theC: ``integer``
  | theT: ``integer``
  | theZ: ``integer``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class PlaneInfoAnnotationLink:

PlaneInfoAnnotationLink
"""""""""""""""""""""""

Used by: :ref:`PlaneInfo.annotationLinks <OMERO model class PlaneInfo>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`PlaneInfo <OMERO model class PlaneInfo>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class PlaneSlicingContext:

PlaneSlicingContext
"""""""""""""""""""

Properties:
  | channelBinding: :ref:`ChannelBinding <OMERO model class ChannelBinding>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | constant: ``boolean``
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | lowerLimit: ``integer``
  | planePrevious: ``integer``
  | planeSelected: ``integer``
  | upperLimit: ``integer``
  | version: ``integer`` (optional) from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`

.. _OMERO model class Plate:

Plate
"""""

Used by: :ref:`PlateAcquisition.plate <OMERO model class PlateAcquisition>`, :ref:`PlateAnnotationLink.parent <OMERO model class PlateAnnotationLink>`, :ref:`ScreenPlateLink.child <OMERO model class ScreenPlateLink>`, :ref:`Well.plate <OMERO model class Well>`

Properties:
  | annotationLinks: :ref:`PlateAnnotationLink <OMERO model class PlateAnnotationLink>` (multiple)
  | columnNamingConvention: ``string`` (optional)
  | columns: ``integer`` (optional)
  | defaultSample: ``integer`` (optional)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | externalIdentifier: ``string`` (optional)
  | name: ``text``
  | plateAcquisitions: :ref:`PlateAcquisition <OMERO model class PlateAcquisition>` (multiple)
  | rowNamingConvention: ``string`` (optional)
  | rows: ``integer`` (optional)
  | screenLinks: :ref:`ScreenPlateLink <OMERO model class ScreenPlateLink>` (multiple)
  | status: ``text`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | wellOriginX.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | wellOriginX.value: ``double`` (optional)
  | wellOriginY.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | wellOriginY.value: ``double`` (optional)
  | wells: :ref:`Well <OMERO model class Well>` (multiple)

.. _OMERO model class PlateAcquisition:

PlateAcquisition
""""""""""""""""

Used by: :ref:`Plate.plateAcquisitions <OMERO model class Plate>`, :ref:`PlateAcquisitionAnnotationLink.parent <OMERO model class PlateAcquisitionAnnotationLink>`, :ref:`WellSample.plateAcquisition <OMERO model class WellSample>`

Properties:
  | annotationLinks: :ref:`PlateAcquisitionAnnotationLink <OMERO model class PlateAcquisitionAnnotationLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | endTime: ``timestamp`` (optional)
  | maximumFieldCount: ``integer`` (optional)
  | name: ``text`` (optional)
  | plate: :ref:`Plate <OMERO model class Plate>`
  | startTime: ``timestamp`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | wellSample: :ref:`WellSample <OMERO model class WellSample>` (multiple)

.. _OMERO model class PlateAcquisitionAnnotationLink:

PlateAcquisitionAnnotationLink
""""""""""""""""""""""""""""""

Used by: :ref:`PlateAcquisition.annotationLinks <OMERO model class PlateAcquisition>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`PlateAcquisition <OMERO model class PlateAcquisition>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class PlateAnnotationLink:

PlateAnnotationLink
"""""""""""""""""""

Used by: :ref:`Plate.annotationLinks <OMERO model class Plate>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Plate <OMERO model class Plate>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Point:

Point
"""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | x: ``double`` (optional)
  | y: ``double`` (optional)

.. _OMERO model class Polygon:

Polygon
"""""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | points: ``text`` (optional)
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`

.. _OMERO model class Polyline:

Polyline
""""""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | markerEnd: ``string`` (optional)
  | markerStart: ``string`` (optional)
  | points: ``text`` (optional)
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`

.. _OMERO model class Project:

Project
"""""""

Used by: :ref:`ProjectAnnotationLink.parent <OMERO model class ProjectAnnotationLink>`, :ref:`ProjectDatasetLink.parent <OMERO model class ProjectDatasetLink>`

Properties:
  | annotationLinks: :ref:`ProjectAnnotationLink <OMERO model class ProjectAnnotationLink>` (multiple)
  | datasetLinks: :ref:`ProjectDatasetLink <OMERO model class ProjectDatasetLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | name: ``text``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ProjectAnnotationLink:

ProjectAnnotationLink
"""""""""""""""""""""

Used by: :ref:`Project.annotationLinks <OMERO model class Project>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Project <OMERO model class Project>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ProjectDatasetLink:

ProjectDatasetLink
""""""""""""""""""

Used by: :ref:`Dataset.projectLinks <OMERO model class Dataset>`, :ref:`Project.datasetLinks <OMERO model class Project>`

Properties:
  | child: :ref:`Dataset <OMERO model class Dataset>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Project <OMERO model class Project>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ProjectionAxis:

ProjectionAxis
""""""""""""""

Used by: :ref:`ProjectionDef.axis <OMERO model class ProjectionDef>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class ProjectionDef:

ProjectionDef
"""""""""""""

Used by: :ref:`RenderingDef.projections <OMERO model class RenderingDef>`

Properties:
  | active: ``boolean``
  | axis: :ref:`ProjectionAxis <OMERO model class ProjectionAxis>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | endPlane: ``integer`` (optional)
  | renderingDef: :ref:`RenderingDef <OMERO model class RenderingDef>`
  | startPlane: ``integer`` (optional)
  | stepping: ``integer`` (optional)
  | type: :ref:`ProjectionType <OMERO model class ProjectionType>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ProjectionType:

ProjectionType
""""""""""""""

Used by: :ref:`ProjectionDef.type <OMERO model class ProjectionDef>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class Pulse:

Pulse
"""""

Used by: :ref:`Laser.pulse <OMERO model class Laser>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class QuantumDef:

QuantumDef
""""""""""

Used by: :ref:`RenderingDef.quantization <OMERO model class RenderingDef>`

Properties:
  | bitResolution: ``integer``
  | cdEnd: ``integer``
  | cdStart: ``integer``
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Reagent:

Reagent
"""""""

Used by: :ref:`ReagentAnnotationLink.parent <OMERO model class ReagentAnnotationLink>`, :ref:`Screen.reagents <OMERO model class Screen>`, :ref:`WellReagentLink.child <OMERO model class WellReagentLink>`

Properties:
  | annotationLinks: :ref:`ReagentAnnotationLink <OMERO model class ReagentAnnotationLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | name: ``text`` (optional)
  | reagentIdentifier: ``string`` (optional)
  | screen: :ref:`Screen <OMERO model class Screen>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | wellLinks: :ref:`WellReagentLink <OMERO model class WellReagentLink>` (multiple)

.. _OMERO model class ReagentAnnotationLink:

ReagentAnnotationLink
"""""""""""""""""""""

Used by: :ref:`Reagent.annotationLinks <OMERO model class Reagent>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Reagent <OMERO model class Reagent>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Rectangle:

Rectangle
"""""""""

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple) from :ref:`Shape <OMERO model class Shape>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Shape <OMERO model class Shape>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Shape <OMERO model class Shape>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Shape <OMERO model class Shape>`
  | fillColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fillRule: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontFamily: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontSize.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | fontStyle: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | height: ``double`` (optional)
  | locked: ``boolean`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | roi: :ref:`Roi <OMERO model class Roi>` from :ref:`Shape <OMERO model class Shape>`
  | strokeColor: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeDashArray: ``string`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | strokeWidth.value: ``double`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | textValue: ``text`` (optional)
  | theC: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theT: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | theZ: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional) from :ref:`Shape <OMERO model class Shape>`
  | version: ``integer`` (optional) from :ref:`Shape <OMERO model class Shape>`
  | width: ``double`` (optional)
  | x: ``double`` (optional)
  | y: ``double`` (optional)

.. _OMERO model class RenderingDef:

RenderingDef
""""""""""""

Used by: :ref:`ChannelBinding.renderingDef <OMERO model class ChannelBinding>`, :ref:`Pixels.settings <OMERO model class Pixels>`, :ref:`ProjectionDef.renderingDef <OMERO model class ProjectionDef>`

Properties:
  | compression: ``double`` (optional)
  | defaultT: ``integer``
  | defaultZ: ``integer``
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | model: :ref:`RenderingModel <OMERO model class RenderingModel>`
  | name: ``text`` (optional)
  | pixels: :ref:`Pixels <OMERO model class Pixels>`
  | projections: :ref:`ProjectionDef <OMERO model class ProjectionDef>` (multiple)
  | quantization: :ref:`QuantumDef <OMERO model class QuantumDef>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | waveRendering: :ref:`ChannelBinding <OMERO model class ChannelBinding>` (multiple)

.. _OMERO model class RenderingModel:

RenderingModel
""""""""""""""

Used by: :ref:`RenderingDef.model <OMERO model class RenderingDef>`

Properties:
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | value: ``string``, see :javadoc:`IEnum <ome/model/IEnum.html>`

.. _OMERO model class ReverseIntensityContext:

ReverseIntensityContext
"""""""""""""""""""""""

Properties:
  | channelBinding: :ref:`ChannelBinding <OMERO model class ChannelBinding>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`
  | reverse: ``boolean``
  | version: ``integer`` (optional) from :ref:`CodomainMapContext <OMERO model class CodomainMapContext>`

.. _OMERO model class Roi:

Roi
"""

Used by: :ref:`FolderRoiLink.child <OMERO model class FolderRoiLink>`, :ref:`Image.rois <OMERO model class Image>`, :ref:`RoiAnnotationLink.parent <OMERO model class RoiAnnotationLink>`, :ref:`Shape.roi <OMERO model class Shape>`

Properties:
  | annotationLinks: :ref:`RoiAnnotationLink <OMERO model class RoiAnnotationLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | folderLinks: :ref:`FolderRoiLink <OMERO model class FolderRoiLink>` (multiple)
  | image: :ref:`Image <OMERO model class Image>` (optional)
  | name: ``text`` (optional)
  | shapes: :ref:`Shape <OMERO model class Shape>` (multiple)
  | source: :ref:`OriginalFile <OMERO model class OriginalFile>` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class RoiAnnotationLink:

RoiAnnotationLink
"""""""""""""""""

Used by: :ref:`Roi.annotationLinks <OMERO model class Roi>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Roi <OMERO model class Roi>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Screen:

Screen
""""""

Used by: :ref:`Reagent.screen <OMERO model class Reagent>`, :ref:`ScreenAnnotationLink.parent <OMERO model class ScreenAnnotationLink>`, :ref:`ScreenPlateLink.parent <OMERO model class ScreenPlateLink>`

Properties:
  | annotationLinks: :ref:`ScreenAnnotationLink <OMERO model class ScreenAnnotationLink>` (multiple)
  | description: ``text`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | name: ``text``
  | plateLinks: :ref:`ScreenPlateLink <OMERO model class ScreenPlateLink>` (multiple)
  | protocolDescription: ``text`` (optional)
  | protocolIdentifier: ``string`` (optional)
  | reagentSetDescription: ``text`` (optional)
  | reagentSetIdentifier: ``string`` (optional)
  | reagents: :ref:`Reagent <OMERO model class Reagent>` (multiple)
  | type: ``string`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ScreenAnnotationLink:

ScreenAnnotationLink
""""""""""""""""""""

Used by: :ref:`Screen.annotationLinks <OMERO model class Screen>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Screen <OMERO model class Screen>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ScreenPlateLink:

ScreenPlateLink
"""""""""""""""

Used by: :ref:`Plate.screenLinks <OMERO model class Plate>`, :ref:`Screen.plateLinks <OMERO model class Screen>`

Properties:
  | child: :ref:`Plate <OMERO model class Plate>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Screen <OMERO model class Screen>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ScriptJob:

ScriptJob
"""""""""

Properties:
  | description: ``string`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`

.. _OMERO model class Session:

Session
"""""""

Subclasses: :ref:`Share <OMERO model class Share>`

Used by: :ref:`Event.session <OMERO model class Event>`, :ref:`Node.sessions <OMERO model class Node>`, :ref:`SessionAnnotationLink.parent <OMERO model class SessionAnnotationLink>`

Properties:
  | annotationLinks: :ref:`SessionAnnotationLink <OMERO model class SessionAnnotationLink>` (multiple)
  | closed: ``timestamp`` (optional)
  | defaultEventType: ``string``
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | events: :ref:`Event <OMERO model class Event>` (multiple)
  | message: ``text`` (optional)
  | node: :ref:`Node <OMERO model class Node>`
  | owner: :ref:`Experimenter <OMERO model class Experimenter>`
  | started: ``timestamp``
  | sudoer: :ref:`Experimenter <OMERO model class Experimenter>` (optional)
  | timeToIdle: ``long``
  | timeToLive: ``long``
  | userAgent: ``string`` (optional)
  | userIP: ``string`` (optional)
  | uuid: ``string``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class SessionAnnotationLink:

SessionAnnotationLink
"""""""""""""""""""""

Used by: :ref:`Session.annotationLinks <OMERO model class Session>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Session <OMERO model class Session>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Shape:

Shape
"""""

Subclasses: :ref:`Ellipse <OMERO model class Ellipse>`, :ref:`Label <OMERO model class Label>`, :ref:`Line <OMERO model class Line>`, :ref:`Mask <OMERO model class Mask>`, :ref:`Path <OMERO model class Path>`, :ref:`Point <OMERO model class Point>`, :ref:`Polygon <OMERO model class Polygon>`, :ref:`Polyline <OMERO model class Polyline>`, :ref:`Rectangle <OMERO model class Rectangle>`

Used by: :ref:`Roi.shapes <OMERO model class Roi>`, :ref:`ShapeAnnotationLink.parent <OMERO model class ShapeAnnotationLink>`

Properties:
  | annotationLinks: :ref:`ShapeAnnotationLink <OMERO model class ShapeAnnotationLink>` (multiple)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | fillColor: ``integer`` (optional)
  | fillRule: ``string`` (optional)
  | fontFamily: ``string`` (optional)
  | fontSize.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | fontSize.value: ``double`` (optional)
  | fontStyle: ``string`` (optional)
  | locked: ``boolean`` (optional)
  | roi: :ref:`Roi <OMERO model class Roi>`
  | strokeColor: ``integer`` (optional)
  | strokeDashArray: ``string`` (optional)
  | strokeWidth.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | strokeWidth.value: ``double`` (optional)
  | theC: ``integer`` (optional)
  | theT: ``integer`` (optional)
  | theZ: ``integer`` (optional)
  | transform: :ref:`AffineTransform <OMERO model class AffineTransform>` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ShapeAnnotationLink:

ShapeAnnotationLink
"""""""""""""""""""

Used by: :ref:`Shape.annotationLinks <OMERO model class Shape>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Shape <OMERO model class Shape>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class Share:

Share
"""""

Used by: :ref:`ShareMember.parent <OMERO model class ShareMember>`

Properties:
  | active: ``boolean``
  | annotationLinks: :ref:`SessionAnnotationLink <OMERO model class SessionAnnotationLink>` (multiple) from :ref:`Session <OMERO model class Session>`
  | closed: ``timestamp`` (optional) from :ref:`Session <OMERO model class Session>`
  | data: ``binary``
  | defaultEventType: ``string`` from :ref:`Session <OMERO model class Session>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Session <OMERO model class Session>`
  | events: :ref:`Event <OMERO model class Event>` (multiple) from :ref:`Session <OMERO model class Session>`
  | group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`
  | itemCount: ``long``
  | message: ``text`` (optional) from :ref:`Session <OMERO model class Session>`
  | node: :ref:`Node <OMERO model class Node>` from :ref:`Session <OMERO model class Session>`
  | owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Session <OMERO model class Session>`
  | started: ``timestamp`` from :ref:`Session <OMERO model class Session>`
  | sudoer: :ref:`Experimenter <OMERO model class Experimenter>` (optional) from :ref:`Session <OMERO model class Session>`
  | timeToIdle: ``long`` from :ref:`Session <OMERO model class Session>`
  | timeToLive: ``long`` from :ref:`Session <OMERO model class Session>`
  | userAgent: ``string`` (optional) from :ref:`Session <OMERO model class Session>`
  | userIP: ``string`` (optional) from :ref:`Session <OMERO model class Session>`
  | uuid: ``string`` from :ref:`Session <OMERO model class Session>`
  | version: ``integer`` (optional) from :ref:`Session <OMERO model class Session>`

.. _OMERO model class ShareMember:

ShareMember
"""""""""""

Properties:
  | child: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Share <OMERO model class Share>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class StageLabel:

StageLabel
""""""""""

Used by: :ref:`Image.stageLabel <OMERO model class Image>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | name: ``text``
  | positionX.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | positionX.value: ``double`` (optional)
  | positionY.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | positionY.value: ``double`` (optional)
  | positionZ.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | positionZ.value: ``double`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class StatsInfo:

StatsInfo
"""""""""

Used by: :ref:`Channel.statsInfo <OMERO model class Channel>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | globalMax: ``double``
  | globalMin: ``double``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class TagAnnotation:

TagAnnotation
"""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | textValue: ``text`` (optional) from :ref:`TextAnnotation <OMERO model class TextAnnotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class TermAnnotation:

TermAnnotation
""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | termValue: ``text`` (optional)
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class TextAnnotation:

TextAnnotation
""""""""""""""

Subclasses: :ref:`CommentAnnotation <OMERO model class CommentAnnotation>`, :ref:`TagAnnotation <OMERO model class TagAnnotation>`, :ref:`XmlAnnotation <OMERO model class XmlAnnotation>`

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | textValue: ``text`` (optional)
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class Thumbnail:

Thumbnail
"""""""""

Used by: :ref:`Pixels.thumbnails <OMERO model class Pixels>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | mimeType: ``string``
  | pixels: :ref:`Pixels <OMERO model class Pixels>`
  | ref: ``string`` (optional)
  | sizeX: ``integer``
  | sizeY: ``integer``
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class ThumbnailGenerationJob:

ThumbnailGenerationJob
""""""""""""""""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`

.. _OMERO model class TimestampAnnotation:

TimestampAnnotation
"""""""""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | timeValue: ``timestamp`` (optional)
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class TransmittanceRange:

TransmittanceRange
""""""""""""""""""

Used by: :ref:`Filter.transmittanceRange <OMERO model class Filter>`

Properties:
  | cutIn.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | cutIn.value: ``double`` (optional)
  | cutInTolerance.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | cutInTolerance.value: ``double`` (optional)
  | cutOut.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | cutOut.value: ``double`` (optional)
  | cutOutTolerance.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | cutOutTolerance.value: ``double`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | transmittance: ``double`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class TypeAnnotation:

TypeAnnotation
""""""""""""""

Subclasses: :ref:`FileAnnotation <OMERO model class FileAnnotation>`

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

.. _OMERO model class UploadJob:

UploadJob
"""""""""

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Job <OMERO model class Job>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Job <OMERO model class Job>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Job <OMERO model class Job>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Job <OMERO model class Job>`
  | finished: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | groupname: ``string`` from :ref:`Job <OMERO model class Job>`
  | message: ``string`` from :ref:`Job <OMERO model class Job>`
  | originalFileLinks: :ref:`JobOriginalFileLink <OMERO model class JobOriginalFileLink>` (multiple) from :ref:`Job <OMERO model class Job>`
  | scheduledFor: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | started: ``timestamp`` (optional) from :ref:`Job <OMERO model class Job>`
  | status: :ref:`JobStatus <OMERO model class JobStatus>` from :ref:`Job <OMERO model class Job>`
  | submitted: ``timestamp`` from :ref:`Job <OMERO model class Job>`
  | type: ``string`` from :ref:`Job <OMERO model class Job>`
  | username: ``string`` from :ref:`Job <OMERO model class Job>`
  | version: ``integer`` (optional) from :ref:`Job <OMERO model class Job>`
  | versionInfo: list (multiple)

.. _OMERO model class Well:

Well
""""

Used by: :ref:`Plate.wells <OMERO model class Plate>`, :ref:`WellAnnotationLink.parent <OMERO model class WellAnnotationLink>`, :ref:`WellReagentLink.parent <OMERO model class WellReagentLink>`, :ref:`WellSample.well <OMERO model class WellSample>`

Properties:
  | alpha: ``integer`` (optional)
  | annotationLinks: :ref:`WellAnnotationLink <OMERO model class WellAnnotationLink>` (multiple)
  | blue: ``integer`` (optional)
  | column: ``integer`` (optional)
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | externalDescription: ``text`` (optional)
  | externalIdentifier: ``string`` (optional)
  | green: ``integer`` (optional)
  | plate: :ref:`Plate <OMERO model class Plate>`
  | reagentLinks: :ref:`WellReagentLink <OMERO model class WellReagentLink>` (multiple)
  | red: ``integer`` (optional)
  | row: ``integer`` (optional)
  | status: ``string`` (optional)
  | type: ``string`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | wellSamples: :ref:`WellSample <OMERO model class WellSample>` (multiple)

.. _OMERO model class WellAnnotationLink:

WellAnnotationLink
""""""""""""""""""

Used by: :ref:`Well.annotationLinks <OMERO model class Well>`

Properties:
  | child: :ref:`Annotation <OMERO model class Annotation>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Well <OMERO model class Well>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class WellReagentLink:

WellReagentLink
"""""""""""""""

Used by: :ref:`Reagent.wellLinks <OMERO model class Reagent>`, :ref:`Well.reagentLinks <OMERO model class Well>`

Properties:
  | child: :ref:`Reagent <OMERO model class Reagent>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | parent: :ref:`Well <OMERO model class Well>`, see :javadoc:`ILink <ome/model/ILink.html>`
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`

.. _OMERO model class WellSample:

WellSample
""""""""""

Used by: :ref:`Image.wellSamples <OMERO model class Image>`, :ref:`PlateAcquisition.wellSample <OMERO model class PlateAcquisition>`, :ref:`Well.wellSamples <OMERO model class Well>`

Properties:
  | details.creationEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional), see :javadoc:`IObject <ome/model/IObject.html>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>`, see :javadoc:`IObject <ome/model/IObject.html>`
  | image: :ref:`Image <OMERO model class Image>`
  | plateAcquisition: :ref:`PlateAcquisition <OMERO model class PlateAcquisition>` (optional)
  | posX.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | posX.value: ``double`` (optional)
  | posY.unit: enumeration of :javadoc:`Length <ome/model/units/Length.html>` (optional)
  | posY.value: ``double`` (optional)
  | timepoint: ``timestamp`` (optional)
  | version: ``integer`` (optional), see :javadoc:`IMutable <ome/model/IMutable.html>`
  | well: :ref:`Well <OMERO model class Well>`

.. _OMERO model class XmlAnnotation:

XmlAnnotation
"""""""""""""

Properties:
  | annotationLinks: :ref:`AnnotationAnnotationLink <OMERO model class AnnotationAnnotationLink>` (multiple) from :ref:`Annotation <OMERO model class Annotation>`
  | description: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.creationEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.externalInfo: :ref:`ExternalInfo <OMERO model class ExternalInfo>` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | details.group: :ref:`ExperimenterGroup <OMERO model class ExperimenterGroup>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.owner: :ref:`Experimenter <OMERO model class Experimenter>` from :ref:`Annotation <OMERO model class Annotation>`
  | details.updateEvent: :ref:`Event <OMERO model class Event>` from :ref:`Annotation <OMERO model class Annotation>`
  | name: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | ns: ``text`` (optional) from :ref:`Annotation <OMERO model class Annotation>`
  | textValue: ``text`` (optional) from :ref:`TextAnnotation <OMERO model class TextAnnotation>`
  | version: ``integer`` (optional) from :ref:`Annotation <OMERO model class Annotation>`

