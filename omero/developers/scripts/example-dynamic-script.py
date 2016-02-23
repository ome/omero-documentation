#!/usr/bin/env python
# Example OMERO.script using dynamic arguments
# Included in omero/developers/scripts/user-guide.txt
# A list of datasets will be dynamically generated and used to populate the
# script parameters every time the script is called

import omero
import omero.gateway
from omero import scripts
from omero.rtypes import rstring


def get_params():
    try:
        client = omero.client()
        client.createSession()
        conn = omero.gateway.BlitzGateway(client_obj=client)
        conn.SERVICE_OPTS.setOmeroGroup(-1)
        objparams = [rstring('Dataset:%d %s' % (d.id, d.getName()))
                     for d in conn.getObjects('Dataset')]
        if not objparams:
            objparams = [rstring('<No objects found>')]
        return objparams
    except Exception as e:
        return ['Exception: %s' % e]
    finally:
        client.closeSession()


def runScript():
    """
    The main entry point of the script
    """

    objparams = get_params()

    client = scripts.client(
        'Example Dynamic Test', 'Example script using dynamic parameters',

        scripts.String(
            'Dataset', optional=False, grouping='1',
            description='Select a dataset', values=objparams),

        namespaces=[omero.constants.namespaces.NSDYNAMIC],
    )

    try:
        scriptParams = client.getInputs(unwrap=True)
        message = 'Params: %s\n' % scriptParams
        print message
        client.setOutput('Message', rstring(str(message)))

    finally:
        client.closeSession()

if __name__ == '__main__':
    runScript()
