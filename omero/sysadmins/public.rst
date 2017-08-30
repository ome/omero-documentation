Public data in the repository
=============================

The OMERO.web framework allows raw data to be published using built-in tools
or supplied through webservices to external web pages. Selected datasets
can be made visible to a 'public user' using the standard OMERO permissions
system, ensuring you always have control over how users can interact with
your data.

There are several ways of publishing data using OMERO.web:

- using a URL to launch the web-based Image viewer, as described in
  :ref:`launching_web_viewer`, which can be accompanied by a thumbnail. For
  more details of how to load the thumbnail see
  :ref:`urls_from_within_OMERO_web`

- embedding the image viewport directly into other web pages, for more
  details see :ref:`embedding_web_viewport`

- allowing public access to the OMERO.web data manager

- writing your own app to host your public data (see
  :doc:`/developers/Web/CreateApp`) and then allowing public access to the
  chosen URL for that app

The sections below describe how to set up these features.

Public user
-----------

The OMERO.web framework supports auto-login for a single username / password.
This means that any public visitors to certain OMERO.web pages will be
automatically logged in and will be able to access the data available to the
defined 'public user'.

To set this up on your OMERO.web installation:

- Create a group with read-only permissions (the name can be anything e.g.
  "public-data"). We recommend read-only permissions so that the public user
  will not be able to modify, delete or annotate data belonging to other
  members.

- Create a member of this group, noting the username and password (you will
  enter these below). Again, the First Name, Last Name, username and
  password can be anything you like.

  .. note:: If you add this member to other groups, all data in these groups
      will also become publicly accessible for as long as this user remains
      in the group.

- Enable the :property:`omero.web.public.enabled` property and set
  :property:`omero.web.public.user` and
  :property:`omero.web.public.password`:

  ::

     $ bin/omero config set omero.web.public.enabled True

     $ bin/omero config set omero.web.public.user '<username>'

     $ bin/omero config set omero.web.public.password '<password>'

- By default the public user is only allowed to perform GET requests. This means
  that the public user will not be able to Create, Edit or Delete data which
  requires POST requests.
  You can change that by setting the :property:`omero.web.public.get_only`
  property:
  ::

      $ bin/omero config set omero.web.public.get_only false

- Set the :property:`omero.web.public.url_filter`. This filter is a
  regular expression that will allow only matching URLs to be accessed
  by the public user.

  There are three common use cases for the URL filter:

  - Enable 'webgateway' URLs which includes everything needed for the
    full image viewer:

    ::

       $ bin/omero config set omero.web.public.url_filter '^/webgateway'


    without the ability to download data:

    ::

       $ bin/omero config set omero.web.public.url_filter '^/webgateway/(?!archived_files|download_as)'


    Then you can access public images via the following link
    `\http://your_host/webgateway/img_detail/IMAGE_ID/`.

  - Create your own public pages in a separate app
    (see :doc:`create app </developers/Web/CreateApp>`) and allow
    public access to that app. For example, to allow only
    URLs that start with '/my_web_public' you would use:

    ::

       $ bin/omero config set omero.web.public.url_filter '^/my_web_public'


  - You can use the full webclient UI for public browsing of images.
    Attempts by public user to create, edit or delete data will fail silently
    with the default :property:`omero.web.public.get_only` setting above. You 
    may also choose to disable various dialogs for these actions such as
    launching scripts or OME-TIFF export, for example:

    ::

       $ bin/omero config set omero.web.public.url_filter '^/(webadmin/myphoto/|webclient/(?!(script_ui|ome_tiff|figure_script))|webgateway/(?!(archived_files|download_as)))'

- Set the :property:`omero.web.public.server_id` which the public user will be
  automatically connected to. Default: 1 (the first server in the
  :property:`omero.web.server_list`)

  ::

     $ bin/omero config set omero.web.public.server_id 1


If you enable public access to the main webclient but still wish registered
users to be able to login, the login page can always be accessed using a link
of the form `\https://your_host/webclient/login/`.


Reusing OMERO session
---------------------

As an alternative to granting permanent public access to the data, the
OMERO.web framework supports password-less, OMERO session key-based
authentication. For example a direct link to image will look as follows:

::

    https://your_host/webgateway/img_detail/IMAGE_ID/?server=SERVER_ID&bsession=OMERO_SESSION_KEY

.. note::

    The `SERVER_ID` should match the index from the list set using
    :property:`omero.web.server_list` from the server session
    you created. If your list contains only one server, the index will be 1.

For more details about how to create an OMERO session see
:doc:`server-side session </developers/Server/Sessions>` or
use the :doc:`command line interface </users/cli/sessions>` to create one.

