Administrator restrictions: relating OMERO.webadmin to OMERO.server
===================================================================


Summary
-------

OMERO allows you to create administrators with a subset of the full
administrator privileges,
see :doc:`/sysadmins/restricted-admins`.
The OMERO.web user interface form for creation and editing of
restricted administrators
(see the :help:`create new users <sharing-data#admin>` section)
collates the server-side privileges
into fewer options and gives the options user-friendly
names. Here, the mapping of the OMERO.web options to the 
server-side privileges is given. The server-side privileges
are more granular and direct work with them is possible on the CLI,
as described in :doc:`/sysadmins/cli/light-admins`.

Map of the OMERO.web UI options to the server-side privileges
-------------------------------------------------------------

================================ =============================================== 
Option in OMERO.web              Server-side privilege(s)  
-------------------------------- -----------------------------------------------
Sudo                              Sudo                    
Write data                        WriteOwned, WriteFile, WriteManagedRepo                           
Delete data                       DeleteOwned, DeleteFile, DeleteManagedRepo                
Chgrp                             Chgrp                
Chown                             Chown                
Create and Edit groups            ModifyGroup                
Create and Edit Users             ModifyUser               
Add Users to Groups               ModifyGroupMembership                
Upload Scripts                    WriteScriptRepo, DeleteScriptRepo                

================================ =============================================== 

.. note::
    **CLI lists restrictions, OMERO.web lists privileges**
    The lists shown using CLI commands recommended in 
    :doc:`/sysadmins/cli/light-admins` will be complementary
    lists to the ones which can be deduced from the table above.

.. note::
    **ReadSession privilege is never given to restricted admin**
    In OMERO.web, you can never create an administrator with restricted
    privileges who has the "ReadSession" privilege.
