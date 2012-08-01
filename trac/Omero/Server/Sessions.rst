`OmeroSessions </ome/wiki/OmeroSessions>`_
==========================================

Beginning with OMERO-3.0-Beta3, the OMERO server has unified the
handling of login sessions among both the JBoss and the
`OmeroBlitz </ome/wiki/OmeroBlitz>`_ servers. Previously JBoss logins
were handled via the standard
` JAAS <http://java.sun.com/javase/technologies/security/>`_ mechanisms,
using a modified ``DatabaseLoginModule``. This proved problematic for
several reason:

#. exceptions thrown during login could not easily be caught or
   specified
#. passwords were sent in the clear on every invocation
#. sql queries on every invocation caused significant overhead

Blitz did not suffer from these problems, but the login functionality
was largely outside of the core server code and sessions were more
volatile: a loss of an Ice connection caused all resources to be lost.
With `OmeroSessions </ome/wiki/OmeroSessions>`_, both login systems have
been brought together and simplified.

In short, Sessions …
--------------------

-  are a replacement for the standard JavaEE security infrastructure.
-  unify the Blitz and RMI session handling,or better put, make, working
   with Java RMI more like Blitz, since the JavaEE interaction is
   essentially "conversationless".
-  provide the ability (esp. in Blitz) to quit a session and rejoin it
   later as long as it hasn't timed out, possibly useful for moving from
   one machine to another.
-  provide the ability to share the same space. Two users/clients
   attached to the same session would experience the same life-cycle.
-  provides a scratch space to which any data can be written for and by
   job/script executions.
-  act as a global cache (in memory or on disk) to speed up various
   server tasks, including login. With further extensions like
   ` http://terracotta.org/ <http://terracotta.org/>`_, sessions could
   serve as a "distributed" cache.
-  prevent sending passwords in plain text (or in any form). After that,
   all session interaction takes place via a shared secret key.

Design
------

All services other than ISession, assume that a user is logging in with
a username equal to session uuid. Whereas previously one logged in with:

::

      ome.system.Principal p = new ome.system.Principal("josh","user","User");

behind the scenes, now the "josh" value is replaced by the UUID of a
``ome.model.meta.Session`` instance.

The session is acquired by a call to:

::

      ome.api.ISession.createSession(Principal princpal, String credentials);

and carries information related to the current users session.

::

      Session session;
      session.getUuid();       // Unique identifier; functions as a temporary password. DO NOT SHARE IT. 
      session.getTimeToIdle(); // Number of milliseconds which the user can idle without session timeout
      session.getTimeToLove(); // Total number of milliseconds for which the session can live
      session.getStarted();    // Start of session
      session.getClosed();     // if != null, then session is closed

These properties cannot be modified.

Other properites are for use by clients:

::

      session.getMessage();            // General purpose message statement
      session.getAgent();              // Can be used to specify which program the user is using
      session.getDefaultEventType();   // Default event type (the third argument "User" to Principal above)
      session.getDefaultPermissions(); // String representation of umask (e.g. "rw----")

After changing a property on the session returned by createSession()
it's possible to save them to the server via:

::

      ome.api.ISession.updateSession(Session);

Finally, when finished, to conserve resources it is possible to destroy
the session via:

::

      ome.api.ISession.closeSession(Session);

Existing sessions
~~~~~~~~~~~~~~~~~

In `OmeroBlitz </ome/wiki/OmeroBlitz>`_, once the connection to a
``ServiceFactoryPrx`` (a Glacier2.Session subclass) was lost, it was not
possible to reconnect to any of the services created using that
connection. Now it is possible to reacquire the session if it is still
active, by passing the previous session UUID as your password (User
principal is ignored.)

::

      client = omero.client()
      servicefactory = client.createSession()
      iadmin = servicefactory.getAdminService()
      olduuid = iadmin.getEventContext().sessionUuid
      
      // lose connection

      client = omero.client()
      servicefactory = client.createSession(omero.sys.Principal(), olduuid)
      // now reattached  

Comments
--------

Backwards compatibility
~~~~~~~~~~~~~~~~~~~~~~~

In the short-term, there is no need for any change to client code to
make use of the new sessions.

``ome.system.ServiceFactory`` has been modified to automatically acquire
a session before the first service call is made. Eventually, clients
will want to make use of the session API and catch session exceptions to
have a finer control of the client lifecycle.

Similarly, no changes are needed in `OmeroBlitz </ome/wiki/OmeroBlitz>`_
client code since Glacier2 sessions now delegate to
`OmeroSessions </ome/wiki/OmeroSessions>`_. Clients can access the
ISession service when necessary. Exceptions thrown are still Ice-based.

--------------

See also : `OmeroBlitz </ome/wiki/OmeroBlitz>`_,
`OmeroSecurity </ome/wiki/OmeroSecurity>`_

Attachments
~~~~~~~~~~~

-  `BlitzSessionCreationDestruction.png </ome/attachment/wiki/OmeroSessions/BlitzSessionCreationDestruction.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroSessions/BlitzSessionCreationDestruction.png>`_
   (106.4 KB) - added by *jmoore* `4
   ago.
