/**
 * Author: Antonio De Piano
 * Web site: http://www.depiano.it
 * email: depianoantonio@gmail.com
 */

package it.unisa.ofvd.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.utils.Utility;

@WebServlet("/Logout")
public class Logout extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		{
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

			AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
			if (account != null) {
				Utility.info("Logout: " + account.getNome() + " " + account.getCognome());

				request.getSession().removeAttribute("account");
				request.getSession().invalidate();
			}

			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
