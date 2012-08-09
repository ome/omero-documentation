SqlAction
=========

Internal server interface used to wrap all calls which speak JDBC
directly. This allows special logic to be introduced where necessary for
each RDBM.

Calls which use Hibernate for the cross-database conversion can use the
``org.hibernate.Session`` interface.
