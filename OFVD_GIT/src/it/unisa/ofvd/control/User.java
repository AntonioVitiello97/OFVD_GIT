package it.unisa.ofvd.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import it.unisa.ofvd.exception.LocalException;
import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.model.dao.AccountsDao;
import it.unisa.ofvd.utils.Constants;
import it.unisa.ofvd.utils.SendMail;
import it.unisa.ofvd.utils.Utility;

@WebServlet("/User")
public class User extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

		AccountsModel accountS = (AccountsModel) request.getSession().getAttribute("account");
		if (accountS == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		String json = request.getParameter("elements");

		if (json != null) {
			JSONObject obj = new JSONObject(json);

			try {
				String action = (String) obj.get("action");

				AccountsDao accountDao = new AccountsDao();
				String email = (String) obj.get("email");

				if (action.equals("removeUser")) {
					accountDao.delete(email);
				} else if (action.equals("selectUser")) {

					AccountsModel accountModel = accountDao.retrieve(email);

					String questionJsonString = new Gson().toJson(accountModel);
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
				} else if (action.equals("updateUser")) {

					AccountsModel accountModel = accountDao.retrieve(email);

					accountModel.setNome((String) obj.get("nome"));
					accountModel.setCognome((String) obj.get("cognome"));
					accountModel.setMatricola((String) obj.get("matricola"));
					accountModel.setTelefono((String) obj.get("telefono"));
					accountModel.setEmail((String) obj.get("email"));

					Random rand = new Random();
					// Generate random integers in range 0 to 999
					String pass = (String) obj.get("password") + rand.nextInt(99);

					Utility.info("La password per l'account modificato è [" + pass + "]");

					accountModel.setPassword(pass);
					accountModel.setCav((String) obj.get("codeCav"));
					accountModel.setHospital((String) obj.get("codeOspedale"));
					accountModel.setAdmin((String) obj.get("codeAdmin"));
					accountModel.setDefaultPassword(true);

					accountDao.update(accountModel);

					// Invio email per la modifica fatta e le nuove credenziali
					String to = accountModel.getEmail();
					String subject = "OFVD - Attivazione Account Utente";

					String message = createMessage(accountModel, true);
					
					SendMail.send(to, subject, message, Constants.EMAIL_ADDRESS, Constants.EMAIL_PWD);

				} else if (action.equals("createUser")) {
					AccountsModel accountModel = new AccountsModel();

					accountModel.setNome((String) obj.get("nome"));
					accountModel.setCognome((String) obj.get("cognome"));
					accountModel.setMatricola((String) obj.get("matricola"));
					accountModel.setTelefono((String) obj.get("telefono"));
					accountModel.setEmail((String) obj.get("email"));

					Random rand = new Random();
					// Generate random integers in range 0 to 999
					String pass = (String) obj.get("password") + rand.nextInt(99);

					Utility.info("La password per l'account creato è [" + pass + "]");

					accountModel.setPassword(pass);
					accountModel.setCav((String) obj.get("codeCav"));
					accountModel.setHospital((String) obj.get("codeOspedale"));
					accountModel.setAdmin((String) obj.get("codeAdmin"));
					accountModel.setDefaultPassword((Boolean) obj.get("defaultPassword"));

					if (accountModel.getHospital() == "")
						accountModel.setHospital(null);
					if (accountModel.getCav() == "")
						accountModel.setCav(null);
					if (accountModel.getAdmin() == "")
						accountModel.setAdmin(null);

					if (accountModel.getHospital() != null && accountModel.getCav() == null)
						accountModel.setHospitalUser();
					else if (accountModel.getHospital() == null && accountModel.getCav() != null)
						accountModel.setCavUser();

					accountDao.create(accountModel);

					// Invio email testato e funzionante
					String to = accountModel.getEmail();
					String subject = "OFVD - Attivazione Account Utente";

					String message = createMessage(accountModel, false);
					
					SendMail.send(to, subject, message, Constants.EMAIL_ADDRESS, Constants.EMAIL_PWD);

				}
			} catch (JSONException | SQLException | LocalException e) {
				Utility.exception(e);
			}

			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}
	}
	
	private String createMessage(AccountsModel acc, boolean activation) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Gentile utente,\n\n");
		
		if(activation) {
			buffer.append("lo staff di OFVD le comunica l'attivazione dell'account.\n\n"
					+ "Di seguito le credenziali d'accesso:\n\n"); 
		} else {
			buffer.append("l'account OFVD è stato modificato come richiesto.\n\n"
				+ "Di seguito le nuove credenziali d'accesso:\n\n");
		}
		
		buffer.append("Host: " + Constants.appHost + "\n"
				+ "Email: " + acc.getEmail() + "\n" 
				+ "Password: " + acc.getPassword()
				+ "\n\n\n" + Constants.PRIVACY + "\n\n" 
				+ "Distinti Saluti\n");	
		
		return buffer.toString();
	}
	
}
