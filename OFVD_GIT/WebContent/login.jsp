<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	String error = (String)request.getAttribute("error");
	if(error == null) {
		error = "&nbsp;";
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
	        window.history.forward()
	    }
	   noBack();
	   window.onload = noBack;
	   window.onpageshow = function(evt) { if (evt.persisted) noBack() }
	   window.onunload = function() { void (0) }
	   
	   function visiblePassword() {
		   var x = document.getElementById("exampleInputPassword1");
		   if (x.type === "password") {
		     x.type = "text";
		   } else {
		     x.type = "password";
		   }
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
                <form action="Login" method="post">
                    <div class="login-form-head">
                        <h4>Login</h4>
                        <a href="/ofvd">
                          <img src="./assets/images/logo/logo.png" class="rounded-circle" alt="OFVD" width="204" height="200">
                        </a>
                    </div>
                    <div class="login-form-body">
                        <div class="form-gp">
                            <label for="exampleInputEmail1">Email</label>
                            <input type="email" id="exampleInputEmail1" name="email" required>
                            <i class="ti-email"></i>
                        </div>
                        <div class="form-gp">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" id="exampleInputPassword1" name="password" required>
                            <i class="ti-lock"></i>
                        </div>
                        <div class="row mb-4 rmber-area">
                            <div class="col-6">
                                 <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlVisible" onclick="visiblePassword()">
                                    <label class="custom-control-label" for="customControlVisible">Mostra Password</label>                                
                                </div>
                                <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlAutosizing">
                                    <label class="custom-control-label" for="customControlAutosizing">Ricordami</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-gp" style="text-align:center;">
                        	<div id="error" style="color: red;"><%=error %></div>
                        </div>
                        <div class="submit-btn-area">
                            <button id="form_submit" type="submit">Accedi <i class="ti-arrow-right"></i></button>
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
