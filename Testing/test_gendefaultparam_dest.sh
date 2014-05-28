#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_gendefaultparam_dest.sh /wiperdog_home_path"
   exit
}
puts "++++++++++++++++++++++++++"
puts "Test tools 'defaultedit' - edit dest"
puts "++++++++++++++++++++++++++"
set wiperdogPath  [lindex $argv 0]
set orgin_param testGenDefaultParam/original/default.params
set dest_file  $wiperdogPath/var/conf/default.params
puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_1/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case1: Test dest edit - Adding dest : 'file' "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "add\r"
expect "Enter key of dest (file|http|mongoDB)(*): " 
send "file\r"
expect "Enter correnponding value(*): " 
send "test_case_1.txt\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
} 
puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_2/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 2: Test dest edit - Adding dest : 'http' "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "add\r"
expect "Enter key of dest (file|http|mongoDB)(*): " 
send "http\r"
expect "Enter correnponding value(*): " 
send "http://test_case_2:13111/tmp\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 2 Success !\r"
} else {
   puts "Case 2 Failed ! \r"
} 
puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_3/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 3: Test dest edit - Adding dest : 'mongoDB' "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "add\r"
expect "Enter key of dest (file|http|mongoDB)(*): " 
send "mongoDB\r"
expect "Enter correnponding value(*): " 
send "localhost:27017/test_case_3\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 3 Success !\r"
} else {
   puts "Case 3 Failed ! \r"
} 
puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_4/default.params
set origin_param_full testGenDefaultParam/original/other/default.params
file copy -force $origin_param_full $wiperdogPath/var/conf
puts "#Case 4: Test dest edit - Delete dest : 'file' "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "delete\r"
expect "Enter delete key: " 
send "file\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 4 Success !\r"
} else {
   puts "Case 4 Failed ! \r"
} 
puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_5/default.params
set origin_param_full testGenDefaultParam/original/other/default.params
file copy -force $origin_param_full $wiperdogPath/var/conf
puts "#Case 5: Test dest edit - Delete dest : 'http' "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "delete\r"
expect "Enter delete key: " 
send "http\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 5 Success !\r"
} else {
   puts "Case 5 Failed ! \r"
} 

puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_6/default.params
set origin_param_full testGenDefaultParam/original/other/default.params
file copy -force $origin_param_full $wiperdogPath/var/conf
puts "#Case 6: Test dest edit - Delete dest : 'mongoDB' "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "delete\r"
expect "Enter delete key: " 
send "mongoDB\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 6 Success !\r"
} else {
   puts "Case 6 Failed ! \r"
} 

puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_7/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 7: Test dest edit - Adding dest not available "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "add\r"
expect "Enter key of dest (file|http|mongoDB)(*): " 
send "not_available\r"
set assert1 1
expect {
	"Enter key of dest (file|http|mongoDB)(*): " {
		send "file\r"
		set assert1 0
	}
}
expect "Enter correnponding value(*): " 
send "test_case_7.txt\r"
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0 && $assert1 == 0} {
   puts "Case 7 Success !\r"
} else {
   puts "Case 7 Failed ! \r"
} 

puts "---------------------------------------------"
set source_file testGenDefaultParam/dest/case_8/default.params
file copy -force $orgin_param $wiperdogPath/var/conf
puts "#Case 8: Test dest edit - Delete dest not available "
spawn $wiperdogPath/bin/gendefaultparam.sh dest
expect "*** Do you want (add|delete) dest? " 
send "delete\r"
expect "Enter delete key: " 
send "not_available\r"
set assert1 1
expect {
	"This key is not exist. Please re-enter: " {
	send "file\r"
	set assert1 0
	}
}
expect eof
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0 && $assert1 == 0} {
   puts "Case 8 Success !\r"
} else {
   puts "Case 8 Failed ! \r"
} 