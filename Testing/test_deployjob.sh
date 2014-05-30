#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_deployjob.sh /wiperdog_home_path"
   exit
}
puts "#Prepare: Please Create & deploy a test bundle to maven local repository & start wiperdog before running testcase"
puts "Resource file to packaging test bundle located in testDeployJob/test_deployjob "

puts "++++++++++++++++++++++++++"
puts "Test tools 'deployjob'"
puts "++++++++++++++++++++++++++"
set wiperdogPath  [lindex $argv 0]
#set source_file testGe/test.trg
set job_dir  $wiperdogPath/var/job
set tmp_dir  $wiperdogPath/tmp/job
puts "#Case1: Input all require data & install selected file: "
#Remove all file in var/job before test
set listDelJob [glob -nocomplain $job_dir/*]
set listDelTmp [glob -nocomplain $tmp_dir/*]
foreach name $listDelJob {
	file delete -force $name
}
foreach name $listDelTmp {
	file delete -force $name
}

spawn $wiperdogPath/bin/deployjob.sh
expect "Enter bundle groupId: "
send "org.wiperdog\r"
expect "Enter bundle artifactId: "
send "job\r"
expect "Enter bundle version: "
send "1.0\r"
expect "Enter wiperdog host (default is : \"localhost\"):"
send "\r"
expect "Enter Rest post (default is : 8089): "
send "\r"
sleep 3
#check if file downloaded and extract to tmp/job
set assert1 [file exist $tmp_dir/A.job]
set assert2 [file exist $tmp_dir/B.job]
set assert3 [file exist $tmp_dir/C.job]
expect "Enter 'all' for install all files:  Left empty for exit : "
send "0\r"
expect "Enter 'all' for install all files:  Left empty for exit : "
send "\r"
expect eof
sleep 3
#check if selected file installed in var/job
set assert4 [file exist $job_dir/.job]

if {$assert1 == 1 && $assert2 == 1 && $assert3 == 1 && $assert4 == 0 } {
	puts "Case 1 : Success ! "
} else {
	puts "Case 1 : Failed !"
}

puts "--------------------------------------------------------"

puts "#Case2: Input all require data & install all file: "
set listDelJob [glob -nocomplain $job_dir/*]
set listDelTmp [glob -nocomplain $tmp_dir/*]

foreach name $listDelJob {
	file delete $name
}
foreach name $listDelTmp {
	file delete $name
}

spawn $wiperdogPath/bin/deployjob.sh
expect "Enter bundle groupId: "
send "org.wiperdog\r"
expect "Enter bundle artifactId: "
send "job\r"
expect "Enter bundle version: "
send "1.0\r"
expect "Enter wiperdog host (default is : \"localhost\"):"
send "\r"
expect "Enter Rest post (default is : 8089): "
send "\r"
sleep 3
#check if file downloaded and extract to tmp/job
set assert1 [file exist $tmp_dir/A.job]
set assert2 [file exist $tmp_dir/B.job]
set assert3 [file exist $tmp_dir/C.job]
sleep 3
expect "Enter 'all' for install all files:  Left empty for exit : "
send "all\r"
expect "Enter 'all' for install all files:  Left empty for exit : "
send "\r"
expect eof
sleep 3
#check if selected file installed in var/job
set assert4 [file exist $job_dir/A.job]
set assert5 [file exist $job_dir/B.job]
set assert6 [file exist $job_dir/C.job]

if {$assert1 == 1 && $assert2 == 1 && $assert3 == 1 && $assert4 == 1 && $assert5 == 1 && $assert6 == 1} {
	puts "Case 2 : Success ! "
} else {
	puts "Case 2 : Failed !"
}
puts "---------------------------------------------------"
puts "#Case3: Input missing require data : "
puts "Object : When missing require data ,user will be prompt to re-enter !"
#Remove all file in var/job & tmp/job before test
set listDelJob [glob -nocomplain $job_dir/*]
set listDelTmp [glob -nocomplain $tmp_dir/*]

foreach name $listDelJob {
	file delete $name
}
foreach name $listDelTmp {
	file delete $name
}

spawn $wiperdogPath/bin/deployjob.sh
set asser1  0
expect "Enter bundle groupId: "
send "\r"
expect {
	"Enter bundle groupId: "  {
		set assert1  1
		send "org.wiperdog\r"
	}
}
set asser2  0
expect "Enter bundle artifactId: "
send "\r"
expect {
	"Enter bundle artifactId: "  {
		set assert2  1
		send "job\r"
	}
}
set asser3  0
expect "Enter bundle version: "
send "\r"


expect {
	"Enter bundle version: "  {
		set assert3  1
		send "1.0\r"
	}
}
expect "Enter wiperdog host (default is : \"localhost\"):"
send "\r"
expect "Enter Rest post (default is : 8089): "
send "\r"
expect "Enter 'all' for install all files:  Left empty for exit : "
send "\r"
expect eof

if {$assert1 == 1 && $assert2 == 1 && $assert3 == 1} {
	puts "Case 3 : Success ! "
} else {
	puts "Case 3 : Failed !"
}

puts "--------------------------------------------------------"

puts "#Case4: Repeat install multi times at one time the deployjob start: "
set listDelJob [glob -nocomplain $job_dir/*]
set listDelTmp [glob -nocomplain $tmp_dir/*]

foreach name $listDelJob {
	file delete $name
}
foreach name $listDelTmp {
	file delete $name
}

sleep 10
spawn $wiperdogPath/bin/deployjob.sh
expect "Enter bundle groupId: "
send "org.wiperdog\r"
expect "Enter bundle artifactId: "
send "job\r"
expect "Enter bundle version: "
send "1.0\r"
expect "Enter wiperdog host (default is : \"localhost\"):"
send "\r"
expect "Enter Rest post (default is : 8089): "
send "\r"
sleep 3
#check if file downloaded and extract to tmp/job
expect "Enter 'all' for install all files:  Left empty for exit : "
send "1\r"
sleep 3
#check if selected file installed in var/job
set assert1 [file exist $job_dir/A.job]
set assert2 [file exist $job_dir/C.job]
set assert3 [file exist $job_dir/B.job]
set assert4 0
set assert5 0
set assert5 0
expect { 
	"Enter 'all' for install all files:  Left empty for exit : " {
		set assert4 1
		send "2\r"
		sleep 1
		set assert5 [file exist $job_dir/A.job]
		set assert6 [file exist $job_dir/C.job]
		set assert7 [file exist $job_dir/B.job]
	}
}
expect "Enter 'all' for install all files:  Left empty for exit : "
send "\r"
expect eof
if {$assert1 == 0 && $assert2 == 1  && $assert3 == 0 && $assert4 == 1 && $assert5 == 0 && $assert6 == 1 && $assert7 == 1} {
	puts "Case 4 : Success ! "
} else {
	puts "Case 4 : Failed !"
}

puts "--------------------------------------------------------"

puts "#Case 5: Select file not available to install: "
puts "#Expect : Message error about invalid selection "
set listDelJob [glob -nocomplain $job_dir/*]
set listDelTmp [glob -nocomplain $tmp_dir/*]

foreach name $listDelJob {
	file delete $name
}
foreach name $listDelTmp {
	file delete $name
}

sleep 10
spawn $wiperdogPath/bin/deployjob.sh
expect "Enter bundle groupId: "
send "org.wiperdog\r"
expect "Enter bundle artifactId: "
send "job\r"
expect "Enter bundle version: "
send "1.0\r"
expect "Enter wiperdog host (default is : \"localhost\"):"
send "\r"
expect "Enter Rest post (default is : 8089): "
send "\r"
sleep 3
#check if file downloaded and extract to tmp/job
expect "Enter 'all' for install all files:  Left empty for exit : "
send "4\r"
set assert1 0
expect {
	-re "Can not select file at index :.* " {
		set assert1 1
	}
}
expect "Enter 'all' for install all files:  Left empty for exit :"
send "\r"
expect eof
if {$assert1 == 1 } {
	puts "Case 5 : Success ! "
} else {
	puts "Case 5 : Failed !"
}
