OMERO.web customization
=======================

The OMERO.web offer a flexible user interface that can be customized.
The sections below describe how to set up these features.

Note that depending on the deployment choice, OMERO.web will not activate
configuration changes until gunicorn is restarted using ``bin/omero web
restart``.

Note that the command ``bin/omero`` used throughout this page refers to ``OMERO.py/bin/omero`` if OMERO.web is deployed **separately** otherwise it refers to ``OMERO.server/bin/omero``.


Index page
----------

Create new custom template in
:file:`/your/path/to/templates/mytemplate/index.html` and add the following::

    $ bin/omero config set omero.web.template_dirs '/your/path/to/templates/'
    $ bin/omero config set omero.web.index_template 'mytemplate/index.html'

.. figure:: /images/indexPage.png

Note that users will no longer be automatically redirected to the login page
once an index page is added.

Login page
----------

:property:`omero.web.login_logo` allows you to customize the webclient login
page with your own logo. Logo images should ideally be 150 pixels high or
less and will appear above the OMERO logo. You will need to host the image
somewhere else and link to it with::

    $ bin/omero config set omero.web.login_logo 'http://www.url/to/image.png'

.. figure:: /images/customLogin.png


Login redirection
-----------------

:property:`omero.web.login_redirect` property redirects to the given location
after logging in::

    $ bin/omero config set omero.web.login_redirect '{"redirect": ["webindex"], "viewname": "load_template", "args":["userdata"], "query_string": "experimenter=-1"}'

Top links menu
--------------

:property:`omero.web.ui.top_links` adds links to the top header::

    $ bin/omero config append omero.web.ui.top_links '["Figure", "figure_index", {"title": "Open Figure in new tab", "target": "_blank"}]'
    $ bin/omero config append omero.web.ui.top_links '["GRE", "http://lifesci.dundee.ac.uk/gre"]'

.. figure:: /images/topLink.png

Open With option
----------------

:property:`omero.web.open_with` adds entry to the Open with right-click menu in tree::

    $ bin/omero config append omero.web.open_with '["omero_figure", "new_figure",
      {"supported_objects":["images"], "target": "_blank", "label": "OMERO.figure"}]'


Group and Users in dropdown menu
--------------------------------

Customize the groups and users dropdown menu by changing the labels or hiding
the entire list::

    $ bin/omero config set omero.client.ui.menu.dropdown.leaders.label "Owners"
    $ bin/omero config set omero.client.ui.menu.dropdown.leaders.enabled true
    $ bin/omero config set omero.client.ui.menu.dropdown.colleagues.label "Members"
    $ bin/omero config set omero.client.ui.menu.dropdown.colleagues.enabled true
    $ bin/omero config set omero.client.ui.menu.dropdown.everyone.label "All Members"
    $ bin/omero config set omero.client.ui.menu.dropdown.everyone.enabled false

.. figure:: /images/dropdownMenu.png


Orphaned container
------------------

:property:`omero.client.ui.tree.orphans.name` allows you to change the name
of the "Orphaned images" container located in the client data manager tree::

    $ bin/omero config set omero.client.ui.tree.orphans.name "Orphaned images"

.. figure:: /images/orphans.png


Disabling scripts
-----------------

:property:`omero.client.scripts_to_ignore` hides the scripts that
the clients should not display::

    $ bin/omero config append omero.client.scripts_to_ignore "/my_scripts/script.py"

.. figure:: /images/disableScripts.png


.. _download_restrictions:

Download restrictions
---------------------

:property:`omero.policy.binary_access` determines whether users can access
binary files from disk. Binary access includes all attempts to download
a file from the UI::

    $ bin/omero config set omero.policy.binary_access "+read,+write,+image"

.. figure:: /images/downloadRestriction.png
