.. _developers/Omero/Modules/ExceptionHandling:

Exception Handling
==================

.. contents::

Client Exceptions
-----------------

The exceptions which can be received by a client due to a remote call on
the OMERO server are all defined in
:source:`components/blitz/resources/omero/ServerErrors.ice`
(included below). This file contains two separate hierarchies rooted at
``Ice::Exception`` and ``omero::ServerError``. A third hierarchy rooted
at ``omero::ClientError`` is defined in
:source:`components/blitz/resources/omero/ClientErrors.ice`
(not included below). These exceptions are thrown due to local (i.e.
non-remote) invocations, including issues during configuration.

For a better understanding of how to handle exceptions, please read both
of the ``*.ice`` files carefully, and see |OmeroClients| for examples of exception
handling.

::

    /*
     *   $Id$
     *
     *   Copyright 2007 Glencoe Software, Inc. All rights reserved.
     *   Use is subject to license terms supplied in LICENSE.txt
     *
     */
    #ifndef OMERO_SERVERERRORS_ICE
    #define OMERO_SERVERERRORS_ICE
    #include <Glacier2/Session.ice>
    /**
     * Exceptions thrown by OMERO server components. Exceptions thrown client side
     * are available defined in each language binding separately, but will usually
     * subclass from "ClientError" For more information, see:
     *
     *   <a href="http://trac.openmicroscopy.org.uk/ome/wiki/ExceptionHandling">
     *      http://trac.openmicroscopy.org.uk/ome/wiki/ExceptionHandling
     *   </a>
     *
     * including examples of what a appropriate try/catch block would look like.
     *
     * <p>
     * All exceptions that are thrown by a remote call (any call on a *Prx instance)
     * will be either a subclass of [Ice::UserException] or [Ice::LocalException].
     * <a href="http://zeroc.com/doc/Ice-3.3.1/manual/Slice.5.10.html#50592"> Figure 4.4 </a>
     * from the Ice manual shows the entire exception hierarchy. The exceptions described in
     * this file will subclass from [Ice::UserException]. Other Ice-runtime exceptions subclass
     * from [Ice::LocalException].
     * </p>
     *
     * <pre>
     *
     * OMERO Specific:
     * ===============
     *  ServerError (root server exception)
     *   |
     *   |_ InternalException (server bug)
     *   |
     *   |_ ResourceError (non-recoverable)
     *   |  \_ NoProcessorAvailable
     *   |
     *   |_ ConcurrencyException (recoverable)
     *   |  |_ ConcurrentModification (data was changed)
     *   |  |_ OptimisticLockException (changed data conflicts)
     *   |  |_ LockTimeout (took too long to aquire lock)
     *   |  |_ TryAgain (some processing required before server is ready)
     *   |  \_ TooManyUsersException
     *   |     \_ DatabaseBusyException
     *   |
     *   |_ ApiUsageException (misuse of services)
     *   |   |_ OverUsageException (too much)
     *   |   |_ QueryException (bad query string)
     *   |   \_ ValidationException (bad data)
     *   |
     *   |_ SecurityViolation (some no-no)
     *   |   \_ GroupSecurityViolation
     *   |      |_ PermissionMismatchGroupSecurityViolation
     *   |      \_ ReadOnlyGroupSecurityViolation
     *   |
     *   \_SessionException
     *      |_ RemovedSessionException (accessing a non-extant session)
     *      |_ SessionTimeoutException (session timed out; not yet removed)
     *      \_ ShutdownInProgress      (session on this server will most likely be destroyed)
     * </pre>
     *
     *
     * <p>
     * However, in addition to [Ice::LocalException] subclasses, the Ice runtime also
     * defines subclasses of [Ice::UserException]. In some cases, OMERO subclasses
     * from these exceptions. The subclasses shown below are not exhaustive, but show those
     * which an application's exception handler may want to deal with.
     * </p>
     *
     *
     * <pre>
     *  Ice::Exception (root of all Ice exceptions)
     *   |
     *   |_ Ice::UserException (super class of all application exceptions)
     *   |  |
     *   |  |_ Glacier2::CannotCreateSessionException (1 of 2 exceptions throwable by createSession)
     *   |  |   |_ omero::AuthenticationException (bad login)
     *   |  |   |_ omero::ExpiredCredentialException (old password)
     *   |  |   |_ omero::WrappedCreateSessionException (any other server error during createSession)
     *   |  |   \_ omero::licenses::NoAvailableLicensesException (see tools/licenses/resources/omero/LicensesAPI.ice)
     *   |  |
     *   |  \_ Glacier2::PermissionDeniedException (other of 2 exceptions throwable by createSession)
     *   |
     *   \_ Ice::LocalException (should generally be considered fatal. See exceptions below)
     *       |
     *       |_ Ice::ProtocolException (something went wrong on the wire. Wrong version?)
     *       |
     *       |_ Ice::RequestFailedException
     *       |   |_ ObjectNotExistException (Service timeout or similar?)
     *       |   \_ OperationNotExistException (Improper use of uncheckedCast?)
     *       |
     *       |_ Ice::UknownException (server threw an unexpected exception. Bug!)
     *       |
     *       \_ Ice::TimeoutException
     *           \_ Ice::ConnectTimeoutException (Couldn't establish a connection. Retry?)
     *
     * </pre>
     *
     **/
    module omero
    {
      /*
       * Base exception. Equivalent to the ome.conditions.RootException.
       * RootException must be split into a ServerError and a ClientError
       * base-class since the two systems are more strictly split by the
       * Ice-runtime than is done in RMI/Java.
       */
      exception ServerError
        {
          string serverStackTrace;
          string serverExceptionClass;
          string message;
        };
      // SESSION EXCEPTIONS --------------------------------
      /**
       * Base session exception, though in the OMERO.blitz
       * implementation, all exceptions thrown by the Glacier2
       * must subclass CannotCreateSessionException. See below.
       */
      exception SessionException extends ServerError
        {
        };
      /**
       * Session has been removed. Either it was closed, or it
       * timed out and one "SessionTimeoutException" has already
       * been thrown.
       */
      exception RemovedSessionException extends SessionException
        {
        };
      /**
       * Session has timed out and will be removed.
       */
      exception SessionTimeoutException extends SessionException
        {
        };
      /**
       * Server is in the progress of shutting down which will
       * typically lead to the current session being closed.
       */
      exception ShutdownInProgress extends SessionException
        {
        };
      // SESSION EXCEPTIONS (Glacier2) ---------------------
      /**
       * createSession() is a two-phase process. First, a PermissionsVerifier is
       * called which must return true; then a SessionManager is called to create
       * the session (ServiceFactory). If the PermissionsVerifier returns false,
       * then PermissionDeniedException will be thrown. This, however, cannot be
       * subclassed and so string parsing must be used.
       */
      /**
       * Thrown when the information provided omero.createSession() or more
       * specifically Glacier2.RouterPrx.createSession() is incorrect. This
       * does -not- subclass from the omero.ServerError class because the
       * Ice Glacier2::SessionManager interface can only throw CCSEs.
       */
      exception AuthenticationException extends Glacier2::CannotCreateSessionException
        {
        };
      /**
       * Thrown when the password for a user has expried. Use: ISession.changeExpiredCredentials()
       * and login as guest. This does -not- subclass from the omero.ServerError class because the
       * Ice Glacier2::SessionManager interface can only throw CCSEs.
       */
      exception ExpiredCredentialException extends Glacier2::CannotCreateSessionException
        {
        };
      /**
       * Thrown when any other server exception causes the session creation to fail.
       * Since working with the static information of Ice exceptions is not as easy
       * as with classes, here we use booleans to represent what has gone wrong.
       */
      exception WrappedCreateSessionException extends Glacier2::CannotCreateSessionException
        {
          bool    concurrency;
          long    backOff;    /* Only used if ConcurrencyException */
          string  type;       /* Ice static type information */
        };
      // OTHER SERVER EXCEPTIONS ------------------------------
      /**
       * Programmer error. Ideally should not be thrown.
       */
      exception InternalException extends ServerError
        {
        };
      // RESOURCE
      /**
       * Unrecoverable error. The resource being accessed is not available.
       */
      exception ResourceError extends ServerError
        {
        };
      /**
       * A script cannot be executed because no matching processor
       * was found.
       */
      exception NoProcessorAvailable extends ResourceError
        {
            /**
             * Number of processors that responded to the inquiry.
             * If 1 or more, then the given script was not acceptable
             * (e.g. non-official) and a specialized processor may need
             * to be started.
             **/
            int processorCount;
        };
      // CONCURRENCY
      /**
       * Recoverable error caused by simultaneous access of some form.
       */
      exception ConcurrencyException extends ServerError
        {
           long backOff; /* Backoff in milliseconds */
        };
      /**
       * Currently unused.
       */
      exception ConcurrentModification extends ConcurrencyException
        {
        };
      /**
       * Too many simultaneous database users. This implies that a
       * connection to the database could not be acquired, no data
       * was saved or modifed. Clients may want to wait the given
       * backOff period, and retry.
       */
      exception DatabaseBusyException extends ConcurrencyException
        {
        };
      /**
       * Conflicting changes to the same piece of data.
       */
      exception OptimisticLockException extends ConcurrencyException
        {
        };
      /**
       * Lock cannot be acquired and has timed out.
       */
      exception LockTimeout extends ConcurrencyException
        {
            int seconds; /* Informational field on how long timeout was */
        };
      /**
       * Background processing needed before server is ready
       */
      exception TryAgain extends ConcurrencyException
        {
        };
      exception MissingPyramidException extends ConcurrencyException
       {
            long pixelsID;
       };
      // API USAGE
      exception ApiUsageException extends ServerError
        {
        };
      exception OverUsageException extends ApiUsageException
        {
        };
      /**
       *
       */
      exception QueryException extends ApiUsageException
        {
        };
      exception ValidationException extends ApiUsageException
        {
        };
      // SECURITY
      exception SecurityViolation extends ServerError
        {
        };
      exception GroupSecurityViolation extends SecurityViolation
        {
        };
      exception PermissionMismatchGroupSecurityViolation extends SecurityViolation
        {
        };
      exception ReadOnlyGroupSecurityViolation extends SecurityViolation
        {
        };
      // OMEROFS
        /**
         * OmeroFSError
         *
         * Just one catch-all UserException for the present. It could be
         * subclassed to provide a finer grained level if necessary.
         *
         * It should be fitted into or subsumed within the above hierarchy
         **/
        exception OmeroFSError extends ServerError
          {
            string reason;
          };
    };
    #endif // OMERO_SERVERERRORS_ICE

