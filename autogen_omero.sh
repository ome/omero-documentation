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
BRANCH=$1; shift
OPEN_PR=false
export SPHINXOPTS=-W

# TODO: using for now, but likely this should be an artifact copy
# which likely points to a release-ci.
if [ ! -e OMERO.server ]; then
    omego download server --branch=$BRANCH --ice 3.6
    rm -rf OMERO.server*.zip
    ln -s OMERO.server* OMERO.server
fi

./omero/autogen_docs

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

cd $WORKSPACE/ome-documentation/omero
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
    md5sum "$base" >> "$base.md5"
    sha1sum "$base" >> "$base.sha1"
    popd
done
