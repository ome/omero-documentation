Deprecated Page

Grand Unified Modelling
=======================

Getting from a specification of users objects to a running version of
code usually works like this:

-  requirements for new business-objects are gathered and layed down
   into UML
-  this UML is then manually translated into DomainSpecificLanguage?
-  the build then generates from this dsl all required artefacts
   (\*.java, \*.hbm.xml, ddl, etc.)

Although this approach is now tried and tested, it has some drawbacks:

-  **manual step to get from UML to DSL**: There is no automatism to
   translate the UML we use to specify the object-model into the DSL
   from which the actual code is generated. There are also no tools
   available to visualise the DSL. If the goal to enable end-users to
   make up their own types can actually be achieved with the current
   state of the dsl is not clear. Writing correct XML for the DSL's is
   not trivial and would need a significant investment into supporting
   infrastructure (an editor that supports code-completion and
   validation, visualization-tools etc., tools for documentation)
-  **documentation and model can get out of sync**: As the dsl is the
   actual basis for the code, deltas between this dsl and the underlying
   can occur.
-  **UML is not required to be valid and complete**: As no actual code
   is generated out of it, there is no single source for documentation.
   Therefore, the UML is not yet used as the single source for complete
   documentation of the business-objects in the system. (There have been
   some efforts to document the ER-Model, as it gives a complete picture
   of whats in the database. Although this gives you a good overview of
   the system, this documentation is not stable. The DDL gets
   regenerated whenever changes in the DSL occur, therefore it becomes
   hard to maintain this documentation.)

The goal of the
`GrandUnifiedModelling </ome/wiki/GrandUnifiedModelling>`_ approach is
therefore:

-  get a complete and valid UML model for the system
-  use the UML as the definitive source for all business-objects and
   artefacts in the system (eliminate the manual step in translating the
   UML to DSL manually.)
-  use this model (and a decent UML-Editor) to document the system
-  use off-the-shelf-tools for code-generation, templating, uml etc.

Reference:

-  ` Lightweight Domain Specific
   Modeling <http://www.theserverside.com/tt/articles/article.tss?l=LightweightModeling>`_

Goal of this story is to increase the quality of the documentation of
the system and to unify the sources, from which artefacts are generated.
For a full discussion&Motivation of this story see
`GrandUnifiedModelling </ome/wiki/GrandUnifiedModelling>`_.

The goals in detail are:

-  Use UML as the single source for code-generation in the system
-  Use this UML as the basis for an elaborate and complete documentation
-  Use off-the-shelf-tools for UML-Visualization, Template-Production
   and Code-Generation whereever possible

Getting from a specification of users objects to a running version of
code usually works like this:

-  requirements for new business-objects are gathered and layed down
   into UML
-  this UML is then manually translated into DomainSpecificLanguage?
-  the build then generates from this dsl all required artefacts
   (\*.java, \*.hbm.xml, ddl, etc.)

Although this approach is now tried and tested, it has some drawbacks:

-  **manual step to get from UML to DSL**: There is no automatism to
   translate the UML we use to specify the object-model into the DSL
   from which the actual code is generated. There are also no tools
   available to visualise the DSL. If the goal to enable end-users to
   make up their own types can actually be achieved with the current
   state of the dsl is not clear. Writing correct XML for the DSL's is
   not trivial and would need a significant investment into supporting
   infrastructure (an editor that supports code-completion and
   validation, visualization-tools etc., tools for documentation)
-  **documentation and model can get out of sync**: As the dsl is the
   actual basis for the code, deltas between this dsl and the underlying
   can occur.
-  **UML is not required to be valid and complete**: As no actual code
   is generated out of it, there is no single source for documentation.
   Therefore, the UML is not yet used as the single source for complete
   documentation of the business-objects in the system. (There have been
   some efforts to document the ER-Model, as it gives a complete picture
   of whats in the database. Although this gives you a good overview of
   the system, this documentation is not stable. The DDL gets
   regenerated whenever changes in the DSL occur, therefore it becomes
   hard to maintain this documentation.)

This a huge task, it is therefore split into several sub-stories:

-  Migration to ejb3/annotations:

   -  `#93 </ome/ticket/93>`_: Migrating from \*.hbm.xml
   -  `#94 </ome/ticket/94>`_: Annotations for Search
   -  `#95 </ome/ticket/95>`_: Ensure Testablility

-  Getting to know the tools

   -  Enterprise Architect (UML->XMI? EA->ecore (see
      ` Argo2Ecore <http://sourceforge.net/projects/argo2ecore>`_, which
      translates Argo-Model into Ecore, which can be consumed by emf)
   -  emf
   -  jet/\ ` Merlin <http://sourceforge.net/projects/merlingenerator/>`_
   -  ` openArchitectureWare <http://www.openarchitectureware.org/>`_

-  Model-Cleaning

   -  getting the UML-model right to the point where we can generate the
      whole domain-model from it
   -  documentation of the model (ongoing task...)
