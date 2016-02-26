
#!/bin/bash

PY_ENV=${PY_ENV:-py27}

# Figure URL
URL_FIGURE=http://downloads.openmicroscopy.org/latest/figure.zip

# Web tagging URL
URL_WEBTAGGING=http://downloads.openmicroscopy.org/latest/webtagging.zip

# Gallery URL
URL_GALLERY=https://github.com/ome/gallery/archive/v1.0.0.zip

# web test URL
URL_WEBTEST=https://github.com/openmicroscopy/webtest/archive/master.zip

# web error URL
URL_WEBERROR=https://github.com/openmicroscopy/weberror/archive/master.zip

cd ~omero

# Add OMERO.figure
NAME_FIGURE_ZIP=${URL_FIGURE##*/}

wget $URL_FIGURE
unzip -q $NAME_FIGURE_ZIP
rm $NAME_FIGURE_ZIP
mv figure* OMERO.server/lib/python/omeroweb/figure

echo "value=$PY_ENV"
# Install required packages
if [ "$PY_ENV" = "py26" ]; then
	pip install reportlab==2.7
	pip install reportlab markdown
elif [ "$PY_ENV" = "py27_scl" ]; then
	set +u
	source /opt/rh/python27/enable
	set -u
	pip install reportlab markdown
elif [ "$PY_ENV" = "py27_ius" ]; then
	virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
	set +u
	source /home/omero/omeroenv/bin/activate
	set -u
	/home/omero/omeroenv/bin/pip2.7 install reportlab markdown
	deactivate
else
	pip install reportlab markdown
fi

# Register the app
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"figure\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.top_links '[\"Figure\", \"figure_index\", {\"title\": \"Open Figure in new tab\", \"target\": \"figure\"}]'"

# Copy the script 
FOLDER=OMERO.server/lib/python/omeroweb/figure/scripts
cp $FOLDER/omero/figure_scripts/Figure_To_Pdf.py OMERO.server/lib/scripts/omero/figure_scripts

# Webtagging
NAME_WEBTAGGING_ZIP=${URL_WEBTAGGING##*/}

wget $URL_WEBTAGGING
unzip -q $NAME_WEBTAGGING_ZIP
rm $NAME_WEBTAGGING_ZIP

mv webtagging*/autotag OMERO.server/lib/python/omeroweb/autotag
mv webtagging*/tagsearch OMERO.server/lib/python/omeroweb/tagsearch

# Register the app
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"autotag\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"tagsearch\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.center_plugins '[\"Auto Tag\", \"autotag/auto_tag_init.js.html\", \"auto_tag_panel\"]'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.top_links '[\"Tag Search\", \"tagsearch\"]'"

# Web gallery
NAME_GALLERY_ZIP=${URL_GALLERY##*/}

wget $URL_GALLERY
unzip -q $NAME_GALLERY_ZIP

rm $NAME_GALLERY_ZIP
mv gallery* OMERO.server/lib/python/omeroweb/gallery
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"gallery\"'"

# Web error
NAME_WEBERROR_ZIP=${URL_WEBERROR##*/}

wget $URL_WEBERROR
unzip -q $NAME_WEBERROR_ZIP

rm $NAME_WEBERROR_ZIP
mv weberror*/weberror OMERO.server/lib/python/omeroweb/weberror
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"weberror\"'"


# Web test
NAME_WEBTEST_ZIP=${URL_WEBTEST##*/}

wget $URL_WEBTEST
unzip -q $NAME_WEBTEST_ZIP
rm $NAME_WEBTEST_ZIP

mv webtest* OMERO.server/lib/python/omeroweb/webtest
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"webtest\"'"

su - omero -c "OMERO.server/bin/omero config append omero.web.ui.right_plugins '[\"ROIs\", \"webtest/webclient_plugins/right_plugin.rois.js.html\", \"image_roi_tab\"]'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.center_plugins '[\"Split View\", \"webtest/webclient_plugins/center_plugin.splitview.js.html\", \"split_view_panel\"]'"
