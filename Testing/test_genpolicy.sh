#!/usr/bin/expect
#!/bin/bash
puts "++++++++++++++++++++++++++"
puts "TEST TOOLS 'genpolicy'"
puts "++++++++++++++++++++++++++"

puts ">>>>> CASE 1: GENERATE POLICY FOR JOB STORE <<<<<"

set wiperdogPath  [lindex $argv 0]
set source_file testGenPolicy/job391.store.policy
set dest_file  $wiperdogPath/var/job/policy/job391.store.policy
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genpolicy.sh

# Auto enter data
expect "Enter Job Name: "
send "job391.store\r"
expect "Enter IstIid: "
send "\r"
expect "Job is store or subtyped (store|subtyped): "
send "store\r"
expect "Enter list key data: (a, b, c, ...): "
send "schemaname, tablename, tablesize, rowcount\r"
expect "Enter Level (1:Low, 2:Medium, 3:High): "
send "2\r"
expect "Enter Condition (a > 3): "
send "tablesize > 1000\r"
expect "Enter Message: "
send "Size of table is too high\r"
expect "Do you want add condition (y|Y|n|N) ?"
send "y\r"
expect "Enter Level (1:Low, 2:Medium, 3:High): "
send "3\r"
expect "Enter Condition (a > 3): "
send "rowcount > 2014\r"
expect "Enter Message: "
send "Warning !!!\r"
expect "Do you want add condition (y|Y|n|N) ?"
send "n\r"
expect "nothing"
sleep 1

#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "=================="
if {$status == 0} {
   puts "CASE 1 SUCCESS !!!\r"
} else {
   puts "CASE 1 FAILED !!!\r"
}
puts "=================="

puts ">>>>> CASE 2: GENERATE POLICY FOR JOB SUBTYPED <<<<<"

set wiperdogPath  [lindex $argv 0]
set source_file testGenPolicy/job391.subtyped.policy
set dest_file  $wiperdogPath/var/job/policy/job391.subtyped.policy
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genpolicy.sh

# Auto enter data
expect "Enter Job Name: "
send "job391.subtyped\r"
expect "Enter IstIid: "
send "\r"
expect "Job is store or subtyped (store|subtyped): "
send "subtyped\r"
expect "Enter list key data: (a, b, c, ...): "
send "DatabaseNm, UsedDataSize, UsedIndexSize, DataFreeSize, UsedSize, TotalSize\r"
expect "Enter Group: "
send "M\r"
expect "Enter Level (1:Low, 2:Medium, 3:High): "
send "1\r"
expect "Enter Condition (a > 3): "
send "UsedSize > 9500000\r"
expect "Enter Message: "
send "UsedSize is too high\r"
expect "Do you want add condition (y|Y|n|N) ?"
send "y\r"
expect "Enter Group: "
send "M\r"
expect "Enter Level (1:Low, 2:Medium, 3:High): "
send "2\r"
expect "Enter Condition (a > 3): "
send "UsedIndexSize > 100000\r"
expect "Enter Message: "
send "okeeeeeeeee\r"
expect "Do you want add condition (y|Y|n|N) ?"
send "y\r"
expect "Enter Group: "
send "D\r"
expect "Enter Level (1:Low, 2:Medium, 3:High): "
send "3\r"
expect "Enter Condition (a > 3): "
send "TotalSize != 3000\r"
expect "Enter Message: "
send "show is ok\r"
expect "Do you want add condition (y|Y|n|N) ?"
send "n\r"
expect "nothing"
sleep 1

#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "=================="
if {$status == 0} {
   puts "CASE 2 SUCCESS !!!\r"
} else {
   puts "CASE 2 FAILED !!!\r"
}
puts "=================="