#!/bin/bash
TITLE="Edit default.params file !!!"

#SET DEFAULT DIRECTORY
self="$0"
dir=`dirname "$self"`
path=`pwd $0`
if [ "$dir" == "." ]  
then
    export dirname=`pwd $0`
else
    export dirname=$path"/"$dir
fi
    export currentdir=`pwd`/

# MOVE TO THE WIPERDOG HOME/BIN
PREFIX=`cd "$dir/.." && pwd`
cd "$PREFIX/bin"

##
 # helper: help when enter an incorrect format
##
function helper() {
	echo ">>>>> INCORRECT FORMAT !!! <<<<<"
	echo "Correct format of command: "
	echo "    - defaultedit dbinfo --dbt <dbtype> --hid <hostid> --hn <hostname> --p <port> --usn <username> --sid <sid> --hidik --sidik"
	echo "        + hidik: set host id as a dbinfo element"
	echo "        + sidik: set sid as a dbinfo element"
	echo "    - defaultedit dest --add '[file: \"stdout\"]'"
	echo "    - defaultedit datadirectory --db <db type> --default <default string> --sql <query string> --append <append variable>"
	echo "    - defaultedit programdirectory --db <db type> --default <default string> --sql <query string> --append <append variable>"
	echo "    - defaultedit dbmsversion --db <db type> --default <default string> --sql <query string> --append <append variable>"
	echo "    - defaultedit dblogdir --db <db type> --default <default string> --sql <query string> --append <append variable>"
	exit
}

if [[ $# -ne 2 ]]; then
	if [ "$1" == "dbinfo" ] || [ "$1" == "dest" ] || [ "$1" == "datadirectory" ] || [ "$1" == "programdirectory" ] || [ "$1" == "dbmsversion" ] || [ "$1" == "dblogdir" ] ; then
		"$PREFIX/bin/groovy" "$PREFIX/bin/defaultedit.groovy" "$@"
	else
		helper
	fi
else
	helper
fi