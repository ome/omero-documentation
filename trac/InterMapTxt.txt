`InterMapTxt </ome/wiki/InterMapTxt>`_
======================================

This is the place for defining `InterWiki </ome/wiki/InterWiki>`_ prefixes
--------------------------------------------------------------------------

This page was modelled after the
` MeatBall:InterMapTxt <http://www.usemod.com/cgi-bin/mb.pl?InterMapTxt>`_
page. In addition, an optional comment is allowed after the mapping.

This page is interpreted in a special way by Trac, in order to support
InterWiki links in a flexible and dynamic way.

The code block after the first line separator in this page will be
interpreted as a list of InterWiki specifications:

::

    prefix <space> URL [<space> # comment]

By using ``$1``, ``$2``, etc. within the URL, it is possible to create
`InterWiki </ome/wiki/InterWiki>`_ links which support multiple
arguments, e.g. Trac:ticket:40. The URL itself can be optionally
followed by a comment, which will subsequently be used for decorating
the links using that prefix.

New InterWiki links can be created by adding to that list, in real time.
Note however that *deletions* are also taken into account immediately,
so it may be better to use comments for disabling prefixes.

Also note that InterWiki prefixes are case insensitive.

List of Active Prefixes
-----------------------

+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| *Prefix*                                                                                                | *Site*                                                                                                                                             |
+=========================================================================================================+====================================================================================================================================================+
| `Acronym <http://www.acronymfinder.com/af-query.asp?String=exact&Acronym=RecentChanges>`_               | `http://www.acronymfinder.com/af-query.asp?String=exact&Acronym= <http://www.acronymfinder.com/af-query.asp?String=exact&Acronym=>`_               |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `C2find <http://c2.com/cgi/wiki?FindPage&value=RecentChanges>`_                                         | `http://c2.com/cgi/wiki?FindPage&value= <http://c2.com/cgi/wiki?FindPage&value=>`_                                                                 |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `c2Wiki <http://c2.com/cgi/wiki?RecentChanges>`_                                                        | `http://c2.com/cgi/wiki? <http://c2.com/cgi/wiki?>`_                                                                                               |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `Cache <http://www.google.com/search?q=cache:RecentChanges>`_                                           | `http://www.google.com/search?q=cache: <http://www.google.com/search?q=cache:>`_                                                                   |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `CPAN <http://search.cpan.org/perldoc?RecentChanges>`_                                                  | `http://search.cpan.org/perldoc? <http://search.cpan.org/perldoc?>`_                                                                               |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `DebianBug <http://bugs.debian.org/RecentChanges>`_                                                     | `http://bugs.debian.org/ <http://bugs.debian.org/>`_                                                                                               |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `DebianPackage <http://packages.debian.org/RecentChanges>`_                                             | `http://packages.debian.org/ <http://packages.debian.org/>`_                                                                                       |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `Dictionary <http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=RecentChanges>`_       | `http://www.dict.org/bin/Dict?Database=\*&Form=Dict1&Strategy=\*&Query= <http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=>`_   |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `Google <http://www.google.com/search?q=RecentChanges>`_                                                | `http://www.google.com/search?q= <http://www.google.com/search?q=>`_                                                                               |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `GoogleGroups <http://groups.google.com/group/RecentChanges/msg/>`_                                     | `Message $2 in $1 Google Group <http://groups.google.com/group/$1/msg/$2>`_                                                                        |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `JargonFile <http://downlode.org/perl/jargon-redirect.cgi?term=RecentChanges>`_                         | `http://downlode.org/perl/jargon-redirect.cgi?term= <http://downlode.org/perl/jargon-redirect.cgi?term=>`_                                         |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `MeatBall <http://www.usemod.com/cgi-bin/mb.pl?RecentChanges>`_                                         | `http://www.usemod.com/cgi-bin/mb.pl? <http://www.usemod.com/cgi-bin/mb.pl?>`_                                                                     |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `Mercurial <http://www.selenic.com/mercurial/wiki/index.cgi/RecentChanges>`_                            | `the wiki for the Mercurial distributed SCM <http://www.selenic.com/mercurial/wiki/index.cgi/>`_                                                   |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `MetaWiki <http://sunir.org/apps/meta.pl?RecentChanges>`_                                               | `http://sunir.org/apps/meta.pl? <http://sunir.org/apps/meta.pl?>`_                                                                                 |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `MetaWikiPedia <http://meta.wikipedia.org/wiki/RecentChanges>`_                                         | `http://meta.wikipedia.org/wiki/ <http://meta.wikipedia.org/wiki/>`_                                                                               |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `MoinMoin <http://moinmoin.wikiwikiweb.de/RecentChanges>`_                                              | `http://moinmoin.wikiwikiweb.de/ <http://moinmoin.wikiwikiweb.de/>`_                                                                               |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `PEP <http://www.python.org/peps/pep-RecentChanges.html>`_                                              | `Python Enhancement Proposal <http://www.python.org/peps/pep-$1.html>`_                                                                            |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `RFC <http://rfc.net/rfcRecentChanges.html>`_                                                           | `IETF's RFC $1 <http://rfc.net/rfc$1.html>`_                                                                                                       |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `trac-dev <http://thread.gmane.org/gmane.comp.version-control.subversion.trac.devel/RecentChanges>`_    | `Message $1 in Trac Development Mailing List <http://thread.gmane.org/gmane.comp.version-control.subversion.trac.devel/>`_                         |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `Trac-ML <http://thread.gmane.org/gmane.comp.version-control.subversion.trac.general/RecentChanges>`_   | `Message $1 in Trac Mailing List <http://thread.gmane.org/gmane.comp.version-control.subversion.trac.general/>`_                                   |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `WhoIs <http://www.whois.sc/RecentChanges>`_                                                            | `http://www.whois.sc/ <http://www.whois.sc/>`_                                                                                                     |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `Why <http://clublet.com/c/c/why?RecentChanges>`_                                                       | `http://clublet.com/c/c/why? <http://clublet.com/c/c/why?>`_                                                                                       |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| `WikiPedia <http://en.wikipedia.org/wiki/RecentChanges>`_                                               | `http://en.wikipedia.org/wiki/ <http://en.wikipedia.org/wiki/>`_                                                                                   |
+---------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+

--------------

Prefix Definitions
------------------

::

    PEP     http://www.python.org/peps/pep-$1.html                                       # Python Enhancement Proposal 
    Trac-ML  http://thread.gmane.org/gmane.comp.version-control.subversion.trac.general/ # Message $1 in Trac Mailing List
    trac-dev http://thread.gmane.org/gmane.comp.version-control.subversion.trac.devel/   # Message $1 in Trac Development Mailing List

    Mercurial http://www.selenic.com/mercurial/wiki/index.cgi/ # the wiki for the Mercurial distributed SCM
    RFC       http://rfc.net/rfc$1.html # IETF's RFC $1

    #
    # A arbitrary pick of InterWiki prefixes...
    #
    Acronym          http://www.acronymfinder.com/af-query.asp?String=exact&Acronym=
    C2find           http://c2.com/cgi/wiki?FindPage&value=
    Cache            http://www.google.com/search?q=cache:
    CPAN             http://search.cpan.org/perldoc?
    DebianBug        http://bugs.debian.org/
    DebianPackage    http://packages.debian.org/
    Dictionary       http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=
    Google           http://www.google.com/search?q=
    GoogleGroups     http://groups.google.com/group/$1/msg/$2        # Message $2 in $1 Google Group
    JargonFile       http://downlode.org/perl/jargon-redirect.cgi?term=
    MeatBall         http://www.usemod.com/cgi-bin/mb.pl?
    MetaWiki         http://sunir.org/apps/meta.pl?
    MetaWikiPedia    http://meta.wikipedia.org/wiki/
    MoinMoin         http://moinmoin.wikiwikiweb.de/
    WhoIs            http://www.whois.sc/
    Why              http://clublet.com/c/c/why?
    c2Wiki             http://c2.com/cgi/wiki?
    WikiPedia        http://en.wikipedia.org/wiki/
