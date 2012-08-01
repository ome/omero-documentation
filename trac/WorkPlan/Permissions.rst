Deprecated Page

**NOTE: This page has been moved to `#1854 </ome/ticket/1854>`_. The
following breakdown is kept for historical reasons.**

Breakdown
---------

**OMERO.server:**

Breakdown:

#. `#1434 </ome/ticket/1434>`_ Re-enable group permissions (Iteration I)

   #. rollback `#1405 </ome/ticket/1405>`_ (remove configurable default
      perms) **DONE**
   #. rollback `#1204 </ome/ticket/1204>`_ (make group global) **DONE**
   #. choice to make groups public on creation? cF.
      `ticket:1204 </ome/ticket/1204>`_ (essentially re-opening that
      ticket) **DONE**
   #. All linked objects are checked for group (warning/exception on
      mixed group and/or mixed permissions) **DONE**
   #. All new objects are created in current group (warning/exception on
      explicit) with proper permissions for group **DONE**
   #. No object can be linked to an object of another group, regardless
      of permissions. **DONE**
   #. `#1310 </ome/ticket/1310>`_ setGroup (1 day) **DONE**
   #. Prevent changing groups to "755" except through API! **DONE**
   #. `#445 </ome/ticket/445>`_ allow admin's to login into another
      group (Est. 1 day / Act. 0.5 days)
   #. `#1767 </ome/ticket/1767>`_ Enumerations made global (Est. 1 days
      / Act. 0.5 days)
   #. `#1764 </ome/ticket/1764>`_ Allow root to login to any group even
      if not member (Est. 0.5 days / Act. 0.5 days)
   #. `#1766 </ome/ticket/1766>`_ Allow multiple owners (Est. 0.5 days,
      partially done before / Act. 0.5 days)
   #. `#1762 </ome/ticket/1762>`_ All returned graphs are
      group-consistent, i.e. consist only of objects from a single group
      (with the exception of system types) (Est. 2 day / Act. 1.5 days)

#. Cont. (Iteration II, Ending Feb. 18)

   #. `#1771 </ome/ticket/1771>`_ **simpify filter
      ``group_id = X && true|false`` should suffice** (DONE as part of
      `#1769 </ome/ticket/1769>`_)
   #. `#1769 </ome/ticket/1769>`_ handle root annotations of private
      groups (Est. 1 day / Act. 1.5 day)
   #. `#1776 </ome/ticket/1776>`_ disallow calls to changePermissions
      with breaking permissions (Est. 0.5 days / Act. 0.5 days)
   #. `#1778 </ome/ticket/1778>`_ add/removeGroupOwners (Est. 0.5 days /
      Act. 0.5 days)
   #. `#1781 </ome/ticket/1781>`_ allow group owners to manage group
      (Est. 0.5 days / Act. 0.5 days)
   #. Bugs (Act. 2.5 days)

      -  `#1792 </ome/ticket/1792>`_ (link restrictions)
      -  `#1791 </ome/ticket/1791>`_ (user photos)
      -  `#1784 </ome/ticket/1784>`_ (scripting service)
      -  `#1775 </ome/ticket/1775>`_ (createGroup -> public)
      -  `#1774 </ome/ticket/1774>`_ (sudo broken)
      -  `#1434 </ome/ticket/1434>`_ (misc)

#. Cont. (Iteration III - mostly cleanup items)

   #. `#1731 </ome/ticket/1731>`_ - unify umask and defaultPermissions
   #. "user" group becomes the "world public space" (may required
      "guest" to login to only "user") (2 days) **???**
   #. Allow all users to login to public groups.
   #. `#1783 </ome/ticket/1783>`_ decide on sensible permissions for
      initial groups

#. Cont. (Later)

   #. `#1750 </ome/ticket/1750>`_ database upgrade (8 days)
   #. `#320 </ome/ticket/320>`_ changeGroup (and
      `#967 </ome/ticket/967>`_) (5 days)
   #. decide on world-public space (0.5 days) **???**

-  Cont

   -  rollback `#337 </ome/ticket/337>`_ (remove locking) (2 days)

**everything above here transferred to agilo**

-  Cont

   -  chown similar to chgrp
      (` email <http://lists.openmicroscopy.org.uk/pipermail/ome-users/2010-February/002204.html>`_)
   -  How long does setting a group public take? (timeouts)

      -  Return sum of rows

   -  review exceptions so, e.g write violation in share clearly states
      a share-violation
   -  rollback `#307 </ome/ticket/307>`_ (remove 'soft' perms) (2 days)
   -  Check interaction with runAsAdmin & privileged-tokens. (i.e. which
      has the highest priority) (1 day)
   -  `#1765 </ome/ticket/1765>`_ Move-User Wizard (3 days)
   -  decide what "user-non-read" means.
   -  eventually handle individual user settings of WRITE permissions
      (` transitions <http://spreadsheets.google.com/ccc?key=tUi3slhO09MEn1_Rod115YA&hl=en>`_)
   -  possibly remove "guest" group, since it won't help to view other
      groups.
   -  prevent "setSecurityContext('user')"
   -  allow "user.group" setting in implicit context
   -  Finally, review all open tickets in securty component.

