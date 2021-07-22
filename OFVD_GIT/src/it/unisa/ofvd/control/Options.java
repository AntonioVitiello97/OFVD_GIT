package it.unisa.ofvd.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.model.OptionModel;
import it.unisa.ofvd.model.dao.OptionsDao;

@WebServlet("/Options")
public class Options extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

		AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
		if (account == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		String forwardedPage = "/administrator/opzioni.jsp";

		OptionsDao options = new OptionsDao();

		String action = request.getParameter("options");

		try {
			if (action != null) {
				if (action.equals("save")) {
					Collection<OptionModel> optionList = options.load();
					Iterator<OptionModel> it = optionList.iterator();
					while (it.hasNext()) {
						OptionModel opt = it.next();
						opt.setValue(request.getParameter(opt.getKey()));
						options.set(opt);
					}

					options.closure();
				} else if (action.equals("update")) {
					options.update();

				} else if (action.equals("restore")) {
					options.restore();
				}
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
		}

		try {
			request.setAttribute("options", options.load());
		} catch (SQLException e) {
			request.setAttribute("error", e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(forwardedPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
