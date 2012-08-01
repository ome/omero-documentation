Deprecated Page

**NOTE:**

    This page is now depreciated and superceeded by the new Permissions
    page found
    ` here <http://www.openmicroscopy.org.uk/site/support/omero4/server/permissions/>`_.

Omero Permissions
=================

    The **ome.model.internal.Permissions** class is the central
    definition of the rights, roles, and flags (TBD) which can be
    attached to every metadata object stored in Omero.

Roles and Rights
----------------

    The Permissions class defines the three roles known from the Unix
    filesystem : USER, GROUP, and WORLD. It also defines three rights
    similar to the RWX known from Unix, namely: READ, WRITE, USE. And
    these are typically represented as "rwurwurwu" where the first "rwu"
    is for the USER, the second for GROUP, and the third for WORLD. A
    letter means that the right is turned on, and a dash (e.g.
    rwur-u---) means that the right is turned off. The example given
    being for an object readable and useable by USER and GROUP, and only
    writeable by USER.

Umasks
------

    Umasks are mentioned frequently with regards to the security system.
    They are used when working with the Unix filesystem to define what
    permissions are set automatically on newly created files. In Omero,
    umasks are really nothing other than instances of **Permissions**
    which are used to create initialize Permissions on all new objects.

    For example, with no interaction from the user, the Permissions
    object created for a new Image will be equal to:

::

        Permissions p = new Permissions(); // p here has all rights turned on RWURWURWU
        p.revoke(GROUP,WRITE).revoke(WORLD,WRITE); // now only the user can modify the value

    However, if one of the following umasks were turned on, then the
    image permissions would also change:

::

        Permissions umask;
       
        umask = new Permissions( Permissions.GROUP_PRIVATE ); // WORLD can't read the image
        umask = new Permissions( Permissions.READ_ONLY ); // not even the user can change the image
        umask = new Permissions( Pemrissions.PRIVATE ); // no one in group (other than the PI) can see the image

Session-wide umasks
~~~~~~~~~~~~~~~~~~~

    So, just how does one turn on a umask? Umasks are set at the
    **`ServiceFactory </ome/wiki/ServiceFactory>`_** level and are
    active for all services created by that
    `ServiceFactory </ome/wiki/ServiceFactory>`_ starting with the very
    next call. For example,

::

       Login myLogin = new Login("myusername","mypassword");
       ServiceFactory sf = new ServiceFactory( myLogin );
     
       // create an object with the default permissions (Permissions.DEFAULT)
       IUpdate update = sf.getUpdateService();
       Image myImg = new Image();
       myImg.setName("test");
       update.saveObject( myImg );

       // now set the umask
       sf.setUmask( new Permissions( Permissions.PRIVATE ) );
      
       // and now save another image that only I can see
       Image myImg2 = new Image();
       myImg2.setName("test2");
       update.saveObject( myImg2 );
