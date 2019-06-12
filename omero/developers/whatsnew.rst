What's new for OMERO 5.5 for developers
=======================================

This release focuses on decoupling the Java components to new,
separate repositories, each with a new `Gradle <https://gradle.org>`_ build system:

- https://github.com/ome/omero-dsl-plugin
- https://github.com/ome/omero-model
- https://github.com/ome/omero-common
- https://github.com/ome/omero-romio
- https://github.com/ome/omero-renderer
- https://github.com/ome/omero-server
- https://github.com/ome/omero-blitz
- https://github.com/ome/omero-gateway-java
- https://github.com/ome/omero-blitz-plugin
- https://github.com/ome/omero-insight
- https://github.com/ome/omero-matlab
- https://github.com/ome/omero-javapackager-plugin
- https://github.com/ome/omero-api-plugin

This has the goal of enabling more fine-grained releases.

A new restriction is that the names of server configuration properties
may include only letters, numbers and the symbols ".", "_", "-".
