# !/bin/bash

#create folders for volumes if they don't exist

#check if the folder exists
if [ ! -d "data/mariadb" ]; then
	mkdir -p data/mariadb
fi

#check if the folder exists
if [ ! -d "data/wordpress" ]; then
	mkdir -p data/wordpress
fi