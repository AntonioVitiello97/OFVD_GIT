package it.unisa.ofvd.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.model.dao.AccountsDao;
import it.unisa.ofvd.utils.Utility;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

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

				String type = (String) obj.get("type");

				if (type.equals("cav")) {
					account.setTelefono((String) obj.get("telefono"));
					account.setEmail((String) obj.get("email"));
					account.setMatricola((String) obj.get("matricola"));
					account.setCav((String) obj.get("codeCav"));
					account.setPassword((String) obj.get("password"));

				} else if (type.equals("hospital")) {
					account.setTelefono((String) obj.get("telefono"));
					account.setEmail((String) obj.get("email"));
					account.setMatricola((String) obj.get("matricola"));
					account.setHospital((String) obj.get("codeHospital"));
					account.setPassword((String) obj.get("password"));

				} else if (type.equals("admin")) {
					account.setTelefono((String) obj.get("telefono"));
					account.setEmail((String) obj.get("email"));
					account.setPassword((String) obj.get("password"));
				}

				AccountsDao accountDao = new AccountsDao();
				accountDao.updateProfile(account);

			} catch (JSONException | SQLException e) {
				Utility.exception(e);
			}
		}

		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
}
