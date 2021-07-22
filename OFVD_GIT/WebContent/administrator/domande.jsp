<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.model.QuestionsModel"%>
<%@page import="it.unisa.ofvd.model.dao.QuestionsDao"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.unisa.ofvd.model.dao.AccountsDao"%>
<%@page import="it.unisa.ofvd.model.dao.CavsDao"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.model.CavsModel"%>
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
if (account == null || !account.isAdministrator()) {
	String redirectedPage = "/login.jsp";
	response.sendRedirect(request.getContextPath() + redirectedPage);
	return;
}

QuestionsDao questionDao = new QuestionsDao();
Collection<QuestionsModel> questions = questionDao.getAll();
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
<!-- data table -->
<link rel="stylesheet" href="../assets/datatable/css/datatables.css">
<!--  wizard library -->
<!-- JSpdf -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.4.1/jspdf.debug.js"></script>
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet" href="../assets/wizard_layout/fonts/material-design-iconic-font/css/material-design-iconic-font.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="../assets/wizard_layout/css/style.css">
<!-- confirm  -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<!-- data table -->
<script src="../assets/datatable/js/datatables.js"></script>
<!-- end confirm -->
<style>
#float {
        position: fixed;
        top: 3em;
        right: 2em;
        z-index: 100;
    }
    
table.dataTable thead tr th.sorting_asc, 
table.dataTable thead tr td.sorting_asc {
  background-color: #dadada;
}

