package it.unisa.ofvd.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

import it.unisa.ofvd.connection.DBMongoConnectionPool;
import it.unisa.ofvd.connection.DBMySQLConnectionPool;
import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.utils.Utility;

@WebServlet("/Query")
public class Query extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

		AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
		if (account == null || !account.isAdministrator()) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		String dbParam = request.getParameter("db");

		String jsonParam = request.getParameter("elements");
		if (jsonParam != null && dbParam != null && (dbParam.equals("mysql") || dbParam.equals("mongo"))) {

			JSONObject obj = new JSONObject(jsonParam);
			if (obj != null) {
				String query = obj.getString("query");

				if (query != null) {
					query = query.trim();
					if (!query.equals("")) {

						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");

						PrintWriter out = response.getWriter();

						if (dbParam.equals("mysql")) {
							try {
								con = DBMySQLConnectionPool.getConnection();

								stmt = con.createStatement();
								boolean valid = stmt.execute(query);

								if (valid) {
									rs = stmt.getResultSet();
									out.print(convert(rs).toString());
								}

							} catch (JSONException | SQLException exception) {
								Utility.severe(exception.getMessage());
								out.print(convertException(exception));
							} finally {
								try {
									if (rs != null)
										rs.close();
									if (stmt != null)
										stmt.close();
								} catch (SQLException sqlException) {
									Utility.severe(sqlException.getMessage());
								} finally {
									if (con != null) {
										try {
											DBMySQLConnectionPool.releaseConnection(con);
										} catch (SQLException sqlException) {
											Utility.severe(sqlException.getMessage());
										}
									}
								}
							}
						} else if (dbParam.equals("mongo")) {
							try {
								MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
								MongoDatabase db = client.getDatabase("ofvd");
							
								Document result = db.runCommand(Document.parse(query));
								out.print(result.toJson());

								DBMongoConnectionPool.close(client);
							} catch (Exception e) {
								Utility.exception(e);
								out.print(convertException(e));
							}
						}

						out.flush();
						return;
					}
				}
			}
		}

		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}

	private JSONArray convertException(Exception e) throws JSONException {
		JSONArray json = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("error", e.getMessage());

		json.put(obj);
		return json;
	}
		
	private JSONArray convert(ResultSet rs) throws SQLException, JSONException {
		JSONArray json = new JSONArray();
		ResultSetMetaData rsmd = rs.getMetaData();

		while (rs.next()) {
			int numColumns = rsmd.getColumnCount();
			JSONObject obj = new JSONObject();

			for (int i = 1; i < numColumns + 1; i++) {
				String column_name = rsmd.getColumnName(i);

				if (rsmd.getColumnType(i) == java.sql.Types.ARRAY) {
					obj.put(column_name, rs.getArray(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.BIGINT) {
					obj.put(column_name, rs.getInt(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.BOOLEAN) {
					obj.put(column_name, rs.getBoolean(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.BLOB) {
					obj.put(column_name, rs.getBlob(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.DOUBLE) {
					obj.put(column_name, rs.getDouble(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.FLOAT) {
					obj.put(column_name, rs.getFloat(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.INTEGER) {
					obj.put(column_name, rs.getInt(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.NVARCHAR) {
					obj.put(column_name, rs.getNString(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.VARCHAR) {
					obj.put(column_name, rs.getString(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.TINYINT) {
					obj.put(column_name, rs.getInt(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.SMALLINT) {
					obj.put(column_name, rs.getInt(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.DATE) {
					obj.put(column_name, rs.getDate(column_name));
				} else if (rsmd.getColumnType(i) == java.sql.Types.TIMESTAMP) {
					obj.put(column_name, rs.getTimestamp(column_name));
				} else {
					obj.put(column_name, rs.getObject(column_name));
				}
			}

			json.put(obj);
		}

		return json;
	}
}
