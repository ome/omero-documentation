Deprecated Page

#. `Overview <#Overview>`_

   #. `Method 1 : \*.ics files in
      subversion <#Method1:.icsfilesinsubversion>`_

      #. `Publishing a calendar <#Publishingacalendar>`_

   #. `Getting a hold of calendars <#Gettingaholdofcalendars>`_
   #. `Method 2: Google Calendar <#Method2:GoogleCalendar>`_
   #. `Method 3: .mac account <#Method3:.macaccount>`_

      #. `Team members calendar URIs <#TeammemberscalendarURIs>`_

Overview
========

Letting people know what you're doing is difficult. Even more difficult
still is keeping track of what others are doing and the dependencies
therein. For Omero, all team members are responsible for keeping a
publicly accessible calendar (\*.ics) available. This doesn't eliminate
the need for discussion but it at least means that everyone can see what
everyone else is doing at any time. Currently, three options are
immediately available.

Method 1 : \*.ics files in subversion
-------------------------------------

The first supported way of tackling this problem is with a centralized,
Subversion managed calendaring resource.

Publishing a calendar
~~~~~~~~~~~~~~~~~~~~~

WebDAV publishing is basically... out. It'd require everyone to have
another set of passwords and we'd have no way of tracking changes or
backing up calendars without using the very suspect auto-versioning
features of Subversion's WebDAV integration. So, a compromise is that
we're using the same SVN+SSH Subversion URIs that we use for everything
else along with a new "cal" repository.

For Windows, there is a nice, friendly GUI tool that will let you work
with Subversion repositories:

-  ` TortoiseSVN <http://tortoisesvn.tigris.org/>`_

For Mac OS X, there is of course the command line tools which can be
conveniently installed via packages available from here:

-  ` http://metissian.com/projects/macosx/subversion/ <http://metissian.com/projects/macosx/subversion/>`_

and GUI tools:

-  ` svnX <http://www.lachoseinteractive.net/en/community/subversion/svnx/features/>`_
-  ` scplugin <http://scplugin.tigris.org/>`_

You are then responsible for working on the following Subversion URI:

-  ` svn+ssh:// <svn+ssh://>`_\ <username>@cvs.openmicroscopy.org.uk/home/svn/cal/trunk/omero

**PLEASE** commit files in "/home/svn/cal/trunk/omero" and **PLEASE**
follow the "<username>.ics" naming convention.

Getting a hold of calendars
---------------------------

You can browse all the calendars that are available by looking here:

-  ` http://cvs.openmicroscopy.org.uk/svn/cal/trunk/omero <http://cvs.openmicroscopy.org.uk/svn/cal/trunk/omero>`_

The easiest way to grab a calendar is to use the subscription features
of:

-  ` Mozilla
   Sunbird <http://www.mozilla.org/projects/calendar/sunbird.html>`_
-  ` iCal <http://www.apple.com/macosx/features/ical/>`_
-  ` Evolution <http://www.gnome.org/projects/evolution/>`_
-  ` Kontact <http://www.kontact.org/>`_

using WebDAV URIs like:

-  ` http://cvs.openmicroscopy.org.uk/svn/cal/trunk/omero/callan.ics <http://cvs.openmicroscopy.org.uk/svn/cal/trunk/omero/callan.ics>`_

Method 2: Google Calendar
-------------------------

Recently, Google began the beta version (but what isn't beta at Google)
of their calendar service. Visit
` http://calendar.google.com <http://calendar.google.com>`_ for specific
information. But all Google calendars are exportable in the \*.ics
format.

Method 3: .mac account
----------------------

A further option is to use iCal directly on a Mac, and export the \*.ics
to a .Mac account. This is then viewable online like
` this <http://ical.mac.com/WebObjects/iCal.woa/wa/default?u=jrsdundee&n=WorkStuff.ics>`_,
but can also be viewed directly as
` \*.ics <http://homepage.mac.com/jrsdundee/.calendars/WorkStuff.ics>`_.

Team members calendar URIs
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Omero General Calendar (Milestones, etc.) [Google] --
   ` HTML <http://www.google.com/calendar/embed?src=918ul13ut1l2994usllsan96ec%40group.calendar.google.com&ctz=Europe/Berlin>`_\ ` ICS <http://www.google.com/calendar/ical/918ul13ut1l2994usllsan96ec@group.calendar.google.com/public/basic>`_
-  ` Brian
   Loranger <http://www.google.com/calendar/ical/jei7hms541a8hekgmuc3033i7k@group.calendar.google.com/public/basic>`_
   [Google]
-  ` Josh's Omero
   availablitiy <http://www.google.com/calendar/ical/6hpe6erb4gqo7p7ecf78nnkiq4@group.calendar.google.com/public/basic>`_
   [Google]
-  ` Jason
   Swedlow <http://ical.mac.com/WebObjects/iCal.woa/wa/default?u=jrsdundee&n=WorkStuff.ics>`_
   [.Mac]
-  ` Catriona
   Macaulay <http://ical.mac.com/WebObjects/iCal.woa/wa/default?u=catriona&n=Published.ics>`_
   [.Mac]
-  ` Jean-Marie
   Burel <http://www.google.com/calendar/ical/jmburel@hotmail.com/public/basic>`_
   [Google]
