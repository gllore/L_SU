#!/bin/bash

# see if global variable is set
# global variable L_SU locates main folder

 if [ -z "${L_SU}" ]; then

 	echo "global variable L_SU must first be set"
 	echo "e.g. in .bashrc: "
 	echo " export L_SU=/usr/local/pl/L_SU "

 else
	echo "L_SU =" ${L_SU}
fi