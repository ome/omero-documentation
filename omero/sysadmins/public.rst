Publishing data using OMERO.web
===============================

The OMERO.web framework allows raw data to be published using built-in tools
or supplied through web services to external web pages. Selected datasets
can be made visible to a 'public user' using the standard OMERO permissions
system, ensuring you always have control over how users can interact with
your data.

There are several ways of publishing data using OMERO.web:

- using a URL to launch the web-based Image viewer, as described in
  :ref:`launching_web_viewer`, which can be accompanied by a thumbnail. For
  more details of how to load the thumbnail, see
  :ref:`urls_from_within_OMERO_web`

- embedding the image viewport directly into other web pages, for more
  details see :ref:`embedding_web_viewport`

- allowing public access to the OMERO.web data manager

- writing your own app to host your public data (see
  :doc:`/developers/Web/CreateApp`) and then allowing public access to the
  chosen URL for that app

The sections below describe how you might use these features and how to
set them up.

.. _public_user:

Configuring public user
-----------------------

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
  enter these below). Again, the First name, Last name, Username and
  Password can be anything you like.

  .. note:: If you add this member to other groups, all data in these groups
      will also become publicly accessible for as long as this user remains
      in the group.

- Enable the :property:`omero.web.public.enabled` property and set
  :property:`omero.web.public.user` and
  :property:`omero.web.public.password`:

  ::

     $ omero config set omero.web.public.enabled True

     $ omero config set omero.web.public.user '<username>'

     $ omero config set omero.web.public.password '<password>'

- By default the public user is only allowed to perform GET requests. This
  means that the public user will not be able to Create, Edit or Delete data,
  as these require POST requests.
  If you want to allow these actions from the public user, you can change the
  :property:`omero.web.public.get_only` property::

      $ omero config set omero.web.public.get_only false

.. _public.url_filter:

- Set the :property:`omero.web.public.url_filter`. This filter is a
  regular expression that will allow only matching URLs to be accessed
  by the public user. If this is not set, no URLs will be publicly
  available.

  You need to configure the url_filter to *allow* all URLs that are
  required for the pages you wish to be public but to *block* any
  URLs that you do not want public users to access.

  Some examples are listed below:

  - To allow all URLs from a single app, such as 'webgateway', use a filter
    for URLs that start with the app name. For example::

       $ omero config set omero.web.public.url_filter '^/webgateway'

    This filter permits all URLs needed for the full image viewer.
    If you wish to block webgateway URLs for downloading data, use::

       $ omero config set omero.web.public.url_filter '^/webgateway/(?!archived_files|download_as)'

  - You may need to allow access to additional URLs for some apps.
    For example, the :omero:`OMERO.iviewer <iviewer/>` also
    uses some ``webgateway`` and ``api`` URLs::

       $ omero config set omero.web.public.url_filter '^/iviewer|webgateway|api'

  - You can use the full webclient UI for public browsing of images.
    Attempts by public user to create, edit or delete data will fail silently
    with the default :property:`omero.web.public.get_only` setting above. You
    may also choose to disable various dialogs for these actions such as
    launching scripts or OME-TIFF export, for example::

       $ omero config set omero.web.public.url_filter '^/(webadmin/myphoto/|webclient/(?!(script_ui|ome_tiff|figure_script))|webgateway/(?!(archived_files|download_as))|iviewer|api)'

- Set the :property:`omero.web.public.server_id` which the public user will be
  automatically connected to. Default: 1 (the first server in the
  :property:`omero.web.server_list`)::

     $ omero config set omero.web.public.server_id 1


If you enable public access to the main webclient but still wish registered
users to be able to log in, the login page can always be accessed using a link
of the form `\https://your_host/webclient/login/`.


.. _hosting_data_example:

Full example of hosting data for a publication
----------------------------------------------

Putting the pieces of this puzzle together, the following describes the steps
of a complete workflow for using OMERO to host public data associated with a
publication. It is illustrated using an example publication from the Swedlow
lab in Dundee,
`Schleicher et al, 2017 <http://dx.doi.org/10.1098/rsob.170099>`_ with the
data hosted at
`<https://omero.lifesci.dundee.ac.uk/pub/schleicher-et-al-2017>`_.

Ansible playbooks can be found describing how the production server in Dundee
("nightshade") was configured in the
:omero_subs_github_repo_root:`prod-playbooks <prod-playbooks>`
repository on GitHub.

Group setup
^^^^^^^^^^^

A group-per-publication allows the public user to be selectively added (or
removed) from given publications to decide their visibility.

#. Create a dedicated read-only group to host the raw data underlying the
   publication (see :doc:`cli/usergroup`).
#. Add all the authors of the paper to this new group.
#. Once you have configured OMERO.web to create a public user (see below), add
   the public user as a member of the newly created read-only group.

Configuring OMERO.web
^^^^^^^^^^^^^^^^^^^^^

