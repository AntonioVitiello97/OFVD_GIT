/*
package it.unisa.ofvd.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.ofvd.model.AccountsModel;
import it.unisa.ofvd.utils.Utility;


@WebFilter(urlPatterns = { "/hospital/*", "/cav/*", "/administrator/*", "/*" })
public class AuthFilter implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;

		String uri = hrequest.getRequestURI();
		
		Utility.info("URI: "+uri);

		if (uri.contains("/hospital/")) {
			HttpSession session = hrequest.getSession(false);

			if (session != null)
			{
				AccountsModel account = (AccountsModel) session.getAttribute("account");

				if (account != null && account.isHospitalUser())
				{
					chain.doFilter(request, response);
				} 
				else 
					hresponse.sendRedirect(hrequest.getContextPath() + "/login.jsp");
			} 
			else
				hresponse.sendRedirect(hrequest.getContextPath() + "/login.jsp");
		}
		else if (uri.contains("/cav/")) {
			HttpSession session = hrequest.getSession(false);

			if (session != null)
			{
				AccountsModel account = (AccountsModel) session.getAttribute("account");

				if (account != null && account.isCavUser())
				{
					chain.doFilter(request, response);
				}
				else 
					hresponse.sendRedirect(hrequest.getContextPath() + "/login.jsp");
			}
			else
				hresponse.sendRedirect(hrequest.getContextPath() + "/login.jsp");
		}
		else if (uri.contains("/administrator/")) {
			HttpSession session = hrequest.getSession(false);

			if (session != null)
			{
				AccountsModel account = (AccountsModel) session.getAttribute("account");

				if (account != null && account.isAdministrator())
				{
					chain.doFilter(request, response);
				}
				else 
					hresponse.sendRedirect(hrequest.getContextPath() + "/login.jsp");
			}
			else
				hresponse.sendRedirect(hrequest.getContextPath() + "/login.jsp");
		}
		else chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		Utility.info("Initialize the authorization filters");
	}

}
*/
