# MakeFile for building OMERO & Formats documentations

.PHONY: clean html latexpdf

# Loop over the possible products and call other build targets.
html:
	cd omero && make html
	cd formats && make html
	cd contributing && make html

latexpdf:
	cd omero && make latexpdf
	cd formats && make latexpdf
	cd contributing && make html

clean:
	cd omero && make clean
	cd formats && make clean
	cd contributing && make clean
