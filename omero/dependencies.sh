#!/usr/bin/env bash
# This script is used by a Continuous Integration job to update
# the versions of the "ome" dependencies
# We have 3 groups:
#  - dependencies on artifactories e.g. omero-blitz
#  - dependencies on GitHub e.g. omero-insight
#  - dependencies on pypi e.g. omero-py

PREFIX="omero-"
# GitHub packages
new_version=false
github_packages=("ome/ice-builder-gradle" "ome/openmicroscopy" "ome/omero-insight" "ome/omero-matlab")
for p in "${github_packages[@]}"
do
    :
    values=(${p//// })
    value=${values[${#values[@]}-1]}
    v=${value#"$PREFIX"}
    v=${v//"-"/"_"}
    echo $v
    version=`curl --silent "https://api.github.com/repos/$p/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'`
    # drop v or version
    version=${version//"v"/""}
    echo $version
    if [ $v = "openmicroscopy" ]; then
        while IFS= read -r line; do
           values=(${line/=/ })
           if [[ ${values[0]} = "version_openmicroscopy" && \"$version\" != ${values[1]} ]]; then
               new_version=true
           fi
        done < conf_autogen.py
    fi
    
    sed -i -e "s/version_${v} = .*/version_${v} = \"${version}\"/" conf_autogen.py
done

echo $new_version

# Java packages
dirs=("org/openmicroscopy/omero-blitz" "org/openmicroscopy/omero-server" "org/openmicroscopy/omero-gateway"
      "org/openmicroscopy/omero-romio" "org/openmicroscopy/omero-renderer" "org/openmicroscopy/omero-common"
      "org/openmicroscopy/omero-model" "org/openmicroscopy/omero-dsl-plugin" "org/openmicroscopy/omero-blitz-plugin"
      "ome/formats-gpl")

if [ $new_version = "true" ]; then

    for dir in "${dirs[@]}"
    do
        : 
        values=(${dir//// })
        value=${values[${#values[@]}-1]}
        v=${value#"$PREFIX"}
        v=${v//"-"/"_"}
        echo $v
        # get the latest version of the package
        repopath="https://artifacts.openmicroscopy.org/artifactory/ome.releases/${dir}"
        version=`curl -s ${repopath}/maven-metadata.xml | grep latest | sed "s/.*<latest>\([^<]*\)<\/latest>.*/\1/"`
        echo $version
        sed -i -e "s/version_${v} = .*/version_${v} = \"${version}\"/" conf_autogen.py
    done
fi


# Python packages
packages=("omero-py" "omero-web" "omero-dropbox")
for package in "${packages[@]}"
do
    :
    v=${package#"$PREFIX"}
    echo $v
    version=`curl -Ls https://pypi.org/pypi/$package/json | jq -r .info.version`
    echo $version
    sed -i -e "s/version_${v} = .*/version_${v} = \"${version}\"/" conf_autogen.py
done



# Clean up
rm conf_autogen.py-e
