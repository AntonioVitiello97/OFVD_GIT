package it.unisa.ofvd.utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import it.unisa.ofvd.connection.DBMongoConnectionPool;
import it.unisa.ofvd.connection.DBMySQLConnectionPool;
import it.unisa.ofvd.model.Info;

@WebListener
public class ApplicationContext implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {

		Utility.info("Startup \"" + Constants.appName + "\" web application", 
				"Host: " + Constants.appHost,
				"Url: " + Constants.appUrl, 
				"Local url: " + Constants.appLocalUrl,
				"Version: " + Constants.mainVersion+VersionBuild.buildnum,
				"Last update: " + VersionBuild.builddate);
		
		Info.setAppName(Constants.appName);
		Info.setAppVersion(Constants.mainVersion+VersionBuild.buildnum);
		Info.setAppBuild(VersionBuild.builddate);
		
		Utility.printDevelopment();

		try {
			DBMongoConnectionPool.test();
			Utility.info("Mongo database '" + Constants.mongoDb + "' is active");
		} catch (Exception e) {
			Utility.severe(e.getMessage());
			Utility.severe("Mongo database '" + Constants.mongoDb + "' is not active");
		}

		try {
			DBMySQLConnectionPool.test();
			Utility.info("MySql database '" + Constants.mysqlDb + "' is active");
		} catch (Exception e) {
			Utility.severe(e.getMessage());
			Utility.severe("MySql database '" + Constants.mysqlDb + "' is not active");
		}
		
		Utility.info("\"" + Constants.appName + "\" web application is ready");
	}

	@Override
	public void contextDestroyed(javax.servlet.ServletContextEvent sce) {
		Utility.info("Shutdown " + Constants.appName + " web application");
	}
}
