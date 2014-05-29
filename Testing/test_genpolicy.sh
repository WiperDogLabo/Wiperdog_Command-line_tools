#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_genjobinst.sh /wiperdog_home_path"
   exit
}
puts "++++++++++++++++++++++++++"
puts "TEST TOOLS 'genpolicy'"
puts "++++++++++++++++++++++++++"
puts "Importing testing data to mongo..."
set status [catch { exec mongorestore testGenPolicy/wiperdog } result]
puts "Import done !"
set wiperdogPath  [lindex $argv 0]

puts ">>>>> CASE 1: GENERATE POLICY FOR JOB STORE <<<<<"
set source_file testGenPolicy/case_1/MySQL.Performance.InnoDBIOStatus.localhost-@MYSQL-information_schema.policy
set dest_file  $wiperdogPath/var/job/policy/MySQL.Performance.InnoDBIOStatus.localhost-@MYSQL-information_schema.policy
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genpolicy.sh

# Auto enter data
expect "Enter Job Name: "
send "MySQL.Performance.InnoDBIOStatus\r"
expect "Enter IstIid: "
send "localhost-@MYSQL-information_schema\r"
expect "Enter Level (Low|Medium|High):"
send "Medium\r"
expect "Enter Condition (a > 3): "
send "WritesCnt > 100\r"
expect "Enter Message: "
send "Write count is so high\r"
expect "Do you want add condition (y|Y|n|N) ?"
send "y\r"
expect "Enter Level (Low|Medium|High):"
send "Medium\r"
expect "Enter Condition (a > 3): "
send "ReadsCnt > 100\r"
expect "Enter Message: "
send "Read count is so high\r"
expect "Do you want add condition (y|Y|n|N) ?"
send "n\r"
expect eof
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
	puts "Case 1: Success "
} else {
	puts "Case 1: Failed"
}
# puts ">>>>> CASE 2: GENERATE POLICY FOR JOB SUBTYPE <<<<<"
# set source_file testGenPolicy/case_2/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# set dest_file  $wiperdogPath/var/job/policy/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# catch { exec rm $dest_file } errorCode
# spawn $wiperdogPath/bin/genpolicy.sh

# # Auto enter data
# expect "Enter Job Name: "
# send "MySQL.Database_Area.Top30Database\r"
# expect "Enter IstIid: "
# send "localhost-@MYSQL-information_schema\r"
# expect "Enter Group: "
# send "M\r"
# expect "Enter Level (Low|Medium|High):"
# send "Low\r"
# expect "Enter Condition (a > 3): "
# send "DataFreeSize < 100\r"
# expect "Enter Message: "
# send "Database free size is low\r"
# expect "Do you want add condition (y|Y|n|N) ?"
# send "n\r"
# expect eof
# set status [catch {exec diff "$source_file" "$dest_file"} result]
# if {$status == 0} {
# 	puts "Case 2: Success "
# } else {
# 	puts "Case 2: Failed"
# }

# puts ">>>>> CASE 3: Enter job name && IstIid empty or not available <<<<<"
# set source_file testGenPolicy/case_3/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# set dest_file  $wiperdogPath/var/job/policy/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# catch { exec rm $dest_file } errorCode
# spawn $wiperdogPath/bin/genpolicy.sh

# # Auto enter data
# expect "Enter Job Name: "
# send "NOT_AVAILABLE\r"
# expect "Enter IstIid: "
# send "NOT_AVAILABLE\r"
# set assert1 1
# expect {
# 	"This job is not exists, please re-enter !!!" {
# 		set assert1 0
# 	}
	
# }
# expect "Enter Job Name: "
# send "\r"
# expect "Enter IstIid: "
# send "\r"
# set assert2 1
# expect {
# 	"This job is not exists, please re-enter !!!" {
# 		set assert2 0
# 	}
	
