Complete workflow for hosting data for a publication
====================================================

The following describes the steps of a complete workflow for using OMERO to
host public data associated with a publication. It is illustrated using an
example publication from our lab in Dundee,
`Schleicher et al, 2017 <http://dx.doi.org/10.1098/rsob.170099>`_.

Group setup
-----------

#. Create a dedicated read-only group to host the raw data underlying the
   publication (see :doc:`cli/usergroup`)
#. Add all the authors of the paper to this new group.
#. If you have not already done so, configure the :ref:`public_user`.
#. Add the public user as a member of the newly created read-only group to
   make all the data publicly available.

Data setup
----------

#. Move the original images into the dedicated group using OMERO.web or
   :doc:`OMERO.cli </users/cli/chgrp>`. The CLI is best used where Images or
   Datasets are cross-linked to other Datasets or Projects in the original
   group. The command ``bin/omero chgrp Project:$ID --include Dataset,Image``
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

Configuring OMERO.web
---------------------

#. Configure the OMERO.web :ref:`filter on the public user <public.url_filter>` by setting
   :property:`omero.web.public.url_filter` to allow 'webclient' so that the
   full webclient is visible for the public user, and thus the Data tree with
   Projects and Datasets is also browsable, as well as the Tags tab and the
   full image viewer.
#. In order to have both a public webclient and a closed webclient side by
   side without affecting the existing closed webclient (and thus giving your
   existing non-public OMERO users an unchanged user experience in their
   workflows), a dedicated,
   :doc:`separate web server <unix/install-web/web-deployment>` for servicing
   the public workflows can be added and configured to point at your existing
   OMERO.server.

Data configuration
------------------

#. Once the data is in the dedicated read-only group, it can be reorganized
   and renamed to reflect the publication e.g. Projects can be renamed
   according to the corresponding figure panels in the manuscript while the
   names of the Datasets could be retained corresponding to different
   treatment conditions represented in each figure panel. For example, Project
   `Schleicher_etal_figure7_c <https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27920>`_
   contains images underlying the
   `publication Figure panel 7c <http://rsob.royalsocietypublishing.org/content/royopenbio/7/11/170099/F7.large.jpg>`_.
   Some Projects underlie two publication figure panels, such as Project
   `Schleicher_etal_figure2_a_c <https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27917>`_
   where representative images are shown in panel a and the
   corresponding quantification is shown in panel c of `Figure 2 <http://rsob.royalsocietypublishing.org/content/royopenbio/7/11/170099/F2.large.jpg>`_. 
   This makes clear which original images are underlying which figure panels
   in the publication.
#. Data can also be tagged with OMERO tags to enhance the browsing
   possibilities through these data for any user with basic knowledge of
   OMERO. For example, see `Tag:Schleicher_etal_figure1_a <https://omero.lifesci.dundee.ac.uk/webclient/?show=tag-364188>`_). The
   tags are highlighting the images displayed in the publication figures as
   images (the other, non-tagged images in the group are the ones used for
   analysis which produced the published numerical data).
#. Key-Value pairs can be used to add more detailed information about the
   study and publication. For example, go to `Schleicher_etal_figure1_a <https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27936>`_
   and expand the 'Key-Value Pairs' section in the right-hand pane to display
   the content (see the :help:`Managing data guide <managing-data.html#keyvalue>` for information on using Key-Value pairs).

Configuring URLs
----------------

#. The URL of the first Project (corresponding to the first
   figure in the publication) can be used for a DOI and data landing
   page. For example, Project 'Schleicher_etal_figure1_a'
   `<https://omero.lifesci.dundee.ac.uk/webclient/?show=project-27936>`_
   corresponds to `<http://dx.doi.org/10.17867/10000109>`_.
#. Optionally, you can decide on a set pattern of URLs for this and future
   publications. For example, in Dundee we have established a pattern which
   supposes every new publication from our institution will be in a separate
   group, and this group will be directly navigable by the public user using
   the syntax: “server-address/pub/publication-identifier”. This means for
   example, `<https://omero.lifesci.dundee.ac.uk/pub/schleicher-et-al-2017>`_
   is the link where "omero.lifesci.dundee.ac.uk" is the server address, and
   "schleicher-et-al-2017" is the publication-identifier.
#. This makes use of redirects allowing
   `<https://omero.lifesci.dundee.ac.uk/pub/schleicher-et-al-2017>`_ to
   redirect to the correct group and Project in OMERO in the same way as the
   DOI above (these need to be set in the `NGINX <http://nginx.org/>`_
   component of the OMERO.web installation dedicated to publication
   workflows).
