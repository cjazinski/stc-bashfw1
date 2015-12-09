#!/bin/bash
# Some basic input/output commands that do some logical checking before attempting to move, copy, rename, delete, or modify files. This script also will check a file against a directory with multiple files to see if the file exists (names not important). This is done through md5sum

file_exists()
{
	# Parameters
	# $1 = file location (full path)
	if [ -z "$1" ];	then
		error_exit "You must specify a file location"
	else
		file=$1
	fi;

	if [ ! -f $file ]; then
		# 1 = false
		return 1
	else
		# 0 = true
		return 0
	fi;
}

delete_file() 
{
	# Parameters
	# $1 = file location (full path)
	#Check for parameters
	if [ -z "$1" ]
	then
		error_exit "You must specify a file location"
	else
		file=$1
	fi;
	echo "##### Validating File #####"
	if file_exists $file; then
		echo "Deleting.. $file"
		rm -f $file
	else
		echo "File: $file was not found.."
	fi;
}

has_data()
{
	# Parameters
	# $1 = file location (full path)
	#Check for parameters
	if [ -z "$1" ]
	then
		error_exit "You must specify a file location"
	else
		file=$1
	fi;
	echo "##### Validating File #####"
	if file_exists $file; then
		#counts the number of lines. If one line we know its just header and cand deleted the file.
		if [[ $(wc -l <$file) -ge 2 ]]
		then
			# 0 = true
			return 0
		else
			# 1 = false
			return 1
		fi;
	else
		echo "File: $file was not found.."
	fi;
	
}

move_file()
{
	# Parameters
	# $1 = file location (full path)
	# $2 = file out location (full path)
	#Check for parameters
	if [ -z "$1" ]
	then
		error_exit "You must specify a file"
	else
		file=$1
	fi;

	if [ -z "$2" ]
	then
		error_exit "You must specify new location"
	else
		file_out=$2
	fi;

	if file_exists $file; then
		mv $file $file_out
		if [ $? -ne 0 ]; then
			error_exit "Error moving file $file to $file_out"
		else
			echo "$file moved to $file_out"
		fi;
	else
		error_exit "File $file was not found"
	fi;
}

change_file_attributes()
{
	# Parameters
	# $1 = octal attribute to apply
	# $2 = file
	#Check for parameters
	if [ -z "$1" ]
	then
		error_exit "You must specify a file"
	else
		attributes=$1
	fi;

	if [ -z "$2" ]
	then
		error_exit "You must specify a file"
	else
		file=$2
	fi;
	if file_exists $file; then
		chmod $attributes $file
	else
		error_exit "File $file not found"
	fi;	
}

copy_file()
{
	# Parameters
	# $1 = file location (full path)
	# $2 = file out location (full path)
	#Check for parameters
	if [ -z "$1" ]
	then
		error_exit "You must specify a file"
	else
		file=$1
	fi;

	if [ -z "$2" ]
	then
		error_exit "You must specify new location"
	else
		file_out=$2
	fi;

	if file_exists $file; then
		cp $file $file_out
		if [ $? -ne 0 ]; then
			error_exit "Error copying file $file to $file_out"
		else
			echo "$file copied to $file_out"
		fi;
	else
		error_exit "File $file was not found"
	fi;
}

duplicate_file_exists()
{
	# Parameters
	# $1 = fileToCheck
	# $2 = directory to search
	#Check for parameters
	if [ -z "$1" ]
	then
		error_exit "You must specify a file"
	else
		file=$1
		md5File=$( md5sum $file | awk '{ print $1 }' )
		echo "-- MD5 $md5File"
	fi;

	if [ -z "$2" ]
	then
		error_exit "You must specify new location"
	else
		directory=$2/*
	fi;

	echo "-- Searching $directory for duplicate file"
	for f in $directory
	do
		#echo "found $f - Getting MD5SUM"
		md5Current=$( md5sum $f | awk '{ print $1 }' )
		if [ "$md5File" == "$md5Current" ]; then
			if [ "$file" == "$f" ]; then
				echo "-- Skipping current file in directory"
			else
				error_exit "File $file has already been processed under the name $f"
			fi;
		fi;
	done;
}