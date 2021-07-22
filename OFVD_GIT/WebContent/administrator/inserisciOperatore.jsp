<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.model.CavsModel"%>
<%@page import="it.unisa.ofvd.model.dao.CavsDao"%>
<%@page import="it.unisa.ofvd.model.HospitalsModel"%>
<%@page import="it.unisa.ofvd.model.dao.HospitalsDao"%>
<%@page import="java.util.Collection"%>
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

	$(document).ready(function() {

		$('select').on("mousedown", function() {
			if (this.options.length >= 8)
				this.size = 8;
			else
				this.size = this.options.length;
		});

		$('select').on("blur", function() {
			this.size = 0;
		});

		$('select').on("change", function() {
			this.blur();
		});
	});

	//10 numeri
	var re_cel = new RegExp("^([0-9]{9,10})$");	
	var re_mail = new RegExp("^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$");  
	var re_mat = new RegExp("^([0-9]{4,8})$");	
	var email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;	
	var re_cf = /^(?:[A-Z][AEIOU][AEIOUX]|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]$/i;
	
	
	function alertCreate() {

		var flag = false;
		
		if ($('#nome_operatore').val() == "") {
			$('#nome_operatore').css("border-color", "red");
			$('#nome_operatore_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#nome_operatore').css("border-color", "");
			$('#nome_operatore_error_msg').text("");			
		}			
		
		if ($('#cognome_operatore').val() == "") {
			$('#cognome_operatore').css("border-color", "red");
			$('#cognome_operatore_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#cognome_operatore').css("border-color", "");
			$('#cognome_operatore_error_msg').text("");			
		}		
		
		if (re_cel.test($('#telefono_operatore').val())) {
			$('#telefono_operatore').css("border-color", "");
			$('#telefono_operatore_error_msg').text("");
		} else {	
			$('#telefono_operatore').css("border-color", "red");
			if ($('#telefono_operatore').val() == "")
				$('#telefono_operatore_error_msg').text("Compila il campo");
			else
				$('#telefono_operatore_error_msg').text(
						"Inserisci un numero di telefono valido di 9 o 10 cifre");	
			flag = true;
		}
		
		if ($('#email_operatore').val().match(email)) {
			$('#email_operatore').css("border-color", "");
			$('#email_operatore_error_msg').text("");
		} else {	
			$('#email_operatore').css("border-color", "red");
			if ($('#email_operatore').val() == "")
				$('#email_operatore_error_msg').text("Compila il campo");
			else
				$('#email_operatore_error_msg').text(
						"Inserisci una mail valida");	
			flag = true;
		}	
		
		if ($('#matricola_operatore').val() != "") {
			if (re_cf.test($('#matricola_operatore').val())) {
				$('#matricola_operatore').css("border-color", "");
				$('#matricola_operatore_error_msg').text("");
			} else {	
				$('#matricola_operatore').css("border-color", "red");
				$('#matricola_operatore_error_msg').text(
							"Inserisci un codice fiscale valido");	
				flag = true;
			} 
		} else {
				$('#matricola_operatore').css("border-color", "");
				$('#matricola_operatore_error_msg').text("");				
		}	
				
		if($("#codice_ospedale").val() == "" && $("#codice_cav").val() == "") {
			$('#codice_ospedale').css("border-color", "red");
			$('#codice_cav').css("border-color", "red");			
			$('#ospedale_operatore_error_msg').text("Selezionare un codice tra ospedale e servizio antiviolenza");
			flag = true;
		} else {
			$('#codice_ospedale').css("border-color", "");
			$('#codice_cav').css("border-color", "");
			$('#ospedale_operatore_error_msg').text("");
		}
		
		if(!flag) {
			document.getElementById('alertCreate').removeAttribute('hidden');
			window.scrollTo(0, 0);
		}			
	}

	function nascondi() {
		document.getElementById('alertCreate').setAttribute('hidden', 'true');
	}

	var user = new Object();
		
	function load() {
		var d = new Date();
		var timestamp = d.getTime();
		$('#password').val(timestamp);

		$("#codice_ospedale").change(function() {
			$("#codice_ospedale option:selected").each(function() {
				var al = $(this).val();
				if (al != "") {
					$("#codice_cav").val("");
				}
			})
		});
		$("#codice_cav").change(function() {
			$("#codice_cav option:selected").each(function() {
				var al = $(this).val();
				if (al != "") {
					$("#codice_ospedale").val("");
				}
			})
		});
	}

	function createUser() {
		var email_operatore = $('#email_operatore').val();
		var nome_operatore = $('#nome_operatore').val();
		var cognome_operatore = $('#cognome_operatore').val();
		var telefono_operatore = $('#telefono_operatore').val();
		var matricola_operatore = $('#matricola_operatore').val();
		var codice_ospedale = $('#codice_ospedale').val();
		var codice_cav = $('#codice_cav').val();
		var codice_admin = $('#codice_admin').val();
		var password_operatore = $('#password').val();

		user.action = "createUser";
		user.nome = "" + nome_operatore;
		user.cognome = "" + cognome_operatore;
		user.telefono = "" + telefono_operatore;
		user.matricola = "" + matricola_operatore;
		user.password = "" + password_operatore;
		user.email = "" + email_operatore;
		user.codeCav = "" + codice_cav;
		user.codeOspedale = "" + codice_ospedale;
		user.codeAdmin = "" + codice_admin;
		user.defaultPassword = true;

		$.ajax({
			url : "../User",
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

		setTimeout(function(){ window.location.href = './operatori.jsp'; }, 200);
		//window.location.href = "./operatori.jsp";

	}
</script>
</head>
<body onLoad="load();">
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
                <li><a href="operatori.jsp">Gestione Operatori</a></li>
                <li><span>Inserisci Operatore</span></li>
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
                <div style="text-align: center;">
                  <img src="../assets/images/icon/teamwork.png" style="width: 15%;">
                </div>
                <form id="myForm" method="post">
                  <div id="alertCreate" class="alert alert-primary" role="alert" hidden="true">
                    <h4 align="center" class="alert-heading">Attenzione</h4>
                    <p>Sei sicuro di voler inserire un nuovo operatore?</p>
                    <hr>
                    <div align="center">
                      <input class="btn btn-rounded btn-primary mb-3" type="button" value="Conferma" onclick="createUser();"> <input class="btn btn-rounded btn-primary mb-3" type="button" value="Annulla" onclick="nascondi();">
                    </div>
                  </div>
                  <div class="form-group">
                    <label>Nome&nbsp;<span id="nome_operatore_error_msg" style="color: red;"></span></label> <input id="nome_operatore" type="text" class="form-control" name="nome"> 
                    <label>Cognome&nbsp;<span id="cognome_operatore_error_msg" style="color: red;"></span></label> <input id="cognome_operatore" class="form-control" name="cognome" type="text"> 
                    <label>Telefono&nbsp;<span id="telefono_operatore_error_msg" style="color: red;"></span></label> <input id="telefono_operatore" type="text" class="form-control" name="telefono"> 
                    <label>Email&nbsp;<span id="email_operatore_error_msg" style="color: red;"></span></label> <input id="email_operatore" type="text" class="form-control" name="email"> 
                    <label>Codice Fiscale&nbsp;<span id="matricola_operatore_error_msg" style="color: red;"></span></label> <input id="matricola_operatore" type="text" class="form-control" name="matricola">
                    <%
                    	HospitalsDao hospitalDao = new HospitalsDao();
                    Collection<HospitalsModel> hospitals = hospitalDao.getAll();
                    %>
                    <label class="form-label">Identificativo Ospedale&nbsp;<span id="ospedale_operatore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="codice_ospedale">
                      <option value="" selected>Scegli...</option>
                      <%
                      	for (HospitalsModel ospedali : hospitals) {
                      %>
                      <option value="<%=ospedali.getEmail()%>"><%=ospedali.getNome()%> (<%=ospedali.getEmail()%>)
                      </option>
                      <%
                      	}
                      %>
                    </select>
                    <%
                    	CavsDao cavDao = new CavsDao();
                    Collection<CavsModel> cavs = cavDao.getAll();
                    %>
                    <label class="form-label">Identificativo Servizio Antiviolenza&nbsp;<span id="cav_operatore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="codice_cav">
                      <option value="" selected>Scegli...</option>
                      <%
                      	for (CavsModel cav : cavs) {
                      %>
                      <option value="<%=cav.getEmail()%>"><%=cav.getNome()%> (<%=cav.getEmail()%>)
                      </option>
                      <%
                      	}
                      %>
                    </select> 
                    <label>Codice Admin</label> <input id="codice_admin" type="text" class="form-control" name="code_admin" value="<%=account.getEmail()%>" readonly> 
                    <label>Password</label> <input id="password" class="form-control" name="password" readonly type=password>
                  </div>
                  <button type="button" class="btn btn-success btn-lg btn-block" onclick="alertCreate();">Inserisci</button>
                  <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="window.location.href='./operatori.jsp'">Annulla</button>
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