If you wish to have an automatically logged-in public user while still giving
your existing OMERO users an unchanged user experience (i.e. not automatically
logging them in as the public user), a dedicated,
:doc:`separate web server <unix/install-web/web-deployment>` for servicing
the public workflows can be added and configured to point at your existing
OMERO.server. This is the workflow adopted here by adding a public OMERO.web at
https://omero.lifesci.dundee.ac.uk, without changing the existing internal
OMERO.web.

#. Follow the steps in :ref:`public_user` above on the chosen OMERO.web.
#. Also configure :ref:`the filter on the public user <public.url_filter>`
   on the chosen OMERO.web by setting :property:`omero.web.public.url_filter`
   to allow 'webclient' so that the full webclient is visible for the public
   user, and thus the Data tree with Projects and Datasets is also browsable,
   as well as the Tags tab and the full image viewer.

Data migration
^^^^^^^^^^^^^^

The data to be made public will need to be in the publication group to be
considered "published".

#. Move the original images into the dedicated group using OMERO.web or
   :doc:`OMERO.cli </users/cli/chgrp>`. The CLI is best used where Images or
   Datasets are cross-linked to other Datasets or Projects in the original
   group. The command ``omero chgrp Project:$ID --include Dataset,Image``
   cuts the cross-links in the original group and preserves the
   Project/Dataset/Image hierarchy prepared for the move by the author.
#. If you have used OMERO.figure to create your figures for publication, you
   can always find the original data by using the 'info' tab, as shown in the
   :help:`OMERO.figure Help guide <figure.html#info>` (OMERO.figure supports a
   complete figure creation workflow, including exporting figures into image
   processing applications for final adjustments - see the
   :help:`OMERO.figure Help guide <figure.html>` for full details).
#. Having all the data belong to one user simplifies the UI experience for
   public users. If necessary, ownership of data can be transferred using the
   'Chown' privilege (see :doc:`restricted-admins` and
   :doc:`/users/cli/chown`).

Data layout
^^^^^^^^^^^

Once the data is in the dedicated read-only group, it can be reorganized
and renamed to reflect the publication e.g. Projects can be renamed
according to the corresponding figure panels in the manuscript while the
names of the Datasets could be retained corresponding to different
treatment conditions represented in each figure panel.
For example, Project
`Schleicher_etal_figure7_c <https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27920>`_
contains images underlying the
`publication Figure panel 7(c) <https://royalsocietypublishing.org/cms/attachment/36fd7495-4d87-454f-952e-a581da261f71/rsob170099f07.jpg>`_.
Some Projects underlie two publication figure panels, such as Project
`Schleicher_etal_figure2_a_c <https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27917>`_
where representative images are shown in panel (a) and the
corresponding quantification is shown in panel (c) of `Figure 2 <https://royalsocietypublishing.org/cms/attachment/aac23d26-2197-4dc1-8f85-7bb5686f926d/rsob170099f02.jpg>`_.
This makes clear which original images are underlying which figure panels
in the publication.

Data can also be tagged with OMERO tags to enhance the browsing
possibilities through these data for any user with basic knowledge of
OMERO. For example, see `Tag:Schleicher_etal_figure1_a <https://omero.lifesci.dundee.ac.uk/webclient/?show=tag-364188>`_. The
tags are highlighting the images displayed in the publication figures as
images. The other, non-tagged images in the group are the ones used for
analysis which produced the published numerical data.

Key-Value pairs can be used to add more detailed information about the
study and publication. For example, go to `Schleicher_etal_figure1_a <https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27936>`_
and expand the 'Key-Value Pairs' section in the right-hand pane to display
the content (see the :help:`Managing data guide <managing-data.html#keyvalue>` for information on using Key-Value pairs).

Configuring URLs
^^^^^^^^^^^^^^^^

The URL of the first Project (corresponding to the first
figure in the publication) can be used for a DOI and data landing
page. For example, Project 'Schleicher_etal_figure1_a'
`<https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27936>`_
corresponds to `<http://dx.doi.org/10.17867/10000109>`_.

Optionally, you can decide on a set pattern of URLs for this and future
publications. For example, in Dundee we have established a pattern which
supposes every new publication from our institution will be in a separate
group, and this group will be directly navigable by the public user using
the syntax: “server-address/pub/publication-identifier”. This means for
example, `<https://omero.lifesci.dundee.ac.uk/pub/schleicher-et-al-2017>`_
is the link where "omero.lifesci.dundee.ac.uk" is the server address, and
"schleicher-et-al-2017" is the publication-identifier.

This makes use of redirects allowing
`<https://omero.lifesci.dundee.ac.uk/pub/schleicher-et-al-2017>`_ to
link to the correct group and Project in OMERO, just as the
DOI above does. Redirects need to be set in the
`NGINX <https://nginx.org/>`_ component of the OMERO.web installation
dedicated to publication workflows. You can find our configuration for this
example :omero_subs_github_repo_root:`here on GitHub <prod-playbooks/blob/2018-01/nightshade-webclients.yml#L181>`:

.. code-block:: shell

      location /pub/schleicher-et-al-2017 {
          return 307 /webclient/?show=project-27936;
      }
