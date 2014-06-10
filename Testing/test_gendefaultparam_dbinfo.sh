#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_gendefaultparam.sh /wiperdog_home_path"
   exit
}
puts "++++++++++++++++++++++++++"
puts "Test tools 'defaultedit' - edit dbinfo"
puts "++++++++++++++++++++++++++"
set wiperdogPath  [lindex $argv 0]
set orgin_param testGenDefaultParam/original/default.params
set dest_file  $wiperdogPath/var/conf/default.params
puts "---------------------------------------------"
set source_file testGenDefaultParam/dbinfo/case_1/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case1: Test dbinfo edit - Input all require param: "
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@MYSQL\r"
expect "Enter Host ID (*): " 
send "test_hostid\r"
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "5433\r"
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "y\r"
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "y\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case 2 : Test dbinfo edit - Input missing require params: "
file copy -force $orgin_param $wiperdogPath/var/conf
set source_file testGenDefaultParam/dbinfo/case_2/default.params
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
set assert1 1
set assert2 1
set assert3 1
set assert4 1
set assert5 1
set assert6 1
set assert7 1
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "\r"
expect {
	"DB Type is incorrect. Please re-enter (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " {
		send "@MYSQL\r"
		set assert1 0
	}
	
}
expect "Enter Host ID (*): " 
send "\r"
expect {
	"Host ID cannot be empty. Please re-enter (*): " {
		send "test_hostid\r"
		set assert2 0
	}
	
}

expect "Enter Host Name (*): " 
send "\r"
expect {
	"Host name cannot be empty. Please re-enter (*): " {
		send "test_hostname\r"
		set assert3 0
	}
	
}

expect "Enter Port (Port must be number)(*): " 
send "\r"
expect {
	"Port must be number. Please re-enter (*): " {
		send "5433\r"
		set assert4 0
	}
	
}
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "\r"
expect {
	"Set host ID as a DBinfo element (y|Y|n|N): " {
		send "y\r"
		set assert5 0
	}
	
}
expect "Enter User Name (*): " 
send "\r" 
expect {
	"User name cannot be empty. Please re-enter (*): " {
		send "test_user\r"
		set assert6 0
	}
	
}
expect "Enter Sid: "
send "\r"

expect "Set Sid as a DBinfo element (y|Y|n|N): " 
send "\r" 
expect {
	"Set Sid as a DBinfo element (y|Y|n|N): " {
		send "y\r"
		set assert7 0	
	}
	
}
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]

#After file written , check content with expected file
if { $status == 0 && $assert1 == 0 && $assert2 == 0 && $assert3 == 0  && $assert4 == 0 && $assert5 == 0 && $assert6 == 0 && $assert7 == 0 } {

   puts "Case 2 Success !\r"
} else {
   puts "Case 2 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case3: Test dbinfo edit - Input DBTYPE not available in { @MYSQL|@PGSQL|@MSSQL|@ORACLE } "
set source_file testGenDefaultParam/dbinfo/case_3/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
set assert1 1
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@NOTAVAILABLE\r"
expect {
	"DB Type is incorrect. Please re-enter (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " {
		send "@MYSQL\r"
		set assert1 0
	}
	
}
expect "Enter Host ID (*): " 
send "test_hostid\r"
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "5433\r"
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "y\r"
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "y\r"
expect eof

set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0 && $assert1 == 0} {
   puts "Case 3 Success !\r"
} else {
   puts "Case 3 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case 4: Test dbinfo edit - Input host id contain '.' character  "
file copy -force $orgin_param $wiperdogPath/var/conf
set source_file testGenDefaultParam/dbinfo/case_4/default.params
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo

set assert1 1
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@MYSQL\r"
expect "Enter Host ID (*): " 
send "test.hostid\r"
expect {
	"Host ID cannot contains '.' character. Please re-enter (*): " {
		send "test_hostid\r"
		set assert1 0		
	}

}
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "5433\r"
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "y\r"
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "y\r"
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]

#After file written , check content with expected file
if {$status == 0 && $assert1 == 0 } {
   puts "Case 4 Success !\r"
} else {
   puts "Case 4 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case 5: Test dbinfo edit - Port is a non-numeric"
file copy -force $orgin_param $wiperdogPath/var/conf
set source_file testGenDefaultParam/dbinfo/case_5/default.params
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
set assert1 1
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@MYSQL\r"
expect "Enter Host ID (*): " 
send "test_hostid\r"
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "test_port\r"
expect {
	"Port must be number. Please re-enter: " {
		send "5433\r"
		set assert1 0	
	}
	
}
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "y\r"
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "y\r"
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]

#After file written , check content with expected file
if {$status == 0 && $assert1 == 0 } {
   puts "Case 5 Success !\r"
} else {
   puts "Case 5 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case 6: Test dbinfo edit - Input 'set hostid as DBinfo element' incorrect"
file copy -force $orgin_param $wiperdogPath/var/conf
set source_file testGenDefaultParam/dbinfo/case_6/default.params
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
set assert1 1
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@MYSQL\r"
expect "Enter Host ID (*): " 
send "test_hostid\r"
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "5433\r"
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "A\r"
expect {
	"Set host ID as a DBinfo element (y|Y|n|N): " {
		send "y\r"
		set assert1 0
	}
	
}
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "y\r"
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]

#After file written , check content with expected file
if {$status == 0 && $assert1 == 0 } {
   puts "Case 6 Success !\r"
} else {
   puts "Case 6 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case 7: Test dbinfo edit - Input 'set hostid as DBinfo element' is 'n'"
file copy -force $orgin_param $wiperdogPath/var/conf
set source_file testGenDefaultParam/dbinfo/case_7/default.params
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@MYSQL\r"
expect "Enter Host ID (*): " 
send "test_hostid\r"
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "5433\r"
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "n\r"
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "y\r"
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]

#After file written , check content with expected file
if {$status == 0 } {
   puts "Case 7 Success !\r"
} else {
   puts "Case 7 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case 8: Test dbinfo edit - Input 'set sid as DBinfo element' is 'n'"
file copy -force $orgin_param $wiperdogPath/var/conf
set source_file testGenDefaultParam/dbinfo/case_8/default.params
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@MYSQL\r"
expect "Enter Host ID (*): " 
send "test_hostid\r"
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "5433\r"
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "y\r"
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "n\r"
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]

#After file written , check content with expected file
if {$status == 0 } {
   puts "Case 8 Success !\r"
} else {
   puts "Case 8 Failed ! \r"
} 

puts "---------------------------------------------"
puts "#Case 8: Test dbinfo edit - Update to existed element"
file copy -force $orgin_param $wiperdogPath/var/conf
set source_file testGenDefaultParam/dbinfo/case_9/default.params
spawn $wiperdogPath/bin/gendefaultparam.sh dbinfo
expect "Enter DB Type (@MYSQL|@PGSQL|@MSSQL|@ORACLE)(*): " 
send "@MYSQL\r"
expect "Enter Host ID (*): " 
send "test_hostid\r"
expect "Enter Host Name (*): " 
send "test_hostname\r"
expect "Enter Port (Port must be number)(*): " 
send "5433\r"
expect "Set host ID as a DBinfo element (y|Y|n|N): " 
send "n\r"
expect "Enter User Name (*): " 
send "test_user\r"
expect "Enter Sid: "
send "test_sid\r"
expect "Set Sid as a DBinfo element (y|Y|n|N): "
send "n\r"
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]

#After file written , check content with expected file
if {$status == 0 } {
   puts "Case 9 Success !\r"
} else {
   puts "Case 9 Failed ! \r"
} 
