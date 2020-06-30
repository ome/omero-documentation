Editing OMERO.web
=================

If you need to make changes to OMERO.web itself, then you
can perform a developer install of ``omero-web``.
You need to be within a virtual environment with ``omero-py``
installed as described at :doc:`/developers/Python`.
Then::

    $ git clone https://github.com/ome/omero-web.git
    $ cd omero-web
    $ pip install -e .

This will allow you to edit and run the source code without a build step.

You can then run OMERO.web as described at :doc:`/developers/Web/Deployment`.
You may need to restart the web server after saving changes, particularly for
python files, before refreshing the browser.
