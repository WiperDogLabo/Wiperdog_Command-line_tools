#!/bin/sh
command -v groovy >/dev/null 2>&1 || { echo "Groovy not installed. Aborting." >&2; exit 1;}
if [ "$#" -eq 6 ] ; then
	groovy genschedule.groovy $1 $2 $3 $4 $5 $6
else
	if [ "$#" -eq 4 ] ;then
		groovy genschedule.groovy $1 $2 $3 $4
	else
		echo $#
		echo "Incorrect parameter: "
		echo "Usage : "
		echo "genschedule [-f] [file_name] -j [job_name] -s [schedule]"
	fi
fi
