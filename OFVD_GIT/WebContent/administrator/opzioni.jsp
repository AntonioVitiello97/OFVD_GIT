<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.unisa.ofvd.model.dao.AccountsDao"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.*"%>
<%
	response.setHeader("Cache-Control", "no-cache");

//Forces caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control", "no-store");

//Directs caches not to store the page under any circumstance
response.setDateHeader("Expires", 0);

//Causes the proxy cache to see the page as "stale"
response.setHeader("Pragma", "no-cache");
//HTTP 1.0 backward enter code here

String error = (String) request.getAttribute("error");
String uri = request.getContextPath();
uri = uri + "/administrator/";
AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
if (account == null || (!account.isAdministrator())) {
	String redirectedPage = "/login.jsp";
	response.sendRedirect(request.getContextPath() + redirectedPage);
	return;
}

Collection<?> options = (Collection<?>) request.getAttribute("options");

if (options == null) {
	String redirectedPage = "/login.jsp";
	response.sendRedirect(request.getContextPath() + redirectedPage);
	return;
}
%>
<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title><%=Constants.title%></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<base href="<%=uri%>">
<link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../assets/css/fontawesome.min.css">
<link rel="stylesheet" href="../assets/css/themify-icons.css">
<link rel="stylesheet" href="../assets/css/metisMenu.css">
<link rel="stylesheet" href="../assets/css/owl.carousel.min.css">
<link rel="stylesheet" href="../assets/css/slicknav.min.css">
<!-- amchart css -->
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<!-- others css -->
<link rel="stylesheet" href="../assets/css/typography.css">
<link rel="stylesheet" href="../assets/css/default-css.css">
<link rel="stylesheet" href="../assets/css/styles.css">
<link rel="stylesheet" href="../assets/css/responsive.css">
<!-- modernizr css -->
<script src="../assets/js/modernizr.min.js"></script>
<script src="../assets/jquery/jquery.min.js"></script>
<link rel="stylesheet" href="../assets/css/bootstrap-sortable.css">
<script src="../assets/js/moment.min.js"></script>
<script src="../assets/js/bootstrap-sortable.js"></script>
<!-- 
		calendar 
		 -->
<script src="https://unpkg.com/gijgo@1.9.11/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.11/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<!-- end calendar -->
<!--  wizard library -->
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet" href="../assets/wizard_layout/fonts/material-design-iconic-font/css/material-design-iconic-font.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="../assets/wizard_layout/css/style.css">
<!-- 
		confirm  -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<!-- 
end confirm -->
<script type="text/javascript">
	function noBack() {
		window.history.forward()
	}
	noBack();
	window.onload = noBack;
	window.onpageshow = function(evt) {
		if (evt.persisted)
			noBack()
	}
	window.onunload = function() {
		void (0)
	}

	$(document).ready(
			function() {
				(function() {
					'use strict';

					window.addEventListener('load', function() {
						var forms = document
								.getElementsByClassName('needs-validation');
						var validation = Array.prototype.filter.call(forms,
								function(form) {
									form.addEventListener('submit', function(
											event) {
										if (form.checkValidity() === false) {
											event.preventDefault();
											event.stopPropagation();
										}
										form.classList.add('was-validated');
									}, false);
								});
					}, false);
				})();
			});
