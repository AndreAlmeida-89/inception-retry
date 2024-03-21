# !/bin/bash

CRT_NAME=andde-so.42.fr
TOOLS_PATH=srcs/requirements/nginx/tools
KEY_FILE=$TOOLS_PATH/$CRT_NAME.key
CRT_FILE=$TOOLS_PATH/$CRT_NAME.crt

# Check if certificates folder exists
if [ ! -d $TOOLS_PATH ]; then
	mkdir -p $TOOLS_PATH
fi

# Check if both certificates already exist
if [ -f $KEY_FILE ] && [ -f $KEY_FILE ]; then
	echo "Certificates already exist"
	exit 0
fi

# Create certificates for the server
openssl req	-x509 \
			-newkey rsa:4096 \
			-keyout $KEY_FILE \
			-out $CRT_FILE \
			-days 365 \
			-nodes \
			-subj "/C=BR/ST=RJ/L=Rio de Janeiro/O=School 42/CN=www.$CRT_NAME"

# Check if the certificates were created
if [ -f $KEY_FILE ] && [ -f $KEY_FILE ]; then
	echo "Certificates created"
	exit 0
else
	echo "Error creating certificates"
	exit 1
fi
