<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
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
if (error == null) {
	error = "&nbsp;";
}

AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
if (account == null || (account.isAdministrator())) {
	String redirectedPage = "/login.jsp";
	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectedPage);
	dispatcher.forward(request, response);
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
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/fontawesome.min.css">
<link rel="stylesheet" href="assets/css/themify-icons.css">
<link rel="stylesheet" href="assets/css/metisMenu.css">
<link rel="stylesheet" href="assets/css/owl.carousel.min.css">
<link rel="stylesheet" href="assets/css/slicknav.min.css">
<link rel="stylesheet" href="assets/css/typography.css">
<link rel="stylesheet" href="assets/css/default-css.css">
<link rel="stylesheet" href="assets/css/styles.css">
<link rel="stylesheet" href="assets/css/responsive.css">
<script src="assets/jquery/jquery.min.js"></script>
<script src="assets/js/modernizr.min.js"></script>
<script type="text/javascript">
	function noBack() {
		window.history.forward();
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

	function visiblePassword() {
		var x = document.getElementById("password");
		if (x.type === "password") {
			x.type = "text";
		} else {
			x.type = "password";
		}
		var x = document.getElementById("newPassword");
		if (x.type === "password") {
			x.type = "text";
		} else {
			x.type = "password";
		}

		var x = document.getElementById("repPassword");
		if (x.type === "password") {
			x.type = "text";
		} else {
			x.type = "password";
		}
	}

	function check() {
		if ($('#newPassword').val() == $('#password').val()) {
			$('#error').html(
					"La nuova Password deve essere differente dalla vecchia");
			$('#newPassword').css("border-color", "red");
			return false;
		}

		var regex = /^[a-zA-Z\d]{8,}$/;
		if (!regex.test($('#newPassword').val())) {
			$('#error').html(
					"La nuova Password deve contenere almeno 8 caratteri")
			$('#newPassword').css("border-color", "red");
			return false;
		}

		regex = /^(?=.*[A-Z])[a-zA-Z\d]{8,}$/;
		if (!regex.test($('#newPassword').val())) {
			$('#error')
					.html(
							"La nuova Password deve contenere almeno un carattere maiuscolo")
			$('#newPassword').css("border-color", "red");
			return false;
		}

		regex = /^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z\d]{8,}$/;
		if (!regex.test($('#newPassword').val())) {
			$('#error')
					.html(
							"La nuova Password deve contenere almeno un carattere minuscolo")
			$('#newPassword').css("border-color", "red");
			return false;
		}

		regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
		if (!regex.test($('#newPassword').val())) {
			$('#error').html(
					"La nuova Password deve contenere almeno un numero")
			$('#newPassword').css("border-color", "red");
			return false;
		}

		if ($('#newPassword').val() != $('#repPassword').val()) {
			$('#error').html("Le password sono diverse")
			$('#newPassword').css("border-color", "");
			$('#repPassword').css("border-color", "red");
			return false;
		}

		$('#newPassword').css("border-color", "");
		return true;
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
  <!-- login area start -->
  <div class="login-area login-s2">
    <div class="container">
      <div class="login-box ptb--10">
        <form action="ChangePassword" method="post" onSubmit="return check();">
          <div class="login-form-head">
            <h4>Modifica la Password di Default per proseguire</h4>
            <a href="/ofvd">
              <img src="./assets/images/logo/logo.png" class="rounded-circle" alt="OFVD" width="204" height="200">
            </a>
          </div>
          <div class="login-form-body">
            <div class="form-gp">
              <label for="exampleInputEmail1">Email</label> <input type="email" id="email" name="email" required> <i class="ti-email"></i>
            </div>
            <div class="form-gp">
              <label for="exampleInputPassword1">Vecchia Password</label> <input type="password" id="password" name="password" required> <i class="ti-lock"></i>
            </div>
            <div class="form-gp">
              <label for="exampleInputPassword1">Nuova Password</label> <input type="password" id="newPassword" name="newPassword" required> <i class="ti-lock"></i>
            </div>
            <div class="form-gp">
              <label for="exampleInputPassword1">Ripeti Nuova Password</label> <input type="password" id="repPassword" name="repPassword" required> <i class="ti-lock"></i>
            </div>
            <div class="row mb-4 rmber-area">
              <div class="col-6">
                <div class="custom-control custom-checkbox mr-sm-2">
                  <input type="checkbox" class="custom-control-input" id="customControlVisible" onclick="visiblePassword()"> <label class="custom-control-label" for="customControlVisible">Mostra Password</label>
                </div>
              </div>
            </div>
            <div class="form-gp" style="text-align: center;">
              <div id="error" style="color: red;"><%=error%></div>
            </div>
            <!--    
                         <div class="form-gp">
                         <p style="text-align:center">La nuova Password deve contenere almeno 8 caratteri di cui almeno:<br/>
                         - Un carattere maiuscolo<br/>
                         - Un carattere miniscolo<br/>
                         - Un numero intero positivo
                         </p>
                         </div>
                        -->
            <div class="submit-btn-area">
              <button id="form_submit" type="submit">
                Modifica <i class="ti-arrow-right"></i>
              </button>
            </div>
            <div class="form-footer text-center mt-5">
              <p class="text-muted">Non sei sicuro? Effettua la seguente procedura</p>
              <a href="Logout">Continua</a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- login area end -->
  <!-- bootstrap 4 js -->
  <script src="assets/js/popper.min.js"></script>
  <script src="assets/bootstrap/js/bootstrap.min.js"></script>
  <script src="assets/js/owl.carousel.min.js"></script>
  <script src="assets/js/metisMenu.min.js"></script>
  <script src="assets/js/jquery.slimscroll.min.js"></script>
  <script src="assets/js/jquery.slicknav.min.js"></script>
  <!-- others plugins -->
  <script src="assets/js/plugins.js"></script>
  <script src="assets/js/scripts.js"></script>
</body>
</html>
