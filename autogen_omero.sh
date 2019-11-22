
set -e
set -u
set -x

# TODO
echo no linkcheck

# from the sub-script
WORKSPACE=${WORKSPACE:-$(pwd)}
USER=${USER:-$(whoami)}

# VARIABLES #1
MESSAGE="Update auto-generated documentation"
PUSH_COMMAND="update-submodules develop --no-ask --push develop/latest/autogen"
BRANCH=$1; shift
OPEN_PR=false

# VARIABLES #2
RELEASE=$BRANCH
TAG_COMMAND="tag-release $RELEASE --no-ask --push --prefix=v"
RSYNC_HOST=hudson-x@ome-web-rw.openmicroscopy.org
DOWNLOADS_PATH=/uod/idr/www/downloads.openmicroscopy.org
DOCS_PATH=/uod/idr/www/docs.openmicroscopy.org
PREFIX=omero
OMERO_RELEASE=${RELEASE}
SPHINXOPTS=-W
SOURCE_BRANCH=v${OMERO_RELEASE}

####
# From https://ci.openmicroscopy.org/job/OMERO-DEV-latest-docs-autogen/configure
# checkout from ome
# see also: https://trello.com/c/ZvmmNTZn/43-omero-auto-generated-documentation
###

if [ ! -e OMERO.server ]; then
    omego download server --branch=$BRANCH --ice 3.6
    rm -rf OMERO.server*.zip
    ln -s OMERO.server* OMERO.server
fi

if [ ! -e omero-install ]; then
    git clone git@github.com:ome/omero-install
fi

if [ ! -e omeroweb-install ]; then
    git clone git@github.com:ome/omeroweb-install
fi

export PYTHONPATH=${PYTHONPATH:-}:$WORKSPACE/OMERO.server/lib/python
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

####
# from https://ci.openmicroscopy.org/job/OMERO-DEV-release-docs/configure
# checks out snoopy
####
exit 1

# GENERATE AND PUSH TAGS
# ----------------------
test -e src && cd src

git tag -l | xargs git tag -d
git fetch origin --tags
  
# TAG CHECK/CREATION
if ! [ "$(git show-ref v$RELEASE)" ]; then
  # If tag does not exist, create it
  source $HOME/virtualenv/bin/activate
  scc $TAG_COMMAND
fi

# DIRECTORY CHECK AND CREATION
# ----------------------------
ssh $RSYNC_HOST mkdir -p $DOWNLOADS_PATH/$PREFIX/$RELEASE/artifacts
ssh $RSYNC_HOST mkdir -p $DOCS_PATH/$PREFIX/$RELEASE


echo "Order deny,allow
Deny from all
Allow from 134.36
Allow from 10
Satisfy Any" > .htaccess

rsync -av .htaccess $RSYNC_HOST:$DOWNLOADS_PATH/$PREFIX/$RELEASE/.htaccess
rsync -av .htaccess $RSYNC_HOST:$DOCS_PATH/$PREFIX/$RELEASE/.htaccess
rm .htaccess

# Build OMERO docs
cd src/omero
make clean zip

# This section must also be kept in sync with the fingerprinting configuration below
# E.g.: src/target/**/*.zip, src/target/**/*.egg, src/target/**/*.pdf,src/target/**/*INFO
# OR: src/target/*.zip,src/target/pkg/*.zip,src/target/*.egg,src/dist/lib/client/omero_client*,src/target/*.log,src/target/*INFO,src/target/*.pdf,src/target/**/*.md5,src/target/**/*.sha1


for x in src/omero/_build/*.zip
#for x in src/omero/_build/latex/*.pdf #for dev_5_2
  do
    base=`basename $x`
    dir=`dirname $x`
    pushd "$dir"
    md5sum "$base" >> "$base.md5"
    sha1sum "$base" >> "$base.sha1"
    rsync -av "$base" $RSYNC_HOST:$DOWNLOADS_PATH/$PREFIX/$RELEASE/artifacts/$base
    rsync -av "$base.md5" $RSYNC_HOST:$DOWNLOADS_PATH/$PREFIX/$RELEASE/artifacts/$base.md5
    rsync -av "$base.sha1" $RSYNC_HOST:$DOWNLOADS_PATH/$PREFIX/$RELEASE/artifacts/$base.sha1
    popd
done

rsync -av src/omero/_build/html/ $RSYNC_HOST:$DOCS_PATH/$PREFIX/$RELEASE/
