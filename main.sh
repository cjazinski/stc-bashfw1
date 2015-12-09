#!/bin/bash
# Name: main.sh
# Author: Christopher Jazinski
# Created: 12/03/2015
# Version: .01a
# Purpose: oo-framework looked very promising but would not work properly bash 3.x for this reason I created the Some Text Commands bash framework or simply stc-bashfw1. I am trying to implement the same commands found in oo-framework. 

# Bootstrap the framework
source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/lib/stc-bashfw1.sh"

## Check for arguments ##

## Set env variables ##

## import (source) files##

#Good Idea to use tempfiles
localDirectory=$PWD
TEMP_FILE=$localDirectory/printfile.$$.$RANDOM

#House Cleaning
clear
echo "-=-=-= Script Started =-=-=-"
echo "$USER `date`" 


################################################
############### Code Goes Here #################
################################################

# House Keeping to clean up
# Should unset env variables
# remove files, etc.
# TO DO: Should be moved into a TRAP
echo "-=-=-= Script End =-=-=-"

exit 0