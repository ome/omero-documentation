Client Server SSL verification
==============================

If you configure OMERO.web behind NGINX with a recognized SSL certificate your users can be sure that they are connecting to their intended server.

OMERO.server and clients do not automatically support host verification, so a
`man-in-the-middle attack <https://www.cloudflare.com/learning/security/threats/man-in-the-middle-attack/>`_
is possible.
This may result in users inadvertently transmitting their login credentials to an attacker.

This can be remedied by configuring OMERO.server with a certificate (the same certificate used for OMERO.web Nginx may work), and ensuring all OMERO clients are configured to verify the server certificate before connecting.


Server certificate
------------------

The easiest solution is to re-use the SSL certificates used to protect OMERO.web.
First convert the public certificate :file:`server.pem` and private key :file:`server.key` to the PKCS12 format where ``secret`` is the password used to protect the combined output file :file:`server.p12`::

    openssl pkcs12 -export -out server.p12 -in server.pem -inkey server.key -passout pass:secret

Copy :file:`server.p12` to the OMERO.server host, for instance to :file:`/etc/ssl/omero/`.

External access to OMERO.server is managed by the Glacier2 component which can be configured as follows::

    # Enable authenticating ciphers.
    omero config set omero.glacier2.IceSSL.Ciphers "ADH:HIGH:!LOW:!MD5:!EXP:!3DES:@STRENGTH"
    # Look for certificates in this directory, you can omit and use the full path to files instead
    omero config set omero.glacier2.IceSSL.DefaultDir /etc/ssl/omero/
    omero config set omero.glacier2.IceSSL.CertFile server.p12
    omero config set omero.glacier2.IceSSL.Password secret

For even stronger security require TLS 1.2, disable anonymous ciphers and only allow ``HIGH``::

    omero config set omero.glacier2.IceSSL.Protocols tls1_2
    omero config set omero.glacier2.IceSSL.ProtocolVersionMin tls1_2
    omero config set omero.glacier2.IceSSL.ProtocolVersionMax tls1_2
    omero config set omero.glacier2.IceSSL.Ciphers HIGH

Restart OMERO.server.


Internal certificate authority
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can also create your own certificates by creating a certificate authority (CA), and using that to create a server certificate.
Set this additional server configuration property to point to the public CA certificate :file:`/etc/ssl/omero/cacert.pem`::

    omero config set omero.glacier2.IceSSL.CAs cacert.pem

`Zeroc provide the Ice Certificate Utilities package <https://pypi.org/project/zeroc-icecertutils/>`_ to help create certificates, but if you know what you are doing you can use ``openssl`` directly.


Client host verification
------------------------

At present there is no easy way to configure the standard OMERO clients to require host verification.

If you are a developer the following Ice properties can be passed to the ``omero.client`` constructor to force host validation:

- ``IceSSL.Ciphers=HIGH``
- ``IceSSL.VerifyPeer=1``
- ``IceSSL.VerifyDepthMax=0``
- ``IceSSL.UsePlatformCAs=1``
- ``IceSSL.Protocols=tls1_2`` (if required by the server configuration)

Some platforms or languages do not support the cipher specification ``HIGH``.
Instead you can specify a cipher family such as ``AES256`` or ``AES_256``.
See the `IceSSL.Ciphers documentation <https://doc.zeroc.com/ice/3.6/property-reference/icessl#id-.IceSSL.*v3.6-IceSSL.Ciphers>`_.

If you have your own certificate authority replace ``IceSSL.UsePlatformCAs`` with:

- ``IceSSL.CAs=/path/to/CA/cacert.pem``

These properties check that the certificate chain is valid, but they do not verify that the hostname matches that of the certificate.
To verify the hostname either set:

- ``IceSSL.CheckCertName=1``

If your certificate hostname does not match exactly (for example, if you have a wildcard certificate) use the ``IceSSL.TrustOnly`` property instead.
Multiple ``CN`` can be specified:

- ``IceSSL.TrustOnly=CN=omero.example.org;CN=*.example.org``


Further information
-------------------

- https://doc.zeroc.com/technical-articles/glacier2-articles/teach-yourself-glacier2-in-10-minutes#TeachYourselfGlacier2in10Minutes-UsingSSLwithGlacier2
- https://doc.zeroc.com/ice/3.6/ice-plugins/icessl/configuring-icessl
- https://doc.zeroc.com/ice/3.6/ice-plugins/icessl/setting-up-a-certificate-authority
- https://doc.zeroc.com/ice/3.6/property-reference/icessl
