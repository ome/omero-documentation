.. _rst_tutorial_editor-latest-features:

Latest Features in OMERO.editor
===============================

This page details the latest version Beta-4 edition of the OMERO.editor.

OMERO.editor can be run from within the Insight client but can also run
as a stand-alone application (without connecting to OMERO) saving files
locally. The stand-alone OMERO.editor can be found in the clients
download package.

Start OMERO.editor via OMERO.insight
------------------------------------

You can run the OMERO.editor as a standalone application (no server
connection) OR via OMERO.insight.

In OMERO.insight, you start OMERO.editor by clicking the OMERO.editor
icon ![Editor Icon] (../images/omeroEditorLink2.png) in the toolbar.

In OMERO.insight, you can open any OMERO.editor file by double clicking
it, either when you find it attached to a Project, Dataset or Image, or
by browsing under :menuselection:`View --> Attachments` (see screen shot).

.. raw:: html

   <p class="CenterImage">

.. raw:: html

   </p>

UI Layout
---------

The OMERO.editor displays a single file per window, which will typically
be split into 3 panels.

The left of the UI displays a hierarchical outline of the file that can
be used for navigating large files. The center is the main display of
the file for editing experimental variables and the right panel is for
editing the protocol 'template'.

Text View of protocols
----------------------

In order to make protocols appear more familiar to users, files can now
be viewed in a "Text" view, which displays the title, description and
parameters in a page layout (below Left). Protocols can also be viewed
in the "Tree" view, which resembles the older (Beta-3) OMERO.editor
layout (below Right). You can switch between these views by using the
tabs at the top of the page.

.. raw:: html

   <p class="CenterImage">

.. raw:: html

   </p>

   <p class="CenterImage">

.. raw:: html

   </p>

Multiple 'parameters' per step
------------------------------

In order to record a single step of a protocol that has multiple
variables, e.g. "Incubate cells with {Antibody} at a dilution of {1:500}
for {60 minutes}", OMERO.editor now supports multiple parameters per
step (see screen-shots below). Placing parameters in context with
descriptions also allows a more natural way of combining multiple
parameters and removes the need to give every parameter a description.

.. raw:: html

   <p class="CenterImage">

.. raw:: html

   </p>

   <p class="CenterImage">

.. raw:: html

   </p>

Screen-shots of multiple parameters in the Text view (left) and the Tree
view (right). In both cases, parameters can be seen in the context of
the step description, which can be edited in the right panel of the Tree
view, or the page layout of the Text view. Parameters can be edited in
the right panel of both views.

Table of parameter values
-------------------------

For some steps in a protocol, the parameters can have more than one
value. In the above example, several antibodies may be used for staining
different targets, and each one will have a different concentration and
staining time. OMERO.editor supports the documenting of this data by
allowing the values for each parameter to be displayed in a table (add
table with the |Add Table Button| icon in the Tree view). Each parameter
is represented by a column, with the column name displaying the name of
each parameter. 'Drop-down' and 'Check-box' parameters are represented
with the appropriate controls in the table (see below).

.. raw:: html

   <p class="CenterImage">

.. raw:: html

   </p>

.. |Add Table Button| image:: ../images/nuvola_add_table16.png
