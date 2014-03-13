# MakeFile for building OMERO documentation

.PHONY: clean html latexpdf

# Loop over the possible products and call other build targets.
html:
	cd omero && make html

latexpdf:
	cd omero && make latexpdf

clean:
	cd omero && make clean

