Deprecated Page

OMERO Tables Code Examples
--------------------------

Table of Contents
^^^^^^^^^^^^^^^^^

#. `OMERO Tables Code Examples <#OMEROTablesCodeExamples>`_

   #. `Pre-requisites <#Pre-requisites>`_
   #. `Creating Needed Services <#CreatingNeededServices>`_
   #. `Creating a Table <#CreatingaTable>`_
   #. `Inserting Data <#InsertingData>`_
   #. `Retrieving Data <#RetrievingData>`_
   #. `Updating Data <#UpdatingData>`_
   #. `Deleting Data <#DeletingData>`_

This page gives an overview on how to use the OMERO tables interface and
provides a number of simple java code snippets on how to connect,
create, and use OMERO tables. Please note that in themselves these
examples will not directly run (as they require a larger class structure
around them). However, an 'OmeroTablesExample.java' file has been
provided along with this page as a complete example of how everything
fits together.

Pre-requisites
~~~~~~~~~~~~~~

In order to run these examples, you must ensure that your OMERO.server
is running the tables. Instructions for how to set this up can be found
by reviewing the `OmeroTables </ome/wiki/OmeroTables>`_ page.
Additionally, a full list of all the methods currently available in the
` Table
API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/grid/Table.html>`_.

Creating Needed Services
~~~~~~~~~~~~~~~~~~~~~~~~

To use OMERO.tables you will need access to an omero.client instance and
service factory, along with several other proxies. The
` IQuery <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/IQuery.html>`_
and
` IUpdate <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/IUpdate.html>`_
proxies are used to access an OriginalFile where you will store your
table, and the
` Table <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/grid/Table.html>`_
proxy itself provides the functionality to update and edit the table's
internal structure. An example of what you will need would look
something like this:

::

        import omero.client;
        import omero.ServerError;
        
        import omero.api.ServiceFactoryPrx;
        import omero.api.IQueryPrx;
        import omero.api.IUpdatePrx;
        
        import omero.grid.Column;
        import omero.grid.Data;
        import omero.grid.LongColumn;
        import omero.grid.StringColumn;
        import omero.grid.TablePrx;
        
        import omero.model.OriginalFile;

        Client client = new client(hostname, 4064);
        ServiceFactoryPrx serviceFactory = client.createSession(myname, mypassword);
        IQueryPrx iQuery = serviceFactory.getQueryService();
        IUpdatePrx iUpdate = serviceFactory.getUpdateService();

Creating a Table
~~~~~~~~~~~~~~~~

Creating a new table requires you to create an originalFile where the
table will reside, initialize the table, and define its column layout.
Currently, each originalFile can only contain one table, although in the
future OMERO.tables may be updated to allow multiple tables to reside in
one originalFile.

::

        // Initialize (or reopen) the table
        private TablePrx initializeTable() throws ServerError 
        {
            TablePrx myTable;
            String myTableFile = "MyTableFile";
            List<OriginalFile> files = getOriginalFiles(myTableFile);
            
            if (files.isEmpty())     
            {
                Column[] columns = createColumns(1);
                myTable = sf.sharedResources().newTable(1, myTableFile);
                myTable.initialize(columns);

            } else {
                myTable = sf.sharedResources().openTable(files.get(0));  
            }
            return myTable;
        }
        
        // Helper Methods //
        
        // Creates a number of empty rows of [rows] size for the table
        private Column[] createColumns(int rows) 
        {
            Column[] newColumns = new Column[2];
            newColumns[0] = new LongColumn("MyLong", "", new long[rows]);
            newColumns[1] = new StringColumn("MyString", "", 256, new String[rows]);
            return newColumns;
        }
        
        // Get originalFile (in practice this method would also filter for experimenter id).
        public List<OriginalFile> getOriginalFiles(String fileName) throw ServerError
        {
            List l = iQuery.findAllByString(OriginalFile.class.getName(), "name", fileName, false, null);
            return (List<OriginalFile>) l;
        }

