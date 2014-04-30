# Delegate all make targets directly to ant

CLASSPATH := $(pwd)/common/ant-contrib-1.0b3.jar

%:
	ant $@
