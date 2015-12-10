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
# Homebrew installation
###################################################################

# Install Homebrew in /usr/local
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update Homebrew
brew update

# Run brew doctor
brew doctor

# Install git if not already installed
brew list | grep "\bgit\b" || brew install git

# Install PostgreSQL
brew install postgres

###################################################################
# Python pip installation
###################################################################

# Install Homebrew python
# Alternately, the system Python can be used but installing Python
# dependencies may require sudo
brew install python

# Tap ome-alt library
if [ "$TESTING_MODE" = true ]; then
    brew tap --full ome/alt || echo "Already tapped"

    # Install scc tools
    pip install -U scc || echo "scc installed"

    # Merge homebrew-alt PRs
    cd /usr/local/Library/Taps/ome/homebrew-alt
    scc merge master

    # Repair formula symlinks after merge
    brew tap --repair
else
    brew tap ome/alt || echo "Already tapped"
fi

# Tap homebrew-science library (HDF5)
brew tap homebrew/science || echo "Already tapped"
