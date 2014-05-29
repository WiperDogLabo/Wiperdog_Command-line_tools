Wiperdog_Command-line_tools
===========================
Command line tools for wiperdog, (tools should be located at $Wiperdog_HOME/bin)
 + Command-line tools/:
	- genschedule : Create/update trigger file for job
	- genjobcls : Creat/update for job class file
	- genjobinst : Creat/update for job instances file
	- genjobparam : Creat/update job param file
	- gendefaultparam: update default.params
	- deployjob : Deploy job 
	- genpolicy : Create/update policy
	
	
 + Testing/ : 
	- Script test for command-line tools
	
Usage :

	- Run tools as Unix shell script
	 EX: ./genschedule.sh
	- Run test ( Before testing ,please install "expect" tools in ubuntu environment using command "sudo apt-get install expect")
	         
	EX: ./test_genschedule.sh /path/to/wiperdog
