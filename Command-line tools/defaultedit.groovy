import java.io.*
import java.nio.charset.Charset
import java.util.ArrayList
import java.util.List
import java.util.regex.Matcher
import java.util.regex.Pattern
import java.io.File
import groovy.json.*

public class ProcessDefaultEdit {
	/**
	 * main: main process
	 * @param args: data receive from batch/bash file
	*/
	public static void main(String[] args) throws Exception {
		// Get map default params
		def shell = new GroovyShell()
		def filePath = System.getProperty("user.dir")
		def defaultParamsFile = new File(filePath.replace("bin", "var/conf/default.params"))
		def mapDefaultParams = shell.evaluate(defaultParamsFile.text)
		def argsSize = args.size()
		// Get key root: dbinfo, dest, datadirectory, programdirectory, dbmsversion or dblogdir
		def keyRoot = args[0]
		if (keyRoot == "dbinfo") { // Update dbinfo
			def map_db_info = [:]
			def map_db_info_inner = [:]
			def dbtype = ""
			def hostId = ""
			def hostName = ""
			def port = ""
			def userName = ""
			def sid = ""
			args.eachWithIndex {obj, i ->
				if (obj == "--dbt" && !args[i+1].contains("--")) {
					dbtype = args[i+1]
				}
				if (obj == "--hid" && !args[i+1].contains("--")) {
					hostId = args[i+1]
				}
				if (obj == "--hn" && !args[i+1].contains("--")) {
					hostName = args[i+1]
				}
				if (obj == "--p" && !args[i+1].contains("--")) {
					if (args[i+1].isNumber()) {
						port = args[i+1]
					} else {
						println "Port must be number !!!"
					}
				}
				if (obj == "--usn" && !args[i+1].contains("--")) {
					userName = args[i+1]
				}
				if (obj == "--sid" && !args[i+1].contains("--")) {
					sid = args[i+1]
				}
			}
			if (dbtype != "" && hostId != "" && hostName != "" && port != "" && userName != "") {
				// Create key for db information
				def key = dbtype
				if (args.contains("--hidik")) {
					key = hostId + "-" + key
				}
				if (args.contains("--sidik")) {
					key = key + "-" + sid
				}
				// DB information
				def db_conn_str = ""
				if (dbtype == "@MYSQL") {
					db_conn_str = "jdbc:mysql://" + hostName + ":" + port
				}
				if (dbtype== "@PGSQL") {
					db_conn_str = "jdbc:postgresql://" + hostName + ":" + port
				}
				if (dbtype== "@MSSQL") {
					db_conn_str = "jdbc:sqlserver://" + hostName + ":" + port
				}
				map_db_info_inner["dbconnstr"] = db_conn_str
				map_db_info_inner["user"] = userName
				map_db_info_inner["dbHostId"] = hostId
				map_db_info_inner["dbSid"] = sid
				mapDefaultParams['dbinfo'][key] = map_db_info_inner
			} else {
				help()
				return
			}
		} else if (keyRoot == "dest") { // Update destination
			def newDest = [:]
			if (args[1] == "--add") {
				newDest = shell.evaluate(args[2])
			}
			if (newDest != [:]) {
				def checkExistDest = false
				mapDefaultParams['dest'].each {eDest ->
					if (eDest[newDest.keySet()[0]] != null) {
						eDest[newDest.keySet()[0]] = newDest[newDest.keySet()[0]]
						checkExistDest = true
					}
				}
				if (!checkExistDest) {
					mapDefaultParams['dest'].add(newDest)
				}
			}
		} else if (keyRoot == "datadirectory") {
			def dbType = args[2]
			def defaultStr = ""
			def sqlStr = ""
			def appendStr = ""
			args.eachWithIndex {obj, i ->
				if (obj == "--default" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					defaultStr = args[i+1]
				}
				if (obj == "--sql" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					sqlStr = args[i+1]
				}
				if (obj == "--append" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					appendStr = args[i+1]
				}
			}
			if (mapDefaultParams['datadirectory'][dbType] != null) {
				mapDefaultParams['datadirectory'][dbType]['default'] = defaultStr
				mapDefaultParams['datadirectory'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['datadirectory'][dbType]['getData']['append'] = appendStr
			} else {
				mapDefaultParams['datadirectory'][dbType] = [:]
				mapDefaultParams['datadirectory'][dbType]['default'] = defaultStr
				mapDefaultParams['datadirectory'][dbType]['getData'] = [:]
				mapDefaultParams['datadirectory'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['datadirectory'][dbType]['getData']['append'] = appendStr
			}
		} else if (keyRoot == "programdirectory") {
			def dbType = args[2]
			def defaultStr = ""
			def sqlStr = ""
			def appendStr = ""
			args.eachWithIndex {obj, i ->
				if (obj == "--default" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					defaultStr = args[i+1]
				}
				if (obj == "--sql" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					sqlStr = args[i+1]
				}
				if (obj == "--append" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					appendStr = args[i+1]
				}
			}
			if (mapDefaultParams['programdirectory'][dbType] != null) {
				mapDefaultParams['programdirectory'][dbType]['default'] = defaultStr
				mapDefaultParams['programdirectory'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['programdirectory'][dbType]['getData']['append'] = appendStr
			} else {
				mapDefaultParams['programdirectory'][dbType] = [:]
				mapDefaultParams['programdirectory'][dbType]['default'] = defaultStr
				mapDefaultParams['programdirectory'][dbType]['getData'] = [:]
				mapDefaultParams['programdirectory'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['programdirectory'][dbType]['getData']['append'] = appendStr
			}
		} else if (keyRoot == "dbmsversion") {
			def dbType = args[2]
			def defaultStr = ""
			def sqlStr = ""
			def appendStr = ""
			args.eachWithIndex {obj, i ->
				if (obj == "--default" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					defaultStr = args[i+1]
				}
				if (obj == "--sql" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					sqlStr = args[i+1]
				}
				if (obj == "--append" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					appendStr = args[i+1]
				}
			}
			if (mapDefaultParams['dbmsversion'][dbType] != null) {
				mapDefaultParams['dbmsversion'][dbType]['default'] = defaultStr
				mapDefaultParams['dbmsversion'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['dbmsversion'][dbType]['getData']['append'] = appendStr
			} else {
				mapDefaultParams['dbmsversion'][dbType] = [:]
				mapDefaultParams['dbmsversion'][dbType]['default'] = defaultStr
				mapDefaultParams['dbmsversion'][dbType]['getData'] = [:]
				mapDefaultParams['dbmsversion'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['dbmsversion'][dbType]['getData']['append'] = appendStr
			}
		} else if (keyRoot == "dblogdir") {
			def dbType = args[2]
			def defaultStr = ""
			def sqlStr = ""
			def appendStr = ""
			args.eachWithIndex {obj, i ->
				if (obj == "--default" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					defaultStr = args[i+1]
				}
				if (obj == "--sql" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					sqlStr = args[i+1]
				}
				if (obj == "--append" && (i + 1 < argsSize) && !args[i+1].contains("--")) {
					appendStr = args[i+1]
				}
			}
			if (mapDefaultParams['dblogdir'][dbType] != null) {
				mapDefaultParams['dblogdir'][dbType]['default'] = defaultStr
				mapDefaultParams['dblogdir'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['dblogdir'][dbType]['getData']['append'] = appendStr
			} else {
				mapDefaultParams['dblogdir'][dbType] = [:]
				mapDefaultParams['dblogdir'][dbType]['default'] = defaultStr
				mapDefaultParams['dblogdir'][dbType]['getData'] = [:]
				mapDefaultParams['dblogdir'][dbType]['getData']['sql'] = sqlStr
				mapDefaultParams['dblogdir'][dbType]['getData']['append'] = appendStr
			}
		}

		FileWriter fw = new FileWriter(defaultParamsFile)
		BufferedWriter bw = new BufferedWriter(fw);
		def builder = new JsonBuilder(mapDefaultParams)
		def str_params =  builder.toPrettyString().replaceAll("\\{","\\[").replaceAll("\\}","\\]")
		try {
			bw.write(str_params);
			println "[SUCCESS] DEFAULT.PARAMS FILE IS UPDATED !!!"
			bw.close();
		} catch (Exception ex) {
			println "[ERROR] " + ex
		}
	}

	public static void help() {
		println ">>>>> INCORRECT FORMAT !!! <<<<<"
		println "Correct format of command: "
		println "    - defaultedit dbinfo --dbt <dbtype> --hid <hostid> --hn <hostname> --p <port> --usn <username> --sid <sid> --hidik --sidik"
		println "        + hidik: set host id as a dbinfo element"
		println "        + sidik: set sid as a dbinfo element"
		println "    - defaultedit dest --add '[file: \"stdout\"]'"
		println "    - defaultedit datadirectory --db <db type> --default <default string> --sql <query string> --append <append variable>"
		println "    - defaultedit programdirectory --db <db type> --default <default string> --sql <query string> --append <append variable>"
		println "    - defaultedit dbmsversion --db <db type> --default <default string> --sql <query string> --append <append variable>"
		println "    - defaultedit dblogdir --db <db type> --default <default string> --sql <query string> --append <append variable>"
	}
}