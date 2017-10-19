Continuous integration
======================


The OME project uses Jenkins_ as a continuous
integration server. Bring up a web browser to access the :jenkins:`OME Jenkins server <>`.

The following sections summarize the main continuous integration jobs used for
the development of OMERO, Bio-Formats and the OME documentation sets. Note
this is not an exhaustive list of all jobs in the project. To know more about
a particular job, click on the :guilabel:`Configure` button on the left-side
panel of the job window. This panel should also include a :guilabel:`GitHub`
button linking to the code repository the job is building from (alternatively,
the console output for the build will indicate where the changes are being
fetched from).


.. toctree::
    :maxdepth: 1

    ci-introduction
    ci-omero
    ci-bio-formats
    ci-ome-files
    ci-docs
    ci-consortium
    ci-release

