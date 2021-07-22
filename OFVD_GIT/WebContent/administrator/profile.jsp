<%@page import="it.unisa.ofvd.model.CavsModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
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

	var user = new Object();
	user.type = "admin";

	function load_data() {
		user.nome = $('#nomeUserHospital').val();
		user.cognome = $('#cognomeUserHospital').val();
		user.telefono = $('#telefonoUserHospital').val();
		user.email = $('#emailUserHospital').val();
		user.password = $('#passwordUserHospital').val();
		user.newpassword = $('#newPasswordUserHospital').val();

	}

	function nascondiAlert() {
		document.getElementById('alertModifica').setAttribute('hidden', 'true');
		document.getElementById('alertDelete').setAttribute('hidden', 'true');

	}

	function confermaAlertPassword() {
		var pass = document.getElementById('passwordUserHospital').value;
		var newPass = document.getElementById('newPasswordUserHospital').value;
		var tel = document.getElementById('telefonoUserHospital').value;

		if (tel == "") {
			document.getElementById('alertDelete').removeAttribute('hidden');
			document.getElementById('mex').innerHTML = "Inserire il numero di telefono";
			window.scrollTo(0, 0);

		} else if (tel.length < 9 || tel.length > 10) {

			document.getElementById('alertDelete').removeAttribute('hidden');
			document.getElementById('mex').innerHTML = "Inserisci un numero di telefono valido di 9 o 10 cifre";
			window.scrollTo(0, 0);
		} else if ((pass != "" && newPass != "")
				|| (pass != "" && newPass == "")
				|| (pass == "" && newPass != "")) {
			if (pass != newPass) {
				document.getElementById('alertDelete')
						.removeAttribute('hidden');
				window.scrollTo(0, 0);
				document.getElementById('mex').innerHTML = "Le password sono diverse";
			} else {
				document.getElementById('alertModifica').removeAttribute(
						'hidden');
				window.scrollTo(0, 0);
			}

		} else {

			document.getElementById('alertModifica').removeAttribute('hidden');
			window.scrollTo(0, 0);
		}
	}

	function clean() {

		document.getElementById('passwordUserHospital').value = "";
		document.getElementById('newPasswordUserHospital').value = "";
	}

	function save() {

		load_data();
		$.ajax({
			url : "../UpdateProfile",
			type : 'GET',
			data : {
				elements : JSON.stringify(user)
			},
			dataType : "JSON",
			contentType : 'application/json',
			mimeType : 'application/json',

			success : function(jsonStr) {
			}
		});
		clean();
		document.getElementById('alertModifica').setAttribute('hidden', 'true');

		var url = "home.jsp";
		$(location).attr('href', url);
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
                <li><span>Profilo Utente</span></li>
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
        <div class="row" id="question5">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <form action="">
                  <div style="text-align: center;">
                    <img src="../assets/images/author/avatar.png" style="width: 15%">
                  </div>
                  <div id="alertModifica" class="alert alert-primary" role="alert" hidden="true">
                    <h4 align="center" class="alert-heading">Attenzione</h4>
                    <p>Sei sicuro di voler modificare il profilo?</p>
                    <hr>
                    <div align="center">
                      <input class="btn btn-rounded btn-primary mb-3" type="button" value="Conferma" onclick="save()"> <input class="btn btn-rounded btn-primary mb-3" type="button" value="Annulla" onclick="nascondiAlert()">
                    </div>
                  </div>
                  <div id="alertDelete" hidden=true; class="alert alert-danger" role="alert">
                    <h4 align="center" class="alert-heading">Attenzione</h4>
                    <p>
                      <label id="mex"></label>
                    </p>
                    <hr>
                    <div align="center">
                      <button id="confermaDelete" class="btn btn-rounded btn-danger mb-3" type="button" value="Conferma" onclick="nascondiAlert()">Conferma</button>
                    </div>
                  </div>
                  <div id="alertDelete" hidden=true; class="alert alert-danger" role="alert">
                    <h4 align="center" class="alert-heading">Attenzione</h4>
                    <p>Le passwords sono diverse!</p>
                    <hr>
                    <div align="center">
                      <button id="confermaDelete" class="btn btn-rounded btn-danger mb-3" type="button" value="Conferma" onclick="nascondiAlert()">Conferma</button>
                    </div>
                  </div>
                  <div class="form-group">
                    <label>Nome</label> <input class="form-control" placeholder="<%=account.getNome()%>" readonly id="nomeUserHospital" value="<%=account.getNome()%>"> 
                    <label>Cognome</label> <input class="form-control" placeholder="<%=account.getCognome()%>" readonly id="cognomeUserHospital" value="<%=account.getCognome()%>"> 
                    <label>Telefono</label> <input class="form-control" placeholder="<%=account.getTelefono()%>" id="telefonoUserHospital" value="<%=account.getTelefono()%>"> 
                    <label>Email</label> <input class="form-control" placeholder="<%=account.getEmail()%>" readonly id="emailUserHospital" value="<%=account.getEmail()%>"> 
                    <label>Password</label> <input type="password" class="form-control" placeholder="Inserisci una nuova Password" id="passwordUserHospital" value=""> 
                    <label>Ripeti Password</label> <input type="password" class="form-control" placeholder="Ripeti la nuova Password" id="newPasswordUserHospital" value="">
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <div class="row" id="button_invia_indietro">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <form action="">
                  <div class="form-group">
                    <button type="button" onclick="confermaAlertPassword()" class="btn btn-success btn-lg btn-block">Modifica</button>
                    <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="window.location.href='./home.jsp'">Annulla</button>
                  </div>
                </form>
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