# }
# expect "Enter Job Name: "
# send "MySQL.Database_Area.Top30Database\r"
# expect "Enter IstIid: "
# send "localhost-@MYSQL-information_schema\r"
# expect "Enter Group: "
# send "M\r"
# expect "Enter Level (Low|Medium|High):"
# send "Low\r"
# expect "Enter Condition (a > 3): "
# send "DataFreeSize < 100\r"
# expect "Enter Message: "
# send "Database free size is low\r"
# expect "Do you want add condition (y|Y|n|N) ?"
# send "n\r"
# expect eof
# set status [catch {exec diff "$source_file" "$dest_file"} result]
# if {$status == 0 && $assert1 == 0 && $assert2 == 0} {
# 	puts "Case 3: Success "
# } else {
# 	puts "Case 3: Failed"
# }

# puts ">>>>> CASE 4: Enter group && level empty or not available <<<<<"
# set source_file testGenPolicy/case_4/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# set dest_file  $wiperdogPath/var/job/policy/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# catch { exec rm $dest_file } errorCode

# spawn $wiperdogPath/bin/genpolicy.sh
# # Auto enter data
# expect "Enter Job Name: "
# send "MySQL.Database_Area.Top30Database\r"
# expect "Enter IstIid: "
# send "localhost-@MYSQL-information_schema\r"
# expect "Enter Group: "
# send "\r"
# set assert1 1
# expect  {
# 	"Group is incorrent, please re-enter:" {
# 		send "NOT_AVAILABLE\r"
# 		set assert1 0
		
# 	}

# }
# set assert2 1
# expect {
# 	"Group is incorrent, please re-enter:" {
# 		send "M\r"
# 		set assert2 0
# 	}	
# } 

# expect "Enter Level (Low|Medium|High):"
# send "\r"
# set assert3 1
# expect {
# 	"Please choose level for policy:" {
# 		set assert3 0
# 		send "NOT_AVAILABLE\r"		
# 	}
# }
# set assert4 1
# expect {
# 	"Please choose level for policy:" {
# 		set assert4 0
# 		send "Low\r"
# 	}
# }
# expect "Enter Condition (a > 3): "
# send "DataFreeSize < 100\r"
# expect "Enter Message: "
# send "Database free size is low\r"
# expect "Do you want add condition (y|Y|n|N) ?"
# send "n\r"
# expect eof
# set status [catch {exec diff "$source_file" "$dest_file"} result]
# if {$status == 0 && $assert1 == 0 && $assert2 == 0 && $assert3 == 0 && $assert4 == 0} {
# 	puts "Case 4: Success "
# } else {
# 	puts "Case 4: Failed"
# }

# puts ">>>>> CASE 5: Enter condition && message empty"
# set source_file testGenPolicy/case_5/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# set dest_file  $wiperdogPath/var/job/policy/MySQL.Database_Area.Top30Database.localhost-@MYSQL-information_schema.policy
# catch { exec rm $dest_file } errorCode

# spawn $wiperdogPath/bin/genpolicy.sh
# # Auto enter data
# expect "Enter Job Name: "
# send "MySQL.Database_Area.Top30Database\r"
# expect "Enter IstIid: "
# send "localhost-@MYSQL-information_schema\r"
# expect "Enter Group: "
# send "M\r"
# expect "Enter Level (Low|Medium|High):"
# send "Low\r"
# expect "Enter Condition (a > 3): "
# send "\r"
# set assert1 1
# expect {
# 	 "Condition can not be empty, please re-enter: " {
# 		send "require condition\r"
# 		set assert1 0
# 	}

# }

# expect "Enter Message: "
# send "\r"
# set assert2 1
# expect {
# 	 "Message can not be empty, please re-enter: " {
# 		set assert1 0
# 		send "require message\r"
# 	}

# }

# expect "Do you want add condition (y|Y|n|N) ?"
# send "n\r"
# expect eof
# set status [catch {exec diff "$source_file" "$dest_file"} result]
# if {$status == 0 && $assert1 == 0 && $assert2 == 0 && $assert3 == 0 && $assert4 == 0} {
# 	puts "Case 5: Success "
# } else {
# 	puts "Case 5: Failed"
# }