#!/bin/bash

echo "Test tools 'defaultedit'"
echo "------------------------"
current_path=$(pwd)

# ============ Case 1 ===============
echo ">>>>> Case1: Update db information <<<<<"
source_file="$current_path/testDefaultEdit/case_1/default.params"
dest_file="$1/var/conf/default.params"

cd $1/bin
./defaultedit.sh dbinfo --dbt @PGSQL --hid HOSTID_TEST --hn HOSTNAME_TEST --p 5433 --usn THANHPT --sid SID_TEST --hidik --sidik
[[ `diff $source_file $dest_file` ]] &&
	(echo "Case 1 Failed !!!") ||
	(echo "Case 1 Success !!!")

# ============ Case 2 ===============
echo ">>>>> Case 2: Update destination <<<<<"
source_file="$current_path/testDefaultEdit/case_2/default.params"
dest_file="$1/var/conf/default.params"

cd $1/bin
./defaultedit.sh dest --add '[file: "test391.txt"]'
[[ `diff $source_file $dest_file` ]] &&
	(echo "Case 2 Failed !!!") ||
	(echo "Case 2 Success !!!")

# ============ Case 3 ===============
echo ">>>>> Case 3: Update programdirectory <<<<<"
source_file="$current_path/testDefaultEdit/case_3/default.params"
dest_file="$1/var/conf/default.params"

cd $1/bin
./defaultedit.sh datadirectory --db ORACLE --default --sql QUERY_TEST --append APPEND_TEST
[[ `diff $source_file $dest_file` ]] &&
	(echo "Case 3 Failed !!!") ||
	(echo "Case 3 Success !!!")

# ============ Case 4 ===============
echo ">>>>> Case 4: Update dbmsversion <<<<<"
source_file="$current_path/testDefaultEdit/case_4/default.params"
dest_file="$1/var/conf/default.params"

cd $1/bin
./defaultedit.sh dbmsversion --db ORACLE --default DEFAULT_DBMSVERSION --sql QUERY_DBMSVERSION --append APPEND_DBMSVERSION
[[ `diff $source_file $dest_file` ]] &&
	(echo "Case 4 Failed !!!") ||
	(echo "Case 4 Success !!!")

# ============ Case 5 ===============
echo ">>>>> Case 5: Update dblogdir <<<<<"
source_file="$current_path/testDefaultEdit/case_5/default.params"
dest_file="$1/var/conf/default.params"

cd $1/bin
./defaultedit.sh dblogdir --db ORACLE --default DEFAULT_DBLOGDIR --sql QUERY_DBLOGDIR --append APPEND_DBLOGDIR
[[ `diff $source_file $dest_file` ]] &&
	(echo "Case 5 Failed !!!") ||
	(echo "Case 5 Success !!!")