**Note:** `#1434 </ome/ticket/1434>`_ still contains some "Items under
discussion". These should be deleted or moved to other tickets upon
completion.

--------------

**OMERO.insight:**

#. [STRIKEOUT:insight:#1026],
   [STRIKEOUT:` insight#1115 <http://trac.openmicroscopy.org.uk/shool/ticket/1115>`_]
   Allow user to switch between groups **DONE**.
#. [STRIKEOUT:insight:#1026] Allow user to view other experimenters
   **DONE** insight:r7009.
#. Allow to set the security context when logging in. insight:r7003.
   (Act. 1 day)
#. insight:#1132 Build facility for Group Owner (e.g. PI) to
   administrate his/her group (6 days)

   -  Integrate in DataManager insight:r7033 (Act. 0.5 days) **DONE**
   -  [STRIKEOUT:insight:#1149] (Iteration I) Integrate in DataBrowser ,
      insight:r7034 (Act. 0.5 days) **DONE**
   -  (Iteration II/III) Build UI to create, remove, group and
      experimenter, insight:r7038,!insight:r7040,
      insight:r7058-!insight:r7060 **DONE**
   -  [STRIKEOUT:insight:#1151] (Iteration II/III) Build structure to
      connect to server insight:r7037, insight:r7041, insight:r7061
      (Act. 2 days) **DONE**
   -  [STRIKEOUT:insight:#1174] (Iteration III) Build UI to
      copy/cut/paste experimenters (Act. 0.5 days) insight:r7065
      **DONE**
   -  [STRIKEOUT:insight:#1174] (Iteration III) Build structure to
      copy/cut/paste experimenters (Act. 0.5 days) insight:r7064
      **DONE**
   -  insight:#1175 (Maybe) LDAP support
   -  [STRIKEOUT:insight:#1176] (Iteration III) Modify Group ownership
      insight:r7071 (Act. 0.5 days) **DONE**
   -  insight:#1177 (Iteration III) Experimenter status
   -  [STRIKEOUT:insight:#1178] (Iteration III) Reset password by
      administrator insight:r7079 (Act. 0.5 days) **DONE**

#. Bugs

   #. Major problems: **permission RWR** (Act. 1day so far)

      -  insight:#1159 Problems with render compressed
      -  [STRIKEOUT:insight:#1179] private group: rendering settings
         changes insight:r7073 **DONE**
      -  [STRIKEOUT:insight:#1162] Security exceptions and UI
         availability when logged in as a group owner insight:r7056
         **DONE**

      1.Minor problems: (Act. 0.5)

      -  [STRIKEOUT:insight:#1166] Expanded comments disappear when
         moving between images insight:r7075 **DONE**
      -  [STRIKEOUT:insight:#1165] Longer user names are cut off.
         insight:r7075 **DONE**
      -  [STRIKEOUT:insight:#1164] Tag manipulation view missing group's
         tags. See also `#1829 </ome/ticket/1829>`_
      -  [STRIKEOUT:insight:#1189] Login screen, group selection.

**Note:** **Discussion Ola, Josh, J-M (21/01/10)**

Options for a Group are rw, rwr, rwrw If the option is rwrw, clients
will add controls so that the user cannot add a dataset for example to a
project that does not belong to him/her

--------------

**OMERO.web:** `#1456 </ome/ticket/1456>`_

#. WebAdmin changes (Iteration II 8-12/02/10):

   -  access control field in GroupForm (est. 1 day \| act. 1 day)
   -  multi-selection owner field in GroupForm (est. 0.5 day \| act. 0.5
      day)
   -  group controller modification (est. 0.5 day \| act. 0.5 day)
   -  group owner panel in 'myaccount' including new page for managing
      group by owner (est. 1.5 day \| act. 1.5 day)
   -  'myaccount' controller modification (est. 0.5 day \| act. 0.5 day)
   -  gateway modification including new role 'owner' (est. 1 day \|
      act. 1 day)

#. WebClient (Iteration II 15-19/02/10):

   -  managing data for active group (est. 2 days \| act. 2 days)
   -  managing user data for active group (est. 2 days \| act. 2 days)
   -  controller modification (est. 0.5 day \| act. 0.5 day)
   -  gateway modification (est. 0.5 day \| act. 0.5 day)

#. WebClient (Iteration III 22-26/02):

   -  'my account' update based on webadmin panel (est. 0.5 day)

#. WebClient (Iteration III 1-5/03):

   -  managing group data for active group (est. 3 days)
   -  controller modification (est. 0.5 day)
   -  gateway modification (est. 0.5 day)

#. Extra tasks (Iteration I 1-5/02/10):

   -  general server tests (act. 2 days)
   -  integration tests (est. 1 day\| act. 1 day)

-  Decide on multi-group login

--------------

**OMERO.importer:**

#. Review and make changes to `ImportLibrary </ome/wiki/ImportLibrary>`_
   (1 day)
#. Import dialog changes to show groups (1 day)
#. History system updates to store groups (1 day)

-  Decide on multi-group login
