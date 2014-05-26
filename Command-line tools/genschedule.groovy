	def trgFileName ;
	def jobName;
	def schedule;		
	for(int i=0 ; i< args.length; i++ ){
		//get trigger file name
		if(args[i].equalsIgnoreCase("-f")){
			if(!args[i+1].trim().equals("") ){
				trgFileName = args[i+1]
			}
		}
		//get job name
		if(args[i].equalsIgnoreCase("-j")){
			if(!args[i+1].trim().equals("") ){
				jobName = args[i+1]
			}
		}
		
		//get Schedule name
		if(args[i].equalsIgnoreCase("-s")){
			if(!args[i+1].trim().equals("") ){
				schedule = args[i+1]
			}
		}
	}

	if(jobName == null) {
		println "Missing job name !"
		return
	}

	if(schedule == null) {
		println "Missing schedule !"
		return
	}
	if(trgFileName == null){
		trgFileName = jobName + ".trg"
	}
	println getClass().protectionDomain.codeSource
	def basedir = new File(getClass().protectionDomain.codeSource.location.path).parent
	File trgFile = new File(basedir + "/../var/job/",trgFileName);
	if(!trgFile.exists()){
		trgFile.createNewFile()
	} 
	def trgTxt = trgFile.getText()
	if(!trgTxt.trim().equals("")){
		trgTxt+= "\n"
	}
	trgTxt+= "job: \"${jobName}\" , schedule : \"${schedule}\""			
	trgFile.setText(trgTxt)
	println "Finished! Trigger file create at : ${trgFile.getCanonicalPath()}"

