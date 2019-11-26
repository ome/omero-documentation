#!/usr/bin/env bash
set -e
set -u
set -x

# TODO
echo no linkcheck

# from the sub-script
export WORKSPACE=${WORKSPACE:-$(pwd)}
export USER=${USER:-$(whoami)}
export OMERODIR=${WORKSPACE}/OMERO.server

# VARIABLES #1
MESSAGE="Update auto-generated documentation"
PUSH_COMMAND="update-submodules develop --no-ask --push develop/latest/autogen"
OPEN_PR=false
export SPHINXOPTS=-W

# Responsibilities of caller, likely omero-docs-superbuild
test -e $WORKSPACE/OMERO.server
test -e $WORKSPACE/omero-install
test -e $WORKSPACE/omeroweb-install

if [ ! -e $WORKSPACE/venv ]; then
    virtualenv $WORKSPACE/venv
    $WORKSPACE/venv/bin/pip install -r $WORKSPACE/OMERO.server/share/web/requirements-py27.txt
    $WORKSPACE/venv/bin/pip install future
fi
set +u # PS1 issue
. $WORKSPACE/venv/bin/activate
set -u
export PATH=$WORKSPACE/OMERO.server/bin:$PATH

cd $WORKSPACE/ome-documentation/
omero/autogen_docs

if [[ -z $(git status -s) ]]; then
  echo "No local changes"
else
  git add .
  if [ "$OPEN_PR" = "true" ]; then
     scc $PUSH_COMMAND -m "$MESSAGE"
  else
     scc $PUSH_COMMAND --no-pr -m "$MESSAGE"
  fi
fi

# OSX compatibility for testing
MD5SUM=md5sum
type $MD5SUM || MD5SUM=md5
SHA1SUM=sha1sum
type $SHA1SUM || SHA1SUM=shasum

cd omero
make clean html
echo "Order deny,allow
Deny from all
Allow from 134.36
Allow from 10
Satisfy Any" > _build/.htaccess
make zip
for x in $WORKSPACE/ome-documentation/omero/_build/*.zip
  do
    base=`basename $x`
    dir=`dirname $x`
    pushd "$dir"
    $MD5SUM "$base" >> "$base.md5"
    $SHA1SUM "$base" >> "$base.sha1"
    popd
done
