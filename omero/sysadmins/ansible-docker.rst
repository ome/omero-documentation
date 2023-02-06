OMERO.server installation using Ansible and Docker
==================================================

This chapter describes an installation of an OMERO.server and the most important post-installation steps, such as additional apps installation and LDAP configuration. The installation of the server on a local machine is not recommended, except for testing or development purposes. The chapter is aimed at system administrators intending to familiarize themselves with an OMERO installation or wishing to install OMERO for training purposes. It concentrates mainly on an installation using Ansible. If you intend to install a production OMERO.server, please study `the documentation <https://omero.readthedocs.io/en/stable/sysadmins>`_.

Description
-----------

We will show here:


-  Where to find the OMERO.server requirements.

-  How to install OMERO.server quickly using a simple Ansible playbook example.

-  How to install OMERO.server very quickly using a provided Docker image.

-  How to configure OMERO.server to work with LDAP, both using Ansible or using manual configuration.

-  How to install applications such as OMERO.figure for OMERO.web.

Resources
---------

- Webpage  `Start with OMERO at your Institution <https://www.openmicroscopy.org/omero/institution/getting-started.html>`_
- `Ansible <https://www.ansible.com/>`_
- `Ansible documentation <https://docs.ansible.com/ansible_community.html>`_
- `Example <https://github.com/ome/omero-deployment-examples>`_ and `production <https://github.com/ome/prod-playbooks/omero>`_ ansible playbooks.
- `OMERO installation workshop presentation <https://downloads.openmicroscopy.org/presentations/2020/Dundee/Workshops/OME2020-OMERO-Installation>`_
- `Manual installation documentation <https://omero.readthedocs.io/en/stable/sysadmins/unix/server-centos7-ice36.html>`_
- `System requirements <https://omero.readthedocs.io/en/stable/sysadmins/system-requirements.html>`_
- `List of Apps for OMERO.web <https://www.openmicroscopy.org/omero/apps/>`_

Install a server
----------------

System requirements for an OMERO.server are specified in the `documentation <https://omero.readthedocs.io/en/stable/sysadmins/system-requirements.html>`_.
The workflows below were tested on CentOS 7 (python 3.6) and Ubuntu 20.04 (python 3.8.10) only.

Ansible
-------

For OMERO installation, we recommend to use the Ansible software suite which enables infrastructure as a code.

Install ansible (at the time of writing, the ansible-core versions tested were 2.8.18 and 2.11.12). Other versions might work too, but are not routinely tested.::

    $ pip install ansible

Clone the repository for the one-node example::

    $ git clone https://github.com/ome/ansible-example-omero-onenode.git
    $ cd ansible-example-omero-onenode	

Install the requirements::

    $ ansible-galaxy install -r requirements.yml

Edit the file ``hosts.yml`` in the same directory and replace the YOUR-HOST-NAME variable with a name of your machine you prepared in the step above to install OMERO on, e.g. ``foo.example.com`` or ``localhost``)::

    all:
      hosts:
        YOUR-HOST-NAME 

Edit the ``playbook.yml`` file to change the OMERO root password (by default ``ChangeMe``). Then use this playbook to install PostgreSQL, OMERO.server and OMERO.web on one node::

    $ ansible-playbook --become -i hosts.yml playbook.yml

Start OMERO.insight or a Command Line Interface (CLI) and log in to ``YOUR-HOST-NAME`` with the username ``root`` and the password you have set in the ``playbook.yml`` above.

Go to ``https://YOUR-HOST-NAME:4080/webclient/`` in your browser and log in to OMERO.web with the same credentials used above for OMERO.insight. In case you are on the same machine where you installed your OMERO, go to `http://localhost:4080/webclient/ <http://localhost:4080/webclient/>`_ to access your OMERO.web locally.

Docker
------

This approach is quicker than the Ansible installation but you should be comfortable working with containers. The docker workflow below is written for local installation of OMERO only for convenience, but bear in mind that you will have to install OMERO on a remote server when going into production.

Assuming that Docker is installed, clone the deployment examples repository (if not already cloned)::

    $ git clone https://github.com/ome/omero-deployment-examples.git
    $ cd omero-deployment-examples
    $ git clone https://github.com/ome/docker-example-omero.git
    $ cd docker-example-omero

