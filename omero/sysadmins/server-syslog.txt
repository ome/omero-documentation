Syslog configuration
====================

`syslog <https://en.wikipedia.org/wiki/Syslog>`_ is a standard for message
logging over networks. OMERO.server supports logging to either a local or
remote syslog service.

This allows all logs of the OMERO.server to be routed to a central location
instead of (or as well as) to a file.

.. note::

    It is important to note that this applies only to the OMERO.server itself,
    not to components like OMERO.web.


How it works
------------

Whenever a log message is generated, OMERO's logging framework will forward
that message to any configured appenders.

By default, OMERO is configured to log everything to files.

.. note::

    OMERO is configured to log a record of events for operations such as
    import. These are written directly to the Managed Repository. It is very
    likely that even if replacing file logging with syslog, this aspect should
    be retained in files. This is easily achieved by not changing any loggers
    using `SIFT`.


Configuration
^^^^^^^^^^^^^

To configure OMERO to be able to log to syslog, it is necessary to modify the
file ``OMERO.server/current/etc/logback.xml``. It is possible to do all the
configuration changes in this file alone, but for ease of config management,
it is demonstrated here where an additional
``OMERO.server/current/etc/logback_syslog.xml`` file is used in addition.

The following information is required to configure OMERO to log to syslog.

- The host on which syslog is running: e.g. `localhost`
- The port number on which syslog is running on that host: e.g. `514`
- The facility (`RFC 3164 <https://tools.ietf.org/html/rfc3164>`_) that OMERO
  should be handled as: e.g. `user` or `local6`

.. note::

    The facility is important because it determines how syslog will handle the
    messages it receives. It is unlikely that OMERO's log output will be desired
    in a local systems primary message log for example. On Linux this is often
    ``/var/log/messages``. Remember to configure the syslog configuration
    to avoid this. This is also where configuration of onward forwarding can
    be configured (to a service such as `splunk <http://www.splunk.com/>`_).
    Finally, syslog can be configured to specifically output this facility
    output to a file such as ``/var/log/omero``.

Create the new file ``OMERO.server/current/etc/logback_syslog.xml``:

::

    <?xml version="1.0" encoding="UTF-8"?>
    <included>
      <!-- syslog -->
      <appender name="SYSLOG" class="ch.qos.logback.classic.net.SyslogAppender">

        <!-- Exclude debug level logging from ome.services.blitz.repo.ManagedImportRequestI -->
        <filter class="ch.qos.logback.core.filter.EvaluatorFilter">
          <evaluator> <!-- defaults to type ch.qos.logback.classic.boolex.JaninoEventEvaluator -->
            <expression>return Level.DEBUG.equals(Level.toLevel(level)) &amp;&amp; logger.equals("ome.services.blitz.repo.ManagedImportRequestI");</expression>
          </evaluator>
          <OnMismatch>NEUTRAL</OnMismatch>
          <OnMatch>DENY</OnMatch>
        </filter>
        <!-- Exclude debug level logging from omero.* (except allow omero.cmd.*) -->
        <filter class="ch.qos.logback.core.filter.EvaluatorFilter">
          <evaluator> <!-- defaults to type ch.qos.logback.classic.boolex.JaninoEventEvaluator -->
            <expression>return Level.DEBUG.equals(Level.toLevel(level)) &amp;&amp; logger.startsWith("omero.") &amp;&amp; !logger.startsWith("omero.cmd.");</expression>
          </evaluator>
          <OnMismatch>NEUTRAL</OnMismatch>
          <OnMatch>DENY</OnMatch>
        </filter>

        <syslogHost>localhost</syslogHost>
        <facility>local6</facility>
        <suffixPattern>OMERO [%level] [%thread] %logger %msg</suffixPattern>
      </appender>

    </included>

This creates an appender that sends messages to syslog. `syslogHost` is the
host on which syslog is running. No port is specified as `514` is the default.
The `suffixPattern` is customizable. In this instance it is identical to OMERO's
file logger except an added "OMERO" identifier has been added for clarity. The
name of the appender has been set to `SYSLOG`. The filters replicate the same
behaviour from the default `FILE` appender.

.. note::

    If configuring the appender directly in the
    ``OMERO.server/current/etc/logback.xml`` file, then the `included` tag
    should not be used.

Within the `configuration` tag of ``OMERO.server/current/etc/logback.xml`` add:

::

    <include file="/path/to/OMERO.server/etc/logback_syslog.xml"/>

.. note::

    The included file path can be relative, but note that it is NOT relative
    to the ``OMERO.server/current/etc/logback.xml`` file, but to the
    current directory set by OMERO. It is highly recommended to use a full
    path.

Finally, also within ``OMERO.server/current/etc/logback.xml`` modify the `root`
tag to include a second `appender-ref` (It can also be replaced if the file
logs are not desired or syslog will handle writing those to a file on OMERO's
behalf):

::

    <root level="OFF">
      <appender-ref ref="SYSLOG"/>
      <appender-ref ref="FILE"/>
    </root>

.. note::

    A restart of OMERO will be necessary before this takes effect.
