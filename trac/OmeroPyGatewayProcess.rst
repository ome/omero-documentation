Deprecated Page

(Note: This process was created in `#4772 </ome/ticket/4772>`_)

Goals:

-  Foster communication and understanding of
   `OmeroPy </ome/wiki/OmeroPy>`_ gateway API changes
-  Utilisation of Git functionality to allow for better change review
-  Keep development velocity high

Pre-requisite TODOs:

-  Creation of `OmeroPy </ome/wiki/OmeroPy>`_ gateway API evolution
   **REQUIREMENT**
-  Creation of STORIES with specific targets (bug fixes, query support,
   etc.)
-  python-team@… e-mail address
-  Creation of python-gateway ome.git branch
-  E-mail notifications to python-team of branch changes

Non-code pre-requisites:

-  0.1d or 0.25d OME Trac TASK creation linked to a relevant STORY
-  CC of python-team for your TASK with a brief synopsis of the planned
   change
-  Where required and possible (ie. not a trivial change) discussion of
   your change with at least one other member of python-team before
   coding.

Commit stylistic notes:

-  NO superfluous whitespace or formatting changes
-  Variable or method name changes in their own commits
-  Gateway integration test case(s) covering your change
-  Eye towards application to multiple branches (4.1, 4.2 and develop)
-  Concise, documented and controlled size (more commits per merge)
-  Concise commit messages with ticket linkage. Example:

Added getGadget() method to gateway. (See `#999 </ome/ticket/999>`_)

After discussion with Carlos, Will and Ola it was decided that we should
add a getGadget() method to the gateway to support the retrieval of
gadgets from both `OmeroPy </ome/wiki/OmeroPy>`_ and OMERO.web.

Commit workflow:

**1) Push to python-gateway on ome.git**
 **2) Review of any change. Example requirements:**

The review of any change will be done by at least one person, on
python-team, involved in the discussed changes, who is not the
committer, and at least one person, again on python-team, who was not.
If Will and Ola, for example, decide that the getGadget() method needs
to be added and Will has done the work and pushed to python-gateway Ola
would review it followed by a review from Josh, Carlos or Chris.

**3) Upon review completion, the merge (with history; --no-ff) of all
changes into develop.**

git fetch git checkout python-gateway git rebase origin/python-gateway [
git rebase origin/develop ] # handle conflicts here BEFORE merge git
checkout develop git rebase origin/develop git merge —no-ff —log
python-gateway git commit --amend git push origin develop In order to
keep the python-develop branch up to date with develop, Chris or Josh
needs to do this on origin, then everyone has to do

-  git checkout python-gateway
-  git reset —hard origin/python-gatewa

**4) Merge and/or cherry-pick of changes into 4.1, 4.2 and/or
4.1\_custom by Carlos, Josh or Chris.**
