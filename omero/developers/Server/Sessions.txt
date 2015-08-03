OMERO sessions
==============

OMERO sessions simplifies the handling of login sessions for
:doc:`/developers/server-blitz`.

.. figure:: /images/omero-BlitzSessionCreationDestruction.png
  :align: center
  :alt: Blitz session creation and destruction

In short:

-  Sessions are a replacement for the standard JavaEE security infrastructure.
-  Sessions unify the Blitz and RMI session handling, making working
   with Java RMI more like Blitz (since the JavaEE interaction is
   essentially "conversationless").
-  Sessions provide the ability (especially in Blitz) to quit a session and  
   rejoin it later as long as it has not timed out, possibly useful for moving 
   from one machine to another.
-  Sessions provide the ability to share the same space. Two users/clients
   attached to the same session would experience the same life-cycle.
-  Sessions provide a scratch space to which any data can be written for and 
   by job/script executions.
-  Sessions act as a global cache (in memory or on disk) to speed up various
   server tasks, including login. With further extensions like
   `http://terracotta.org/ <http://terracotta.org/>`_, sessions could
   serve as a "distributed" cache.
-  Sessions prevent sending passwords in plain text or any other form. After 
   that, all session interactions take place via a shared secret key.

Design
------

All services other than ``ISession``, assume that a user is logging in with
a username equal to session uuid. Whereas previously one logged in with:

::

      ome.system.Principal p = new ome.system.Principal("josh","user","User");

behind the scenes, now the "josh" value is replaced by the UUID of a
``ome.model.meta.Session`` instance.

The session is acquired by a call to:

::

      ome.api.ISession.createSession(Principal princpal, String credentials);

and carries information related to the current user's session.

::

      Session session;
      session.getUuid();       // Unique identifier; functions as a temporary password. DO NOT SHARE IT. 
      session.getTimeToIdle(); // Number of milliseconds which the user can idle without session timeout
      session.getTimeToLive(); // Total number of milliseconds for which the session can live
      session.getStarted();    // Start of session
      session.getClosed();     // if != null, then session is closed

These properties cannot be modified.

Other properties are for use by clients:

::

      session.getMessage();            // General purpose message statement
      session.getAgent();              // Can be used to specify which program the user is using
      session.getDefaultEventType();   // Default event type (the third argument "User" to Principal above)
      session.getDefaultPermissions(); // String representation of umask (e.g. "rw----")

After changing a property on the session returned by ``createSession()``
it is possible to save them to the server via:

::

      ome.api.ISession.updateSession(Session);

Finally, when finished, to conserve resources it is possible to destroy
the session via:

::

      ome.api.ISession.closeSession(Session);

Existing sessions
-----------------

In :doc:`/developers/server-blitz`, it is possible to reacquire the session if
it is still active, by passing the previous session UUID as your password
(User principal is ignored).

::

      client = omero.client()
      servicefactory = client.createSession()
      iadmin = servicefactory.getAdminService()
      olduuid = iadmin.getEventContext().sessionUuid
      
      // lose connection

      client = omero.client()
      servicefactory = client.createSession(omero.sys.Principal(), olduuid)
      // now reattached

.. seealso:: :doc:`/sysadmins/server-security`