</script>
</head>
<body>
  <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
  <!-- preloader area start -->
  <div id="preloader">
    <div class="loader"></div>
  </div>
  <!-- preloader area end -->
  <!-- page container area start -->
  <div class="page-container">
    <!-- sidebar menu area start -->
    <%@include file="common/sidebar.jsp"%>
    <!-- sidebar menu area end -->
    <!-- main content area start -->
    <div class="main-content">
      <!-- header area start -->
      <div class="header-area">
        <div class="row align-items-center">
          <!-- nav and search button -->
          <div class="col-md-6 col-sm-8 clearfix">
            <div class="nav-btn pull-left">
              <span></span> <span></span> <span></span>
            </div>
          </div>
          <!-- profile info & task notification -->
        </div>
      </div>
      <!-- header area end -->
      <!-- page title area start -->
      <div class="page-title-area">
        <div class="row align-items-center">
          <div class="col-sm-8">
            <div class="breadcrumbs-area clearfix">
              <h4 class="page-title pull-left">Dashboard</h4>
              <ul class="breadcrumbs pull-left">
                <li><a href="home.jsp">Home</a></li>
                <li><span>Opzioni</span></li>
              </ul>
            </div>
          </div>
          <div class="col-sm-4 clearfix">
          <%@include file="common/user.jsp"%>
          </div>
        </div>
      </div>
      <!-- page title area end -->
      <div class="main-content-inner">
        <!-- Prima parte -->
        <div class="row">
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <h4 class="header-title">Opzioni</h4>
                <div class="single-table">
                  <form action="../Options" method="post" class="needs-validation" novalidate>
                    <%
                    	Iterator<?> it = options.iterator();
                    String pModule = "";

                    while (it.hasNext()) {
                    	OptionModel option = (OptionModel) it.next();

                    	if (!pModule.equals(option.getModule())) {
                    		pModule = option.getModule();
                    %>
                    <h5><%=option.getModule()%></h5>
                    <br>
                    <%
                    	}

                    switch (option.getType()) {
                    case 0:
                    boolean modifiable = option.isModifiable();  
                    if (option.getValue().length() < 100) {
                    %>
                    <div class="form-group row">
                      <label for="<%=option.getKey()%>" class="col-sm-3 col-form-label"><%=option.getLabel()%></label>
                      <div class="col-sm-9 input-group">
                        <span class="input-group-text"><i class="fas fa-font"></i></span> 
                    <% 
                    if(modifiable) {
                    %>	
                        <input class="form-control" type="text" id="<%=option.getKey()%>" name="<%=option.getKey()%>" maxlength="5000" placeholder="inerisci <%=option.getLabel().toLowerCase()%>" value="<%=option.getValue()%>" required>
                    <% } else { %>
                        <input readonly class="form-control" type="text" id="<%=option.getKey()%>" name="<%=option.getKey()%>" maxlength="5000" placeholder="inerisci <%=option.getLabel().toLowerCase()%>" value="<%=option.getValue()%>" required>
                    <% } %>
                        <div class="invalid-feedback">
                          Please insert
                          <%=option.getLabel().toLowerCase()%></div>
                      </div>
                    </div>
                    <%
                    	} else {
                    %>
                    <div class="form-group row">
                      <label for="<%=option.getKey()%>" class="col-sm-3 col-form-label"><%=option.getLabel()%></label>
                      <div class="col-sm-9 input-group">
                        <textarea class="form-control" spellcheck="true" id="<%=option.getKey()%>" name="<%=option.getKey()%>" rows="3" required><%=option.getValue()%></textarea>
                      </div>
                    </div>
                    <%
                    	}
                    break;
                    case 1:
                    %>
                    <div class="form-group row">
                      <label for="<%=option.getKey()%>" class="col-sm-3 col-form-label"><%=option.getLabel()%></label>
                      <div class="col-sm-9 input-group">
                        <span class="input-group-text"><i class="fas fa-italic"></i></span> <input class="form-control" type="number" id="<%=option.getKey()%>" name="<%=option.getKey()%>" placeholder="inserisci <%=option.getLabel().toLowerCase()%>" value="<%=option.getValue()%>" required>
                        <div class="invalid-feedback">
                          Please insert
                          <%=option.getLabel().toLowerCase()%></div>
                      </div>
                    </div>
                    <%
                    	break;
                    case 4:
                    %>
                    <div class="form-group row text-left">
                      <label for="<%=option.getKey()%>" class="col-sm-3 col-form-label"><%=option.getLabel()%></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <div class="form-check form-check-inline">
                        <input class="form-check-input" id="T<%=option.getKey()%>" type="radio" name="<%=option.getKey()%>" value="true" <%=(option.getValue().equals("true") ? "checked" : "")%>> <label class="form-check-label" for="T<%=option.getKey()%>">True</label>
                      </div>
                      <div class="form-check form-check-inline">
                        <input class="form-check-input" id="F<%=option.getKey()%>" type="radio" name="<%=option.getKey()%>" value="false" <%=(option.getValue().equals("false") ? "checked" : "")%>> <label class="form-check-label" for="F<%=option.getKey()%>">False</label>
                      </div>
                    </div>
                    <%
                    	break;
                    case 5:
                    %>
                    <div class="form-group row">
                      <label for="<%=option.getKey()%>" class="col-sm-3 col-form-label"><%=option.getLabel()%></label>
                      <div class="col-sm-9 input-group">
                        <div id="cp2" class="input-group">
                          <input type="color" id="<%=option.getKey()%>" name="<%=option.getKey()%>" value="<%=option.getValue()%>" required>
                          <div class="invalid-feedback">
                            Please insert
                            <%=option.getLabel().toLowerCase()%></div>
                        </div>
                      </div>
                    </div>
                    <%
                    	break;
                    default:
                    %>
                    <%
                    	}
                    %>
                    <%
                    	}
                    %>
                    <%
                    	if (error != null) {
                    %>
                    <div class="form-group" style="text-align: center;">
                      <span id="error_msg_footer" style="color: red;"><%=error%></span>
                    </div>
                    <%
                    	}
                    %>
                    <div class="btn-group btn-lg btn-block" role="group">
                      <%
                      	if (options.size() != 0) {
                      %>
                      <button type="submit" class="btn btn-success" value="save" name="options">Salva</button>
                      <button type="reset" class="btn btn-secondary" value="reset" name="options">Ripristina</button>
                      <%
                      	}
                      %>
                      <button type="submit" class="btn btn-warning" value="update" name="options">Aggiorna opzioni</button>
                      <button type="submit" class="btn btn-danger" value="restore" name="options">Inizializza opzioni</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="form-group">
        <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="window.location.href='./home.jsp'">Indietro</button>
      </div>
    </div>
    <%@include file="../common/footer.jsp"%>
  </div>
  <!-- bootstrap 4 js -->
  <script src="../assets/js/popper.min.js"></script>
  <script src="../assets/bootstrap/js/bootstrap.min.js"></script>
  <script src="../assets/js/owl.carousel.min.js"></script>
  <script src="../assets/js/metisMenu.min.js"></script>
  <script src="../assets/js/jquery.slimscroll.min.js"></script>
  <script src="../assets/js/jquery.slicknav.min.js"></script>
  <!-- others plugins -->
  <script src="../assets/js/plugins.js"></script>
  <script src="../assets/js/scripts.js"></script>
</body>
</html>
