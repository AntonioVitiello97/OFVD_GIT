package it.unisa.ofvd.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.model.QuestionsModel;
import it.unisa.ofvd.model.dao.QuestionsDao;
import it.unisa.ofvd.utils.Utility;

@WebServlet("/QuestionTrace")
public class QuestionTrace extends HttpServlet {
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

			String id = request.getParameter("id");
			if(id == null) {
				id = "";
			}
			try {
				JSONObject obj = new JSONObject(json);

				String nome = obj.getString("nome");
				String cognome = obj.getString("cognome");
				String nascita = obj.getString("nascita");
				String luogo = obj.getString("luogo");

				if (nome != null && nome != "" && cognome != null && cognome != "" && nascita != null && nascita != ""
						&& luogo != null && luogo != "") {

					String trace = Utility.generateTrace(nome, cognome, luogo, nascita);

					QuestionsDao questionDao = new QuestionsDao();

					Collection<QuestionsModel> colls = questionDao.checkTrace(trace, id);

					String questionJsonString = new Gson().toJson(colls);
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
			} catch (JSONException e) {
				Utility.exception(e);
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
