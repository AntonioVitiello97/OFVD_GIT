<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.model.dao.CavsDao"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.utils.Utility"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.model.QuestionsModel"%>
<%@page import="it.unisa.ofvd.model.dao.QuestionsDao"%>
<%@page import="it.unisa.ofvd.model.dao.HospitalsDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.*"%>
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
uri = uri + "/cav/";
AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");

if (account == null || (!account.isCavUser())) {
	String redirectedPage = "/login.jsp";
	response.sendRedirect(request.getContextPath() + redirectedPage);
	return;
}

QuestionsDao question = new QuestionsDao();
Collection<QuestionsModel> questions = question.getInviate(account.getEmail());
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
<!-- calendar  -->
<script src="https://unpkg.com/gijgo@1.9.11/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.11/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<!-- end calendar -->
<!--  wizard library -->
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet" href="../assets/wizard_layout/fonts/material-design-iconic-font/css/material-design-iconic-font.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="../assets/wizard_layout/css/style.css">
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
                <li><span>Schede Inviate</span></li>
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
                <h4 class="header-title">Schede Inviate</h4>
                <div class="single-table">
                  <div class="table-responsive">
                    <%
                    	Iterator<QuestionsModel> itr = questions.iterator();
                    if (itr.hasNext()) {
                    %>
                    <table class="table table-hover progress-table text-center sortable">
                      <thead class="text-uppercase">
                        <tr>
                          <th scope="col">ID</th>
                          <th scope="col">Compilata da</th>
                          <th scope="col">Presso</th>
                          <th data-dateformat="DD/MM/YYYY" scope="col">In data</th>
                          <th scope="col">Stato</th>
                          <th data-defaultsort='disabled' scope="col">Azioni</th>
                        </tr>
                      </thead>
                      <tbody>
                        <%
                        	CavsDao cav = new CavsDao();
                        while (itr.hasNext()) {
                        	QuestionsModel element = itr.next();
                        %>
                        <tr id="<%=element.getAnswer1()%>">
                          <td><b><%=element.getAnswer1()%></b></td>
                          <td><%=account.getNome() + " " + account.getCognome()%></td>
                          <td><%=cav.retrieve(element.getCav()).getNome()%></td>
                          <td><%=element.getAnswer2()%></td>
                          <td><span class='status-p bg-success'><%=element.getStatus()%></span></td>
                          <td><ul class='d-flex justify-content-center'>
                              <li class='mr-3'><a href='detailinviate.jsp?id_question=<%=element.getAnswer1()%>' class='text-secondary'> <i class='far fa-eye' title="Dettagli"></i></a></li>
                            </ul></td>
                        </tr>
                        <%
                        	}
                        %>
                      </tbody>
                    </table>
                    <%
                    	} else {
                    %>
                    <div style="text-align: center;">
                      <img src="../assets/images/media/loader.gif" width="60%" height="60%" />
                      <p>
                        <span style="color: orange;"><b>Attenzione.</b> Nessuna scheda inviata all'osservatorio</span>
                      </p>
                    </div>
                    <%
                    	}
                    %>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
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
