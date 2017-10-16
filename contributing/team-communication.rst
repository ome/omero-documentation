Team communication
==================

For anyone completely new to the project, it is most important to know
how to get plugged in. There is a fairly extensive amount of
communication flying around related to the project, and being able to
find and track it may take some time.

Instant messaging and video conferencing
----------------------------------------

On a day-to-day level, the team meets in a Slack chatroom. Slack can be used
in your internet browser or via an app; you will be invited to join the team
by an admin.

The daily stand-up meeting is managed via the '#general' channel, with notes
in google docs that are edited throughout the day as people complete the tasks
assigned to them.

Slightly less frequently, members of the team meet on Zoom for voice
discussions. These meetings are organized as needed, but should provide
feedback where appropriate (tickets, notes, etc).

Other IM tools
^^^^^^^^^^^^^^

Slack is the only IM tool used by the entire OME team. Some team members do
also use IRC (#ome on irc.freenode.net) and provide support via that channel
but all significant conversations should be documented formally via Trac
tickets or Trello. In general, all external requests for help are best
submitted and dealt with via the forums or mailing lists (see below) so they
are available for the whole community. In particular, the various Gitter
channels associated with OME projects on GitHub are not routinely monitored
and responded to.

Trac
----

.. note:: The team is increasingly moving away from Trac and towards using
    Trello, especially for managing 'story'-level items, documentation and
    testing.

The Trac server is available under https://trac.openmicroscopy.org/ome and
uses your LDAP account for authentication. Trac is used to record all tickets
and allows hierarchical groups of “tasks” in “requirements” and “stories”
(functionality provided by a `plugin for Trac named “Agilo”
<http://www.agilofortrac.com>`_ which you may want to read more about). Note
that bugs should be recorded as "task" tickets with "BUG:" in the ticket
summary, as the official Trac "Bug" tickets only allow limited functionality.

.. figure:: /images/trac_screenshot.png
   :align:  center

Trac is also used for the milestone pages which summarize the tickets
completed for each release (as opposed to the GitHub milestone pages
which show all the code changes).

Trello
------

`Trello <http://www.trello.com>`_ is an online organizational tool used to
manage "cards" arranged in "lists" on various subject-themed "boards". This is
currently the team's main internal planning tool for higher level development
goals and for managing documentation, testing, and the maintenance of our
continuous integration tools.

.. figure:: /images/trello_screenshot.png
   :align:  center

You can request access to the openmicroscopy boards as an external
collaborator. Sign up for a free account and then get in touch with us to be
added. We have now added a `public OME organization <https://trello.com/ome>`_
to allow anyone to follow our development progress (see :ref:`public-trello`
for more information).

Developer documentation
-----------------------

The developer documentation is maintained under version control, generated
using Sphinx and hosted on the OME website.

Each section of the code base (OMERO, Bio-Formats) has a landing page that
will direct you to all the developer documentation that you might need. For
example, the Developer page for OMERO is
:omero_doc:`here <developers/index.html>`.

Jenkins: Continuous integration
-------------------------------

Our Jenkins_ server is available :jenkins:`here <>` and also uses LDAP
authentication. Jenkins provides a mechanism to run arbitrary tasks (“jobs”) on one or
more platforms after particular events (time of day, git push, etc.) These
jobs build all of the binaries released by the team, and also run automated
testing.

.. _jenkins_screenshot:
.. figure:: /images/jenkins_screenshot.png
   :align:  center

Git and GitHub: Source code
---------------------------

Commits take place primarily on GitHub currently. To be aware of
what is really going on, your best option is to become familiar with
Git, GitHub, and the repositories of all the team members. Information
on doing that is available in the :doc:`source-code` and :doc:`using-git`.

.. _github_screenshot:
.. figure:: /images/github_screenshot.png
   :align:  center

Forums and mailing list
-----------------------

Feedback from the OME community happens primarily on 2 public mailing
lists that are further described under :mailinglist:`ome-users` and
:mailinglist:`ome-devel`, as well as on the :forum:`PhpBB forums <>`,
an  alternative to the mailing lists since some users prefer the forum
interface to the mailing list one, and vice versa.

You should add yourself to all three and be aware of and scan all
threads on a fairly regular basis. The general rule is that requests
from the community will be responded to by the next working day, where
to the best of our ability, we keep the ‘working days’ and time zones
of the community in mind. If you miss any messages or want to review
previous discussions see the archive lists available on the
“mailing-lists” page:

.. _lists_screenshot:
.. figure:: /images/lists_screenshot.png
   :align:  center

Where possible, the task of monitoring feedback is spread across the
team. Mailing list and forum questions are listed at the morning stand-up
meeting and can be checked off in the accompanying notes when dealt with to
ensure nothing is ignored or forgotten.

Anyone on the team should feel free to speak up to answer questions,
but do try to verify the correctness of answers, code samples, etc. before
posting.

As much information about our activities and decision processes should
be made public as possible. For many items, there is no reason to hide
our process, but we do not go out of our way to make them public. For
example, internally the team often uses OmniGraffle documents to
illustrate concepts, but these are kept privately to prevent any
confusion.

Internal mailing lists
----------------------

In addition to the two public mailing lists mentioned above, there are
also:

* **ome-nitpick@lists.openmicroscopy.org.uk**, used for team-wide,
  developer communication that isn’t appropriate for the wider OME
  community such as organizing mini-group meetings, scheduling
  vacation, etc.

* a number of mail-aliases reserved for automated messages from
  various pieces of development machinery (do not send mail directly
  to these, instead use ome-nitpick).

Internal servers
----------------

There are a number of servers and services inside of the University of
Dundee system that are used by the entire team. You may not need
access to all of them immediately, but it is good to know what is
available in case you do.

* **vpn.lifesci.dundee.ac.uk** (LDAP-based) is necessary for securely
  accessing some of the following resources (e.g. squig, jenkins)

* **squig.openmicroscopy.org** is the shared, team-wide repository for
  data which can be mounted if you are on VPN or within the UoD
  system. It contains test data for various file formats.

* The OME `QA <http://qa.openmicroscopy.org.uk/>`_ system is an in-house
  system for collecting feedback from users, including failing files,
  stack traces, etc. Like our community feedback, QA feedback should
  be turned into a ticket in a timely manner.

* Home directory / data repository on necromancer (|SSH|-based)

.. note::

  For anyone who has been hired to work at the University of
  Dundee, you will be provided with a
  `new start tasklist <https://trello.com/c/GmuPPLAi/5-start-tasks>`_ which
  itemizes all the things that need to be done to get you set up in RL
  (building access, a chair, etc.).

Google Docs
-----------

In addition to the services hosted in Dundee, the team also makes use
of several Google resources due to the improved real-time
collaboration that they provide. A single Google collection “OME Docs”
is made available to all team members. Anything placed in the
collection is automatically editable by everyone.

For example, the primary contact information for all team members is
available in the `DevContactList spreadsheet`_.

You can enable notifications on the spreadsheet so that you receive an
email if any changes are made.

Meetings
--------

Weekly meetings are held online with all members of the team. Notes are taken
collaboratively in a **public** Google doc in the “OME Docs > Notes > Tuesday
meetings” collection.
Anyone who missed the meeting is expected to review the notes and
raise any issues during the next meeting.

Periodically, a technical presentation is held during the weekly
meeting. This can be used to either introduce an external tool for
suggested use by the team or as a peer review of in-progress work.

Mini group meetings can either be regularly scheduled (e.g. weekly) or
on an as-needed basis. Notes from such meetings should be recorded in gdocs or
on Trello as appropriate and if necessary matters arising should be covered in
the weekly meeting for the rest of the team.

.. _DevContactList spreadsheet: https://docs.google.com/spreadsheets/d/1oHHU1GdEQq03dDf1FzUe0xoEi1RK1BOLOaL0HhMAeEA/edit