Pull the latest versions of the containers and start them::

    $ docker-compose pull
    $ docker-compose up -d
    $ docker-compose logs -f

Start OMERO.insight or a Command Line Interface (CLI) and log in to ``localhost`` as ``root`` with password ``omero``.

Go to `http://localhost:4080/webclient/ <http://localhost:4080/webclient/>`_ in your browser and log in to OMERO.web as ``root`` with password ``omero``.

Manual installation
-------------------

You also have the option to follow the manual server installation steps - see link in Resources section above. This way is harder then using Ansible or Docker, but you will understand the
server installation in-depth after this.

.. _Warningansible:

.. warning::
    If you used Ansible to install your server, it is not advisable to start making manual installs on top of this, as the next re-run of the Ansible playbook might invalidate the manual changes made.

Install the apps
----------------

In order to give your users full OMERO experience, you might want to install apps after you successful OMERO.server and OMERO.web install above. Many user-facing features are released only as applications for OMERO.web, such as full image viewer and OMERO.figure.

1. Install the apps using Ansible: If you used Ansible to install your OMERO.server, we recommend to add the apps installation lines to your Ansible playbook. First, create an `omero_server_python_addons block <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L74>`_ under your `ome.omero_server <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L73>`_ role block and add the `reportlab <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L78>`_ and `markdown <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L79>`_ addons to it. These addons are necessary for OMERO.figure exports. Further, under your `ome.omero_web <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L84>`_ role block create an `omero_web_config_set definition <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L108>`_ and add the following blocks to it:

 - `omero_web_apps <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L109>`_ 

 - `omero.web.ui.center_plugins <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L117>`_

 - `omero.web.ui.top_links <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L120>`_ 

 - `omero.web.open_with <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L128>`_ 

 - `omero.web.iviewer_view line  <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L141>`_ # enables OMERO.iviewer as default viewer

 - `omero.web.mapr.config <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L142>`_

You also have to `define the App package variables <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L453>`_ in a `vars block at the end of your playbook <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L433>`_. You can simplify the definition and ignore the ``override`` logic as follows::
    
    vars:
      omero_figure_release: "5.1.0"
      omero_web_apps_packages:
        - "omero-figure=={{ omero_figure_release }}"
        - "omero-fpbioimage"
        - "omero-iviewer"
        - "omero-mapr"
        - "omero-parade"
        - "omero-webtagging-autotag"
        - "omero-webtagging-tagsearch"    
    
The release number such as ``5.1.0`` above can be taken from `Python package index (Pypi) <https://pypi.org/search/?q=omero>`_ or you can copy the most recent number from `the OME training playbook <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L444>`_ . Note that the ``omero_figure_release`` must be defined as shown above, because it is used by the Figure_To_Pdf.py routine described below.

In a separate `task <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L187>`_ block `define the job of downloading the necassary script for OMERO.figure <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L204>`_ which exports the Figures as pdf. Then rerun the command::

    $ ansible-playbook --become -i hosts.yml playbook.yml

2. You can also install Apps manually according to `Apps for OMERO.web <https://www.openmicroscopy.org/omero/apps/>`_, but note the :ref:`warning <Warningansible>`.

Configure your server
---------------------

Depending on the environment and purpose of your server, you will need to configure your OMERO.server. 

The parameters which might be necessary for the OMERO.server accessed by many users at the same time, e.g. in training are defined in the `omero_server_config_set block <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L473>`_. Add such ``omero_server_config_set`` block to your playbook and include into it

  - `omero.db.poolsize <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L479>`_
  
  - the `omero.jvmcfg <https://github.com/ome/prod-playbooks/blob/929a4c4fefcffa3b8cebe65047aa32ddbfe0c5b7/omero/training-server/playbook.yml#L480>`_ parameters.

Then rerun the command::

    $ ansible-playbook --become -i hosts.yml playbook.yml

The configuration of the OMERO.server can also be achived `manually <https://omero.readthedocs.io/en/stable/sysadmins/unix/server-centos7-ice36.html#configuring-omero-server>`_, but note the :ref:`warning <Warningansible>`.
