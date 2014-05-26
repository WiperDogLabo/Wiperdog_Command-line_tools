Wiperodg_Command-line_tools
===========================
Command line tools for wiperdog, (tools should be located at $Wiperdog_HOME/bin)
 + Command-line tools/:
	- genschedule : Create/update trigger file for job
	- genjobcls : Creat/update for job class file
	- genjobinst : Creat/update for job instances file
	- genjobparam : Creat/update job param file
+ Testing/ : 
	- Script test for command-line tools
Usage :
	- Run tools as Unix shell script

	 EX: ./genschedule.sh
	- Rung test

	EX: ./test_genschedule.sh /path/to/wiperdog
