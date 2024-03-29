OMERO upgrade checks
====================

On each startup the OMERO server checks for available upgrades via the
:common_source:`UpgradeCheck class
<src/main/java/ome/system/UpgradeCheck.java>`.
An HTTP GET call is made to the URL configured in
:common_source:`omero-common.properties <src/main/resources/omero-common.properties>` as ``omero.upgrades.url``, currently
``http://upgrade.openmicroscopy.org.uk`` by default (note that viewing that link
in your browser will redirect you to this page).

.. note:: If you have been redirected here by clicking on a link to 
    ``http://upgrade.openmicroscopy.org.uk`` in an error message or log while 
    trying to run one of the **Bio-Formats command line tools**, please see 
    the :bf_v_doc:`Bio-Formats command line tools documentation 
    <users/comlinetools/index.html#version-checker>` for assistance.


Actions
-------

Currently the only action taken when an upgrade is necessary is a log
statement at WARN level.

.. parsed-literal::

    2017-09-01 12:21:32,070 WARN  [                 ome.system.UpgradeCheck] (      main) UPGRADE AVAILABLE:Please upgrade to |version_openmicroscopy| See https://downloads.openmicroscopy.org/latest/omero for the latest version

Future versions may also send emails and/or IMs to administrators. In
the case of critical upgrades, the server may refuse to start.

Privacy
-------

Currently, the only information which is being transmitted to the server
is:

-  Java virtual machine version
-  operating system details (architecture, version and name)
-  current server version
-  poll frequency (for determining statistics)
-  your IP address (standard HTTP header information)

.. note:: Currently the "poll" property is unused.

If this is a problem for your site, please see *Disabling* below.

Disabling
---------

If you would prefer to have no checks made, the check can be disabled by
setting the omero.upgrades.url property to an empty string:

::

    omero.upgrades.url=

Developers
----------

To use the UpgradeCheck class from your own
code, it is necessary to have ``omero-common-x.y.z.jar`` on your classpath. Then,

::

        String version = "yourAppVersion" // e.g. 5.5.0;
        ResourceBundle bundle = ResourceBundle.getBundle("omero-common");
        String url = bundle.getString("omero.upgrades.url");
        ome.system.UpgradeCheck check = new UpgradeCheck(
          url, version, "insight"); // Or "importer", etc.
        check.run();
        check.isUpgradeNeeded();
        // optionally
        check.isExceptionThrown();

will connect to the server and check your current version against the
latest release.

.. seealso:: 


    :doc:`/sysadmins/unix/server-installation`
        Instructions for installing OMERO.server on UNIX and UNIX-like
        platforms

    :doc:`/sysadmins/server-upgrade`
        Instructions for upgrading OMERO.server 

    :doc:`/sysadmins/server-security`
        Description of OMERO security practices
