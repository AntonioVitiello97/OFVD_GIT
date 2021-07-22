package it.unisa.ofvd.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.model.dao.AccountsDao;
import it.unisa.ofvd.utils.Utility;

@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		{
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String newPassword = request.getParameter("newPassword");
			String redirectedPage = "/login.jsp";

			try {
				AccountsDao accountDao = new AccountsDao();

				AccountsModel account = accountDao.login(email, password);

				if (account != null) {
					accountDao.changeDefaultPassword(account, newPassword);

					request.getSession().setAttribute("account", account);

					if (account.isAdministrator()) {
						redirectedPage = "/administrator/home.jsp";
					} else {
						if (account.isHospitalUser())
							redirectedPage = "/hospital/home.jsp";
						else if (account.isCavUser())
							redirectedPage = "/cav/home.jsp";
					}

					response.sendRedirect(request.getContextPath() + redirectedPage);
					return;
				}

			} catch (Exception e) {
				Utility.severe(e.getMessage());
				redirectedPage = "/changePassword.jsp";
				request.setAttribute("error", e.getMessage());
			}

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectedPage);
			dispatcher.forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
