#!/usr/bin/env bash
# Installs OMERO requirements

set -e
set -u
set -x

export PATH=/usr/local/bin:$PATH
export LANG=${LANG:-en_US.UTF-8}
export LANGUAGE=${LANGUAGE:-en_US:en}

# Test whether this script is run in a job environment
JOB_NAME=${JOB_NAME:-}
if [[ -n $JOB_NAME ]]; then
    DEFAULT_TESTING_MODE=true
else
    DEFAULT_TESTING_MODE=false
fi
TESTING_MODE=${TESTING_MODE:-$DEFAULT_TESTING_MODE}

###################################################################
# Redis installation
###################################################################

# Install redis
brew install redis
brew services start redis

# Install django-cache-redis
pip install django-redis>=4.4

# Set up redis session backend
omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'
omero config set omero.web.caches '{"default": {"BACKEND": "django_redis.cache.RedisCache","LOCATION": "redis://127.0.0.1:6379/0"}}'
