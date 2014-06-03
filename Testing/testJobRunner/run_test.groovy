public class TestJobRunner{
	public static void main(String [] args){
		String dirFolderTest = "";
		List<String> listCmd = new LinkedList<String>();
		def output = ""
		try {
			// get directory currently
			if(args.size() == 5) {
				dirFolderTest = args[4]			
			} else {
				println "===Command for test is wrong!!!==="
				return			
			}
			
			File dir = new File(dirFolderTest);
			def pathToWiperdog = ""
			def caseTest = ""
			args.eachWithIndex {item, index ->
				// get path to wiperdog
				if ((index < (args.size() - 1)) && (item == "-p") && (args[index+1] != null)) {
					pathToWiperdog = args[index+1].replaceAll("\"", "").replaceAll("\'", "").trim()
				}
				// get case want to test
				if ((index < (args.size() - 1)) && (item == "-c") && (args[index+1] != null)) {
					caseTest = args[index+1].replaceAll("\"", "").replaceAll("\'", "").trim()
				}
			}
			
			// path to folder wiperdog test
			def toFolder = pathToWiperdog + "var/job/"
			// path to folder contains job test
			def fromFolder
			def jobTest
			def listFileTest = (new File(dirFolderTest + "Job_Test/" + caseTest + "/")).listFiles()

			// remove job exist in var/job
			listFileTest.each{
				File fileTest = new File(toFolder + it.getName().toString())
				if(fileTest.exists()){
					fileTest.delete()
				}
				if(it.getName().toString().contains(".job")){
					jobTest = it.getName().toString()
				}
			}
			sleep(2000)

			// copy job file to var/job
			listFileTest.each{
				fromFolder = it.toString()
				listCmd = new LinkedList<String>();
				listCmd.add("/bin/cp")
				listCmd.add(fromFolder)
				listCmd.add(toFolder)
				// get output when run command
				runProcClosure(listCmd, dir, true)
			}
			println "Create job for test!!!"
			sleep(2000)

			// run testcase
			listCmd = new LinkedList<String>();
			listCmd.add("/bin/bash")
			listCmd.add("jobrunner.sh")
			listCmd.add("-f")
			// add schedule
			if (caseTest == "Case8") {
				// run job with default path var/job
				listCmd.add(jobTest)
				listCmd.add("-s")
				listCmd.add("5")
			} else if (caseTest == "Case2" || caseTest == "Case9") {
				// run job with absolute path
				listCmd.add(toFolder + jobTest)
				listCmd.add("-s")
				listCmd.add("10i")
			} else if (caseTest == "Case10") {
				listCmd.add("-s")
				listCmd.add("0/10 * * * * ?")
			} else {
				// run job with relative path
				listCmd.add("var/job/" + jobTest)
			}
			// set dir to run jobrunner
			dir = new File(System.getProperty("user.dir"))
			// get output when run command
			println listCmd
			println "processing..."
			output = runProcClosure(listCmd, dir, true)
			sleep(5000)

			// check result data
			if (caseTest == "Case1") {
				// Test job connect to SQLServer + QUERY
				if (output.contains("ProductVersionStr") && output.contains("ProductLevelStr")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case2") {
				// Test job connect to MYSQL
				if (output.contains("ProtocolVersionTxt") && output.contains("VersionTxt")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case3") {
				// Test job connect to POSTGRES
				if (output.contains("Database Version") && output.contains("PostgreSQL")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case4") {
				// Test job connect to OS
				if (output.contains("SystemWithIOPct") && output.contains("UsedPct")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case5") {
				// Test job processing with GROUPKEY + ACCUMULATE + FINALLY
				println output
				if (output.contains("\"Name\" : \"thanhmx\"") && output.contains("\"Count\": 100") && output.contains("\"Count\": 120")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case6") {
				// Test job processing with data Subtyped
				if (output.contains("\"Message\" : \"Group D!\"") && output.contains("\"Message\" : \"Group M!\"")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case7") {
				// Test job processing with COMMAND
				if (output.contains("\"id\": \"123\"")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case8") {
				// Test job with schedule is "5"
				if (output.contains("\"data\": \"Message test for Job_08!!!\"")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case9") {
				// Test job with schedule is "10i"
				if (output.contains("\"data\": \"Message test for Job_09!!!\"")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} else if (caseTest == "Case10") {
				// Test job with schedule is crontab
				if (output.contains("\"data\": \"Message test for Job_10!!!\"")) {
					println "====Test successfully!!!===="
				} else {
					println "====Test failed!!!===="
				}
			} 
		}catch(Exception ex){
			ex.printStackTrace()
		}
	}

	/**
	 * run command with ProcessBuider
	 * @param listCmd list command
	 * @param dir directory of project
	 * @param waitFor 
	 * @return
	 */
	public static String runProcClosure(listCmd,dir,waitFor){
		def output = [:]
		ProcessBuilder builder = new ProcessBuilder(listCmd);
		builder.redirectErrorStream(true);
		builder.directory(dir);
		Process p = builder.start();
		if(waitFor){
			output['exitVal'] = p.waitFor()
		}
		InputStream procOut  = p.getInputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(procOut))
		def line = null
		StringBuffer stdin = new StringBuffer()
		while((line = br.readLine()) != null){
			stdin.append(line + "\n")
		}
		output["message"] = stdin.toString()
		return output["message"]
	}
}
