package it.unisa.ofvd.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.ofvd.model.Info;
import it.unisa.ofvd.utils.Constants;
import it.unisa.ofvd.utils.Utility;

public class DBMySQLConnectionPool {

	private static boolean datasource = true;

	private static List<Connection> dm;

	private static DataSource ds;

	static {
		if (datasource) {
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context) initCtx.lookup("java:comp/env");

				ds = (DataSource) envCtx.lookup("jdbc/storage");

			} catch (NamingException e) {
				Utility.severe("Data Source error:" + e.getMessage());
			}
		} else {
			dm = new LinkedList<Connection>();
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				Utility.severe("DB driver not found:" + e.getMessage());
			}
		}
	}

	private static synchronized Connection createDBConnection() throws SQLException {
		Connection newConnection = null;

		newConnection = DriverManager.getConnection("jdbc:mysql://" + Constants.mysqlIp + ":" + Constants.mysqlPort
				+ "/" + Constants.mysqlDb
				+ "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true",
				Constants.mysqlLogin, Constants.mysqlPwd);

		newConnection.setAutoCommit(false);
		return newConnection;
	}

	public static synchronized void test() throws SQLException {
		Connection _connection = null;
		if (datasource) {
			try {
				_connection = DBMySQLConnectionPool.getConnection();

				Utility.info("MySQL Data Source database", "Ip: " + Constants.mysqlIp, "Port: " + Constants.mysqlPort,
						"Version: " + _connection.getMetaData().getDatabaseProductVersion(),
						"Product: " + _connection.getMetaData().getDatabaseProductName(),
						"Database: " + Constants.mysqlDb);
				
				Info.setMysqlVersion("MySQL database Ip: " + Constants.mysqlIp + " Port: " + Constants.mysqlPort
						+ " Version: " + _connection.getMetaData().getDatabaseProductVersion());

			} finally {
				if (_connection != null)
					DBMySQLConnectionPool.releaseConnection(_connection);
			}
		} else {

			try {
				_connection = DBMySQLConnectionPool.getConnection();

				Utility.info("MySQL Drive Manager database", "Ip: " + Constants.mysqlIp, "Port: " + Constants.mysqlPort,
						"Version: " + _connection.getMetaData().getDatabaseProductVersion(),
						"Product: " + _connection.getMetaData().getDatabaseProductName(),
						"Database: " + Constants.mysqlDb);

				Info.setMysqlVersion("MySQL database Ip: " + Constants.mysqlIp + " Port: " + Constants.mysqlPort
						+ " Version: " + _connection.getMetaData().getDatabaseProductVersion());

			} finally {
				if (_connection != null)
					DBMySQLConnectionPool.releaseConnection(_connection);
			}
		}

	}

	private static synchronized Connection checkConnection() throws SQLException {
		Connection connection;

		if (!dm.isEmpty()) {
			connection = (Connection) dm.get(0);
			dm.remove(0);

			try {
				if (connection.isClosed())
					connection = checkConnection();
			} catch (SQLException e) {
				connection.close();
				connection = checkConnection();
			}
		} else {
			connection = createDBConnection();
		}

		return connection;
	}

	public static synchronized Connection getConnection() throws SQLException {
		Connection connection;

		if (datasource) {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
		} else {
			connection = checkConnection();
		}

		return connection;
	}

	public static synchronized void releaseConnection(Connection connection) throws SQLException {
		if (connection != null) {
			if (datasource) {
				connection.close();
			} else {
				dm.add(connection);
			}
		}
	}

}
