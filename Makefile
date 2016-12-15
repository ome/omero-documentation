# Delegate all make targets directly to ant

ifdef SPHINXOPTS
ANT_SPHINXOPTS := -Dsphinx.opts="$(SPHINXOPTS)"
endif

ifdef OMERO_RELEASE
ANT_OMERO_RELEASE := -Domero.release="$(OMERO_RELEASE)"
endif

ifdef SOURCE_BRANCH
ANT_SOURCE_BRANCH := -Dsource.branch="$(SOURCE_BRANCH)"
endif

ifdef SOURCE_USER
ANT_SOURCE_USER := -Dsource.user="$(SOURCE_USER)"
endif

ifdef JENKINS_JOB
ANT_JENKINS_JOB := -Djenkins.job="$(JENKINS_JOB)"
endif

default: html

%:
	ant $@ $(ANT_SPHINXOPTS) $(ANT_FORMATS_RELEASE) $(ANT_OMERO_RELEASE) $(ANT_SOURCE_BRANCH) $(ANT_SOURCE_USER) $(ANT_JENKINS_JOB)

.PHONY: default
