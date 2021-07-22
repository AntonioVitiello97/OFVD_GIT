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
		$('#nome_struttura').on("keyup", function() {	
			$(this).val($(this).val().toUpperCase());
		});	
	});		
	
	var structure = new Object();
	function createStructure() {
		var email_cav = $('#email_struttura').val();
		var nome_cav = $('#nome_struttura').val();
		//var id_cav = $('#id_struttura').val();
		var telefono_cav = $('#telefono_struttura').val();
		var telefono1_cav = $('#telefono1_struttura').val();
		var indirizzo_cav = $('#indirizzo_struttura').val();

		structure.type = "cav";
		structure.action = "createStructure";
		structure.nome = "" + nome_cav;
		//structure.id = "" + id_cav;
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

	//10 numeri
	var re_cel = new RegExp("^([0-9]{9,10})$");	
	var re_mail = new RegExp("^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$");  
	var email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;	
	
	function alertStruttura() {
		
		var flag = false;
		
		if ($('#nome_struttura').val() == "") {
			$('#nome_struttura').css("border-color", "red");
			$('#nome_struttura_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#nome_struttura').css("border-color", "");
			$('#nome_struttura_error_msg').text("");			
		}	
		
		if ($('#indirizzo_struttura').val() == "") {
			$('#indirizzo_struttura').css("border-color", "red");
			$('#indirizzo_struttura_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#indirizzo_struttura').css("border-color", "");
			$('#indirizzo_struttura_error_msg').text("");			
		}		
		
		if ($('#email_struttura').val().match(email)) {
			$('#email_struttura').css("border-color", "");
			$('#email_struttura_error_msg').text("");
		} else {	
			$('#email_struttura').css("border-color", "red");
			if ($('#email_struttura').val() == "")
				$('#email_struttura_error_msg').text("Compila il campo");
			else
				$('#email_struttura_error_msg').text(
						"Inserisci una mail valida");	
			flag = true;
		}		
				
		if (re_cel.test($('#telefono_struttura').val())) {
			$('#telefono_struttura').css("border-color", "");
			$('#telefono_struttura_error_msg').text("");
		} else {	
			$('#telefono_struttura').css("border-color", "red");
			if ($('#telefono_struttura').val() == "")
				$('#telefono_struttura_error_msg').text("Compila il campo");
			else
				$('#telefono_struttura_error_msg').text(
						"Inserisci un numero di telefono valido di 9 o 10 cifre");	
			flag = true;
		}
		
		if ($('#telefono1_struttura').val() != "") {
			if (re_cel.test($('#telefono1_struttura').val())) {
				$('#telefono1_struttura').css("border-color", "");
				$('#telefono1_struttura_error_msg').text("");				
			} else {
				$('#telefono1_struttura').css("border-color", "red");
				$('#telefono1_struttura_error_msg').text(
				"Inserisci un numero di telefono valido di 9 o 10 cifre");	
				flag = true;
			}
		} else {
			$('#telefono1_struttura').css("border-color", "");
			$('#telefono1_struttura_error_msg').text("");			
		}
		
		
		if(!flag) {		
			document.getElementById('alertStruct').removeAttribute('hidden');
			window.scrollTo(0, 0);
		}	
	}

	function nascondi() {
		document.getElementById('alertStruct').setAttribute('hidden', 'true');
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
                <li><a href="strutture.jsp">Gestione Strutture</a></li>
                <li><a href="cav.jsp">Gestione Servizi Antiviolenza</a></li>
                <li><span>Inserisci Servizio Antiviolenza</span></li>
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
                <form method="post">
                  <div id="alertStruct" class="alert alert-primary" role="alert" hidden="true">
                    <h4 align="center" class="alert-heading">Attenzione</h4>
                    <p>Sei sicuro di voler inserire un nuovo cav?</p>
                    <hr>
                    <div align="center">
                      <input class="btn btn-rounded btn-primary mb-3" type="button" value="Conferma" onclick="createStructure()"> <input class="btn btn-rounded btn-primary mb-3" type="button" value="Annulla" onclick="nascondi()">
                    </div>
                  </div>
                  <div style="text-align: center;">
                    <img src="../assets/images/icon/building.png" style="width: 15%;">
                  </div>
                  <div class="form-group">
                    <!--  label>Id Servizio Antiviolenza</label> <input id="id_struttura" name="id_struttura" class="form-control" value=''--> 
                    <label>Nome Struttura&nbsp;<span id="nome_struttura_error_msg" style="color: red;"></span></label> <input id="nome_struttura" name="nome_struttura" class="form-control" value="">                                   
                    <label>Indirizzo&nbsp;<span id="indirizzo_struttura_error_msg" style="color: red;"></span></label> <input id="indirizzo_struttura" name="indirizzo" class="form-control" value=""> 
                    <label>Email&nbsp;<span id="email_struttura_error_msg" style="color: red;"></span></label> <input id="email_struttura" name="email" class="form-control" value=""> 
                    <label>Telefono&nbsp;<span id="telefono_struttura_error_msg" style="color: red;"></span></label> <input id="telefono_struttura" name="telefono" class="form-control" value="">
                    <label>Telefono&nbsp;<span id="telefono1_struttura_error_msg" style="color: red;"></span></label> <input id="telefono1_struttura" name="telefono1" class="form-control" value="">               
                  </div>
                  <button type="button" class="btn btn-success btn-lg btn-block" onclick="alertStruttura()">Inserisci</button>
                  <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="window.location.href='./cav.jsp'">Annulla</button>
                </form>
              </div>
            </div>
          </div>
        </div>
        <div class="row" id="button_invia_indietro">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body"></div>
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
