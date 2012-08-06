#. `OMERO.webpublic <#OMERO.webpublic>`_

   #. `Base URL <#BaseURL>`_
   #. `Overview <#Overview>`_
   #. `Quick start <#Quickstart>`_

      #. `Requirements <#Requirements>`_
      #. `Adding a public user <#Addingapublicuser>`_
      #. `Configure OMERO.web using the OMERO PostgreSQL
         database <#ConfigureOMERO.webusingtheOMEROPostgreSQLdatabase>`_
      #. `Making a group collaborative and adding the public user to the
         group <#Makingagroupcollaborativeandaddingthepublicusertothegroup>`_
      #. `Creating a public URL <#CreatingapublicURL>`_

   #. `Configuration Options <#ConfigurationOptions>`_
   #. `Known limitations <#Knownlimitations>`_

OMERO.webpublic
===============

The OMERO.webpublic application is an **EXPERIMENTAL** OMERO.web
extension that provides a framework for *URL shortening*
(` http://en.wikipedia.org/wiki/URL\_shortening <http://en.wikipedia.org/wiki/URL_shortening>`_)
and public access to OMERO.web URLs.

Base URL
--------

-  ` http://omero.web.host/p/ <http://omero.web.host/p/>`_

Overview
--------

The OMERO.webpublic extension works predominantly by exploiting the
added permissions functionality of
`milestone:OMERO-Beta4.2 </ome/milestone/OMERO-Beta4.2>`_. The
administrator adds a new *public* user which when added to any existing
**collaborative** (at least read-only) OMERO experimenter group allows
users with in that group to *publicise* OMERO.web URLs. When a URL is
*publicised* a Django
`Link </ome/browser/omero/trunk/components/tools/OmeroWeb/omeroweb/webpublic/models.py>`_
model is written to the database and an ascending base62 identifier is
given to the user for use under the ``/p/`` base URL.

When this URL is visited, the *public* user is logged in and the user is
redirected to the original URL specified.

Quick start
-----------

Requirements
~~~~~~~~~~~~

-  OMERO installed and running with OMERO.web configured and running
-  PostgreSQL ` psycopg2 <http://initd.org/psycopg/>`_ module installed

   ::

       # easy_install psycopg2
       ...

Adding a public user
~~~~~~~~~~~~~~~~~~~~

An administrator should create a public experimenter group (ease of use
and security) and a public user.

Configure OMERO.web using the OMERO PostgreSQL database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An example set of configuration options:

::

    $ bin/omero config get
    ...
    omero.web.database_engine=postgresql_psycopg2
    omero.web.database_host=localhost
    omero.web.database_port=5432
    omero.web.database_name=omero
    omero.web.database_user=omero
    omero.web.database_password=omero
    ...
    omero.web.public.user=_public_
    omero.web.public.password=secret
    ...

Making a group collaborative and adding the public user to the group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once you've performed the above base configuration an administrator can
then proceed to either add a new collaborative (at least read-only)
group to be used with OMERO.webpublic or make an existing group
collaborative and add the *public* user to that group.

Creating a public URL
~~~~~~~~~~~~~~~~~~~~~

Navigate to the OMERO.webpublic base URL (``/p/`` as a user within the
collaborative group, paste an OMERO.web URL
(` http://omero.web.host/webclient/ <http://omero.web.host/webclient/>`_
for example) and click *Publicise*. A public URL has now been created
(which can be removed by navigating to ``/p/user_listing/``) which can
be shared with anyone.

Configuration Options
---------------------

OMERO.webpublic adds the following extended configuration options:

-  *Public* user username (omename):

   ::

       $ bin/omero config set omero.web.public.user '_public_'

-  *Public* user password:

   ::

       $ bin/omero config set omero.web.public.password 'password'

-  Django
   ` DATABASE\_ENGINE <http://docs.djangoproject.com/en/1.1/ref/settings/#database-engine>`_:

   ::

       $ bin/omero config set omero.web.database_engine 'postgresql_psycopg'

-  Django
   ` DATABASE\_HOST <http://docs.djangoproject.com/en/1.1/ref/settings/#database-host>`_:

   ::

       $ bin/omero config set omero.web.database_host 'psql.my.domain'

-  Django
   ` DATABASE\_PORT <http://docs.djangoproject.com/en/1.1/ref/settings/#database-port>`_:

   ::

       $ bin/omero config set omero.web.database_port '5432'

-  Django
   ` DATABASE\_NAME <http://docs.djangoproject.com/en/1.1/ref/settings/#database-name>`_:

   ::

       $ bin/omero config set omero.web.database_name 'omero'

-  Django
   ` DATABASE\_USER <http://docs.djangoproject.com/en/1.1/ref/settings/#database-user>`_:

   ::

       $ bin/omero config set omero.web.database_user 'omero'

-  Django
   ` DATABASE\_PASSWORD <http://docs.djangoproject.com/en/1.1/ref/settings/#database-password>`_:

   ::

       $ bin/omero config set omero.web.database_password 'omero'

Known limitations
-----------------

-  Some matching issues with ``http`` vs. ``https`` URLs
-  Only the **first** OMERO.web configured OMERO host is supported


.. seealso:: 
    |OmeroWeb|, 
    :javadoc:` OMERO.webpublic,
    epydoc <epydoc/omeroweb.webpublic-module.html>`
