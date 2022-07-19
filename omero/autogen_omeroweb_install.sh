#!/usr/bin/env bash
# This script is used by a Continuous Integration job to auto-generate
# the omero-web installation walkthrough.
# The repository https://github.com/ome/omero-install should be downloaded
# downloaded in the WORKSPACE directory. If it
set -u
set -e
set -x

WORKSPACE=${WORKSPACE:-$(pwd)}
WORKSPACE=${WORKSPACE%/}  # Remove trailing slashes
export DOCVENV=${DOCVENV:-$WORKSPACE/.venv3}

$DOCVENV/bin/pip install 'ansible<2.10' jinja2==3.0.1

(cd $WORKSPACE/omeroweb-install && $DOCVENV/bin/ansible-playbook ./.travis/../ansible/omeroweb-install-doc.yml -i ./.travis/../ansible/hosts/centos7-ice3.6 --extra-vars '{"clean": True, "web_session": True}')
(cd $WORKSPACE/omeroweb-install && $DOCVENV/bin/ansible-playbook ./.travis/../ansible/omeroweb-install-doc.yml -i ./.travis/../ansible/hosts/ubuntu1804-ice3.6 --extra-vars '{"clean": True, "web_session": True}')
(cd $WORKSPACE/omeroweb-install && $DOCVENV/bin/ansible-playbook ./.travis/../ansible/omeroweb-install-doc.yml -i ./.travis/../ansible/hosts/ubuntu2004-ice3.6 --extra-vars '{"clean": True, "web_session": True}')
(cd $WORKSPACE/omeroweb-install && $DOCVENV/bin/ansible-playbook ./.travis/../ansible/omeroweb-install-doc.yml -i ./.travis/../ansible/hosts/debian10-ice3.6 --extra-vars '{"clean": True, "web_session": True}')

mv $WORKSPACE/omeroweb-install/ansible/doc/* omero/sysadmins/unix/install-web/walkthrough/