table.dataTable thead tr th.sorting_desc, 
table.dataTable thead tr td.sorting_desc {
  background-color: #dadada;
}    
</style>
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
	
	function cambia(id) {
		document.getElementById('id_domanda').innerHTML = id;
		document.getElementById('alertChangeStatus').removeAttribute('hidden');
		document.getElementById('confermaChange').setAttribute('value', id);
		window.scrollTo(0, 0);
	}

	var question = new Object();

	function modificaDomanda(id) {
		question.action = "changeState";
		question.answer1 = "" + id;

		$.ajax({
			url : "../Question",
			type : 'GET',
			data : {
				elements : JSON.stringify(question)
			},
			dataType : "JSON",
			contentType : 'application/json',
			mimeType : 'application/json',

			success : function(jsonStr) {
			}
		});

		nascondi();
	}

	function nascondi() {
		document.getElementById('alertChangeStatus').setAttribute('hidden', '');
		var url = "domande.jsp";
		$(location).attr('href', url);
	}

	
	function convertToCSV(objArray) {
	    var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
	    var str = '';

	    for (var i = 0; i < array.length; i++) {
	        var line = '';
	        for (var index in array[i]) {
	            if (line != '') line += ';'

	            var tmp = ''+array[i][index];
	            //tmp = tmp.replace(/,/g, '');
	            
	            if(tmp.includes(","))
	            	tmp = '"'+tmp+'"';
	            
	            if(tmp.includes(";"))
	            	tmp = '"'+tmp+'"';	            
	            
	            line += tmp;
	        }

	        str += line + '\r\n';
	    }

	    return str;
	}
	
	function exportCSVFile(items, fileTitle) {

		//var headers = ["trace", "lastUpdate", "type", "hospital", "cav", "status", "author", "section"];
		var headers = ["Traccia", "Ultimo Aggiornamento", "Tipo", "Hospital", "Cav",
					  "Stato", "Autore",
	  			      "Sezione", "Codice Identificativo", "Data Compilazione",
	  			 	  "Nome Compilatore", "Cognome Compilatore", "Pronto Soccorso",
		  			  "Nome Vittima", "Cognome Vittima", "Data di Nascita",
		  			  "Paese Di Nascita", "Provincia Nascita", "Comune Nascita",
		  			  "Indirizzo", "Telefono", "Altro Telefono", 
					  "Cittadinanza Italiana", "Altra Cittadinanza", 
					  "Conoscenza Lingua Italiana", "Mediatore Culturale", "Stato Civile",
					  "Altro Stato Civile", "Figli", "Numero Figli", "Numero Minorenni",
		  			  "Titolo Di Studio", "Altro Titolo Di Studio", "Professione",
		  			  "Autonomo Economicamente", "Primo Accesso Pronto Soccorso", "Numero Accessi Ripetuti",
		  			  "Sfruttamento", "Donna Accompagnata", "Altro Donna Accompagnata", "Motivo Accesso",
		  			  "Nome Aggressore", "Cognome Aggressore", "Data Di Nascita Aggressore",
		  			  "Paese Di Nascita Aggressore", "Provincia Nascita Aggressore", "Comune Nascita Aggressore",
		  			  "Indirizzo Aggressore", "Telefono Aggressore", "Titolo Di Studio Aggressore",
		  			  "Altro Titolo Di Studio Aggressore", "Professione Aggressore", "Fascia Età Aggressore",
		  			  "Rapporto Vittima Aggressore", "Tipologia Familiare", "Altro Rapporto Vittima Aggressore",
		  			  "Servizi Aggressore", "Tipologia Servizi Aggressore", "Altra Tipologia Servizi Aggressore",
		  			  "Precedenti Penali", "Brief_risk1", "Brief_risk2", "Brief_risk3", "Brief_risk4",
		  			  "Brief_risk5", "Brief_risk6", "Brief_risk7", "Ruolo Compilatore","Altro Ruolo Compilatore",
		  			  "Identificativo Servizio", "Altro Identificativo Servizio", "Provincia Pronto Soccorso", "Comune Pronto Soccorso", "Cav Nome",
		  			  "Provincia Cav", "Comune Cav", "Sportello Di Ascolto", "Numero Figli Minorenni Maschi", "Numero Figli Minorenni Femmine",
		  			  "Convivono Figli Femmine", "Assistono Violenza Figli", "Subiscono Violenza Figli", "Altro Stato Occupazionale Donna",
		  			  "Accesso Occasionale", "Donna Accompagnata Al Servizio Anti Violenza", "Donna Accompagnata Forza Dell'Ordine",
		  			  "Provincia Donna Accompagnata Forza Dell'Ordine", "Comune Donna Accompagnata Forza Dell'Ordine",
		  			  "Donna Accompagnata Pronto Soccorso", "Provincia Donna Accompagnata Pronto Soccorso",
		  			  "Comune Donna Accompagnata ProntoSoccorso", "Select Tipologia Violenza", "Violenza Riferite",
		  			  "Altro Violenze Riferite", "Conosci Aggressore", "Altro Stato Occupazionale Aggressore",
		  			  "Violenza Assistita o Subita", "Fase Di Separazione", "Separata", "Tempo Separazione",
		  			  "Ha Comunicato Al Partner", "Sporgere Denuncia", "Sporto Denuncia", "Forze Dell'Ordine",
		  			  "Provincia Denuncia", "Comune Denuncia", "Ritirato Denuncia", "Motivo Ritiro Denuncia",
		  			  "Valutazione Stato Bisogno", "Specificare Altra Valutazione Stato Bisogno",
		  			  "Presa In Carico", "Prestazioni Effettuate", "Attivazione Rete", "Attivazione Rete Pronto Soccorso",
		  			  "Attivazione Rete Provincia Pronto Soccorso", "Attivazione Rete Comune Pronto Soccorso",
		  			  "Attivazione Rete Forze Dell'Ordine", "Attivazione Rete Provincia Forze Dell'Ordine",
		  			  "Attivazione Rete Comune Forza Dell'Ordine", "Servizio Sanitario Provincia",
		  			  "Servizi Sociali Provincia", "Conviventi", "Tipologia Violenza", "Altro Violenza Riferita",
		  			  "Con Figli Minori", "Codice Attributo", "Rete Intra Ospedaliera", "Specifico Rete Intra Ospedaliera",
		  			  "Rete Extra Ospedaliera", "Specifico Rete Extra Ospedaliera", "Forze Dell' Ordine", "Tempi Di Prognosi",
		  			  "Referto", "Attestazioni", "Codice Rosa"];
		
		for (var i = 0; i < headers.size; i++) { 
			headers.push(headers[i]);
		}
	    items.unshift(headers);
		
	    // Convert Object to JSON
	    var jsonObject = JSON.stringify(items);

	    var csv = this.convertToCSV(jsonObject);

	    var exportedFilenmae = fileTitle + '.csv' || 'export.csv';

	    var blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
	    if (navigator.msSaveBlob) { // IE 10+
	        navigator.msSaveBlob(blob, exportedFilenmae);
	    } else {
	        var link = document.createElement("a");
	        if (link.download !== undefined) { // feature detection
	            // Browsers that support HTML5 download attribute
	            var url = URL.createObjectURL(blob);
	            link.setAttribute("href", url);
	            link.setAttribute("download", exportedFilenmae);
	            link.style.visibility = 'hidden';
	            document.body.appendChild(link);
	            link.click();
	            document.body.removeChild(link);
	        }
	    }
	}	
	
	const monthNames = ["Gen", "Feb", "Mar", "Apr", "Mag", "Giu",
		  "Lug", "Ago", "Set", "Oct", "Nov", "Dic"];
		
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
                <li><span>Gestione Schede</span></li>
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
                <h4 class="header-title">Schede</h4>
                <div class="single-table">
                  <div class="table-responsive">
                    <form method="post">
                      <div id="alertChangeStatus" hidden=true; class="alert alert-primary" role="alert">
                        <h4 align="center" class="alert-heading">Attenzione</h4>
                        <p>
                          Sei sicuro di voler cambiare lo stato della scheda <span id="id_domanda"></span>?
                        </p>
                        <hr>
                        <div align="center">
                          <button id="confermaChange" class="btn btn-rounded btn-primary mb-3" type="button" value="Conferma" onclick="modificaDomanda(document.getElementById('confermaChange').value);">Conferma</button>
                          <button class="btn btn-rounded btn-primary mb-3" type="button" value="Annulla" onclick="nascondi();">Annulla</button>
                        </div>
                      </div>
                      <%
                      int avail = 0;                      
                      
                      	if (questions.size() > 0) {
                      %>                
                      <!-- datatable -->
        <span>      
        Colonne: 
        <a class="toggle-vis text-uppercase" data-column="2">Accessi</a> -        
        <a class="toggle-vis text-uppercase" data-column="1">N&deg;</a> -
        <a class="toggle-vis text-uppercase" data-column="4">Presso</a> -
        <a class="toggle-vis text-uppercase" data-column="5">Compilata da</a> -
        <a class="toggle-vis text-uppercase" data-column="6">Tipo</a>
        <br>
        <br>
        </span>                          
        <table id="datas" class="table hover text-center order-column" style="width:100%">       
        <thead class="text-uppercase">
            <tr>
                <th id="select" scope="col">Sel&nbsp;<input id="selectall" type="checkbox" value=""></th>
                <th scope="col">N&deg;</th>
                <th scope="col">Accessi</th>
                <th scope="col">Id</th>
                <th scope="col">Presso</th>
                <th scope="col">Compilata da</th>
                <th scope="col">Tipo</th>
                <th scope="col">In data</th>
                <th scope="col">Stato</th>
                <th scope="col">Azioni</th>
            </tr>
        </thead>
        <tbody>
                          <%
                            int itt = 0;
                            avail = 0;
                          for (QuestionsModel domande : questions) {
                            if (domande.getAnswer1() != null) {
                            	itt++;
                          %>
                          <tr id=<%=domande.getAnswer1()%>>
                            <% if (domande.getStatus().equals("bozze")) { %>
                            <td>&nbsp;</td>
                            <% } else {
                              avail++;
                            %>
                            <td><input name="tabs" type="checkbox" value="<%=domande.getAnswer1()%>" class="available"></td>
                            <% } %>
                            <td style="font-size:80%;"><b><%=itt%></b></td>
                            <% if(domande.getTrace() != null) {
                            %>
                            <td><%=domande.getTrace()%></td>
                            <% } else { %>
                              <td></td>
                            <% } %>
                            <td style="font-size:80%;"><%=domande.getAnswer1()%></td>
                            <%
                              if (domande.getType().equals("hospital")) {
                            %>
                            <td style="font-size:80%;"><%=domande.getAnswer5()%></td>
                            <td style="font-size:90%;"><%=domande.getAnswer3() + " " + domande.getAnswer4()%></td>
                            <%
                              } else {
                            CavsDao cavdao = new CavsDao();
                            CavsModel cav = cavdao.retrieve(domande.getCav());
                            %>
                            <td style="font-size:80%;"><%=cav.getNome()%></td>
                            <td style="font-size:90%;"><%=domande.getAnswer3() + " " + domande.getAnswer4()%></td>
                            <%
                              }
                            %>
                            <td style="font-size:90%;">
                            <% if(domande.getType().equals("cav")) {%>
                            <span class='status-p bg-info' style="text-transform: capitalize;">Servizio</span>
                            <% } else { %>
                            <span class='status-p bg-primary' style="text-transform: capitalize;">Ospedale</span>
                            <% } %>
                            </td>
                            <td><%=domande.getAnswer2()%></td>
                            <td style="font-size:90%;">
                              <%
                                if (domande.getStatus().equals("bozze")) {
                              %> <span class='status-p bg-warning'><%=domande.getStatus()%></span> 
                              <% } else { %> 
                              <span class='status-p bg-success'><%=domande.getStatus()%></span> 
                              <% } %>
                            </td>
                            <td>
                              <ul class='d-flex justify-content-center'>
                                <%
                                  if (domande.getStatus().equals("bozze")) {
                                %>
                                <li class='mr-3'><i class="fa fa-fw"></i></li>
                                <%
                                  } else {
                                %>
                                <li class='mr-3' style="cursor: pointer;"><a class='text-secondary' onclick="cambia('<%=domande.getAnswer1()%>')"> <i class='fa fa-toggle-on' title="Cambia in bozza"></i></a></li>
                                <%
                                  }
                                if (domande.getType().equals("hospital")) {
                                %>
                                <li class='mr-3' style="cursor: pointer;"><a id='dettaglio' href='detailHospital.jsp?id_question=<%=domande.getAnswer1()%>' class='text-secondary'> <i class='far fa-eye' title="Dettagli"></i></a></li>
                                <%
                                  } else {
                                %>
                                <li class='mr-3' style="cursor: pointer;"><a id='dettaglio' href='detailCav.jsp?id_question=<%=domande.getAnswer1()%>' class='text-secondary'> <i class='far fa-eye' title="Dettagli"></i></a></li>
                                <%
                                  }
                                %>
                              </ul>
                            </td>
                          </tr>
                          <%
                            }
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
                          <span style="color: orange;"><b>Attenzione.</b> Nessuna scheda &egrave; disponibile</span>
                        </p>
                      </div>
                      <%
                      	}
                      %>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="form-group">
        <%
        	if (questions.size() > 0) {
        %>
        <button id="download" disabled type="button" class="btn btn-success btn-lg btn-block">Esporta schede</button>
        <%
        	}
        %>
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
  
  <script>
	$(document).ready(function() {
		 var table = $('#datas').DataTable( {
		        "order": [[ 7, "desc" ]],
		        "pagingType": "full_numbers",
		        "lengthMenu" : [ [ 10, 25, 50, 100, -1 ], [ 10, 25, 50, 100, "All" ] ],
		        "info" : true,
		        "fixedHeader": true,
				"columnDefs": [ {
					"targets": 0,
					"orderable": true,
					"orderDataType": 'dom-checkbox'
					},
					{
						"targets": 2,
						"visible": false
					}],
		        "language": {
		            "lengthMenu": "Mostra _MENU_ schede",
		            "zeroRecords": "Nessuna scheda &egrave; disponibile",
		            "info": "Mostra pagina _PAGE_ su _PAGES_<br>Mostra da _START_ a _END_ su _TOTAL_ schede",
		            "infoEmpty": "Nessuna scheda disponibile",
		            "infoFiltered": "(filtrato da _MAX_ schede totali)",
		            "paginate": {
		            	"next": "Successivo",
		            	"previous": "Precedente",
			            "first": "Prima",
			            "last": "Ultima",
			            "emptyTable": "Nessuna scheda disponibile"
		            },
		            "search": "Cerca:",
		        }
		    } );
		 
			$('#selectall').on('click', function(){
			      var rows = table.rows().nodes();
			 
			      $('.available', rows).prop('checked', this.checked);
			      var len = $('.available:checked', rows).length;

			      if(len > 0)  {
			    	  $('#download').prop('disabled', false);
			    	  $('#download').text("Esporta schede ("+len+")");
			      } else {
			    	  $('#download').prop('disabled', true); 
			    	  $('#download').text("Esporta schede");
			      }
			   });	
			
			$('input:checkbox:not(.unavailable)', table.rows().nodes()).on('click', function(){
				 var rows = table.rows().nodes();
				 var len = $('input:checkbox:not(".unavailable, #selectall"):checked', rows).length;
				
			      if(len > 0) {
			    	  $('#download').prop('disabled', false);
			    	  $('#download').text("Esporta schede ("+len+")");
			      } else {
			    	  $('#download').prop('disabled', true); 
			    	  $('#download').text("Esporta schede");
			      }
			      if(len == <%=avail%>) {
			    	  $('#selectall').prop('checked', true);
			      } else {
			    	  $('#selectall').prop('checked', false);
			      }				
			});			
			
		    $('a.toggle-vis').on( 'click', function (e) {
		        e.preventDefault();
		 
		        // Get the column API object
		        var column = table.column( $(this).attr('data-column') );
		 
		        // Toggle the visibility
		        column.visible( ! column.visible() );
		    } );
		    
			$("#download").on("click", function(){
				question.action = "export";

				var nodes = $('input:checkbox[name*="tabs"]:checked', table.rows().nodes())
				question.ids = $.map(nodes, function (param) {return param.value})

				$.ajax({
					url : "../Question",
					type : 'GET',
					data : {
						elements : JSON.stringify(question)
					},
					dataType : "JSON",
					contentType : 'application/json',
					mimeType : 'application/json',
					success : function(jsonStr) {
						
						var data_orario1 = new Date();
						var time = data_orario1.getDate() + "_" +  monthNames[data_orario1.getMonth()]
								+ "_" + data_orario1.getFullYear();
						exportCSVFile(jsonStr, "exportSchede_" + time);
					}
				});	
			});		    
	} );  
  
  </script>
  
</body>
</html>
