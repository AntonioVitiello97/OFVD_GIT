package it.unisa.ofvd.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import it.unisa.ofvd.connection.DBMySQLConnectionPool;
import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.utils.Utility;

@WebServlet("/Support")
public class Support extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

		AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
		if (account == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		String json = request.getParameter("elements");
		if (json != null) {

			try {
				JSONObject obj = new JSONObject(json);

				String type = (String) obj.get("action");

				try {
					if (type.equals("viewComuni")) {
						Collection<String> elementList = comuni((String) obj.get("provincia"));

						String questionJsonString = new Gson().toJson(elementList);
						PrintWriter out = null;
						try {
							out = response.getWriter();
						} catch (IOException e) {
							Utility.exception(e);
						}
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print(questionJsonString);
						out.flush();
						return;
					} else if (type.equals("viewProvince")) {
						Collection<String> elementList = province();

						String questionJsonString = new Gson().toJson(elementList);
						PrintWriter out = null;
						try {
							out = response.getWriter();
						} catch (IOException e) {
							Utility.exception(e);
						}
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print(questionJsonString);
						out.flush();
						return;
					}

				} catch (SQLException e) {
					Utility.exception(e);
				}
			} catch (JSONException e) {
				Utility.exception(e);
			}
		}

		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	private List<String> comuni(String retc) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<String> list = new LinkedList<String>();

		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("SELECT Comune FROM comuni where Provincia=? ORDER BY Comune ASC");

			stmt.setString(1, retc.replace("'", "’"));

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				String ret = rs.getString("Comune");
				list.add(ret.replace("’", "'"));
			}
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}

		return list;
	}

	private List<String> province() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<String> list = new LinkedList<String>();

		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("SELECT DISTINCT Provincia FROM comuni ORDER BY Provincia ASC");

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				String ret = rs.getString("Provincia");
				list.add(ret.replace("’", "'"));

			}
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}

		return list;
	}

}
