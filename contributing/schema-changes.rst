Changing the schema
===================

Background
----------

OMERO.server stores data in PostgreSQL, a relational database system.
The data schema defines what data is stored and how, and new major
versions of OMERO may change that schema. Database upgrade scripts
transform data from an older version of OMERO so that it conforms to
the new schema.

Sometimes, a pull request on GitHub against the develop branch of
OMERO may change the code base in ways that cause changes in the
resulting database schema. This is a problem because the schema must
then be updated, and other developers need to know that code from that
pull request may cause problems unless they update their database
accordingly. To make sure that these database updates happen when
necessary, if your pull request affects the schema then you **must**
increment the database patch number and provide an updated schema as
described below.

Changes to the :model_doc:`OME-XML model <developers/model-overview.html>`
typically require corresponding changes in the OMERO data schema as
defined in its :omero_model_source:`XML mappings files
<src/main/resources/mappings/>`. These feed into OMERO's database
schema so this process is then required.

Patch number conflicts
----------------------

It is possible that another person may also be working on a pull request
that changes the schema and increments the database patch number. This
is unfortunate because if their pull request is merged it will be as
if your pull request does not change the patch number. Others may then
unwittingly attempt to use your code with an inappropriate database.
If you are considering model changes, it is wise to discuss this with
the core OME developers in advance. When working on a schema-changing
pull request, first ask or check if yours will be the only one that
includes a schema change.

Model object proxies
--------------------

Changes to model objects that are passed from the server to clients may
require corresponding changes to be made to the :omero_blitz_source:`IceMapper
<src/main/java/omero/util/IceMapper.java>` class so that the
client-side proxy objects are properly populated.

For example, :omero_commit:`commit 8815a409
<8815a409e24b41ff4c68829657ad98a278594ade>` adds fields to the `Roles` class
in the server's :omero_blitz_source:`System.ice
<src/main/slice/omero/System.ice>` whose instances can be passed
to clients via the :omero_blitz_source:`admin service API
<src/main/slice/omero/api/IAdmin.ice>` so a further
:omero_commit:`commit 2426042a <2426042a4f0b5e31a6e9743844da168a9e550375>` was
needed to populate those fields in the proxy object.

Database patch numbers
----------------------

:omero_source:`omero.properties <etc/omero.properties>` contains a
configuration setting for :literal:`omero.db.patch`. An existing OMERO
database records the patch number of its schema, as demonstrated from
the :literal:`psql` shell:

::

        omero=> select currentpatch from dbpatch;
         currentpatch
        --------------
                    4
        (1 row)

indicating that a database is on patch version 4. Correspondingly,

::

        $ grep ^omero.db.patch= etc/omero.properties
        omero.db.patch=4

By incrementing the patch number with each schema change, OMERO.server
is prevented from attempting to use a database whose schema does not
match its code.

Updating the schema and the SQL scripts
---------------------------------------

Users may wish to upgrade their database from an older version of OMERO to one
that has your new schema. SQL upgrade scripts are provided to allow users to
upgrade easily without having to understand the schema changes themselves, and
part of the upgrade script will involve making the schema changes entailed
with your pull request. The :omero_source:`sql/README.txt` file describes
where to find the appropriate script for you to adjust. SQL upgrade scripts
must be supplied as part of the code changes to upgrade the database from:

* the last release database, e.g. :file:`sql/psql/OMERO5.1DEV__5/OMERO5.0__0`,
* the previous patch's database, e.g.
  :file:`sql/psql/OMERO5.1DEV__5/OMERO5.1DEV__4`.

In your git branch with the code that requires a schema change, edit
:omero_source:`omero.properties <etc/omero.properties>` and increment the
value of :literal:`omero.db.patch`. For instance, in the above
example, edit the file so that

::

        $ grep ^omero.db.patch= etc/omero.properties
        omero.db.patch=5

Move the previous patch's SQL scripts into their new directory.

::

        $ git mv sql/psql/OMERO5.1DEV__4 sql/psql/OMERO5.1DEV__5

Restore the upgrade to that previous patch.

::

        $ mkdir sql/psql/OMERO5.1DEV__4
        $ git mv sql/psql/OMERO5.1DEV__5/OMERO5.1DEV__3.sql sql/psql/OMERO5.1DEV__4/OMERO5.1DEV__3.sql

Build OMERO.server with your code that changes the schema, then use
the :literal:`build-schema` build target to update the SQL scripts in
the new :file:`sql/psql/OMERO5.1DEV__5` directory.

::

        $ ./build.py build-schema

Now, when you use :program:`omero db script` in setting up a database for
your modified server, the generated SQL script creates the new schema
that your code requires. Use this script to set up your database so
that you can start OMERO.server and test your changes thoroughly.

A combination of :file:`sql/psql/OMERO5.1DEV__4/OMERO5.1DEV__3.sql` and
the changes within :file:`sql/psql/OMERO5.1DEV__5` that :command:`git
diff` reports should help you to create a new
:file:`sql/psql/OMERO5.1DEV__5/OMERO5.1DEV__4.sql`.

When you commit your code and issue a pull request, include the
changes to :omero_source:`omero.properties <etc/omero.properties>` and
:omero_sourcedir:`sql/psql` among the commits in the pull request.