Server Exceptions
-----------------

Due to the strict API boundary enforced by Ice, the client and server
exception hierarchies, though related, are distinct. The discussion
below is possibly of interest for server developers only. Client
developers should refer to the information about as well as to the
examples under |OmeroClients|.

Interceptor
~~~~~~~~~~~

Exception handling in the OMERO is centralized in an
:ref:`developers/Omero/Server/Aop` interceptor (:source:`source
code </components/server/src/ome/services/util/ServiceHandler.java>`).
All exceptions thrown by code are caught in a
``try {} catch (Throwable t) {}`` block. Exceptions which don't subclass
:source:`ome.conditions.RootException <components/model/src/ome/conditions/RootException.java>`
are wrapped in an
:source:`ome.conditions.InternalException <components/model/src/ome/conditions/InternalException.java>`.

The only exceptions to this are any interceptors which may be run before
the exception handler is run. The order of interceptors is defined in
:source:`services.xml <components/server/resources/ome/services/services.xml>`.

Hierarchy
~~~~~~~~~

The current exception hierarchy (package
:source:`ome.conditions <components/model/src/ome/conditions>`)
used is as follows:

-  RootException
-  

   -  InternalException : shouldn't reach the client; Bug! Contact
      administrator. E.g. NullPointerException, assertion failed, etc.
   -  ResourceError : fatal error in server. E.g. OutOfMemory, disk
      space full, DB is in illegal state, etc.
   -  DataAccessException
   -  

      -  SecurityViolation : don't do that! E.g. edit locked project,
         create new user.
      -  OptimisticLockException : re-load and compare. E.g. "someone
         else has already updated this project"
      -  ApiUsageException : something wrong with how you did things.
         E.g. IllegalStateException, object uninitialized, etc.
      -  ValidationException : something wrong with what you sent; sends
         list of fields, etc.; edit and retry. E.g. no "?" in image
         names.

where the colors indicate:

Abstract

FixAndRetryConditions

RetryConditions

NoRecourseConditions

Any other exception which reaches the client should be considered an
``OutOfServiceException``, meaning that something is (hopefully only)
temporarily wrong with the server. E.g. No connection, server down,
server restarting. But since this can't be caught since the server can't
be reached, there is no way to guarantee that a real
``OutOfServiceException`` is thrown.

Discussion
~~~~~~~~~~

``FixAndRetryConditions`` need to have information about what should be
fixed, like a Validation object which lists fields with error messages.
A ``RetryCondition`` could have a backoff value to prevent too frequent
retries.

Questions
~~~~~~~~~

-  What data should be available in the exceptions?
-  What other logic do we want on our exceptions, keeping in mind they
   will have to be re-implemented in all target languages?
