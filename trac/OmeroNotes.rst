Deprecated Page

These notes are the starting point for future components or APIs in the
OMERO server. Once they've received enough attention, they should be
written up on Trac ` New
ticket <http://trac.openmicroscopy.org.uk/omero/newticket>`_

::

    * Beta4-- these are jason's notes from August strategy meetings.  please edit, and especially clarify anything you want (especially where thing are "improved" (:confused:)).  The major changes in Beta4 are:
    ** OMERO.fs
    ** OMERO.web
    ** Support for permissions across all clients and server
    ** Server-side Import
    ** Integration of insight and editor
    ** Scripting
    ** Export of Image Files to OME-TIFF

    ** Data Model
    *** Sept 08 XSD to include ROIs, Structured Annotations, and optionals
    *** Minimum Specs-- gold stars
    *** Additional models (EM)
    ** Server
    *** Data proxy/throttling
    *** ROIs
    *** Improved permissions/delete
    *** Improved build and integration
    ** Rendering Engine
    *** Performance
    ** OMERO.fs
    *** 3 platforms
    *** import system and file access
    ** Analysis
    *** Basic image analysis functions (which ones?), workflows and scheduling
    *** Integration of SciPy
    ** Import
    *** Server-side import/batch import
    *** Better support for import of image series
    *** UI improvements
    *** SQL fixes
    *** automated testing of imports
    ** Web
    *** Release of first web client
    *** sharing (must resolve permissions)
    *** data paging
    ** Insight
    *** Support for "more natural workflow"
    *** Improved acquisition metadata support
    ** Editor
    *** insight integration-- view/edit protocols in insight
    *** import "protocol text" into protocol

    ** Things for the team
    *** Improved Collaborative Tools
    *** New Server for storing all data, figs, etc.
    *** New Testing Systems, build systems for all OS's

    ---

    * API
    ** do we need a "primitive" api for non-java
    *** using Class versus String (CONSTANTS?)
    *** arrays rather than Collections
    ** and what about a "bulk" api?
    ** IQuery/IUpdate
    *** review IQuery/IUpdate -- create (long return)/update no hierarchy. else merge.
    *** evaluate new Dao<T extends IObject>(IQuery)

    * Model
    ** ((EmfAsDsl)) -- Use the EclipseModelingFramework ([http://eclipse.org/emf|EMF]) for our modeling/DomainSpecificLanguage needs.
    ** __Lineage__ -- Rois, Image, ResultSet, ...
    ** Details implementations: SystemClassDetails, StandardDetails, UserDefinedDetails Currently it is unneeded, but may be useful. (1.5 would ease this with ((CovariantReturnTypes)) )
    ** Events
    *** currently an event log is produced on every ''successful'' DB change (not selects). Do we also need failure logs on exceptions, or general statistics on read operations?
    *** do we need a scope and/or context on events?
    *** hierarchical events.
    *** use <any/> type for linkng update events (all but last for perf.?)
    ** Locking -- currently we are using optimistic locking at the table/object level. We should consider use cases and future requirements for pessimistic and/or coard-grained locking.
    ** move dynamic methods and Filterable methods to IBase interface(?)
    ** UserProfiles -- The Experimenter class needs to gain an umask field for the security system. Since umask will be used quite often, it makes sense to have it as a top-level value, but one could imagine a PROFILE table linked to the EXPERIMENTER table which in turn was linked to a VARIABLE table containing environment settings. (This is analogous to the bash .profile or .bashrc files) Similarly PROFILE could link to CRON and STARTUP tables for running timed and on-startup up tasks (see Task API).

    * Server
    ** ((Omero::Rules|Rules))
    ** ScratchDB -- because of the difficult of deletion, etc. it's often been wished that there were a scratch database where temporary data could be parked. This is feasible, but the use cases are not clear.
    *** items stored should be marked group/world NON-readable.
    *** A second hibernate sessionFactory would need to be started. 
    ** Embedded EJB Container for testing -- currently we are duplicating code between the services (the logic code) and the EJBs. We could get rid of all duplication IF we had a way to automatically configure the EJBs for testing (it'd be optimal if we could do this ''without'' directly specifying them in the Spring config.)
    ** Transformation API
    *** currently used a non-cascading evict
    *** or copy in session
    *** or closure for outside of session (maintainability?)
    *** or close session (performance, other ejbs?)
    *** or ((GraphApi))
    ** Task API
    *** provide for "[final] class OmeroApplication implements Task" (if final provide OmeroTaskRunner a la main(){ t=new Task(); app = OmeroApp(t); app.run() } )
    *** interface Task { doTask( TaskContext context ); } class Example implements Task { doTask( context ) { context.error( "boom" ); } }
    *** use junit like patterns (provides some familiarity)
    **** composite
    **** gathering parameter
    **** setup/teardown template pattern
    *** relatedly, provde a AbstractTaskTest
    *** how would username and eventtype work? defaults?
    *** Dispatcher, LogCreator, JmsSource( sink )
    *** notifications
    **** ( globalListener ( taskDispatchers ( jms logCreator ) ) )
    *** specific tasks
    **** constant background validator (brings an object out, checks it, returns it)
    ** Working Set
    *** based on query perhaps
    *** is it a StatefulSession or an object in DB?
    *** based on Dataset like current use-case
    *** related to an PixelsSet?

    * Queries
    ** wrap Criteria in Hiearchy with an ome.* class ("CriteriaBuilder")

    * Dynamics
    ** use a mixture of ant-based compilation, ClassLoader magic, and Spring HotSwapping to create objects. Doesn't solve the accessor issue. See also EmfAsDsl cF. SDO
    ** meta-information: if we have Image.class and we know we're talking about annotations can we infer: Image.IMAGEANNOTATIONS, ImageAnnotation.class and for the reverse case, ImageAnnotation.IMAGE. This is (part of) what's needed to mimick Perl's accessors

    * Misc
    ** AopSkipper ( depth++ and on each invocation one keeps track. need ThreadLocal) and/or Ejb3MethodInvocationAdapter
    ** DoubleFilter from omero2. Currently broken. Ability to delegate to 2 filters and walk a similar graph. (And if they differ?)


    ----- 

    Un-"detailed" items. Many of these should be moved directly to bugzilla. ~ Josh

    [[API]
     * redesign apis : getDao,  
     * IQuery doesn't allow us to do a limit efficiently at all! (need options)
     * could add to IQuery.options (JOINED_FIELDS)
     * pojoOptions.world();
     * do we need to reverse engineer perl
     * specifiy all throws

    [[dsl]
     * spring-like dtd (or emf or owl ...)
     * dynamic URN assigned to fields. 
     * meta-model in DB, with DAG of typesets, with namespaces
     * mutability -> cacheability in DSL (performance, later.)
     * add components like <email/> to maping language. 

    [[model]
     * implement readObject and writeObject in order to use normal serialization w/ Hibernate. (need reflection or hibernate libraries????)
     ? all logic in getters setters of pojos (store reference to IUpdate!)
     * new XXX(long id)?
     * package names: [sys,con,ann,roi,cor,...,seq]
     * hiberate v. spring validation
     * container types (Top,Bottom,Parent(s))
     * IdentityHashMap used in all Filter caching
     * annotations for arbitrary external data
       looking at mouse stuff from harry
       want to provide a hierarchy (graph) 
       of annotations of annotations of annotations

       Gene->Images->SortedByProbe->SortedByProbe
     * use more lists 
      Set<-getChannels().getIndex();
        TO
      List<-getChannels()
     * hibernate naming strategy ? (along with our specialized types)
     * do we need a unique on the statement maps?
     * lucene/compass integration
     * evaluate DB update possibilities with Hibernate SchemaUpdate
     * abstract base class in addition to interface?
     * thumbnail with byte array (internal?) 

    [[build]
     * use data of DSL jar to delete .done markers for hibernate generation!
     * ddl.sql -> ddl.sql and clean.sql
     
    [[server]
     * extra tables:  MDB receives events (log_validation, log_image_check, log_*
     * exceptions:
       FixAndRetry->PermissionVioloation
       Retry
       RetryWithBackOff
     * ejb3: http://trailblazer.demo.jboss.com/EJB3Trail/services/interceptor/index.html
       use @AroundInvoke to do Read/Write Locking
     * distributed transactions for JMS
     * versioning of objects. 
     * use hibernate formulas for LSIDs. 


    [[interop] export, etc.
     * OwlFilter to produce Owl/RDF output from a graph. 
     * jms and callback api. (see notes somewhere)
     * DBObject interop

    [[Test]
     * J-M DenialOfService ?? GetImages
     * get in-memory testing working 
       http://www.theserverside.com/articles/article.tss?l=UnitTesting
     * cargo.codehaus.org   
     * performance testing
     ** Sequoia
     ** WebLogic etc.
     ** jboss clustering.
     * comparison testing in omero2 series

    [[RndEngine]
     * setPixels for scrolling through screen
     * pass in lokkup table?
     * move validation code to Validators
     * callback!!!
     * stats. and plane2d (import/nio to chris)

    [[other]
     * accept RDF input?
     * can we do the derivation stuff if someone tries to delete OrigFiles? do we need to?
     * deploy -- supported JVMs
     * deploy -- webstart, knoppix, vmware vdisk (with JRE and eclipse compiler),  
     * policy -- no spring or hibernate in services. aop.
