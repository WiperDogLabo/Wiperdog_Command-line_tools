public class GenSchedule{
	public static void main(String [] args){
		try {
			def trgFileName ;
			def jobName;
			def schedule;		
			for(int i=0 ; i< args.length; i++ ){
				//get trigger file name
				if(args[i].equalsIgnoreCase("-f")){
					if(!args[i+1].trim().equals("") ){
						trgFileName = args[i+1]
					} else {
						println "Missing file name value"
						return
					}
				}
				//get job name
				if(args[i].equalsIgnoreCase("-j")){
					if(!args[i+1].trim().equals("") ){
						jobName = args[i+1]
					} else {
						println "Missing job name value"
						return
					}
				}
				
				//get Schedule name
				if(args[i].equalsIgnoreCase("-s")){
					if(!args[i+1].trim().equals("") ){
						schedule = args[i+1]
					} else {
						println "Missing schedule value"
						return
					}
				}
			}
			if(trgFileName == null){
				trgFileName = jobName + ".trg"
			}
			File trgFile = new File("../var/job/"+trgFileName);
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
		}catch(Exception ex){
			ex.printStackTrace()
		}
	}
}
