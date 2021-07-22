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
<script src="../assets/jquery/jquery.min.js"></script>
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
		$('#nome_cav').on("keyup", function() {	
			$(this).val($(this).val().toUpperCase());
		});	
	});	
	
	var structure = new Object();
	function load() {
		var idEmail = new URLSearchParams(window.location.search);
		var email = idEmail.get('email');

		structure.type = "cav";
		structure.action = "selectStructure";
		structure.email = "" + email;

		$.ajax({
			url : "../Struct",
			type : 'GET',
			data : {
				elements : JSON.stringify(structure)
			},
			dataType : "JSON",
			contentType : 'application/json',
			mimeType : 'application/json',

			success : function(jsonStr) {

				var id = jsonStr['id'];
				var email = jsonStr['email'];
				var indirizzo = jsonStr['indirizzo'];
				var telefono = jsonStr['telefono'];
				var telefono1 = jsonStr['telefono1'];
				var nome = jsonStr['nome'];

				$('#id_cav').val(id);
				$('#email_cav').val(email);
				$('#indirizzo_cav').val(indirizzo);
				$('#telefono_cav').val(telefono);
				$('#telefono1_cav').val(telefono1);
				$('#nome_cav').val(nome);
			}
		});
	}

	//10 numeri
	var re_cel = new RegExp("^([0-9]{9,10})$");	
	var re_mail = new RegExp("^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$");  
	var email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;		
	
	function alertUpdate() {
		
		var flag = false;
		
		if ($('#nome_cav').val() == "") {
			$('#nome_cav').css("border-color", "red");
			$('#nome_cav_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#nome_cav').css("border-color", "");
			$('#nome_cav_error_msg').text("");			
		}	
		
		if ($('#indirizzo_cav').val() == "") {
			$('#indirizzo_cav').css("border-color", "red");
			$('#indirizzo_cav_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#indirizzo_cav').css("border-color", "");
			$('#indirizzo_cav_error_msg').text("");			
		}		
		
		if ($('#email_cav').val().match(email)) {
			$('#email_cav').css("border-color", "");
			$('#email_cav_error_msg').text("");
		} else {	
			$('#email_cav').css("border-color", "red");
			if ($('#email_cav').val() == "")
				$('#email_cav_error_msg').text("Compila il campo");
			else
				$('#email_cav_error_msg').text(
						"Inserisci una mail valida");	
			flag = true;
		}		
				
		if (re_cel.test($('#telefono_cav').val())) {
			$('#telefono_cav').css("border-color", "");
			$('#telefono_cav_error_msg').text("");
		} else {	
			$('#telefono_cav').css("border-color", "red");
			if ($('#telefono_cav').val() == "")
				$('#telefono_cav_error_msg').text("Compila il campo");
			else
				$('#telefono_cav_error_msg').text(
						"Inserisci un numero di telefono valido di 9 o 10 cifre");	
			flag = true;
		}
		
		if ($('#telefono1_cav').val() != "") {
			if (re_cel.test($('#telefono1_cav').val())) {
				$('#telefono1_cav').css("border-color", "");
				$('#telefono1_cav_error_msg').text("");				
			} else {
				$('#telefono1_cav').css("border-color", "red");
				$('#telefono1_cav_error_msg').text(
				"Inserisci un numero di telefono valido di 9 o 10 cifre");	
				flag = true;
			}
		} else {
			$('#telefono1_cav').css("border-color", "");
			$('#telefono1_cav_error_msg').text("");			
		}
		
		if(!flag) {	
			document.getElementById('alertUpdate').removeAttribute('hidden');
			window.scrollTo(0, 0);
		}
	}

	function updateStruct() {
		var email_cav = $('#email_cav').val();
		var nome_cav = $('#nome_cav').val();
		var id_cav = $('#id_cav').val();
		var telefono_cav = $('#telefono_cav').val();
		var telefono1_cav = $('#telefono1_cav').val();
		var indirizzo_cav = $('#indirizzo_cav').val();

		structure.type = "cav";
		structure.action = "updateStructure";
		structure.nome = "" + nome_cav;
		structure.id = "" + id_cav;
		structure.telefono = "" + telefono_cav;
		structure.telefono1 = "" + telefono1_cav;
		structure.email = "" + email_cav;
		structure.indirizzo = "" + indirizzo_cav;

		$.ajax({
			url : "../Struct",
			type : 'GET',
			data : {
				elements : JSON.stringify(structure)
			},
			dataType : "JSON",
			contentType : 'application/json',
			mimeType : 'application/json',

			success : function(jsonStr) {
			}
		});

		setTimeout(function(){ window.location.href = './cav.jsp'; }, 200);
		//window.location.href = './cav.jsp';
	}

	function nascondi() {
		document.getElementById('alertUpdate').setAttribute('hidden', 'true');
	}

	function indietro() {
		window.location.href = 'cav.jsp';

	}
</script>
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
</head>
<body onload="load()">
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
                <li><a href="strutture.jsp">Gestione Strutture</a></li>
                <li><a href="cav.jsp">Gestione Servizi Antiviolenza</a></li>
                <li><span>Modifica Servizio Antiviolenza</span></li>
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
                  <img src="../assets/images/icon/building.png" style="width: 15%;">
                </div>
                <form method="post">
                  <div id="alertUpdate" class="alert alert-primary" role="alert" hidden="true">
                    <h4 align="center" class="alert-heading">Attenzione</h4>
                    <p>Sei sicuro di voler effettuare la modifica?</p>
                    <hr>
                    <div align="center">
                      <input class="btn btn-rounded btn-primary mb-3" type="button" value="Conferma" onclick="updateStruct()"> <input class="btn btn-rounded btn-primary mb-3" type="button" value="Annulla" onclick="nascondi()">
                    </div>
                  </div>
                  <div class="form-group">
                    <label>Id Servizio Antiviolenza&nbsp;<span id="id_cav_error_msg" style="color: red;"></span></label> <input readonly id="id_cav" name="id_struttura" class="form-control" value=''>                  
                    <label>Nome Struttura&nbsp;<span id="nome_cav_error_msg" style="color: red;"></span></label> <input id="nome_cav" name="nome_struttura" class="form-control" value="">                                   
                    <label>Indirizzo&nbsp;<span id="indirizzo_cav_error_msg" style="color: red;"></span></label> <input id="indirizzo_cav" name="indirizzo" class="form-control" value=""> 
                    <label>Email&nbsp;<span id="email_cav_error_msg" style="color: red;"></span></label> <input readonly id="email_cav" name="email" class="form-control" value=""> 
                    <label>Telefono&nbsp;<span id="telefono_cav_error_msg" style="color: red;"></span></label> <input id="telefono_cav" name="telefono" class="form-control" value="">
                    <label>Telefono&nbsp;<span id="telefono1_cav_error_msg" style="color: red;"></span></label> <input id="telefono1_cav" name="telefono1" class="form-control" value="">
                  </div>
                  <div class="form-group">
                    <button type="button" class="btn btn-success btn-lg btn-block" onclick="alertUpdate();">Modifica</button>
                    <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="indietro();">Annulla</button>
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
