Deprecated Page

**Josh Moore, April/2007**

::

      class Validators implements List<Validator>, Validator{} // Composite pattern

      List<Validator> list = iObject.getValidators();
      // list them 
      // or
      Validators validators = iObject.getValidators; 
      validators.validateInsert(iObject);
      validators.validateUpdate(iObject);
      validators.validateDelete(iObject);

Implementation
--------------

-  use an ``new OmeroContext("ome.validation")`` which wraps
   "ome.server" when available giving the validators access to the DB.
-  

Possible Uses
-------------

-  Keeping reverse links on attributes in-sync
-  Implementing security (Currently, who can delete what is hard-coded
   in the security system)
