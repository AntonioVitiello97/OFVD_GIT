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
uri = uri + "/hospital/";
AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
if (account == null || (!account.isHospitalUser())) {
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
<!-- calendar  -->
<script src="https://unpkg.com/gijgo@1.9.11/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.11/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<!-- end calendar -->
<!--  wizard library -->
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet" href="../assets/wizard_layout/fonts/material-design-iconic-font/css/material-design-iconic-font.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="../assets/wizard_layout/css/style.css">
<!-- Grafico gogole -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- start chart js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<!-- start highcharts js -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<!-- start zingchart js -->
<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
<script>
	zingchart.MODULESDIR = "https://cdn.zingchart.com/modules/";
	ZC.LICENSE = [ "569d52cefae586f634c54f86dc99e6a9",
			"ee6b7db5b51705a13dc2339db3edaf6d" ];
</script>
<!-- start amchart js -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/pie.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/animate/animate.min.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<!-- all line chart activation -->
<script src="../assets/js/line-chart.js"></script>
<!-- all bar chart activation -->
<script src="../assets/js/bar-chart.js"></script>
<!-- all pie chart -->
<script src="../assets/js/pie-chart.js"></script>
<!-- others plugins -->	

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
				this.size = 16;
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
	
	var campo_selezionato = "";
	var chart_selezionato = 0;
	
	/*
	ID CHART
	0 = Non è compatibile il chart
	1 = E' compatibile il chart
	*/
	
	function Variabile(nome, nomeDB, donut, world_map, calendar) {
	    this.nome = nome;
	    this.nomeDB = nomeDB;
	    this.donut = donut;
	    this.world_map = world_map;
	    this.calendar = calendar;
	}
	
	var VariabiliArray = [
		//Nome campo visualizzato, nome campo DB, donut, map, calendar
new Variabile("Data Compilazione", "DataCompilazione" , "1", "0", "1"),
new Variabile("Pronto Soccorso", "ProntoSoccorso", "1", "0", "0"),
new Variabile("Luogo di nascita", "LuogoNascita", "1", "1", "0"),
new Variabile("Provincia di nascita", "ProvinciaNascita" , "1", "0", "0"),
new Variabile("Comune di nascita", "ComuneNascita", "1", "0", "0"),
//
new Variabile("Cittadinanza italiana", "CittadinanzaIta" , "1", "0", "0"),
new Variabile("Altra cittadinanza", "AltraCittadinanza" , "1", "0", "0"),
new Variabile("Conoscenza lingua italiana", "ConoscenzaLinguaItaliana" , "1", "0", "0"),
new Variabile("Mediatore culturale", "MediatoreCulturale" , "1", "0", "0"),
new Variabile("Stato civile", "StatoCivile", "1", "0", "0"),

new Variabile("Altro stato civile", "AltroStatoCivile", "1", "0", "0"),
new Variabile("Figli", "Figli" , "1", "0", "0"),
new Variabile("Numero figli minorenni", "NumeroFigliMinorenni" , "1", "0", "0"),
new Variabile("Titolo di studio", "TitoloDiStudio" , "1", "0", "0"),
new Variabile("Altro titolo di studio", "AltroTitoloDiStudio" , "1", "0", "0"),

new Variabile("Professione", "Professione", "1", "0", "0"),
new Variabile("Economicamente autonomo", "EconomicamenteAutonomo" , "1", "0", "0"),
new Variabile("Primo accesso pronto soccorso", "PrimoAccessoProntoSoccorso" , "1", "0", "0"),
new Variabile("Numero accessi ripetuti", "NumeroAccessiRipetuti" , "1", "0", "0"),
new Variabile("Sfruttamento", "Sfruttamento" , "1", "0", "0"),

new Variabile("Donna accompagnata InPS", "DonnaAccompagnataInPS", "1", "0", "0"),
new Variabile("Altro donna accompagnata InPS", "AltroDonnaAccompagnataInPS" , "1", "0", "0"),
new Variabile("Motivo Accesso InPS", "MotivoAccessoInPS" , "1", "0", "0"),
new Variabile("Luogo di nascita presunto aggressore", "LuogoPresuntoAggressore" , "1", "1", "0"),
new Variabile("Provincia di nascita presunto aggressore", "ProvinciaNascitaPresuntoAggressore" , "1", "0", "0"),

new Variabile("Comune di nascita presunto aggressore", "ComuneNascitaPresuntoAggressore", "1", "0", "0"),
new Variabile("Titolo di studio presunto aggressore", "TitoloStudioPresuntoAggressore" , "1", "0", "0"),
new Variabile("Altro titolo di studio presunto aggressore", "AltroTitoloStudioPresuntoAggressore" , "1", "0", "0"),
new Variabile("Professione presunto aggressore", "ProfessionePresuntoAggressore" , "1", "0", "0"),
new Variabile("Fascia età presunto aggressore", "FasciaEtaPresuntoAggressore" , "1", "0", "0"),

new Variabile("Rapporto vittima-aggressore", "RapportoVittimaAggressore", "1", "0", "0"),
new Variabile("Tipologia familiare", "TipologiaFamiliare" , "1", "0", "0"),
new Variabile("Altro rapporto vittima-aggressore", "AltroRapportoVittimaAggressore" , "1", "0", "0"),
new Variabile("Aggressore servizi", "AggressoreServizi" , "1", "0", "0"),
new Variabile("Tipologia servizi aggressore", "TipologiaServiziAggressore" , "1", "0", "0"),

new Variabile("Altra tipologia servizi aggressore", "AltraTipologiaServiziAggressore", "1", "0", "0"),
new Variabile("Precedenti penali", "PrecedentiPenali" , "1", "0", "0"),
new Variabile("Brief_risk1", "Brief_risk1" , "1", "0", "0"),
new Variabile("Brief_risk2", "Brief_risk2" , "1", "0", "0"),
new Variabile("Brief_risk3", "Brief_risk3" , "1", "0", "0"),
new Variabile("Brief_risk4", "Brief_risk4" , "1", "0", "0"),
new Variabile("Brief_risk5", "Brief_risk5" , "1", "0", "0"),
new Variabile("Brief_risk6", "Brief_risk6" , "1", "0", "0"),
new Variabile("Brief_risk7", "Brief_risk7" , "1", "0", "0"),

new Variabile("Conviventi", "Conviventi", "1", "0", "0"),
new Variabile("Tipologia violenza", "TipologiaViolenza" , "1", "0", "0"),
new Variabile("Altra violenza riferita", "AltroViolenzaRiferita" , "1", "0", "0"),
new Variabile("Con figli minori", "ConFigliMinori" , "1", "0", "0"),
new Variabile("Codice attributo", "CodiceAttributo" , "1", "0", "0"),

new Variabile("Rete intra ospedaliera", "ReteIntraOspedaliera", "1", "0", "0"),
new Variabile("Specifico rete intra ospedaliera", "SpecificoReteIntraOspedaliera" , "1", "0", "0"),
new Variabile("Rete extra ospedaliera", "ReteExtraOspedaliera" , "1", "0", "0"),
new Variabile("Forze dell'ordine", "ForzaDellOrdine" , "1", "0", "0"),
new Variabile("Tempi di prognosi", "TempiDiPrognosi" , "1", "0", "0"),

new Variabile("Referto", "Referto", "1", "0", "0"),
new Variabile("Attestazioni", "Attestazioni" , "1", "0", "0"),
new Variabile("Codice rosa", "CodiceRosa" , "1", "0", "0"),

];

	function addVariabili() {
			
		for (var i = 0; i < VariabiliArray.length; i++) {
			$(
				'#variabile_select')
				.append(
						"<option value=\""+VariabiliArray[i].nomeDB+"\">"
								+ VariabiliArray[i].nome + "</option>");
			}
	
		for (var i = 0; i < VariabiliArray.length; i++) {
			$(
				'#variabile_select2')
				.append(
						"<option value=\""+VariabiliArray[i].nomeDB+"\">"
								+ VariabiliArray[i].nome + "</option>");
			}
		
		for (var i = 0; i < VariabiliArray.length; i++) {
			$(
				'#variabile_select3')
				.append(
						"<option value=\""+VariabiliArray[i].nomeDB+"\">"
								+ VariabiliArray[i].nome + "</option>");
			}
			
	}
	
	function addChart() 
	{
	    for(var i = 0; i < VariabiliArray.length; i++) 
		{
	    	if(VariabiliArray[i].nomeDB == campo_selezionato)
	    	{
				if(VariabiliArray[i].donut == 1)
				{
					if(chart_selezionato == 1)
						$('#idDonut').show();	
					else if(chart_selezionato == 2)
						$('#idDonut2').show();
					else if(chart_selezionato == 3)
						$('#idDonut3').show();
				}
				
				if(VariabiliArray[i].world_map == 1)
				{
					if(chart_selezionato == 1)
						$('#idWorldMap').show();
					else if(chart_selezionato == 2)
						$('#idWorldMap2').show();
					else if(chart_selezionato == 3)
						$('#idWorldMap3').show();
				}
				
				if(VariabiliArray[i].calendar == 1)
				{
					if(chart_selezionato == 1)
						$('#idCalendar').show();
					if(chart_selezionato == 2)
						$('#idCalendar2').show();
					if(chart_selezionato == 3)
						$('#idCalendar3').show();
				}
	    	}
		
		}
	}
	
	//
	
		function addProvince() {
		var object_support = new Object();
		object_support.action = "viewProvince";
		$
				.ajax({
					url : "../Support",
					type : 'GET',
					data : {
						elements : JSON.stringify(object_support)
					},
					dataType : "JSON",
					contentType : 'application/json',
					mimeType : 'application/json',

					success : function(jsonStr) {
						$('#second_var')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#second_var').append(
									"<option value=\""+jsonStr[ii]+"\">"
											+ jsonStr[ii] + "</option>");
						}
					}
				});

	}
	
	//
	
	function load() {
		addProvince();
		
		addVariabili();
		//
		$('#div_selezioneChart').hide();
		$('#div_selezioneChart2').hide();
		$('#div_selezioneChart3').hide();
		//
		$('#div_chart_identificatio').hide();
		$('#div_chart_identificatio2').hide();
		$('#div_chart_identificatio3').hide();
		//
		$('#idDonut').hide();
		$('#idWorldMap').hide();
		$('#idCalendar').hide();
		//
		$('#idDonut2').hide();
		$('#idWorldMap2').hide();
		$('#idCalendar2').hide();
		//
		$('#idDonut3').hide();
		$('#idWorldMap3').hide();
		$('#idCalendar3').hide();
		//
		$('#div_selezioneSecondaVariabile').hide();
		
		
		
		$(document).ready(
				function() 
				{
					
					$('#chart_select').change(
							function() 
							{
								if (this.value == 'Donut_Chart') 
								{
								$('#div_chart_identificatio').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "donut";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {
										var list = [];
										var list1 = [];
										list1.push("Descrizione");
										list1.push("# Domande");

										list.push(list1);

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											list1.push(jsonStr[i]['descrizione']);
											list1.push(parseInt(jsonStr[i]['count']));
											list.push(list1)
										}

										google.charts.load("current", {
											packages : [ "corechart" ]
										});
										google.charts.setOnLoadCallback(drawChart);
										function drawChart() {
											var data = google.visualization.arrayToDataTable(list);

											var options = {
												title : this.label,
												pieHole : 0.4,
											};
											
											var chart = new google.visualization.PieChart(document.getElementById('chart'));

											chart.draw(data, options);
										
									}
								}
								});
							
							}
							else if (this.value == 'Map_Chart') 
							{
								$('#div_chart_identificatio').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "world_map";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $
								.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {

										var list = [];
										var list1 = [];
										list1.push("Nazione");
										list1.push("#");

										list.push(list1);

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											list1.push(jsonStr[i]['descrizione']);
											list1.push(parseInt(jsonStr[i]['count']));
											list.push(list1)
										}

										//Grafico
										google.charts
												.load(
														'current',
														{
															'packages' : [ 'geochart' ],
															'mapsApiKey' : 'AIzaSyCx60FMdmquosh8goQg6UrjmhTmk81HWMo'
														});
										google.charts.setOnLoadCallback(drawRegionsMap);

										function drawRegionsMap() {
											var data = google.visualization
													.arrayToDataTable(list);
											var options = {
												title : 'Paese di origine delle donne maltrattate/vittime di violenza',
												colorAxis : {
													colors : [ 'cyan', 'blue' ]
												}
											};

											var chart = new google.visualization.GeoChart(document.getElementById('chart'));
											chart.draw(data, options);
										}
									}
								});
							}
							//
							else if (this.value == 'Calendar_Chart') 
							{
								//
								$('#div_chart_identificatio').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "calendar";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $
								.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {

										var list = [];
										var list1 = [];

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											var giorno = jsonStr[i]['giorno'];
											var mese = jsonStr[i]['mese'];
											var anno = jsonStr[i]['anno'];
											list1.push(new Date(anno, mese, giorno));
											list1.push(parseInt(jsonStr[i]['count']));

											list.push(list1)
										}

										//Grafico
										google.charts.load("current", {packages:["calendar"]});
      									google.charts.setOnLoadCallback(drawCalendarChart);

										function drawCalendarChart() {
											var dataTable = new google.visualization.DataTable();
										       dataTable.addColumn({ type: 'date', id: 'Date' });
										       dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
										       
										       dataTable.addRows(list);
										       
											   var chart = new google.visualization.Calendar(document.getElementById('chart'));
												
										       var options = {
										         title: "Numero di domande inviate",
										         height: 350,
										       };

										       chart.draw(dataTable, options);
										}
									}
								});
							}
							//
							else
							{
									$('#div_chart_identificatio').show();
							}
					});
					
					//----------------------------2 Blocco---------------------------------------------------------------
					
					$('#chart_select2').change(
							function() 
							{
								if (this.value == 'Donut_Chart') 
								{
								$('#div_chart_identificatio2').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "donut";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {
										var list = [];
										var list1 = [];
										list1.push("Descrizione");
										list1.push("# Domande");

										list.push(list1);

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											list1.push(jsonStr[i]['descrizione']);
											list1.push(parseInt(jsonStr[i]['count']));
											list.push(list1)
										}

										google.charts.load("current", {
											packages : [ "corechart" ]
										});
										google.charts.setOnLoadCallback(drawChart);
										function drawChart() {
											var data = google.visualization.arrayToDataTable(list);

											var options = {
												title : this.label,
												pieHole : 0.4,
											};
											
											var chart = new google.visualization.PieChart(document.getElementById('chart2'));

											chart.draw(data, options);
										
									}
								}
								});
							
							}
							else if (this.value == 'Map_Chart') 
							{
								$('#div_chart_identificatio2').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "world_map";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $
								.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {

										var list = [];
										var list1 = [];
										list1.push("Nazione");
										list1.push("#");

										list.push(list1);

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											list1.push(jsonStr[i]['descrizione']);
											list1.push(parseInt(jsonStr[i]['count']));
											list.push(list1)
										}

										//Grafico
										google.charts
												.load(
														'current',
														{
															'packages' : [ 'geochart' ],
															'mapsApiKey' : 'AIzaSyCx60FMdmquosh8goQg6UrjmhTmk81HWMo'
														});
										google.charts.setOnLoadCallback(drawRegionsMap);

										function drawRegionsMap() {
											var data = google.visualization
													.arrayToDataTable(list);
											var options = {
												title : 'Paese di origine delle donne maltrattate/vittime di violenza',
												colorAxis : {
													colors : [ 'cyan', 'blue' ]
												}
											};

											var chart = new google.visualization.GeoChart(document.getElementById('chart2'));
											chart.draw(data, options);
										}
									}
								});
							}
							//
							else if (this.value == 'Calendar_Chart') 
							{
								//
								$('#div_chart_identificatio2').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "calendar";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $
								.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {

										var list = [];
										var list1 = [];

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											var giorno = jsonStr[i]['giorno'];
											var mese = jsonStr[i]['mese'];
											var anno = jsonStr[i]['anno'];
											list1.push(new Date(anno, mese, giorno));
											list1.push(parseInt(jsonStr[i]['count']));

											list.push(list1)
										}

										//Grafico
										google.charts.load("current", {packages:["calendar"]});
      									google.charts.setOnLoadCallback(drawCalendarChart);

										function drawCalendarChart() {
											var dataTable = new google.visualization.DataTable();
										       dataTable.addColumn({ type: 'date', id: 'Date' });
										       dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
										       
										       dataTable.addRows(list);
										       
											   var chart = new google.visualization.Calendar(document.getElementById('chart2'));
												
										       var options = {
										         title: "Numero di domande inviate",
										         height: 350,
										       };

										       chart.draw(dataTable, options);
										}
									}
								});
							}
							//
							else
							{
									$('#div_chart_identificatio2').show();
							}
					});
					
					
					
					//---------------------------------------------------------------------------------------------------
					
					//----------------------------3 Blocco---------------------------------------------------------------
					$('#chart_select3').change(
							function() 
							{
								if (this.value == 'Donut_Chart') 
								{
								$('#div_chart_identificatio3').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "donut";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {
										var list = [];
										var list1 = [];
										list1.push("Descrizione");
										list1.push("# Domande");

										list.push(list1);

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											list1.push(jsonStr[i]['descrizione']);
											list1.push(parseInt(jsonStr[i]['count']));
											list.push(list1)
										}

										google.charts.load("current", {
											packages : [ "corechart" ]
										});
										google.charts.setOnLoadCallback(drawChart);
										function drawChart() {
											var data = google.visualization.arrayToDataTable(list);

											var options = {
												title : this.label,
												pieHole : 0.4,
											};
											
											var chart = new google.visualization.PieChart(document.getElementById('chart3'));

											chart.draw(data, options);
										
									}
								}
								});
							
							}
							else if (this.value == 'Map_Chart') 
							{
								$('#div_chart_identificatio3').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "world_map";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $
								.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {

										var list = [];
										var list1 = [];
										list1.push("Nazione");
										list1.push("#");

										list.push(list1);

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											list1.push(jsonStr[i]['descrizione']);
											list1.push(parseInt(jsonStr[i]['count']));
											list.push(list1)
										}

										//Grafico
										google.charts
												.load(
														'current',
														{
															'packages' : [ 'geochart' ],
															'mapsApiKey' : 'AIzaSyCx60FMdmquosh8goQg6UrjmhTmk81HWMo'
														});
										google.charts.setOnLoadCallback(drawRegionsMap);

										function drawRegionsMap() {
											var data = google.visualization
													.arrayToDataTable(list);
											var options = {
												title : 'Paese di origine delle donne maltrattate/vittime di violenza',
												colorAxis : {
													colors : [ 'cyan', 'blue' ]
												}
											};

											var chart = new google.visualization.GeoChart(document.getElementById('chart3'));
											chart.draw(data, options);
										}
									}
								});
							}
							//
							else if (this.value == 'Calendar_Chart') 
							{
								//
								$('#div_chart_identificatio3').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "calendar";
								question.campo = campo_selezionato;
								question.provincia = "";

								var request = $
								.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {

										var list = [];
										var list1 = [];

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											var giorno = jsonStr[i]['giorno'];
											var mese = jsonStr[i]['mese'];
											var anno = jsonStr[i]['anno'];
											list1.push(new Date(anno, mese, giorno));
											list1.push(parseInt(jsonStr[i]['count']));

											list.push(list1)
										}

										//Grafico
										google.charts.load("current", {packages:["calendar"]});
      									google.charts.setOnLoadCallback(drawCalendarChart);

										function drawCalendarChart() {
											var dataTable = new google.visualization.DataTable();
										       dataTable.addColumn({ type: 'date', id: 'Date' });
										       dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
										       
										       dataTable.addRows(list);
										       
											   var chart = new google.visualization.Calendar(document.getElementById('chart3'));
												
										       var options = {
										         title: "Numero di domande inviate",
										         height: 350,
										       };

										       chart.draw(dataTable, options);
										}
									}
								});
							}
							//
							else
							{
									$('#div_chart_identificatio3').show();
							}
					});
					
					
					
					//---------------------------------------------------------------------------------------------------
					
					
					//----------------------------4 Blocco---------------------------------------------------------------
					$('#second_var').change(
							function() 
							{
								$('#div_chart_istogramma').show();
								question = {};
								question.action = "report";
								question.type = "hospital";
								question.status = "inviata";
								question.description = "istogramma";
								question.campo = "ServiziSocialiProvincia";
								question.provincia = this.value;

								var request = $.ajax({
									url : "../Question",
									type : "GET",
									data : {
										elements : JSON.stringify(question)
									},
									dataType : "JSON",
									contentType : 'application/json',
									mimeType : 'application/json',

									success : function(jsonStr) {
										var list = [];
										var list1 = [];
										list1.push("Descrizione");
										list1.push("Anno");

										list.push(list1);

										for (i = 0; i < jsonStr.length; i++) {
											list1 = [];
											list1.push(jsonStr[i]['descrizione']);
											list1.push(parseInt(jsonStr[i]['count']));
											
											list.push(list1)
										}

										google.charts.load("current", {packages:["corechart"]});
									      google.charts.setOnLoadCallback(drawChart);
									      function drawChart() {
									        var data = google.visualization.arrayToDataTable(list);
									        
									        var options = {
									                title: 'Numero domande in base all anno',
									                legend: { position: 'none' },
									              };

									        var chart = new google.visualization.Histogram(document.getElementById('istogramma'));
									        chart.draw(data, options);
									      
										}
									} 
								});
							});
					
					
					
					//---------------------------------------------------------------------------------------------------

					
					$('#variabile_select').change(
							function() 
							{
								if (this.value != 'Scegli...') 
								{	
									//
									$('#idDonut').hide();
									$('#idWorldMap').hide();
									$('#idCalendar').hide();
									//
									$('#div_selezioneChart').show();
									$('#chart_select').val("Scegli...");
									$('#div_chart_identificatio').hide();
									campo_selezionato = this.value;
									chart_selezionato = 1;
									addChart();
								
								}
								else
								{
									$('#div_selezioneChart').hide();
									$('#div_chart_identificatio').hide();
								}
							});
					
					$('#variabile_select2').change(
							function() 
							{
								if (this.value != 'Scegli...') 
								{	
									//
									$('#idDonut2').hide();
									$('#idWorldMap2').hide();
									$('#idCalendar2').hide();
									//
									$('#div_selezioneChart2').show();
									$('#chart_select2').val("Scegli...");
									$('#div_chart_identificatio2').hide();
									campo_selezionato = this.value;
									chart_selezionato = 2;
									addChart();
								
								}
								else
								{
									$('#div_selezioneChart2').hide();
									$('#div_chart_identificatio2').hide();
								}
							});
					
					$('#variabile_select3').change(
							function() 
							{
								if (this.value != 'Scegli...') 
								{	
									//
									$('#idDonut3').hide();
									$('#idWorldMap3').hide();
									$('#idCalendar3').hide();
									//
									$('#div_selezioneChart3').show();
									$('#chart_select3').val("Scegli...");
									$('#div_chart_identificatio3').hide();
									campo_selezionato = this.value;
									chart_selezionato = 3;
									addChart();
								
								}
								else
								{
									$('#div_selezioneChart3').hide();
									$('#div_chart_identificatio3').hide();
								}
							});
					
					$('#first_var').change(
							function() 
							{
								if (this.value != 'Scegli...') 
								{	
									$('#div_selezioneSecondaVariabile').show();
									$('#second_var').val("Scegli...");
									$('#div_chart_istogramma').hide();
								}
								else
								{
									$('#div_chart_istogramma').hide();
									$('#div_selezioneSecondaVariabile').hide();
								}
							});
					
				});									

}
	
	
</script>

  <!-- 
  <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCmHJRiCR5sZ2jTMxkTIqZDQa6GV4hMzYg&callback=initMap"></script>	
	-->
	
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
          <!-- profile info & task notification -->
        </div>
      </div>
     
      <!-- header area end -->
      <!-- page title area start -->
      <div class="page-title-area">
        <div class="row align-items-center">
          <div class="col-sm-6">
            <div class="breadcrumbs-area clearfix">
              <h4 class="page-title pull-left">Dashboard</h4>
              <ul class="breadcrumbs pull-left">
                <li><a href="home.jsp">Home</a></li>
                <li><span>Statistiche</span></li>
              </ul>
            </div>
          </div>
          <div class="col-sm-6 clearfix">
            <%@include file="common/user.jsp"%>
          </div>
        </div>
      </div>
      <!-- page title area end -->
      <div class="main-content-inner">
        <!-- pie chart start -->
        <div class="row">
          
          <!-- Primo Blocco, Alto Sinistra -->
           <div class="form-group" id="div_block_chart1"  style="width: 515px; height: 515px; background-color:white; border: 1px solid #201a56; margin-top:5px;">
          		<div class="form-group">
               		<div class="form-holder">
				           <div class="form-group" id="div_selezioneVariabile">
				            <div class="form-group">
				                      <div class="form-holder">
				                        <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Variabile</span>&nbsp;</label> 
				                        <select class="custom-select" id="variabile_select" style="width: 500px; margin-left:7px;">
				                          <option  value="Scegli..." selected>Scegli</option> 
				                        </select>
				                      </div>
				             </div>
				            </div>
           
         
               
		         		 <div class="form-group" id="div_selezioneChart">
		          	  		<div class="form-group">
		              			 <div class="form-holder">
		                 			 <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Tipologia charts</span>&nbsp;</label> 
		                 			 <select class="custom-select" id="chart_select" style="width: 500px; margin-left:7px;">
			                   			 <option value="Scegli..." selected>Scegli</option>
			                    		 <option id= "idDonut" value="Donut_Chart">Donut Chart</option>
			                    		 <option id= "idWorldMap" value="Map_Chart">World Map Chart</option>
			                    		 <option id= "idCalendar" value="Calendar_Chart">Calendar Chart</option>
		                    		 </select>
		                		</div>
		            		</div>
		            	</div>
                  
			 		  <div id="div_chart_identificatio">
			
			              		<div id="chart" style="width: 470px; height: 250px;"></div>
			            	
			          </div>
					</div>
				</div>
			  </div>
		
		          <!-- Secondo Blocco, Alto Destra -->
           <div class="form-group" id="div_block_chart1"  style="width: 515px; height: 515px; background-color:white; border: 1px solid #201a56; margin-top:5px;">
          		<div class="form-group">
               		<div class="form-holder">
				           <div class="form-group" id="div_selezioneVariabile">
				            <div class="form-group">
				                      <div class="form-holder">
				                        <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Variabile</span>&nbsp;</label> 
				                        <select class="custom-select" id="variabile_select2" style="width: 500px; margin-left:7px;">
				                          <option  value="Scegli..." selected>Scegli</option> 
				                        </select>
				                      </div>
				             </div>
				            </div>
           
         
               
		         		 <div class="form-group" id="div_selezioneChart2">
		          	  		<div class="form-group">
		              			 <div class="form-holder">
		                 			 <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Tipologia charts</span>&nbsp;</label> 
		                 			 <select class="custom-select" id="chart_select2" style="width: 500px; margin-left:7px;">
			                   			 <option value="Scegli..." selected>Scegli</option>
			                    		 <option id= "idDonut2" value="Donut_Chart">Donut Chart</option>
			                    		 <option id= "idWorldMap2" value="Map_Chart">World Map Chart</option>
			                    		 <option id= "idCalendar2" value="Calendar_Chart">Calendar Chart</option>
		                    		 </select>
		                		</div>
		            		</div>
		            	</div>
                  
			 		  <div id="div_chart_identificatio2">
			
			              		<div id="chart2" style="width: 470px; height: 250px;"></div>
			            	
			          </div>
					</div>
				</div>
			  </div>
			  
	 		          <!-- Terzo Blocco, Basso Sinistra -->
           <div class="form-group" id="div_block_chart1"  style="width: 515px; height: 515px; background-color:white; border: 1px solid #201a56;">
          		<div class="form-group">
               		<div class="form-holder">
				           <div class="form-group" id="div_selezioneVariabile">
				            <div class="form-group">
				                      <div class="form-holder">
				                        <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Variabile</span>&nbsp;</label> 
				                        <select class="custom-select" id="variabile_select3" style="width: 500px; margin-left:7px;">
				                          <option  value="Scegli..." selected>Scegli</option> 
				                        </select>
				                      </div>
				             </div>
				            </div>
          
		      <div class="form-group" id="div_selezioneChart3">
		          	  		<div class="form-group">
		              			 <div class="form-holder">
		                 			 <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Tipologia charts</span>&nbsp;</label> 
		                 			 <select class="custom-select" id="chart_select3" style="width: 500px; margin-left:7px;">
			                   			 <option value="Scegli..." selected>Scegli</option>
			                    		 <option id= "idDonut3" value="Donut_Chart">Donut Chart</option>
			                    		 <option id= "idWorldMap3" value="Map_Chart">World Map Chart</option>
			                    		 <option id= "idCalendar3" value="Calendar_Chart">Calendar Chart</option>
		                    		 </select>
		                		</div>
		            		</div>
		            	</div>
                  
			 		  <div id="div_chart_identificatio3">
			
			              		<div id="chart3" style="width: 470px; height: 250px;"></div>
			            	
			          </div>
					</div>
				</div>
			  </div>
          
          
           <!-- Secondo Blocco, Basso Destra -->
            <!-- Istogramma Variabile doppia -->
           <div class="form-group" id="div_block_chart1"  style="width: 515px; height: 515px; background-color:white; border: 1px solid #201a56;">
          		<div class="form-group">
               		<div class="form-holder">
				           <div class="form-group" id="div_selezioneVariabile">
				            <div class="form-group">
				                      <div class="form-holder">
				                        <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Variabile</span>&nbsp;</label> 
				                        <select class="custom-select" id="first_var" style="width: 500px; margin-left:7px;">
				                          <option  value="Scegli..." selected>Scegli</option>
				                          <option  value="Provincia">Provincia</option>  
				                        </select>
				                      </div>
				             </div>
				            </div>
           
         
               
		         		 <div class="form-group" id="div_selezioneSecondaVariabile">
		          	  		<div class="form-group">
		              			 <div class="form-holder">
		                 			 <label class="form-label" style="font-size: medium; margin-left:10px; margin-top:10px;"><span class="h6s">Seconda Variabile</span>&nbsp;</label> 
		                 			 <select class="custom-select" id="second_var" style="width: 500px; margin-left:7px;">
			                   			 <option value="Scegli..." selected>Scegli</option>		           
		                    		 </select>
		                		</div>
		            		</div>
		            	</div>
                  
			 		  <div id="div_chart_istogramma">
			
			              		<div id="istogramma" style="width: 470px; height: 250px;"></div>
			            	
			          </div>
					</div>
				</div>
			  </div>
        
        <!-- pie chart end -->
      </div>
    </div>
    </div>
    </div> 
    <%@include file="../common/footer.jsp"%>
     
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
