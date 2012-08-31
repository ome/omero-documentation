Various notes and ideas for import

Josh
----

I've tried to come up with something that can provide the low-level data
access that the import team needs. Take a look at the following and
comment.

Assuming we have an `ImportEngine </ome/wiki/proposals/ImportEngine>`_
StatefulSessionBean? like the
`RenderingEngine </ome/wiki/RenderingEngine>`_, we could do something
like the following on the client:

::

       ImportEngine importEngine = serviceFactory.getImporter();

       importEngine.createImportDef();
       // alternatively use lookup to load running import
       // importEngine.lookupImportDef( importDefinitionID );

       importEngine.addFile( myFile );
       importEngine.addFile( myOtherFile );
       // alternatively use the ImportDef directly
       // this is less clean but may be useful.
       // ImportDef def = importEngine.getImportDef();
       // def.addFile( myFile );
       // importEngine.updateImportDef( def );

       importEngine.save(); // persists to the DB

       // here's where the logic comes in. 
       String[] importEngine.getAbilities(); 
       importEngine.start();

       ImportStatus status = importEngine.getStatus();  // eumeration accessible at ImportDef.setStatus();
       Error[] errors = importEngine.getErrors(); // Similar or identical to validation errors.

The notification system could then be tied to any Event of type "UPDATE"
on the class "ImportDef?".

``ome.model.import.ImportDef``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  name : String
-  status : FK to Status enumeration
-  errors : 1-N link to various failures. see discussion on failure log
   \*events : 1-N link to the events that we've caused.

``ome.model.import.Actions``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Message : String
-  OriginalFile : FK to OriginalFile?
-  Pixels : FK to Pixels
-  status : FK to Status enumeration

A change to to any of the actions should represent a change to the
import and an event should be thrown.

Other possibilities:
--------------------

-  config value (table?) for "default, optimize size v. speed, etc."
-  relation to cron jobs: some of the actions can be put on the schedule

   -  do we create pixels right away or do we just schedule them for
      later.
   -  use Task Api

      -  gets an individual action and can set its status as necessary
         (RUNNING->FINISHED)
      -  retries?
      -  separate actions in a different JVM for protecting against
         IO/memory issues?

Questions:
----------

-  When should state be saved to the DB? On each addFile() ?
-  Hierarchical (rather than virtual) events? Where are the TX
   boundaries?
