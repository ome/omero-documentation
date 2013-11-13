//
// yourcode.cpp:
//

// Domain
#include <omero/client.h>
#include <omero/api/IAdmin.h>
// Std
#include <iostream>
#include <cassert>
#include <vector>
#include <time.h>
#include <map>

using namespace std;

/*
 * Pass "--Ice.Config=your_config_file" to the executable, or
 * set the ICE_CONFIG environment variable.
 */
int main(int argc, char* argv[])
{
    omero::client_ptr omero = new omero::client(argc, argv);
    omero::api::ServiceFactoryPrx sf = omero->createSession();
    sf->closeOnDestroy();

    // IAdmin is responsible for all user/group creation, password changing, etc.
    omero::api::IAdminPrx  admin  = sf->getAdminService();

    // Who you are logged in as.
    cout << admin->getEventContext()->userName << endl;

    // These two services are used for database access
    omero::api::IQueryPrx  query  = sf->getQueryService();
    omero::api::IUpdatePrx update = sf->getUpdateService();

    return 0;
}
