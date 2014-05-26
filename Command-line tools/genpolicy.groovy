import java.io.BufferedReader
import java.io.InputStreamReader
import groovy.json.*
import java.io.IOException
import java.io.InputStream
import java.io.InputStreamReader
import java.util.regex.Matcher
import java.util.regex.Pattern
import groovy.lang.GroovyShell

public class ProcessGeneratePolicy {
	def static reader = new BufferedReader(new InputStreamReader(System.in));
	def static confirmLoop = false
	def static jobName
	def static istIid
	def static group
	def static level
	def static condition
	def static message
	def static type
	def static data = [:]
	def static mappolicy = [:]
	def static mapPolicyForKey = [:]
	public static void main(String[] args) throws Exception {
		def filePath = System.getProperty("user.dir")
		def policyPath = filePath.replace("bin", "/var/job/policy")
		def policyStr
		def listStrKey = ""
		println ">>>>> ENTER POLICY'S INFORMATION <<<<<"
		print "Enter Job Name: "
		jobName = reader.readLine()
		print "Enter IstIid: "
		istIid = reader.readLine()
		print "Job is store or subtyped (store|subtyped): "
		type = reader.readLine()
		while (type != "store" && type != "subtyped") {
			print "Please choose job type: "
			type = reader.readLine()
		}
		print "Enter list key data: [a, b, c, ...]: "
		listStrKey = reader.readLine().split(",")
		ArrayList<String> listKey = new ArrayList<String>()
		listStrKey.each {
			listKey.add(it)
		}

		while(!confirmLoop) {
			enterData()
		}

		data['jobName'] = jobName
		data['instanceName'] = istIid
		data['mappolicy'] = mappolicy

		policyStr = generatePolicyString(data, listKey, type)
		def policyFile = new File(policyPath + "/" + jobName + "." + istIid + ".policy")
		try {
			policyFile.setText(policyStr)
			println "[SUCCESS] POLICY FILE IS CREATED/UPDATE !!!"
		} catch (Exception ex) {
			println "[ERROR] " + ex
		}
	}

	public static void enterData() {
		if (type == "store") {
			print "Enter Level (1:Low, 2:Medium, 3:High): "
			level = reader.readLine()
			while (level != "1" && level != "2" && level != "3") {
				print "Please choose level for policy: "
				level = reader.readLine()
			}
			print "Enter Condition [ a > 3 ]: "
			condition = reader.readLine()
			print "Enter Message (Leave message empty to finish input): "
			message = reader.readLine()
			mappolicy[condition] = message
			print "Do you want add condition (y|Y|n|N) ?"
			def check = reader.readLine()
			if (check == "n" || check == "N") {
				confirmLoop = true
			}
		} else if (type == "subtyped") {
			print "Enter Group (If job is subtyped): "
			group = reader.readLine()
			if (mappolicy[group] != null) {
				mapPolicyForKey = mappolicy[group]
			}
			print "Enter Level (1:Low, 2:Medium, 3:High): "
			level = reader.readLine()
			while (level != "1" && level != "2" && level != "3") {
				print "Please choose level for policy: "
				level = reader.readLine()
			}
			print "Enter Condition [ a > 3 ]: "
			condition = reader.readLine()
			print "Enter Message (Leave message empty to finish input): "
			message = reader.readLine()
			mapPolicyForKey[condition] = message
			mappolicy[group] = mapPolicyForKey
			mapPolicyForKey = [:]
			print "Do you want add condition (y|Y|n|N) ?"
			def check = reader.readLine()
			if (check == "n" || check == "N") {
				confirmLoop = true
			}
		}
	}

