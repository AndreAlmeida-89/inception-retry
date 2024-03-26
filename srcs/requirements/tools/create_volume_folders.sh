# !/bin/bash

#create folders for volumes if they don't exist

#check if the folder exists
if [ ! -d "${HOME}/data/mariadb" ]; then
	mkdir -p ${HOME}/data/mariadb
fi

#check if the folder exists
if [ ! -d "${HOME}data/wordpress" ]; then
	mkdir -p ${HOME}/data/mariadb
fi