Inserting Data
~~~~~~~~~~~~~~

Inserting data into a table is a fairly straightforward process.

::

        private void addTableRow(String myLong, String myString) throws Exception {
                columns = createColumns(1);
                    
                LongColumn myLongs = (LongColumn) columns[0];
                StringColumn myStrings = (StringColumn) columns[1];
                
                myLongs.values[0] = myLong;
                myString.values[0] = myString;
                
                myable.addData(columns);
        }

A couple things to note here: First, its possible to create and add more
then one row at a time (by passing in createColumns(3) for example), and
by doing so save file access overhead when the addData(columns) commit .
Also note that OMERO.tables does not supply any mechanism for generating
unique key ids for each table row so creating and tracking UIDs must be
handled by you.

Retrieving Data
~~~~~~~~~~~~~~~

There are a couple of different ways to retrieve data from a table, but
for the purposes of this demonstration only the basics will be covered.
The simplist way to retrieve data is to use the table.read() method,
which returns a number of table columns between a range of rows, for
example:

::

        /**
         * Return all the table data
         * @return
         * @throws ServerError 
         */
        public Data getTableData() throws ServerError
        {
                long rows = myTable.getNumberOfRows();
                long[] ColNumbers = {0, 1};
                Data data = myTable.read(ColNumbers, 0L, rows);
                return data;
        }

A more complicated example involves retrieving a set of data based on a
query string. To do this, you will need to use the table.getWhereList()
method, passing in a query string and returning a index of rows matching
the query. For example:

::

        public long[] getTableRowsFromQuery() throws Exception
        {   
            String searchString = "(myLong >= " + 1 + ")";
            long[] ids = myTable.getWhereList(searchString, null, 0, myTable.getNumberOfRows(), 1);
            return ids;
        }

Note that this will only return you a list of the rows matching your
query. From here you will have to iterate over the data to retrieve any
specific data you require using something like this:

::

        Data d = getTableData();
            
        LongColumn myLongs = (LongColumn) columns[0];
        StringColumn myStrings = (StringColumn) columns[1];
            
        long[] ids = getTableRowsFromQuery()
                
        for (int h = 0; h < ids.length ; h++)
        {
            int i = (int) ids[h];

            aLong = myLongs.values[i];
            aString = myStrings.values[i];
        }

Updating Data
~~~~~~~~~~~~~

The ability to update table data is a feature only recently added to
OMERO.tables (as of mid-March 2010), so to access this functionality you
will need a newer edition of the server.

::

        public Integer updateRowStatus() throws ServerError
        {
            String searchString = "(myLong ==" + 1 + ")";
            long[] ids = myTable.getWhereList(searchString, null, 0, myTable.getNumberOfRows(), 1);
            
            Data data = getTableData(); 
            
            for (int h = 0; h < ids.length; h++)
            {
                int i = (int) ids[h];
                ((StringColumn) data.columns[1]).values[i] = "new string";
            }
            
            myTable.update(data);
            
            return returnedRows;
        }

Deleting Data
~~~~~~~~~~~~~

Currently there is **no functionality to delete specific rows** within
an existing table. However, it is possible to "empty" a table by
deleting its OriginalFile, and then re-create the table from scratch
using the method described above under `Creating a
Table </ome/wiki/OmeroTablesCodeExamples#CreatingaTable>`_.

Attachments
~~~~~~~~~~~

-  `OmeroTableExample.java </ome/attachment/wiki/OmeroTablesCodeExamples/OmeroTableExample.java>`_
   `|Download| </ome/raw-attachment/wiki/OmeroTablesCodeExamples/OmeroTableExample.java>`_
   (4.8 KB) - added by *bwzloranger* `2
   years </ome/timeline?from=2010-03-17T16%3A37%3A33Z&precision=second>`_
   ago.