	def static generatePolicyString(data, listKey, type){
	    def policyStr = ""
	    //return data
	    try {
	        if(type == "store") {
			    if(data.mappolicy != null && data.mappolicy.size() > 0){
			   	policyStr += "POLICY = {resultData->\n"
			   	policyStr += "\tdef listMess = []\n"
				policyStr += "\tdef ret = ['jobName' : '" + data.jobName + "', 'istIid' : '" + data.instanceName + "']\n"
			   	def mapPolicy = data.mappolicy
			   	policyStr += "\tresultData.each{data->\n"
			   	mapPolicy.each {key,value ->
				    key = key.trim()
				    if(key[0] != "("){
			 	        key = "(" + key
				    }
				    if(key[key.size() - 1] != ")"){
				        key = key + ")"
				    }
						   
				    // if statement
				    policyStr += "\t\tif(" + getDataConditionsAfterEdit(key, listKey) + "){\n"
				    // message print statement
				    policyStr += "\t\t\tlistMess.add(\"\"\""+ getDataMessageAfterEdit(value, listKey) +"\"\"\")\n\t\t}\n"
			        }
				policyStr += "\t}\n"
				policyStr += "\tret['message'] = listMess\n"
				policyStr += "\treturn ret\n}"
			    }
	        } else if(type == "subtyped") {
	            policyStr += "POLICY = {resultData->\n"
	            policyStr += "\tdef listMess = []\n"
	            policyStr += "\tdef ret = ['jobName' : '" + data.jobName + "', 'istIid' : '" + data.instanceName + "']\n"
	            policyStr += "\tresultData.each {key,value ->\n"
	            data.mappolicy.each {keyData,valueData ->
	                policyStr += "\t\tif(key == \"" + keyData + "\") {\n"
	                policyStr += "\t\t\tresultData[key].each {data ->\n"
	                valueData.each {key,value ->
	                    // If
	                    policyStr += "\t\t\t\tif(" + getDataConditionsAfterEdit(key, listKey) + "){\n"
	                    // Message
	                    policyStr += "\t\t\t\t\tlistMess.add(\"\"\""+ getDataMessageAfterEdit(value, listKey) +"\"\"\")\n"
	                    policyStr += "\t\t\t\t}\n"
	                }
	                policyStr += "\t\t\t}\n"
	                policyStr += "\t\t}\n"
	            }
	            policyStr += "\t}\n"
	            policyStr += "\tret['message'] = listMess\n"
	            policyStr += "\treturn ret\n"
	            policyStr += "}"
	        }
	        return policyStr
	    } catch(Exception ex) {
			return "ex:" + ex
	    }
	}

	def static getDataConditionsAfterEdit(String stringOfPolicy, dataKey){
	    List OperatorList = [" ", "\\(", "\\)", "=", "\\+|\\-|\\*|\\/|%", ">|<|=|!", "\\|\\||&&|\\?\\:", "\\~|<<|>>|>>>|&|\\^|\\|"]

	    //Replace all unnecessary space
	    String macherPattern = "([ ]{2,})"
	    Pattern pattern = Pattern.compile(macherPattern, Pattern.DOTALL);
	    stringOfPolicy = "(" + stringOfPolicy.replaceAll(pattern, " ").trim() + ")"

	    String strKeyPattern = convertListToString(dataKey, "|")
	    String strOperator = convertListToString(OperatorList, "|")
		
	    //Create macher
	    macherPattern = "(" + strOperator + ")(" + strKeyPattern + ")(" + strOperator + "|\\.)"
	    pattern = Pattern.compile(macherPattern, Pattern.DOTALL);
	    Matcher matcher = pattern.matcher(stringOfPolicy);
	    def oldData
	    def newData
	    while(matcher.find()){
	    	oldData = matcher.group()
		newData = matcher.group(1) + "data." + matcher.group(2) + matcher.group(3)
		stringOfPolicy = stringOfPolicy.replace(oldData, newData)
	    }
	    stringOfPolicy = stringOfPolicy.substring(1, stringOfPolicy.length() -1)
	    return stringOfPolicy
	}

	def static getDataMessageAfterEdit(String stringOfMessage, dataKey){
		//Replace all unnecessary space
		String macherPattern = "([ ]{2,})"
		Pattern pattern = Pattern.compile(macherPattern, Pattern.DOTALL);
		stringOfMessage = stringOfMessage.replaceAll(pattern, " ").trim()
		stringOfMessage = "+" + stringOfMessage + "+"
	  	stringOfMessage = stringOfMessage.replaceAll('"""', '\'\'\'')
	 	String strKeyPattern = convertListToString(dataKey, "|")

		//Create macher
		macherPattern = "([ ]*[\\+]{1,}[ ]*)(" + strKeyPattern + ")([ ]*[\\+]{1,}[ ]*)"
		pattern = Pattern.compile(macherPattern, Pattern.DOTALL);
		Matcher matcher = pattern.matcher(stringOfMessage);
		def oldData
		def newData
		while(matcher.find()){
			oldData = matcher.group()
			newData = matcher.group(1) + '${data.' + matcher.group(2) + '}' + matcher.group(3)
		  	stringOfMessage = stringOfMessage.replace(oldData, newData)
		}
		stringOfMessage = stringOfMessage.substring(1, stringOfMessage.length() -1)
		stringOfMessage = stringOfMessage.replaceAll('[ ]*[\\+]{1,}[ ]*', ' ')
		stringOfMessage = stringOfMessage.replace('"', '') 
		stringOfMessage = stringOfMessage.replace('\'\'\'', '')
		return stringOfMessage
	}

	def static convertListToString (List listData, String concatStr = "|"){
		def strRet = ""
	 	listData.each {key->
	  		strRet += key + concatStr
	 	}
	 	if (strRet != "") {
	  		strRet = strRet.subSequence(0, strRet.length() - concatStr.length())
	 	}
	}
}