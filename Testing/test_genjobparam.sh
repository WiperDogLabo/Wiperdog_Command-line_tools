#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_genjobinst.sh /wiperdog_home_path"
   exit
}
puts "++++++++++++++++++++++++++"
puts "Test tools 'genjobparam'"
puts "++++++++++++++++++++++++++"
puts "#Case1: Input all require data: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A.params
set dest_file  $wiperdogPath/var/job/A.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "A\r"
expect "Enter param name : "
send "a\r"
expect "Enter param value : "
send "1\r"
expect "Enter param name : "
send "b\r"
expect "Enter param value : "
send "2\r"
expect "Enter param name : "
send "\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
} 

puts "----------------------------------------------"
puts "#Case2: Input missing job file name  field: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A_2.params
set dest_file  $wiperdogPath/var/job/A_2.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "\r"
set status1 1
expect  {
 	"Enter job file name for param creation (*) : " {
 	send "A_2\r"
 	set status1 0
 	}
}
expect "Enter param name : "
send "a\r"
expect "Enter param value : "
send "1\r"
expect "Enter param name : "
send "\r"
expect "nothing"
set status2 [catch {exec diff "$source_file" "$dest_file"} result]
#After file written , check content with efxpected file
if {$status1 == 0 && $status2 == 0} {
   puts "Case 2 Success !\r"
} else {
	puts $status1
	puts $status2
   puts "Case 2 Failed ! \r"
} 


puts "----------------------------------------------"
puts "#Case 3: Input missing param name : "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A_3.params
set dest_file  $wiperdogPath/var/job/A_3.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "A_3\r"
expect "Enter param name : "
send "\r"
expect "nothing"
#After file written , check content with efxpected file
if {$status == 0} {
   puts "Case 3 Success !\r"
} else {
   puts "Case 3 Failed ! \r"
} 


puts "----------------------------------------------"
puts "#Case 4: Input missing param value : "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A_4.params
set dest_file  $wiperdogPath/var/job/A_4.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "A_4\r"
expect "Enter param name : "
send "A_4\r"
expect "Enter param value : "
send "\r"
set status 
expect  {
	"Enter param name : " {
	set status 0
	}
}
send "\r"
expect "nothing"
#After file written , check content with efxpected file
if {$status == 0} {
   puts "Case 4 Success !\r"
} else {
   puts "Case 4 Failed ! \r"
} 
