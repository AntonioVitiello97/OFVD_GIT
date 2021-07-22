package it.unisa.ofvd.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.model.CavsModel;
import it.unisa.ofvd.model.HospitalsModel;
import it.unisa.ofvd.model.dao.CavsDao;
import it.unisa.ofvd.model.dao.HospitalsDao;
import it.unisa.ofvd.utils.Utility;

/**
 * Servlet implementation class Struct
 */
@WebServlet("/Struct")
public class Struct extends HttpServlet {
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
				
				String action = (String) obj.get("action");
				String tipo = (String) obj.get("type");


				HospitalsDao hospitalDao = new HospitalsDao();
				CavsDao cavDao = new CavsDao();

				if (action.equals("removeStructure")) {
					String email = (String) obj.get("email");
					if (tipo.equals("cav")) {
						cavDao.delete(email);
					} else {
						hospitalDao.delete(email);
					}
					return;
				} else if (action.equals("updateStructure")) {

					if (tipo.equals("cav")) {
						CavsModel cavModel = new CavsModel();
						cavModel.setNome((String) obj.get("nome"));
						cavModel.setId((String) obj.get("id"));
						cavModel.setIndirizzo((String) obj.get("indirizzo"));

						cavModel.setTelefono((String) obj.get("telefono"));
						cavModel.setTelefono1((String) obj.get("telefono1"));
						cavModel.setEmail((String) obj.get("email"));
						cavDao.update(cavModel);

					} else {
						HospitalsModel hospitalModel = new HospitalsModel();
						hospitalModel.setNome((String) obj.get("nome"));
						hospitalModel.setId((String) obj.get("id"));
						hospitalModel.setIndirizzo((String) obj.get("indirizzo"));

						hospitalModel.setTelefono((String) obj.get("telefono"));
						hospitalModel.setTelefono1((String) obj.get("telefono1"));
						hospitalModel.setEmail((String) obj.get("email"));
						hospitalDao.update(hospitalModel);
					}
					return;

				} else if (action.equals("createStructure")) {
					if (tipo.equalsIgnoreCase("cav")) {
						CavsModel cav = new CavsModel();
						cav.setNome((String) obj.get("nome"));
						cav.setIndirizzo((String) obj.get("indirizzo"));
						cav.setTelefono((String) obj.get("telefono"));
						cav.setTelefono1((String) obj.get("telefono1"));
						cav.setEmail((String) obj.get("email"));
						cavDao.create(cav);
					} else {
						HospitalsModel hospital = new HospitalsModel();
						hospital.setNome((String) obj.get("nome"));
						hospital.setIndirizzo((String) obj.get("indirizzo"));
						hospital.setTelefono((String) obj.get("telefono"));
						hospital.setTelefono1((String) obj.get("telefono1"));
						hospital.setEmail((String) obj.get("email"));
						hospitalDao.create(hospital);
					}
					return;

				} else if (action.equals("selectStructure")) {
					String email = (String) obj.get("email");
					String structJsonString = "";
					if (tipo.equals("cav")) {
						CavsModel cavModel = cavDao.retrieve(email);
						structJsonString = new Gson().toJson(cavModel);
					} else {
						HospitalsModel hospitalModel = hospitalDao.retrieve(email);
						structJsonString = new Gson().toJson(hospitalModel);
					}
					PrintWriter out = null;
					try {
						out = response.getWriter();
					} catch (IOException e) {
						Utility.exception(e);
					}
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					out.print(structJsonString);
					out.flush();
					return;
				}

			} catch (JSONException | SQLException e) {
				Utility.exception(e);
			}
		}

		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
}
