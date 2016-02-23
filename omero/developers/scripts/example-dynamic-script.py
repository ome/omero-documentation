#!/usr/bin/env python
# Example OMERO.script using dynamic arguments

import omero
import omero.gateway
from omero import scripts
from omero.rtypes import rstring, unwrap
from datetime import datetime


def get_params():
    try:
        client = omero.client()
        client.createSession()
        conn = omero.gateway.BlitzGateway(client_obj=client)
        conn.SERVICE_OPTS.setOmeroGroup(-1)
        objparams = [rstring('Dataset:%d %s' % (d.id, d.getName()))
                    for d in conn.getObjects('Dataset')]
        if not objparams:
            objparams = [rstring('<No objects found> %s' % datetime.now())]
        return objparams
    except Exception as e:
        return ['Exception: %s' % e]
    finally:
        client.closeSession()


def runScript():
    """
    The main entry point of the script
    """

    startTime = datetime.now()
    # objparams = [str(datetime.now()) for n in xrange(2)]
    objparams = get_params()

    client = scripts.client(
        'Dynamic_Test.py',
        'Test dynamic parameters',

        scripts.String(
            'Object', optional=False, grouping='1',
            description='Select an object',
            values=objparams),

        namespaces=[omero.constants.namespaces.NSDYNAMIC],
    )

    paramsTime = datetime.now()

    try:
        scriptParams = client.getInputs(unwrap=True)
        message = ''
        message += 'Params: %s\n' % scriptParams

        stopTime = datetime.now()
        message += 'Parameters time: %s\n' % str(paramsTime - startTime)
        message += 'Processing time: %s\n' % str(stopTime - paramsTime)

        print message
        client.setOutput('Message', rstring(str(message)))

    finally:
        client.closeSession()

if __name__ == '__main__':
    runScript()
