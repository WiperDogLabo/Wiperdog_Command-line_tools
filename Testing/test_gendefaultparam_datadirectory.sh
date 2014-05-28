#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_gendefaultparam_datadirectory.sh /wiperdog_home_path"
   exit
}
puts "++++++++++++++++++++++++++"
puts "Test tools 'gendefaultparam' - edit datadirectory"
puts "++++++++++++++++++++++++++"
set wiperdogPath  [lindex $argv 0]
set orgin_param testGenDefaultParam/original/default.params
set dest_file  $wiperdogPath/var/conf/default.params
puts "---------------------------------------------"
set source_file testGenDefaultParam/datadirectory/case_1/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case1: Test datadirectory - Input all require params "
spawn $wiperdogPath/bin/gendefaultparam.sh datadirectory
expect "Enter DB Type (ORACLE|SQLS|MYSQL|POSTGRES)(*): " 
send "MYSQL\r"

expect "Enter default query: " 
send "test_default_query\r"
expect "Enter query to get datadirectory: " 
send "SELECT datadirectory FROM somewhere\r"
expect "Enter append data: "
send "test_append\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
} 
puts "---------------------------------------------"
set source_file testGenDefaultParam/datadirectory/case_2/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 2: Test datadirectory - Input missing/incorrect DBTYPE"
spawn $wiperdogPath/bin/gendefaultparam.sh datadirectory
expect "Enter DB Type (ORACLE|SQLS|MYSQL|POSTGRES)(*): " 
send "\r"
set assert1 1
set assert2 1

expect {
   "DB Type is incorrect. Please re-enter: "  {
    send "NOTAVAILABLEr\r"
    set assert1 0
   }
}

expect {
   "DB Type is incorrect. Please re-enter: "  {
     send "MYSQL\r"
     set assert2 0
   }  
}
expect "Enter default query: " 
send "test_default_query\r"
expect "Enter query to get datadirectory: " 
send "SELECT datadirectory FROM somewhere\r"
expect "Enter append data: "
send "test_append\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0 && $assert1 == 0 && $assert2 == 0} {
   puts "Case 2 Success !\r"
} else {
   puts "Case 2 Failed ! \r"
} 

puts "---------------------------------------------"
set source_file testGenDefaultParam/datadirectory/case_3/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 3: Test datadirectory - Input missing default query"
spawn $wiperdogPath/bin/gendefaultparam.sh datadirectory
expect "Enter DB Type (ORACLE|SQLS|MYSQL|POSTGRES)(*): " 
send "MYSQL\r"
expect "Enter default query: " 
send "\r"
expect "Enter query to get datadirectory: " 
send "SELECT datadirectory FROM somewhere\r"
expect "Enter append data: "
send "test_append\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0 } {
   puts "Case 3 Success !\r"
} else {
   puts "Case 3 Failed ! \r"
} 
puts "---------------------------------------------"
set source_file testGenDefaultParam/datadirectory/case_4/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 4: Test datadirectory - Input missing query to get datadirectory"
spawn $wiperdogPath/bin/gendefaultparam.sh datadirectory
expect "Enter DB Type (ORACLE|SQLS|MYSQL|POSTGRES)(*): " 
send "MYSQL\r"
expect "Enter default query: " 
send "\r"
expect "Enter query to get datadirectory: " 
send "\r"
expect "Enter append data: "
send "test_append\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0 } {
   puts "Case 4 Success !\r"
} else {
   puts "Case 4 Failed ! \r"
} 
puts "---------------------------------------------"
set source_file testGenDefaultParam/datadirectory/case_5/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 5: Test datadirectory - Input missing append data"
spawn $wiperdogPath/bin/gendefaultparam.sh datadirectory
expect "Enter DB Type (ORACLE|SQLS|MYSQL|POSTGRES)(*): " 
send "MYSQL\r"
expect "Enter default query: " 
send "\r"
expect "Enter query to get datadirectory: " 
send "\r"
expect "Enter append data: "
send "\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0 } {
   puts "Case 5 Success !\r"
} else {
   puts "Case 5 Failed ! \r"
} 