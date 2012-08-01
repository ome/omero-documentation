Deprecated Page

3.2 ONLY. The latest version of page is available at
 `http://www.openmicroscopy.org/site/documents/data-management/omero4/server/security <http://www.openmicroscopy.org/site/documents/data-management/omero4/server/security>`_
=============================================================================================================================================================================

Securing OMERO
==============

Firewall Configuration
----------------------

Securing your OMERO system with so called *firewalling* or *packet
filtering* can be done quite easily. OMERO clients must connect to **4**
TCP ports for communication with your OMERO.server:

-  ``TCP/1098``
   (` RmiPort <http://wiki.jboss.org/wiki/Wiki.jsp?page=RmiPort>`_)
-  ``TCP/1099``
   (` RMI <http://www.jboss.org/wiki/Wiki.jsp?page=UsingJBossBehindAFirewall>`_)
-  ``TCP/4444``
   (` RMIObjectPort <http://wiki.jboss.org/wiki/Wiki.jsp?page=RMIObjectPort>`_)
-  ``TCP/3873`` (` EJB3
   InvokerLocator <http://www.jboss.org/wiki/Wiki.jsp?page=UsingJBossBehindAFirewall>`_)

Please make sure these are open on the machine running JBoss. Further
information can be found on the ` JBoss
Wiki <http://www.jboss.org/wiki/Wiki.jsp?page=UsingJBossBehindAFirewall>`_.
**NOTE:** There should be no reason for you to manually configure the
``jboss-service.xml`` file in your JBoss instance.

Example OpenBSD firewall rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    block in log on $ext_if from any to <omero_server_ip>
    pass in on $ext_if proto tcp from any to <omero_server_ip> port 1098
    pass in on $ext_if proto tcp from any to <omero_server_ip> port 1099
    pass in on $ext_if proto tcp from any to <omero_server_ip> port 4444
    pass in on $ext_if proto tcp from any to <omero_server_ip> port 3873

Example Linux firewall rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    iptables -P INPUT drop
    iptables -A INPUT -p tcp --dport 1098 -j ACCEPT
    iptables -A INPUT -p tcp --dport 1099 -j ACCEPT
    iptables -A INPUT -p tcp --dport 4444 -j ACCEPT
    iptables -A INPUT -p tcp --dport 3873 -j ACCEPT

--------------

Passwords
---------

The password hashes stored in the ``password`` table are generated
equivalent to the command:

::

    $ echo -n "ome" | openssl md5 -binary | openssl base64
    vvFwuczAmpyoRC0Nsv8FCw==

If the password for the root user were lost, the only way to reset it
(in the absence of other admin accounts) would be to manually update the
password table.

::

    $ PASS=`echo -n "ome" | openssl md5 -binary | openssl base64`

    $ psql mydatabase -c " select * from password"
     experimenter_id |           hash           
    -----------------+--------------------------
                   0 | Xr4ilOzQ4PCOq3aQ0qbuaQ==
    (1 row)

    $ psql mydatabase -c "update password set hash = '$PASS' where experimenter_id =0 "
    UPDATE 1

    $ psql mydatabase -c " select * from password"
     experimenter_id |           hash           
    -----------------+--------------------------
                   0 | vvFwuczAmpyoRC0Nsv8FCw==
    (1 row)

--------------

See also: `OmeroInstall </ome/wiki/OmeroInstall>`_,
`OmeroAndPostgres </ome/wiki/OmeroAndPostgres>`_
