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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretty-print-json@1.0/dist/pretty-print-json.css">
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
<script src="https://cdn.jsdelivr.net/npm/pretty-print-json@1.0/dist/pretty-print-json.min.js"></script>
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
	
	$( document ).ready(function() {
			
		var struct = new Object();

		function executeMySQLQuery() {
			struct.query = $("#query_mysql").val();
			$.ajax({
    			url : "../Query",
    			type : "POST",
    			data : {
    				db : "mysql",
    				elements : JSON.stringify(struct)
    			},
    			dataType : "json",    
    			success : function(jsonStr) {
    				$("#table_mysql thead").remove();
    				$("#table_mysql tbody").remove();
    				constructTable(jsonStr,"#table_mysql");
    			},
    			error: function (xhr, ajaxOptions, thrownError) {
    		        //alert(xhr.status+" : " + thrownError);
    		    }   			   			
    		});		
		}
			
		function executeMongoQuery() {
			struct.query = $("#query_mongo").val();	
			$.ajax({
    			url : "../Query",
    			type : "POST",
    			data : {
    				db : "mongo",
    				elements : JSON.stringify(struct)
    			},
    			dataType : "json",    
    			success : function(jsonStr) { 
    				$("#table_mongo").empty();
    				$("#table_mongo").html(prettyPrintJson.toHtml(jsonStr, {"quoteKeys": "true"}));
    			},
    			error: function (xhr, ajaxOptions, thrownError) {
    		        //alert(xhr.status+" : " + thrownError);
    		    }   			   			
    		});		
		}		
		
		$("#run_mysql").click(function() { 
			executeMySQLQuery();
		});

		$("#run_mysql").prop( "disabled", $("#query_mysql").val().trim() == '' );
		
		$("#query_mysql").on('change keyup paste', function() {
				$("#run_mysql").prop( "disabled", $("#query_mysql").val().trim() == '' );
		});		
		
		$("#run_mongo").click(function() { 
			executeMongoQuery();
		});

		$("#run_mongo").prop( "disabled", $("#query_mongo").val().trim() == '' );
		
		$("#query_mongo").on('change keyup paste', function() {
				$("#run_mongo").prop( "disabled", $("#query_mongo").val().trim() == '' );
		});			
		
		function constructTable(list, selector) { 
            var cols = headers(list, selector);   
   
            var tbody = $('<tbody/>');
            // Traversing the JSON data 
            for (var i = 0; i < list.length; i++) { 
                var row = $('<tr/>');    
                for (var colIndex = 0; colIndex < cols.length; colIndex++) { 
                    var val = list[i][cols[colIndex]]; 
                      
                    if (val == null) val = "";   
                        row.append($('<td/>').html(val)); 
                } 
                tbody.append(row);  
            } 
            
            $(selector).append(tbody); 
        } 	
		
        function headers(list, selector) { 
            var columns = []; 
            var theader = $('<thead/>');
            var header = $('<tr/>'); 
              
            for (var i = 0; i < list.length; i++) { 
                var row = list[i]; 
                  
                for (var k in row) { 
                    if ($.inArray(k, columns) == -1) { 
                        columns.push(k); 
                        header.append($('<th/>').html(k)); 
                    } 
                } 
            } 
            theader.append(header);  
            
            $(selector).append(theader); 
                return columns; 
        }
                     
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
                <li><span>Gestione&nbsp;Dati</span></li>
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
                <h4 class="header-title">Gestione Dati</h4>
                
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="mysql-tab" data-toggle="tab" href="#mysql" role="tab" aria-controls="mysql" aria-selected="true">MySQL</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="mongo-tab" data-toggle="tab" href="#mongo" role="tab" aria-controls="mongo" aria-selected="false">Mongo</a>
                  </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                  <div class="tab-pane active" id="mysql" role="tabpanel" aria-labelledby="mysql-tab" style="padding: 10px;">
                      <br>
                      <div><i><%= Info.getMysqlVersion() %></i></div>
                      <br>
                      <form>
                        <div class="form-group">
                          <div class="form-holder">
                            <label class="form-label"><span class="h6s">Inserisci query</span></label><br />
                            <textarea class="form-control" id="query_mysql" autocomplete="off" spellcheck="false" rows="4" placeholder="query sql..." style="font-size: medium; border:1px #dee2e6 solid;resize: vertical;"></textarea>
                          </div>
                          <div class="btn-group btn-lg btn-block" role="group">
                            <button type="button" id="run_mysql" class="btn btn-primary">Esegui</button>         
                          </div>  
                        </div>                         
                      </form>
                      <div class="single-table">
                        <div class="table-responsive">
                          <table id="table_mysql" class="table progress-table"></table>  
                        </div>
                      </div> 
                  </div>
                  <div class="tab-pane" id="mongo" role="tabpanel" aria-labelledby="mongo-tab" style="padding: 10px;">
                      <br>
                      <div><i><%= Info.getMongoVersion() %></i></div>
                      <br>
                      <form>
                        <div class="form-group">
                          <div class="form-holder">
                            <label class="form-label"><span class="h6s">Inserisci query</span></label><br />
                            <textarea class="form-control" id="query_mongo" autocomplete="off" spellcheck="false" rows="4" placeholder="query nosql..." style="font-size: medium; border:1px #dee2e6 solid;resize: vertical;"></textarea>
                          </div>
                          <div class="btn-group btn-lg btn-block" role="group">
                            <button type="button" id="run_mongo" class="btn btn-primary">Esegui</button>         
                          </div>  
                        </div>                         
                      </form>
                      <div class="single-table">
                        <pre id="table_mongo"></pre>  
                      </div>                                                           
                  </div>
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
