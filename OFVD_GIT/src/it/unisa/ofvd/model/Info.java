package it.unisa.ofvd.model;

public class Info {

	public static String appName;
	public static String appVersion;
	public static String appBuild;
	
	public static String mongoVersion;
	public static String mysqlVersion;
	
	public static String getAppName() {
		return appName;
	}
	public static void setAppName(String appName) {
		Info.appName = appName;
	}
	public static String getAppVersion() {
		return appVersion;
	}
	public static void setAppVersion(String appVersion) {
		Info.appVersion = appVersion;
	}
	public static String getAppBuild() {
		return appBuild;
	}
	public static void setAppBuild(String appBuild) {
		Info.appBuild = appBuild;
	}
	public static String getMongoVersion() {
		return mongoVersion;
	}
	public static void setMongoVersion(String mongoVersion) {
		Info.mongoVersion = mongoVersion;
	}
	public static String getMysqlVersion() {
		return mysqlVersion;
	}
	public static void setMysqlVersion(String mysqlVersion) {
		Info.mysqlVersion = mysqlVersion;
	}
	
	
}
