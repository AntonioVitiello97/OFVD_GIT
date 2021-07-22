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
uri = uri + "/cav/";
AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");

if (account == null || (!account.isCavUser())) {
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
<!--  wizard library -->
<!-- JSpdf -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.4.1/jspdf.debug.js"></script>
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet" href="../assets/wizard_layout/fonts/material-design-iconic-font/css/material-design-iconic-font.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="../assets/wizard_layout/css/style.css">
<!-- calendar  -->
<script src="https://unpkg.com/gijgo@1.9.11/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.11/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<!-- end calendar -->
<script src="../assets/js/custom.js"></script>
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

	var index;
	var question = new Object();
	question.action = "compiled";
	var print = "";

	//solo caratteri, di cui minimo 2
	var re = new RegExp("^([a-z A-Z]{2,})$");
	//10 numeri
	var re_cel = new RegExp("^([0-9]{9,10})$");
	//data
	var re_data = new RegExp("^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$");
	//numeri
	var re_number = new RegExp("^([1-9]{1,})$");

	var re_number1 = new RegExp("^([0-9]{1,})$");

	//indirizzo
	//var re_indirizzo= new RegExp("^([a-z ./-A-Z])*([0-9])*$");

	function alertSend() {
		$("#button_invia_indietro *").hide();

		$("#question1 *").prop('disabled', true);
		$("#question2 *").prop('disabled', true);
		$("#question3 *").prop('disabled', true);
		$("#question4 *").prop('disabled', true);
		$("#question5 *").prop('disabled', true);

		$("#question1").show();
		$("#question2").show();
		$("#question3").show();
		$("#question4").show();
		$("#question5").show();		
		
		
		//$("#button_invia_indietro *").prop('disabled', true);
		//$("#question5 *").prop('disabled', true);
		document.getElementById('alertSend').removeAttribute('hidden');
		window.scrollTo(0, 0);
	}

	function confermaAlertSend() {
		var url = "inviate.jsp";
		$(location).attr('href', url);
	}

	function removeAlert() {
		question.action = "changeState";

		save();
		//document.getElementById('alertSend').setAttribute('hidden', 'true');
		var url = "bozze.jsp";
		$(location).attr('href', url);
	}

	function load() {
		$('#cittadinanza_select').hide();
		$('#div_mediatore_culturale').hide();
		$('#div_altroTitoloDiStudio').hide();
		$('#div_eta_figli').hide();
		$('#div_altro_statoCivile').hide();
		$('#div_altro_donnaAccompagnataInPS').hide();
		$('#div_violenzaRiferita').hide();
		$('#accessi_ripetuti').hide();
		$('#div_altroTitoloDiStudiAggressore').hide();
		$('#div_altroRapportoVittimaAggressore').hide();
		$('#div_altroTipologiaServiziAggressore').hide();
		$('#div_tipologia_servizi_aggressore').hide();
		$('#div_familiare').hide();
		$('#div_sfruttamento').hide();

		//Aggiungo da qui

		$('#div_altro_ruoloCompilatore').hide();
		$('#div_altro_identificativoServizio').hide();
		$('#div_centrodiprimaassistenzapsicologica').hide();
		$('#div_cav').hide();
		$('#div_sportelloDiAscolto').hide();
		$('#div_sportelloDiAscoltoLuogo').hide();
		$('#div_donnaaccompagnata_da_altre_persone').hide();
		$('#div_donnaaccompagnata_prontosoccorso').hide();
		$('#div_donnaaccompagnata_forzedellordine').hide();
		$('#div_forze_dell_ordine_denuncia').hide();
		$('#div_tempo_separazione').hide();
		$('#div_motivoRitiroDenuncia_select').hide();
		$('#div_altro_ValutazioneStatoBisogno').hide();
		$('#prestazioniEffettuate').hide();
		$('#div_altro_stato_occupazionale_donna').hide();
		$('#div_altro_stato_occupazionale_aggressore').hide();
		$('#div_attivazioneReteOspedale').hide();
		$('#div_attivazioneRete_forzedellordine').hide();
		$('#div_servizioSanitario').hide();
		$('#div_serviziSociali').hide();

		//A qui

		//question4 hide
		$("#div_nome_presunto_aggressore").hide();

		$("#div_cognome_presunto_aggressore").hide();

		$("#div_data_nascita_presunto_aggressore").hide();

		$("#div_luogo_presunto_aggressore_select").hide();

		$("#div_provincia_nascita_presunto_aggressore_select").hide();

		$("#div_comune_nascita_presunto_aggressore_select").hide();

		$("#div_indirizzo_presunto_aggressore").hide();

		$("#div_telefono_presunto_aggressore").hide();

		$("#div_selectTitoloDiStudioAggressore").hide();

		$("#div_selectProfessioneAggressore").hide();

		$("#div_fascia_di_eta_aggressore").hide();

		$("#div_rapporto_vittima_autore_violenza").hide();

		$("#div_aggressore_servizi").hide();

		$("#div_tipologia_servizi_aggressore").hide();

		$("#div_violenza_assistitaosubita").hide();

		$("#div_precedenti_penali").hide();
		//end question 4 

		var d = new Date();
		var timestamp = d.getTime();
		$('#identificativo_scheda').val(timestamp);
		$('#id_scheda').text(timestamp);

		$('#data_compilazione').val(
				d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear());

		//setto le variabili globali
		index = 1;
		question = new Object();
		question.action = "compiled";
		print = "";

		$("#backbutton").hide();

		$("#question1").show();
		$("#question2").hide();
		$("#question3").hide();
		$("#question4").hide();
		$("#question5").hide();

		load_color_wizard();

		addProvince();
	}

	function load_color_wizard() {
		$('#button_question1').removeClass('btn btn-rounded btn-light mb-3')
				.addClass('btn btn-rounded btn-secondary mb-3');		
		$('#button_question2').removeClass('btn btn-rounded btn-secondary mb-3')
				.addClass('btn btn-rounded btn-light mb-3');
		$('#button_question3').removeClass('btn btn-rounded btn-secondary mb-3')
				.addClass('btn btn-rounded btn-light mb-3');
		$('#button_question4').removeClass('btn btn-rounded btn-secondary mb-3')
				.addClass('btn btn-rounded btn-light mb-3');
		$('#button_question5').removeClass('btn btn-rounded btn-secondary mb-3')
				.addClass('btn btn-rounded btn-light mb-3');
	}

	function checkTrace(idname) {
		var trace = new Object();

		var nome = $("#nome_vittima").val();
		var cognome = $("#cognome_vittima").val();
		var nascita = $("#data_nascita").val();
		var luogo = $("#luogo_select option:selected").text();

		if (nome != "" && cognome != "" && nascita != ""
				&& luogo != "Scegli...") {
			trace.nome = nome;
			trace.cognome = cognome;
			trace.nascita = nascita;
			trace.luogo = luogo;

			$("#trace_result"+idname).html("");
			$("#trace_msg"+idname).text("");

			var curr_id = $('#identificativo_scheda').val();
			
			$
					.ajax({
						url : "../QuestionTrace",
						type : 'GET',
						data : {
							elements : JSON.stringify(trace),
							id : curr_id
						},
						dataType : "JSON",
						contentType : 'application/json',
						mimeType : 'application/json',

						success : function(jsonStr) {
							if (jsonStr.length > 0) {
								var bod = '<div class="single-table">'
										+ '<div class="table-responsive">'
										+ '<table class="table table-hover progress-table text-center">'
										+ '<thead class="text-uppercase">'
										+ '<tr>'
										+ '<th scope="col">N&deg;</th>'
										+ '<th scope="col">ID</th>'
										+ '<th scope="col">Tipo</th>'
										+ '<th data-dateformat="DD/MM/YYYY" scope="col">In data</th>'
										+ '<th scope="col">Stato</th>'
										+ '</tr>' + '</thead>' + '<tbody>';

								for (var i = 0; i < jsonStr.length; i++) {
									var key = jsonStr[i];
									bod = bod
											+ '<tr id="'+key["answer1"]+'">'
											+ '<td>'
											+ (i + 1)
											+ '</td>'
											+ '<td>'
											+ key["answer1"]
											+ '</td>'
											+ '<td><span style="text-transform: capitalize;">'
											+ (key["type"] == "cav" ? "Servizio" : "Ospedale")
											+ '</span></td>'
											+ '<td>'
											+ key["answer2"]
											+ '</span></td>'
											+ '<td><span class="status-p bg-dark">'
											+ key["status"] + '</span></td>'
											+ '</tr>';
								}

								bod = bod + '</tbody>' + '</table>' + '</div>'
										+ '</div>';

								$("#trace_result"+idname).html(bod);
							}

							$("#trace_msg"+idname).text(
									jsonStr.length + ' schede presenti');
							$("#trace_msg"+idname).css("color", "#ffc107");
						}
					});

		} else {
			$("#trace_msg"+idname).text(
					'Inserire il nome, cognome, data e luogo di nascita');
			$("#trace_msg"+idname).css("color", "red");
		}
	}
	
	
	function save() {
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

		prosegui();
	}

	function addComuni() {
		if ($("#provincia_nascita_select option:checked").text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#provincia_nascita_select option:checked").text();
			object_support.action = "viewComuni";
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
							$('#comune_nascita_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$('#comune_nascita_select').append(
										"<option value=\""+jsonStr[ii]+"\">"
												+ jsonStr[ii] + "</option>");

							}

						}
					});

		} else {
			$('#comune_nascita_select').empty().append(
					"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addProvince() {
		var object_support = new Object();
		object_support.provincia = $("#provincia_nascita_select option:checked")
				.text();
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
						$('#provincia_prontosoccorso_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#provincia_prontosoccorso_select').append(
									"<option value=\""+jsonStr[ii]+"\">"
											+ jsonStr[ii] + "</option>");
						}
						$('#provincia_cav_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#provincia_cav_select').append(
									"<option value=\""+jsonStr[ii]+"\">"
											+ jsonStr[ii] + "</option>");
						}
						$('#provincia_sportellodiascolto_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#provincia_sportellodiascolto_select').append(
									"<option value=\""+jsonStr[ii]+"\">"
											+ jsonStr[ii] + "</option>");
						}
						$('#provincia_nascita_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#provincia_nascita_select').append(
									"<option value=\""+jsonStr[ii]+"\">"
											+ jsonStr[ii] + "</option>");
						}

						$('#provincia_donnaaccompagnata_forzedellordine_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$(
									'#provincia_donnaaccompagnata_forzedellordine_select')
									.append(
											"<option value=\""+jsonStr[ii]+"\">"
													+ jsonStr[ii] + "</option>");
						}

						$('#provincia_donnaaccompagnata_prontosoccorso_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$(
									'#provincia_donnaaccompagnata_prontosoccorso_select')
									.append(
											"<option value=\""+jsonStr[ii]+"\">"
													+ jsonStr[ii] + "</option>");
						}

						$('#provincia_nascita_presunto_aggressore_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#provincia_nascita_presunto_aggressore_select')
									.append(
											"<option value=\""+jsonStr[ii]+"\">"
													+ jsonStr[ii] + "</option>");
						}

						$('#provincia_denuncia_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#provincia_denuncia_select').append(
									"<option value=\""+jsonStr[ii]+"\">"
											+ jsonStr[ii] + "</option>");
						}

						$('#attivazioneRete_provincia_prontosoccorso_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$(
									'#attivazioneRete_provincia_prontosoccorso_select')
									.append(
											"<option value=\""+jsonStr[ii]+"\">"
													+ jsonStr[ii] + "</option>");
						}

						$('#attivazioneRete_provincia_forzedellordine_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");
						for (var ii = 0; ii < jsonStr.length; ii++) {
							$(
									'#attivazioneRete_provincia_forzedellordine_select')
									.append(
											"<option value=\""+jsonStr[ii]+"\">"
													+ jsonStr[ii] + "</option>");
						}
					}
				});

	}

	function addattivazioneRete_forzedellordine() {
		if ($(
				"#attivazioneRete_provincia_forzedellordine_select option:checked")
				.text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#attivazioneRete_provincia_forzedellordine_select option:checked")
					.text();
			object_support.action = "viewComuni";
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

							$('#attivazioneRete_comune_forzedellordine_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$(
										'#attivazioneRete_comune_forzedellordine_select')
										.append(
												"<option value=\""+jsonStr[ii]+"\">"
														+ jsonStr[ii]
														+ "</option>");

							}

						}
					});

		} else {
			$('#attivazioneRete_provincia_forzedellordine_select')
					.empty()
					.append(
							"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComuniAttivazioneReteProntoSoccorso() {
		if ($("#attivazioneRete_provincia_prontosoccorso_select option:checked")
				.text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#attivazioneRete_provincia_prontosoccorso_select option:checked")
					.text();
			object_support.action = "viewComuni";
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
							$('#attivazioneRete_comune_prontosoccorso_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$(
										'#attivazioneRete_comune_prontosoccorso_select')
										.append(
												"<option value=\""+jsonStr[ii]+"\">"
														+ jsonStr[ii]
														+ "</option>");

							}

						}
					});
		} else {
			$('#attivazioneRete_comune_prontosoccorso_select').empty().append(
					"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComuniDenuncia() {

		if ($("#provincia_denuncia_select option:checked").text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#provincia_denuncia_select option:checked").text();
			object_support.action = "viewComuni";
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
							$('#comune_denuncia_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$('#comune_denuncia_select').append(
										"<option value=\""+jsonStr[ii]+"\">"
												+ jsonStr[ii] + "</option>");

							}
						}
					});
		} else {
			$('#comune_denuncia_select').empty().append(
					"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComunidonnaaccompagnata_prontosoccorso() {
		if ($(
				"#provincia_donnaaccompagnata_prontosoccorso_select option:checked")
				.text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#provincia_donnaaccompagnata_prontosoccorso_select option:checked")
					.text();
			object_support.action = "viewComuni";
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

							$('#comune_donnaaccompagnata_prontosoccorso_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$(
										'#comune_donnaaccompagnata_prontosoccorso_select')
										.append(
												"<option value=\""+jsonStr[ii]+"\">"
														+ jsonStr[ii]
														+ "</option>");

							}

						}
					});
		} else {
			$('#comune_donnaaccompagnata_prontosoccorso_select')
					.empty()
					.append(
							"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComuniDonnaaccompagnata_forzedellordine() {
		if ($(
				"#provincia_donnaaccompagnata_forzedellordine_select option:checked")
				.text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#provincia_donnaaccompagnata_forzedellordine_select option:checked")
					.text();
			object_support.action = "viewComuni";
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

							$(
									'#comune_donnaaccompagnata_forzedellordine_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$(
										'#comune_donnaaccompagnata_forzedellordine_select')
										.append(
												"<option value=\""+jsonStr[ii]+"\">"
														+ jsonStr[ii]
														+ "</option>");

							}

						}
					});
		} else {
			$('#comune_donnaaccompagnata_forzedellordine_select')
					.empty()
					.append(
							"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComuniSportelloDiAscolto() {
		if ($("#provincia_sportellodiascolto_select option:checked").text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#provincia_sportellodiascolto_select option:checked")
					.text();
			object_support.action = "viewComuni";
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
							$('#comune_sportellodiascolto_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$('#comune_sportellodiascolto_select').append(
										"<option value=\""+jsonStr[ii]+"\">"
												+ jsonStr[ii] + "</option>");

							}

						}
					});
		} else {
			$('#comune_sportellodiascolto_select').empty().append(
					"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComuniCAV() {
		if ($("#provincia_cav_select option:checked").text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $("#provincia_cav_select option:checked")
					.text();
			object_support.action = "viewComuni";
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

							$('#comune_cav_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$('#comune_cav_select').append(
										"<option value=\""+jsonStr[ii]+"\">"
												+ jsonStr[ii] + "</option>");

							}

						}
					});
		} else {
			$('#comune_cav_select').empty().append(
					"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComuniProntoSoccorso() {
		if ($("#provincia_prontosoccorso_select option:checked").text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#provincia_prontosoccorso_select option:checked").text();
			object_support.action = "viewComuni";
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
							$('#comune_prontosoccorso_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$('#comune_prontosoccorso_select').append(
										"<option value=\""+jsonStr[ii]+"\">"
												+ jsonStr[ii] + "</option>");
							}
						}
					});
		} else {
			$('#comune_prontosoccorso_select').empty().append(
					"<option value=\"Scegli...\" selected>Scegli...</option>");

		}
	}

	function addComuniPresunto() {
		if ($("#provincia_nascita_presunto_aggressore_select option:checked")
				.text() != "Scegli...") {
			var object_support = new Object();
			object_support.provincia = $(
					"#provincia_nascita_presunto_aggressore_select option:checked")
					.text();
			object_support.action = "viewComuni";
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
							$('#comune_nascita_presunto_aggressore_select')
									.empty()
									.append(
											"<option value=\"Scegli...\" selected>Scegli...</option>");

							for (var ii = 0; ii < jsonStr.length; ii++) {
								$('#comune_nascita_presunto_aggressore_select')
										.append(
												"<option value=\""+jsonStr[ii]+"\">"
														+ jsonStr[ii]
														+ "</option>");
							}
						}
					});

		} else {
			$('#comune_nascita_presunto_aggressore_select').empty().append(
					"<option value=\"Scegli...\" selected>Scegli...</option>");

		}

	}

	function prosegui() {
		if (index >= 1 && index <= 5)
			index++;

		if (index == 1) {
			$("#backbutton").hide();
		} else {
			$("#backbutton").show();
		}

		switch (index) {
		case 1:
			$("#question5").hide();
			$("#question1").show();
			break;
		case 2:
			$("#question1").hide();
			$("#question2").show();
			$('#button_question2')
					.removeClass('btn btn-rounded btn-light mb-3').addClass(
							'btn btn-rounded btn-secondary mb-3');
			break;

		case 3:
			$("#question2").hide();
			$("#question3").show();
			$('#button_question3')
					.removeClass('btn btn-rounded btn-light mb-3').addClass(
							'btn btn-rounded btn-secondary mb-3');
			break;

		case 4:
			$("#question3").hide();
			$("#question4").show();
			$('#button_question4')
					.removeClass('btn btn-rounded btn-light mb-3').addClass(
							'btn btn-rounded btn-secondary mb-3');
			break;

		case 5:
			$("#question4").hide();
			$("#question5").show();
			$('#button_question5')
					.removeClass('btn btn-rounded btn-light mb-3').addClass(
							'btn btn-rounded btn-secondary mb-3');
			break;

		case 6:
			alertSend();
			break;

		default:
			load();
			break;
		}
	}

	function indietro() {
		if (index > 1 && index <= 5)
			index--;

		if (index == 1) {
			$("#backbutton").hide();
		} else {
			$("#backbutton").show();
		}

		switch (index) {
		case 1:
			$("#question2").hide();
			$("#question1").show();
			$('#button_question2').removeClass(
					'btn btn-rounded btn-secondary mb-3').addClass(
					'btn btn-rounded btn-light mb-3');
			break;

		case 2:
			$("#question3").hide();
			$("#question2").show();
			$('#button_question3').removeClass(
					'btn btn-rounded btn-secondary mb-3').addClass(
					'btn btn-rounded btn-light mb-3');

			break;

		case 3:
			$("#question4").hide();
			$("#question3").show();
			$('#button_question4').removeClass(
					'btn btn-rounded btn-secondary mb-3').addClass(
					'btn btn-rounded btn-light mb-3');
			break;

		case 4:
			$("#question5").hide();
			$("#question4").show();
			$('#button_question5').removeClass(
					'btn btn-rounded btn-secondary mb-3').addClass(
					'btn btn-rounded btn-light mb-3');
			break;
		}
	}

	//Inserisco qui
	$(document)
			.ready(
					function() {

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

						addCountryOption('luogo_select');
						addCountryOption('cittadinanza_select');
						addCountryOption('luogo_presunto_aggressore_select');

						addFirstAidOption('prontosoccorso_select');
						addFirstAidOption('donnaaccompagnata_prontosoccorso_select');
						addFirstAidOption('attivazioneRete_prontosoccorso_select');

						$('input:radio[name=conosci_aggressore]')
								.change(
										function() {
											if (this.value == 'Si') {

												$(
														"#div_nome_presunto_aggressore")
														.show();

												$(
														"#div_cognome_presunto_aggressore")
														.show();

												$(
														"#div_data_nascita_presunto_aggressore")
														.show();

												$(
														"#div_luogo_presunto_aggressore_select")
														.show();

												$(
														"#div_provincia_nascita_presunto_aggressore_select")
														.show();

												$(
														"#div_comune_nascita_presunto_aggressore_select")
														.show();

												$(
														"#div_indirizzo_presunto_aggressore")
														.show();

												$(
														"#div_telefono_presunto_aggressore")
														.show();

												$(
														"#div_selectTitoloDiStudioAggressore")
														.show();

												$(
														"#div_selectProfessioneAggressore")
														.show();

												$(
														"#div_fascia_di_eta_aggressore")
														.show();

												$(
														"#div_rapporto_vittima_autore_violenza")
														.show();

												$("#div_aggressore_servizi")
														.show();

												$(
														"#div_violenza_assistitaosubita")
														.show();

												$("#div_precedenti_penali")
														.show();

											} else if (this.value == 'No') {
												$(
														"#div_nome_presunto_aggressore")
														.hide();

												$(
														"#div_cognome_presunto_aggressore")
														.hide();

												$(
														"#div_data_nascita_presunto_aggressore")
														.hide();

												$(
														"#div_luogo_presunto_aggressore_select")
														.hide();

												$(
														"#div_provincia_nascita_presunto_aggressore_select")
														.hide();

												$(
														"#div_comune_nascita_presunto_aggressore_select")
														.hide();

												$(
														"#div_indirizzo_presunto_aggressore")
														.hide();

												$(
														"#div_telefono_presunto_aggressore")
														.hide();

												$(
														"#div_selectTitoloDiStudioAggressore")
														.hide();

												$(
														"#div_selectProfessioneAggressore")
														.hide();

												$(
														"#div_fascia_di_eta_aggressore")
														.hide();

												$(
														"#div_rapporto_vittima_autore_violenza")
														.hide();

												$("#div_aggressore_servizi")
														.hide();

												$(
														"#div_tipologia_servizi_aggressore")
														.hide();

												$(
														"#div_violenza_assistitaosubita")
														.hide();

												$("#div_precedenti_penali")
														.hide();
											}
										});

						$('#ruoloCompilatore_select').change(function() {
							if (this.value == 'Altro') {
								$('#div_altro_ruoloCompilatore').show();
							} else {
								$('#div_altro_ruoloCompilatore').hide();
							}
						});

						$("#attivazioneRete_select")
								.change(
										function() {
											if (this.value == "Pronto Soccorso") {
												$(
														'#div_attivazioneReteOspedale')
														.show();
											} else {
												$(
														'#div_attivazioneReteOspedale')
														.hide();
											}

											if (this.value == "Forze dell'Ordine") {
												$(
														'#div_attivazioneRete_forzedellordine')
														.show();
											} else {
												$(
														'#div_attivazioneRete_forzedellordine')
														.hide();
											}

											if (this.value == "Servizi Sociali") {
												$('#div_serviziSociali').show();
											} else {
												$('#div_serviziSociali').hide();
											}

											if (this.value == "Servizio Sanitario") {
												$('#div_servizioSanitario')
														.show();
											} else {
												$('#div_servizioSanitario')
														.hide();
											}

										});

						$('#selectProfessioneAggressore')
								.change(
										function() {
											if (this.value == 'Altro') {
												$(
														'#div_altro_stato_occupazionale_aggressore')
														.show();
											} else {
												$(
														'#div_altro_stato_occupazionale_aggressore')
														.hide();
											}
										});

						$('#selectProfessione')
								.change(
										function() {
											if (this.value == 'Altro') {
												$(
														'#div_altro_stato_occupazionale_donna')
														.show();
											} else {
												$(
														'#div_altro_stato_occupazionale_donna')
														.hide();
											}
										});

						$('#identificativoServizio_select')
								.change(
										function() {
											if (this.value == 'Altro') {
												$(
														'#div_altro_identificativoServizio')
														.show();
											} else {
												$(
														'#div_altro_identificativoServizio')
														.hide();
											}

											if (this.value == "Centro di prima assistenza psicologica") {
												$(
														'#div_centrodiprimaassistenzapsicologica')
														.show();
											} else {
												$(
														'#div_centrodiprimaassistenzapsicologica')
														.hide();
											}

											if (this.value == "Centro Antiviolenza") {
												$('#div_cav').show();
											} else {
												$('#div_cav').hide();
											}

											if (this.value == "Sportello di ascolto") {
												$('#div_sportelloDiAscolto')
														.show();
												$(
														'#div_sportelloDiAscoltoLuogo')
														.hide();
											} else {
												$('#div_sportelloDiAscolto')
														.hide();
												$(
														'#div_sportelloDiAscoltoLuogo')
														.hide();
											}

										});

						$('#sportelloDiAscolto_select').change(
								function() {
									if (this.value == 'Altro'
											|| this.value == "Scegli...") {
										$('#div_sportelloDiAscoltoLuogo')
												.hide();
									} else {
										$('#div_sportelloDiAscoltoLuogo')
												.show();
									}
								});

						$('input:radio[name=sportoDenuncia]').change(
								function() {
									if (this.value == 'Si') {
										$('#div_forze_dell_ordine_denuncia')
												.show();
									} else {
										$('#div_forze_dell_ordine_denuncia')
												.hide();
									}
								});

						$(
								'input:radio[name=primo_accesso_servizio_antiviolenza]')
								.change(
										function() {
											if (this.value == 'Si') {
												$('#accessi_ripetuti').hide();
											} else if (this.value == 'No') {
												$('#accessi_ripetuti').show();
											} else if (this.value == 'Dato non dichiarato') {
												$('#accessi_ripetuti').hide();
											}
										});

						$('input:radio[name=ritiratoDenuncia]').change(
								function() {
									if (this.value == 'Si') {
										$('#div_motivoRitiroDenuncia_select')
												.show();
									} else {
										$('#div_motivoRitiroDenuncia_select')
												.hide();
									}
								});

						$('input:radio[name=cittadinanza]').change(function() {
							if (this.value == 'Si') {
								$('#cittadinanza_select').hide();
							} else if (this.value == 'No') {
								$('#cittadinanza_select').show();
							} else if (this.value == 'Dato non dichiarato') {
								$('#cittadinanza_select').hide();
							}
						});

						$('#select_lingua_italiana').change(function() {
							if (this.value == 'No') {
								$('#div_mediatore_culturale').show();
							} else if (this.value == 'Si') {
								$('#div_mediatore_culturale').hide();
							} else if (this.value == 'Dato non dichiarato') {
								$('#div_mediatore_culturale').hide();
							} else {
								$('#div_mediatore_culturale').show();
							}
						});

						$('#statoCivile').change(function() {
							if (this.value == 'Altro') {
								$('#div_altro_statoCivile').show();
							} else {
								$('#div_altro_statoCivile').hide();
							}
						});

						$('#selectTipologiaViolenza').change(function() {
							if ((this.value == 'Altro')) {
								$('#div_violenzaRiferita').show();
							} else {
								$('#div_violenzaRiferita').hide();
							}
						});

						$('#selectTipologiaViolenza')
								.change(
										function() {
											if (this.value == 'Violenza extra domestica'
													|| this.value == "Violenza domestica") {
												$('#div_sfruttamento').show();
											} else {
												$('#div_sfruttamento').hide();
											}
										});

						$('#selectDonnaAccompagnataAlServizioAntiviolenza')
								.change(
										function() {
											if (this.value == 'Altro') {
												$(
														'#div_altro_donnaAccompagnataInPS')
														.show();
											} else {
												$(
														'#div_altro_donnaAccompagnataInPS')
														.hide();
											}

											if (this.value == "Inviata dalle Forze dell'Ordine") {
												$(
														'#div_donnaaccompagnata_forzedellordine')
														.show();
											} else {
												$(
														'#div_donnaaccompagnata_forzedellordine')
														.hide();
											}

											if (this.value == "Inviata dal Pronto Soccorso") {
												$(
														'#div_donnaaccompagnata_prontosoccorso')
														.show();
											} else {
												$(
														'#div_donnaaccompagnata_prontosoccorso')
														.hide();
											}

											if (this.value == "Accompagnata da altre persone") {
												$(
														'#div_donnaaccompagnata_da_altre_persone')
														.show();
											} else {
												$(
														'#div_donnaaccompagnata_da_altre_persone')
														.hide();
											}
										});

						$('input:radio[name=figli]').change(function() {
							if (this.value == 'Si') {
								$('#div_eta_figli').show();
							} else {
								$('#div_eta_figli').hide();
							}
						});

						$("input:radio[name=aggressore_servizi]").change(
								function() {
									if (this.value == 'Si') {
										$('#div_tipologia_servizi_aggressore')
												.show();
									} else {
										$('#div_tipologia_servizi_aggressore')
												.hide();
									}
								});

						$("input:checkbox[name=valutazione_stato_bisogno]")
								.change(
										function() {
											if ($(
													"input:checkbox[name=valutazione_stato_bisogno]:checked")
													.val() == "Altro") {
												$(
														'#div_altro_ValutazioneStatoBisogno')
														.show();
											} else {
												$(
														'#div_altro_ValutazioneStatoBisogno')
														.hide();
											}
										});

						$("input:radio[name=separata]").change(function() {
							if (this.value == 'Si') {
								$('#div_tempo_separazione').show();
							} else {
								$('#div_tempo_separazione').hide();
							}
						});

						$('#selectTitoloDiStudio').change(function() {
							if (this.value == 'Altro') {
								$('#div_altroTitoloDiStudio').show();
							} else {
								$('#div_altroTitoloDiStudio').hide();
							}
						});

						$('#selectTitoloDiStudioAggressore').change(function() {
							if (this.value == 'Altro') {
								$('#div_altroTitoloDiStudiAggressore').show();
							} else {
								$('#div_altroTitoloDiStudiAggressore').hide();
							}
						});

						$('#rapporto_vittima_autore_violenza').change(
								function() {
									if (this.value == 'Familiare') {
										$('#div_familiare').show();
									} else {
										$('#div_familiare').hide();
									}
								});

						$('#tipologia_familiare')
								.change(
										function() {
											if (this.value == 'Altro') {
												$(
														'#div_altroRapportoVittimaAggressore')
														.show();
											} else {
												$(
														'#div_altroRapportoVittimaAggressore')
														.hide();
											}
										});

						$('#tipologia_servizi_aggressore')
								.change(
										function() {
											if (this.value == 'Altro') {
												$(
														'#div_altroTipologiaServiziAggressore')
														.show();
											} else {
												$(
														'#div_altroTipologiaServiziAggressore')
														.hide();
											}

										});

					});

	function check() {
		var result = false;
		if (index == 1)
			result = question1();
		else if (index == 2)
			result = question2();
		else if (index == 3)
			result = question3();
		else if (index == 4)
			result = question4();
		else if (index == 5)
			result = question5();

		if (result) {
			load_data();
			save();
		}
	}

	function load_data() {
		question.section = index;

		if (index == 1) {
			question.answer1 = $('#identificativo_scheda').val();

			question.answer2 = $('#data_compilazione').val();

			question.answer3 = $('#nome_compilatore').val();

			question.answer4 = $('#cognome_compilatore').val();

			question.answer5 = $("#ruoloCompilatore_select option:selected")
					.text();

			question.answer6 = "";
			if (question.answer5 == "Altro")
				question.answer6 = $('#altroruolocompilatore').val();

			question.answer7 = $(
					"#identificativoServizio_select option:selected").text();

			question.answer8 = "";
			question.answer9 = "";
			question.answer10 = "";
			question.answer11 = "";
			question.answer12 = "";
			question.answer13 = "";
			question.answer14 = "";
			question.answer15 = "";
			question.answer16 = "";
			question.answer17 = "";
			question.answer18 = "";

			if (question.answer7 == "Altro")
				question.answer8 = $('#altroIdentificativoServizio').val();
			else if (question.answer7 == "Centro di prima assistenza psicologica") {
				question.answer9 = $('#prontosoccorso_select option:selected')
						.text();
				question.answer10 = $(
						'#provincia_prontosoccorso_select option:selected')
						.text();
				question.answer11 = $(
						'#comune_prontosoccorso_select option:selected').text();
			} else if (question.answer7 == "Centro Antiviolenza") {
				question.answer12 = $('#cav_nome').val();
				question.answer13 = $('#provincia_cav_select option:selected')
						.text();
				question.answer14 = $('#comune_cav_select option:selected')
						.text();
			} else if (question.answer7 == "Sportello di ascolto") {
				question.answer15 = $(
						'#sportelloDiAscolto_select option:selected').text();
				if (question.answer15 != "Altro") {
					question.answer16 = $('#sportello_nome').val();
					question.answer17 = $(
							'#provincia_sportellodiascolto_select option:selected')
							.text();
					question.answer18 = $(
							'#comune_sportellodiascolto_select option:selected')
							.text();
				}
			}
		} else if (index == 2) {
			question.answer19 = $('#nome_vittima').val();

			question.answer20 = $('#cognome_vittima').val();

			question.answer21 = "" + $('#data_nascita').val();

			question.answer22 = $("#luogo_select option:selected").text();

			question.answer23 = $('#provincia_nascita_select option:selected')
					.text();

			question.answer24 = $('#comune_nascita_select option:selected')
					.text();

			question.answer25 = $('#indirizzo').val();

			question.answer26 = $('#telefono_personale').val();

			question.answer27 = $('#altro_telefono').val();

			question.answer28 = "";
			if ($("input[name='cittadinanza']:checked").val() != undefined)
				question.answer28 = $("input[name='cittadinanza']:checked")
						.val();

			if ($("input[name='cittadinanza']:checked").val() == "Si"
					|| $("input[name='cittadinanza']:checked").val() == "Dato non dichiarato")
				question.answer29 = "";
			else
				question.answer29 = $("#cittadinanza_select option:selected")
						.text();

			question.answer30 = $("#select_lingua_italiana option:selected")
					.text();

			if ($("input[name='mediatoreCulturale']:checked").val() == undefined)
				question.answer31 = "";
			else
				question.answer31 = $(
						"input[name='mediatoreCulturale']:checked").val();

			//se Conoscenza lingua italiana -> Si => mediatore NO
			if (question.answer30 == "Si")
				question.answer31 = "";

			question.answer32 = $('#statoCivile option:selected').text();

			if (question.answer32 == "Altro")
				question.answer33 = $('#altrostatocivile').val();
			else
				question.answer33 = "";

			question.answer34 = $("input[name='figli']:checked").val();

			if (question.answer34 == "Si") {
				question.answer35 = $("#numero_figli").val();
				question.answer36 = $("#numero_figli_minorenni").val();
				question.answer37 = $("#numero_figli_minorenni_maschi").val();
				question.answer38 = $("#numero_figli_minorenni_femmine").val();

				if ($("input[name='convivono_figliFemmine']:checked").val() == undefined)
					question.answer39 = "";
				else
					question.answer39 = $(
							"input[name='convivono_figliFemmine']:checked")
							.val();

				if ($("input[name='assistonoViolenza_figli']:checked").val() == undefined)
					question.answer40 = "";
				else
					question.answer40 = $(
							"input[name='assistonoViolenza_figli']:checked")
							.val();

				if ($("input[name='subisconoViolenza_figli']:checked").val() == undefined)
					question.answer41 = "";
				else
					question.answer41 = $(
							"input[name='subisconoViolenza_figli']:checked")
							.val();

			} else {
				question.answer35 = "0";
				question.answer36 = "0";
				question.answer37 = "0";
				question.answer38 = "0";

				question.answer39 = "";
				question.answer40 = "";
				question.answer41 = "";
			}

			question.answer42 = $("#selectTitoloDiStudio option:selected")
					.text();

			if (question.answer42 == "Altro")
				question.answer43 = $('#altroTitoloDiStudio').val();
			else
				question.answer43 = "";

			question.answer44 = $("#selectProfessione option:selected").text();

			if (question.answer44 == "Altro")
				question.answer45 = $('#altro_stato_occupazionale_donna')
						.text();
			else
				question.answer45 = "";

			question.answer46 = $(
					"input[name='autonomo_economicamente']:checked").val();

		} else if (index == 3) {
			if ($("input[name='primo_accesso_servizio_antiviolenza']:checked")
					.val() == undefined)
				question.answer47 = "";
			else
				question.answer47 = $(
						"input[name='primo_accesso_servizio_antiviolenza']:checked")
						.val();

			if (question.answer47 == "Si"
					|| question.answer47 == "Dato non dichiarato")
				question.answer48 = "0";
			else
				question.answer48 = $("#numero_accessi_ripetuti").val();

			if ($("input[name='accesso_occasionale']:checked").val() == undefined)
				question.answer49 = "";
			else
				question.answer49 = $(
						"input[name='accesso_occasionale']:checked").val();

			question.answer50 = $(
					"#selectDonnaAccompagnataAlServizioAntiviolenza option:selected")
					.text();

			if (question.answer50 == "Inviata dalle Forze dell'Ordine") {
				question.answer51 = $(
						"#donnaaccompagnata_forzedellordine_select option:selected")
						.text();
				question.answer52 = $(
						"#provincia_donnaaccompagnata_forzedellordine_select option:selected")
						.text();
				question.answer53 = $(
						"#comune_donnaaccompagnata_forzedellordine_select option:selected")
						.text();

			} else {
				question.answer51 = "";
				question.answer52 = "";
				question.answer53 = "";
			}

			if (question.answer50 == "Inviata dal Pronto Soccorso") {
				question.answer54 = $(
						"#donnaaccompagnata_prontosoccorso_select option:selected")
						.text();
				question.answer55 = $(
						"#provincia_donnaaccompagnata_prontosoccorso_select option:selected")
						.text();
				question.answer56 = $(
						"#comune_donnaaccompagnata_prontosoccorso_select option:selected")
						.text();

			} else {
				question.answer54 = "";
				question.answer55 = "";
				question.answer56 = "";
			}

			if (question.answer50 == "Accompagnata da altre persone")
				question.answer57 = $(
						"#selectDonnaAccompagnataDaAltrePersoneInSA option:selected")
						.text();
			else
				question.answer57 = "";

			if (question.answer50 == "Altro")
				question.answer58 = $(
						"#altroDonnaAccompagnataInPS option:selected").text();
			else
				question.answer58 = "";

			question.answer59 = $("#motivoAccesso").val();

			question.answer60 = $("#selectTipologiaViolenza option:selected")
					.text();

			question.answer61 = "";
			question.answer62 = "";

			if (question.answer60 == "Violenza domestica"
					|| question.answer60 == "Violenza extra domestica") {
				$("input[name='sfruttamento']").each(
						function() {
							var ischecked = $(this).is(":checked");
							if (ischecked) {
								question.answer61 = question.answer61
										+ $(this).val() + ";";
							}
						});

				$("input[name='violenzeRiferite']").each(
						function() {
							var ischecked = $(this).is(":checked");
							if (ischecked) {
								question.answer62 = question.answer62
										+ $(this).val() + ";";
							}
						});
			}

			if (question.answer60 == "Altro")
				question.answer63 = $("#altroViolenzaRiferita").val();
			else
				question.answer63 = "";

		} else if (index == 4) {
			question.answer64 = $("input[name='conosci_aggressore']:checked")
					.val();

			question.answer65 = $("#nome_presunto_aggressore").val();

			question.answer66 = $("#cognome_presunto_aggressore").val();

			question.answer67 = $("#data_nascita_presunto_aggressore").val();

			if ($("#luogo_presunto_aggressore_select option:selected").text() == "Scegli...")
				question.answer68 = "";
			else
				question.answer68 = $(
						"#luogo_presunto_aggressore_select option:selected")
						.text();

			if ($(
					"#provincia_nascita_presunto_aggressore_select option:selected")
					.text() == "Scegli...")
				question.answer69 = "";
			else
				question.answer69 = $(
						"#provincia_nascita_presunto_aggressore_select option:selected")
						.text();

			if ($("#comune_nascita_presunto_aggressore_select option:selected")
					.text() == "Scegli...")
				question.answer70 = "";
			else
				question.answer70 = $(
						"#comune_nascita_presunto_aggressore_select option:selected")
						.text();

			question.answer71 = $("#indirizzo_presunto_aggressore").val();

			question.answer72 = $("#telefono_presunto_aggressore").val();

			if ($("#selectTitoloDiStudioAggressore option:selected").text() == "Scegli...")
				question.answer73 = "";
			else
				question.answer73 = $(
						"#selectTitoloDiStudioAggressore option:selected")
						.text();

			if ($("#selectTitoloDiStudioAggressore option:selected").text() == "Altro")
				question.answer74 = $("#altroTitoloDiStudioAggressore").val();
			else
				question.answer74 = "";

			if ($("#selectProfessioneAggressore option:selected").text() == "Scegli...")
				question.answer75 = "";
			else
				question.answer75 = $(
						"#selectProfessioneAggressore option:selected").text();

			if ($("#selectProfessioneAggressore option:selected").text() == "Altro")
				question.answer76 = $("#altro_stato_occupazionale_aggressore")
						.val();
			else
				question.answer76 = "";

			if ($("#fascia_di_eta_aggressore option:selected").text() == "Scegli...")
				question.answer77 = "";
			else
				question.answer77 = $(
						"#fascia_di_eta_aggressore option:selected").text();

			if ($("#rapporto_vittima_autore_violenza option:selected").text() == "Scegli...")
				question.answer78 = "";
			else
				question.answer78 = $(
						"#rapporto_vittima_autore_violenza option:selected")
						.text();

			if (question.answer78 == "Familiare")
				question.answer79 = $("#tipologia_familiare option:selected")
						.text();
			else
				question.answer79 = "";

			if (question.answer79 == "Altro")
				question.answer80 = $("#altroRapportoVittimaAggressore").val();
			else
				question.answer80 = "";

			if ($("input[name='aggressore_servizi']:checked").val() == undefined)
				question.answer81 = "";
			else
				question.answer81 = $(
						"input[name='aggressore_servizi']:checked").val();

			if ($("#tipologia_servizi_aggressore option:selected").text() == "Scegli...")
				question.answer82 = "";
			else
				question.answer82 = $(
						"#tipologia_servizi_aggressore option:selected").text();

			if ($("#tipologia_servizi_aggressore option:selected").text() == "Altro")
				question.answer83 = $("#altroTipologiaServiziAggressore").val();
			else
				question.answer83 = "";

			if ($("input[name='violenza_assistitaosubita']:checked").val() == undefined)
				question.answer84 = "";
			else
				question.answer84 = $(
						"input[name='violenza_assistitaosubita']:checked")
						.val();

			if ($("input[name='precedenti_penali']:checked").val() == undefined)
				question.answer85 = "";
			else
				question.answer85 = $("input[name='precedenti_penali']:checked")
						.val();

		} else if (index == 5) {
			question.answer86 = $("input[name='brief_risk_1']:checked").val();

			question.answer87 = $("input[name='brief_risk_2']:checked").val();

			question.answer88 = $("input[name='brief_risk_3']:checked").val();

			question.answer89 = $("input[name='brief_risk_4']:checked").val();

			question.answer90 = $("input[name='brief_risk_5']:checked").val();

			question.answer91 = $("input[name='brief_risk_6']:checked").val();

			question.answer92 = $("input[name='brief_risk_7']:checked").val();

			question.answer93 = $("input[name='faseDiSeparazione']:checked")
					.val();

			question.answer94 = $("input[name='separata']:checked").val();

			if (question.answer94 == "Si")
				question.answer95 = $(
						"#tempo_separazione_select option:checked").text();
			else
				question.answer95 = "";

			question.answer96 = $("input[name='haComunicatoAlPartner']:checked")
					.val();

			question.answer97 = $("input[name='sporgereDenuncia']:checked")
					.val();

			question.answer98 = $("input[name='sportoDenuncia']:checked").val();

			if (question.answer98 == "Si") {
				question.answer99 = $(
						"#selectForzeDellOrdineDenuncia option:selected")
						.text();
				question.answer100 = $(
						"#provincia_denuncia_select option:selected").text();
				question.answer101 = $(
						"#comune_denuncia_select option:selected").text();
			} else {
				question.answer99 = "";
				question.answer100 = "";
				question.answer101 = "";
			}

			question.answer102 = $("input[name='ritiratoDenuncia']:checked")
					.val();

			if (question.answer102 == "Si")
				question.answer103 = $(
						"#motivoRitiroDenuncia_select option:checked").text();
			else
				question.answer103 = "";

			question.answer104 = "";

			$("input[name='valutazione_stato_bisogno']").each(
					function() {
						var ischecked = $(this).is(":checked");
						if (ischecked) {
							question.answer104 = question.answer104
									+ $(this).val() + ";";
						}
					});

			if (question.answer104 == "Altro")
				question.answer105 = $(
						"#specificare_altro_ValutazioneStatoBisogno").val();
			else
				question.answer105 = "";

			question.answer106 = "";

			$("input[name='presaInCarico']").each(
					function() {
						var ischecked = $(this).is(":checked");
						if (ischecked) {
							question.answer106 = question.answer106
									+ $(this).val() + ";";
						}
					});

			question.answer107 = "";

			$("input[name='prestazioniEffettuate']").each(
					function() {
						var ischecked = $(this).is(":checked");
						if (ischecked) {
							question.answer107 = question.answer107
									+ $(this).val() + ";";
						}
					});

			question.answer108 = $("#attivazioneRete_select option:checked")
					.text();

			if (question.answer108 == "Pronto Soccorso") {
				question.answer109 = $(
						"#attivazioneRete_prontosoccorso_select option:checked")
						.text();
				question.answer110 = $(
						"#attivazioneRete_provincia_prontosoccorso_select option:checked")
						.text();
				question.answer111 = $(
						"#attivazioneRete_comune_prontosoccorso_select option:checked")
						.text();
			} else {
				question.answer109 = "";
				question.answer110 = "";
				question.answer111 = "";
			}

			if (question.answer108 == "Forze dell'Ordine") {
				question.answer112 = $(
						"#attivazioneRete_forzedellordine_select option:checked")
						.text();
				question.answer113 = $(
						"#attivazioneRete_provincia_forzedellordine_select option:checked")
						.text();
				question.answer114 = $(
						"#attivazioneRete_comune_forzedellordine_select option:checked")
						.text();
			} else {
				question.answer112 = "";
				question.answer113 = "";
				question.answer114 = "";
			}

			if (question.answer108 == "Servizio Sanitario")
				question.answer115 = $(
						"#servizioSanitario_provincia_select option:checked")
						.text();
			else
				question.answer115 = "";

			if (question.answer108 == "Servizi Sociali")
				question.answer116 = $(
						"#serviziSociali_provincia_select option:checked")
						.text();
			else
				question.answer116 = "";

		}
	}

	function question1() {
		flag = false;

		var ruoloCompilatore = $("#ruoloCompilatore_select option:selected")
				.text();
		if (ruoloCompilatore == "Scegli...") {
			$('#ruoloCompilatore_select').css("border-color", "red");
			$("#ruoloCompilatore_select_error_msg").text("Compila il campo");
			flag = true;
		} else {
			$('#ruoloCompilatore_select').css("border-color", "");
			$("#ruoloCompilatore_select_error_msg").text("");
		}

		if (ruoloCompilatore == "Altro") {
			if ($('#altroruolocompilatore').val() == "") {
				$('#altroruolocompilatore').css("border-color", "red");
				$("#altroruolocompilatore_error_msg").text("Compila il campo");
				flag = true;
			} else {
				if (re.test($('#altroruolocompilatore').val())) {
					$('#altroruolocompilatore').css("border-color", "");
					$("#altroruolocompilatore_error_msg").text("");
				} else {
					$('#altroruolocompilatore').css("border-color", "red");
					$("#altroruolocompilatore_error_msg").text(
							"Input non valido");
					flag = true;
				}
			}
		}

		var identificativoServizio = $(
				"#identificativoServizio_select option:selected").text();
		if (identificativoServizio == "Scegli...") {
			$('#identificativoServizio_select').css("border-color", "red");
			$("#identificativoServizio_select_error_msg").text(
					"Compila il campo");
			flag = true;
		} else {
			$('#identificativoServizio_select').css("border-color", "");
			$("#identificativoServizio_select_error_msg").text("");
		}

		if (identificativoServizio == "Altro") {
			if ($('#altroIdentificativoServizio').val() == "") {
				$('#altroIdentificativoServizio').css("border-color", "red");
				$("#altroIdentificativoServizio_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				if (re.test($('#altroIdentificativoServizio').val())) {
					$('#altroIdentificativoServizio').css("border-color", "");
					$("#altroIdentificativoServizio_error_msg").text("");
				} else {
					$('#altroIdentificativoServizio')
							.css("border-color", "red");
					$("#altroIdentificativoServizio_error_msg").text(
							"Input non valido");
					flag = true;
				}
			}
		}

		if (identificativoServizio == "Centro di prima assistenza psicologica") {
			if ($('#prontosoccorso_select option:selected').text() == "Scegli...") {
				$('#prontosoccorso_select').css("border-color", "red");
				$("#prontosoccorso_select_error_msg").text("Compila il campo");
				flag = true;
			} else {
				$('#prontosoccorso_select').css("border-color", "");
				$("#prontosoccorso_select_error_msg").text("");
			}

			if ($('#provincia_prontosoccorso_select option:selected').text() == "Scegli...") {
				$('#provincia_prontosoccorso_select')
						.css("border-color", "red");
				$("#provincia_prontosoccorso_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$('#provincia_prontosoccorso_select').css("border-color", "");
				$("#provincia_prontosoccorso_select_error_msg").text("");
			}

			if ($('#comune_prontosoccorso_select option:selected').text() == "Scegli...") {
				$('#comune_prontosoccorso_select').css("border-color", "red");
				$("#comune_prontosoccorso_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$('#comune_prontosoccorso_select').css("border-color", "");
				$("#comune_prontosoccorso_select_error_msg").text("");
			}
		}

		if (identificativoServizio == "Centro Antiviolenza") {
			if ($('#cav_nome').val() == "") {
				$('#cav_nome').css("border-color", "red");
				$("#cav_nome_error_msg").text("Compila il campo");
				flag = true;
			} else {
				if (re.test($('#cav_nome').val())) {
					$('#cav_nome').css("border-color", "");
					$("#cav_nome_error_msg").text("");
				} else {
					$('#cav_nome').css("border-color", "red");
					$("#cav_nome_error_msg").text("Input non valido");
					flag = true;
				}

			}

			if ($('#provincia_cav_select option:selected').text() == "Scegli...") {
				$('#provincia_cav_select').css("border-color", "red");
				$("#provincia_cav_select_error_msg").text("Compila il campo");
				flag = true;
			} else {
				$('#provincia_cav_select').css("border-color", "");
				$("#provincia_cav_select_error_msg").text("");
			}

			if ($('#comune_cav_select option:selected').text() == "Scegli...") {
				$('#comune_cav_select').css("border-color", "red");
				$("#comune_cav_select_error_msg").text("Compila il campo");
				flag = true;
			} else {
				$('#comune_cav_select').css("border-color", "");
				$("#comune_cav_select_error_msg").text("");
			}
		}

		if (identificativoServizio == "Sportello di ascolto") {
			if ($('#sportelloDiAscolto_select option:selected').text() == "Scegli...") {
				$('#sportelloDiAscolto_select').css("border-color", "red");
				$("#sportelloDiAscolto_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else if ($('#sportelloDiAscolto_select option:selected').text() == "Altro") {
				$('#sportelloDiAscolto_select').css("border-color", "");
				$("#sportelloDiAscolto_select_error_msg").text("");
			} else {
				$('#sportelloDiAscolto_select').css("border-color", "");
				$("#sportelloDiAscolto_select_error_msg").text("");
			}

			if ($('#sportelloDiAscolto_select option:selected').text() != "Altro"
					&& $('#sportelloDiAscolto_select option:selected').text() != "Scegli...") {
				if ($('#sportello_nome').val() == "") {
					$('#sportello_nome').css("border-color", "red");
					$("#sportello_nome_error_msg").text("Compila il campo");
					flag = true;
				} else {
					if (re.test($('#sportello_nome').val())) {
						$('#sportello_nome').css("border-color", "");
						$("#sportello_nome_error_msg").text("");
					} else {
						$('#sportello_nome').css("border-color", "red");
						$("#sportello_nome_error_msg")
								.text("Input non valido");
						flag = true;
					}
				}

				if ($('#provincia_sportellodiascolto_select option:selected')
						.text() == "Scegli...") {
					$('#provincia_sportellodiascolto_select').css(
							"border-color", "red");
					$("#provincia_sportellodiascolto_select_error_msg").text(
							"Compila il campo");
					flag = true;
				} else {
					$('#provincia_sportellodiascolto_select').css(
							"border-color", "");
					$("#provincia_sportellodiascolto_select_error_msg")
							.text("");
				}

				if ($('#comune_sportellodiascolto_select option:selected')
						.text() == "Scegli...") {
					$('#comune_sportellodiascolto_select').css("border-color",
							"red");
					$("#comune_sportellodiascolto_select_error_msg").text(
							"Compila il campo");
					flag = true;
				} else {
					$('#comune_sportellodiascolto_select').css("border-color",
							"");
					$("#comune_sportellodiascolto_select_error_msg").text("");
				}

			}
		}

		if (flag) {
			//$('#myModalError').modal('show'); 
			$('#error_msg_footer').text("Campi non correttamente compilati");
			return false;
		}
		$('#error_msg_footer').text("");
		return true;
	}

	function question2() {
		flag = false;

		if (re.test($('#nome_vittima').val())) {
			$('#nome_vittima').css("border-color", "");
			$('#nome_vittima_error_msg').text("");
		} else {
			$('#nome_vittima').css("border-color", "red");
			if ($('#nome_vittima').val() == "")
				$('#nome_vittima_error_msg').text("Compila il campo");
			else
				$('#nome_vittima_error_msg').text("Input non valido");

			flag = true;
		}

		if (re.test($('#cognome_vittima').val())) {
			$('#cognome_vittima').css("border-color", "");
			$('#cognome_vittima_error_msg').text("");
		} else {
			$('#cognome_vittima').css("border-color", "red");
			if ($('#cognome_vittima').val() == "")
				$('#cognome_vittima_error_msg').text("Compila il campo");
			else
				$('#cognome_vittima_error_msg').text("Input non valido");

			flag = true;
		}

		if (re_data.test($('#data_nascita').val())) {
			anno = parseInt($('#data_nascita').val().substr(6), 10);
			mese = parseInt($('#data_nascita').val().substr(3, 2), 10);
			giorno = parseInt($('#data_nascita').val().substr(0, 2), 10);

			var data = new Date(anno, mese - 1, giorno, 0, 0, 0, 0);
			var data_attuale = new Date();
			if (data.getFullYear() == anno && data.getMonth() + 1 == mese
					&& data.getDate() == giorno) {
				$('#data_nascita').css("border-color", "");
				$('#data_nascita_error_msg').text("");
			} else {
				$('#data_nascita').css("border-color", "red");
				$('#data_nascita_error_msg').text("Input non valido");
				flag = true;
			}
			if (data.getTime() >= data_attuale.getTime()) {
				$('#data_nascita').css("border-color", "red");
				$('#data_nascita_error_msg').text("Input non valido");
				flag = true;
			} else {
				$('#data_nascita').css("border-color", "");
				$('#data_nascita_error_msg').text("");
			}

		} else {
			$('#data_nascita').css("border-color", "red");
			if ($('#data_nascita').val() == "")
				$('#data_nascita_error_msg').text("Compila il campo");
			else
				$('#data_nascita_error_msg').text(
						"Inserisci una data nel formato gg/mm/aaaa");

			flag = true;
		}

		if ($("#luogo_select option:selected").text() == "Scegli...") {
			$('#luogo_select').css("border-color", "red");
			$('#luogo_select_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#luogo_select').css("border-color", "");
			$('#luogo_select_error_msg').text("");
		}

		if ($('#comune_nascita_select option:selected').text() == "Scegli...") {
			$('#comune_nascita_select').css("border-color", "red");
			$('#comune_nascita_select_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#comune_nascita_select').css("border-color", "");
			$('#comune_nascita_select_error_msg').text("");
		}

		if ($('#provincia_nascita_select option:selected').text() == "Scegli...") {
			$('#provincia_nascita_select').css("border-color", "red");
			$('#provincia_nascita_select_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#provincia_nascita_select').css("border-color", "");
			$('#provincia_nascita_select_error_msg').text("");
		}

		if ($('#indirizzo').val() == "") {
			$('#indirizzo').css("border-color", "red");
			$('#indirizzo_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#indirizzo').css("border-color", "");
			$('#indirizzo_error_msg').text("");
		}

		if (re_cel.test($('#telefono_personale').val())) {
			$('#telefono_personale').css("border-color", "");
			$('#telefono_personale_error_msg').text("");
		} else {
			$('#telefono_personale').css("border-color", "red");
			if ($('#telefono_personale').val() == "")
				$('#telefono_personale_error_msg').text("Compila il campo");
			else
				$('#telefono_personale_error_msg').text(
						"Inserisci un numero di telefono valido di 9 o 10 cifre");

			flag = true;
		}

		if (re_cel.test($('#altro_telefono').val())) {
			$('#altro_telefono').css("border-color", "");
			$('#altro_telefono_error_msg').text("");
		} else {

			if ($('#altro_telefono').val() == "") {
				$('#altro_telefono').css("border-color", "");
				$('#altro_telefono_error_msg').text("");
			} else {
				$('#altro_telefono').css("border-color", "red");
				$('#altro_telefono_error_msg')
						.text(
								"Inserisci un numero di telefono valido di 9 o 10 cifre.");
				flag = true;
			}

		}

		if ($("input[name='cittadinanza']:checked").val() == undefined) {
			$('#cittadinanza_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#cittadinanza_error_msg').text("");
		}

		if ($("input[name='cittadinanza']:checked").val() == "No") {
			if ($("#cittadinanza_select option:selected").text() == "Scegli...") {
				$('#cittadinanza_select').css("border-color", "red");
				$('#cittadinanza_select_error_msg').text("Compila il campo");
				flag = true;
			} else {
				$('#cittadinanza_select').css("border-color", "");
				$('#cittadinanza_select_error_msg').text("");
			}

		}
		if ($("#select_lingua_italiana option:selected").text() == "Scegli...") {
			$('#select_lingua_italiana').css("border-color", "red");
			$('#select_lingua_italiana_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#select_lingua_italiana').css("border-color", "");
			$('#select_lingua_italiana_error_msg').text("");
		}

		if ($("#select_lingua_italiana option:selected").text() == "Poco"
				|| $("#select_lingua_italiana option:selected").text() == "No") {
			if ($("input[name='mediatoreCulturale']:checked").val() == undefined) {
				$('#mediatoreCulturale_error_msg').text("Compila il campo");
				flag = true;
			} else {
				$('#mediatoreCulturale_error_msg').text("");
			}

		}

		if ($("#statoCivile option:selected").text() == "Scegli...") {
			$('#statoCivile').css("border-color", "red");
			$('#statoCivile_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#statoCivile').css("border-color", "");
			$('#statoCivile_error_msg').text("");
		}

		if ($("#statoCivile option:selected").text() == "Altro") {
			if ($('#altrostatocivile').val() == "") {
				$('#altrostatocivile').css("border-color", "red");
				$('#altrostatocivile_error_msg').text("Compila il campo");
				flag = true;
			} else {
				if (re.test($('#altrostatocivile').val())) {
					$('#altrostatocivile').css("border-color", "");
					$('#altrostatocivile_error_msg').text("");
				} else {
					$('#altrostatocivile').css("border-color", "red");
					$('#altrostatocivile_error_msg').text("Input non valido");
					flag = true;
				}

			}
		}

		if ($("input[name='figli']:checked").val() == undefined) {
			$('#figli_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#figli_error_msg').text("");
		}

		if ($("input[name='figli']:checked").val() == 'Si') {
			if (re_number1.test($('#numero_figli').val())) {
				$('#numero_figli').css("border-color", "");
				$('#numero_figli_error_msg').text("");
			} else {
				$('#numero_figli').css("border-color", "red");
				$('#numero_figli_error_msg').text("Input non valido");
				return false;
			}

			if (re_number1.test($('#numero_figli_minorenni').val())) {
				$('#numero_figli_minorenni').css("border-color", "");
				$('#numero_figli_minorenni_error_msg').text("");
			} else {
				$('#numero_figli_minorenni').css("border-color", "red");
				$('#numero_figli_minorenni_error_msg')
						.text("Input non valido");
				return false;
			}

			if (re_number1.test($('#numero_figli_minorenni_maschi').val())) {
				$('#numero_figli_minorenni_maschi').css("border-color", "");
				$('#numero_figli_minorenni_maschi_error_msg').text("");
			} else {
				$('#numero_figli_minorenni_maschi').css("border-color", "red");
				$('#numero_figli_minorenni_maschi_error_msg').text(
						"Input non valido");
				return false;
			}

			if (re_number1.test($('#numero_figli_minorenni_femmine').val())) {
				$('#numero_figli_minorenni_femmine').css("border-color", "");
				$('#numero_figli_minorenni_femmine_error_msg').text("");
			} else {
				$('#numero_figli_minorenni_femmine').css("border-color", "red");
				$('#numero_figli_minorenni_femmine_error_msg').text(
						"Input non valido");
				return false;
			}

			if ($('#numero_figli').val() >= $('#numero_figli_minorenni').val()) {
				$('#numero_figli').css("border-color", "");
				$('#numero_figli_minorenni').css("border-color", "");
				$('#numero_figli_minorenni_error_msg').text("");
			} else {
				$('#numero_figli').css("border-color", "red");
				$('#numero_figli_minorenni').css("border-color", "red");

				$('#numero_figli_minorenni_error_msg')
						.text("Input non valido");
				flag = true;
			}

			if ($('#numero_figli_minorenni').val() == (parseInt($(
					'#numero_figli_minorenni_maschi').val()) + parseInt($(
					'#numero_figli_minorenni_femmine').val()))) {

				$('#numero_figli_minorenni_maschi').css("border-color", "");
				$('#numero_figli_minorenni_maschi_error_msg').text("");

				$('#numero_figli_minorenni_femmine').css("border-color", "");
				$('#numero_figli_minorenni_femmine_error_msg').text("");
			} else {

				$('#numero_figli_minorenni_maschi').css("border-color", "red");
				$('#numero_figli_minorenni_maschi_error_msg').text(
						"Input non valido");

				$('#numero_figli_minorenni_femmine').css("border-color", "red");
				$('#numero_figli_minorenni_femmine_error_msg').text(
						"Input non valido");

				flag = true;
			}

			if ($("input[name='convivono_figliFemmine']:checked").val() == undefined) {
				$('#convivono_figliFemmine_error_msg').text("Compila il campo");
				flag = true;
			} else {
				$('#convivono_figliFemmine_error_msg').text("");
			}

			if ($("input[name='assistonoViolenza_figli']:checked").val() == undefined) {
				$('#assistonoViolenza_figli_error_msg')
						.text("Compila il campo");
				flag = true;
			} else {
				$('#assistonoViolenza_figli_error_msg').text("");
			}

			if ($("input[name='subisconoViolenza_figli']:checked").val() == undefined) {
				$('#subisconoViolenza_figli_error_msg')
						.text("Compila il campo");
				flag = true;
			} else {
				$('#subisconoViolenza_figli_error_msg').text("");
			}

		}

		if ($("#selectTitoloDiStudio option:selected").text() == "Scegli...") {
			$('#selectTitoloDiStudio').css("border-color", "red");
			$('#selectTitoloDiStudio_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#selectTitoloDiStudio').css("border-color", "");
			$('#selectTitoloDiStudio_error_msg').text("");
		}

		if ($("#selectTitoloDiStudio option:selected").text() == "Altro") {
			if ($('#altroTitoloDiStudio').val() == "") {
				$('#altroTitoloDiStudio').css("border-color", "red");
				$('#altroTitoloDiStudio_error_msg').text("Compila il campo");
				flag = true;
			} else {
				if (re.test($('#altroTitoloDiStudio').val())) {
					$('#altroTitoloDiStudio').css("border-color", "");
					$('#altroTitoloDiStudio_error_msg').text("");
				} else {
					$('#altroTitoloDiStudio').css("border-color", "red");
					$('#altroTitoloDiStudio_error_msg').text(
							"Input non valido");
					flag = true;
				}
			}

		}
		if ($("#selectProfessione option:selected").text() == "Scegli...") {
			$('#selectProfessione').css("border-color", "red");
			$('#selectProfessione_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#selectProfessione').css("border-color", "");
			$('#selectProfessione_error_msg').text("");

		}

		if ($("#selectProfessione option:selected").text() == "Altro") {
			if ($('#altro_stato_occupazionale_donna').val() == "") {
				$('#altro_stato_occupazionale_donna')
						.css("border-color", "red");
				$('#altro_stato_occupazionale_donna_error_msg').text(
						"Compila il campo");
				flag = true;
			} else {
				if (re.test($('#altro_stato_occupazionale_donna').val())) {
					$('#altro_stato_occupazionale_donna').css("border-color",
							"");
					$('#altro_stato_occupazionale_donna_error_msg').text("");
				} else {
					$('#altro_stato_occupazionale_donna').css("border-color",
							"red");
					$('#altro_stato_occupazionale_donna_error_msg').text(
							"Input non valido");
					flag = true;
				}
			}

		}

		if ($("input[name='autonomo_economicamente']:checked").val() == undefined) {
			$('#autonomo_economicamente_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#autonomo_economicamente_error_msg').text("");
		}

		if (flag) {
			//$('#myModalError').modal('show'); 
			$('#error_msg_footer').text("Campi non correttamente compilati");
			return false;
		}
		$('#error_msg_footer').text("");
		return true;
	}

	function question3() {
		flag = false;

		if ($("input[name='primo_accesso_servizio_antiviolenza']:checked")
				.val() == undefined) {
			$('#primo_accesso_servizio_antiviolenza_error_msg').text(
					"Compila il campo");
			flag = true;
		} else {
			$('#primo_accesso_servizio_antiviolenza_error_msg').text("");
		}

		if ($("input[name='primo_accesso_servizio_antiviolenza']:checked")
				.val() == "No") {
			if (re_number.test($("#numero_accessi_ripetuti").val())) {
				$('#numero_accessi_ripetuti_error_msg').text("");
				$('#numero_accessi_ripetuti').css("border-color", "");
			} else {
				$('#numero_accessi_ripetuti').css("border-color", "red");
				$('#numero_accessi_ripetuti_error_msg').text(
						"Input non valido");
				flag = true;
			}

			if ($("input[name='accesso_occasionale']:checked").val() == undefined) {
				$('#accesso_occasionale_error_msg').text("Compila il campo");
				$('#accesso_occasionale').css("border-color", "red");
				falg = true;
			} else {
				$('#accesso_occasionale').css("border-color", "");
				$('#accesso_occasionale_error_msg').text("");

				if ($("input[name='accesso_occasionale']:checked").val() == "No - In carico al servizio")
					$('#prestazioniEffettuate').show();
				else
					$('#prestazioniEffettuate').hide();
			}

		}

		if ($("#selectDonnaAccompagnataAlServizioAntiviolenza option:selected")
				.text() == "Scegli...") {
			$('#selectDonnaAccompagnataAlServizioAntiviolenza').css(
					"border-color", "red");
			$('#selectDonnaAccompagnataAlServizioAntiviolenza_error_msg').text(
					"Compila il campo");
			flag = true;
		} else {
			$('#selectDonnaAccompagnataAlServizioAntiviolenza').css(
					"border-color", "");
			$('#selectDonnaAccompagnataAlServizioAntiviolenza_error_msg').text(
					"");
		}

		if ($("#selectDonnaAccompagnataAlServizioAntiviolenza option:selected")
				.text() == "Altro") {
			if ($("#altroDonnaAccompagnataInPS").val() == "") {
				$('#altroDonnaAccompagnataInPS').css("border-color", "red");
				$('#altroDonnaAccompagnataInPS_error_msg').text(
						"Compila il campo");
				flag = true;
			} else {
				if (re.test($("#altroDonnaAccompagnataInPS").val())) {
					$('#altroDonnaAccompagnataInPS').css("border-color", "");
					$('#altroDonnaAccompagnataInPS_error_msg').text("");
				} else {
					$('#altroDonnaAccompagnataInPS').css("border-color", "red");
					$('#altroDonnaAccompagnataInPS_error_msg').text(
							"Input non valido");
					flag = true;
				}

			}

		}

		if ($("#selectDonnaAccompagnataAlServizioAntiviolenza option:selected")
				.text() == "Inviata dalle Forze dell'Ordine") {
			if ($("#donnaaccompagnata_forzedellordine_select option:selected")
					.text() == "Scegli...") {
				$('#donnaaccompagnata_forzedellordine_select').css(
						"border-color", "red");
				$('#donnaaccompagnata_forzedellordine_select_error_msg').text(
						"Compila il campo");
				flag = true;
			} else {
				$('#donnaaccompagnata_forzedellordine_select').css(
						"border-color", "");
				$('#donnaaccompagnata_forzedellordine_select_error_msg').text(
						"");
			}

			if ($(
					"#provincia_donnaaccompagnata_forzedellordine_select option:selected")
					.text() == "Scegli...") {
				$('#provincia_donnaaccompagnata_forzedellordine_select').css(
						"border-color", "red");
				$(
						'#provincia_donnaaccompagnata_forzedellordine_select_error_msg')
						.text("Compila il campo");
				flag = true;
			} else {
				$('#provincia_donnaaccompagnata_forzedellordine_select').css(
						"border-color", "");
				$(
						'#provincia_donnaaccompagnata_forzedellordine_select_error_msg')
						.text("");
			}

			if ($(
					"#comune_donnaaccompagnata_forzedellordine_select option:selected")
					.text() == "Scegli...") {
				$('#comune_donnaaccompagnata_forzedellordine_select').css(
						"border-color", "red");
				$('#comune_donnaaccompagnata_forzedellordine_select_error_msg')
						.text("Compila il campo");
				flag = true;
			} else {
				$('#comune_donnaaccompagnata_forzedellordine_select').css(
						"border-color", "");
				$('#comune_donnaaccompagnata_forzedellordine_select_error_msg')
						.text("");
			}

		}

		if ($("#selectDonnaAccompagnataAlServizioAntiviolenza option:selected")
				.text() == "Inviata dal Pronto Soccorso") {
			if ($("#donnaaccompagnata_prontosoccorso_select option:selected")
					.text() == "Scegli...") {
				$('#donnaaccompagnata_prontosoccorso_select').css(
						"border-color", "red");
				$('#donnaaccompagnata_prontosoccorso_select_error_msg').text(
						"Compila il campo");
				flag = true;
			} else {
				$('#donnaaccompagnata_prontosoccorso_select').css(
						"border-color", "");
				$('#donnaaccompagnata_prontosoccorso_select_error_msg')
						.text("");
			}

			if ($(
					"#provincia_donnaaccompagnata_prontosoccorso_select option:selected")
					.text() == "Scegli...") {
				$('#provincia_donnaaccompagnata_prontosoccorso_select').css(
						"border-color", "red");
				$(
						'#provincia_donnaaccompagnata_prontosoccorso_select_error_msg')
						.text("Compila il campo");
				flag = true;
			} else {
				$('#provincia_donnaaccompagnata_prontosoccorso_select').css(
						"border-color", "");
				$(
						'#provincia_donnaaccompagnata_prontosoccorso_select_error_msg')
						.text("");
			}

			if ($(
					"#comune_donnaaccompagnata_prontosoccorso_select option:selected")
					.text() == "Scegli...") {
				$('#comune_donnaaccompagnata_prontosoccorso_select').css(
						"border-color", "red");
				$('#comune_donnaaccompagnata_prontosoccorso_select_error_msg')
						.text("Compila il campo");
				flag = true;
			} else {
				$('#comune_donnaaccompagnata_prontosoccorso_select').css(
						"border-color", "");
				$('#comune_donnaaccompagnata_prontosoccorso_select_error_msg')
						.text("");
			}

		}

		if ($("#selectDonnaAccompagnataAlServizioAntiviolenza option:selected")
				.text() == "Accompagnata da altre persone") {
			if ($("#selectDonnaAccompagnataDaAltrePersoneInSA option:selected")
					.text() == "Scegli...") {
				$('#selectDonnaAccompagnataDaAltrePersoneInSA').css(
						"border-color", "red");
				$('#selectDonnaAccompagnataDaAltrePersoneInSAt_error_msg')
						.text("Compila il campo");
				flag = true;
			} else {
				$('#selectDonnaAccompagnataDaAltrePersoneInSA').css(
						"border-color", "");
				$('#selectDonnaAccompagnataDaAltrePersoneInSA_error_msg').text(
						"");
			}
		}

		if ($("#selectTipologiaViolenza option:selected").text() == "Scegli...") {
			$('#selectTipologiaViolenza').css("border-color", "red");
			$('#selectTipologiaViolenza_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#selectTipologiaViolenza').css("border-color", "");
			$('#selectTipologiaViolenza_error_msg').text("");
		}

		if (($("#selectTipologiaViolenza option:selected").text() == "Altro")) {
			if ($("#altroViolenzaRiferita").val() == "") {
				$('#altroViolenzaRiferita').css("border-color", "red");
				$('#altroViolenzaRiferita_error_msg').text("Compila il campo");
				flag = true;
			} else {
				if (re.test($("#altroViolenzaRiferita").val())) {
					$('#altroViolenzaRiferita').css("border-color", "");
					$('#altroViolenzaRiferita_error_msg').text("");
				} else {
					$('#altroViolenzaRiferita').css("border-color", "red");
					$('#altroViolenzaRiferita_error_msg').text(
							"Input non valido");
					flag = true;
				}

			}

		}

		if ($("#selectTipologiaViolenza option:selected").text() == "Violenza extra domestica"
				|| $("#selectTipologiaViolenza option:selected").text() == "Violenza domestica") {
			if ($("input[name='sfruttamento']:checked").val() == undefined
					&& $("input[name='violenzeRiferite']:checked").val() == undefined) {
				$('#checksfruttamento_error_msg').text("Compila il campo");
				flag = true;
			} else {
				$('#checksfruttamento_error_msg').text("");
			}

		}

		if ($("#motivoAccesso").val() == "") {
			$('#motivoAccesso').css("border-color", "red");
			$('#motivoAccesso_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#motivoAccesso').css("border-color", "");
			$('#motivoAccesso_error_msg').text("");
		}

		if (flag) {
			//$('#myModalError').modal('show'); 
			$('#error_msg_footer').text("Campi non correttamente compilati");
			return false;
		}
		$('#error_msg_footer').text("");
		return true;
	}

	function question4() {
		flag = false;

		if ($("#nome_presunto_aggressore").val() != "") {
			if (re.test($("#nome_presunto_aggressore").val())) {
				$("#nome_presunto_aggressore").css("border-color", "");
				$("#nome_presunto_aggressore_error_msg").text("");
			} else {
				$("#nome_presunto_aggressore").css("border-color", "red");
				$("#nome_presunto_aggressore_error_msg").text(
						"Input non valido");
				flag = true;
			}
		}

		if ($("#cognome_presunto_aggressore").val() != "") {
			if (re.test($("#cognome_presunto_aggressore").val())) {

				$("#cognome_presunto_aggressore").css("border-color", "");
				$("#cognome_presunto_aggressore_error_msg").text("");
			} else {
				$("#cognome_presunto_aggressore").css("border-color", "red");
				$("#cognome_presunto_aggressore_error_msg").text(
						"Input non valido");
				flag = true;
			}
		}

		if ($("#data_nascita_presunto_aggressore").val() != "") {
			if (re_data.test($("#data_nascita_presunto_aggressore").val())) {
				anno = parseInt($("#data_nascita_presunto_aggressore").val()
						.substr(6), 10);
				mese = parseInt($("#data_nascita_presunto_aggressore").val()
						.substr(3, 2), 10);
				giorno = parseInt($("#data_nascita_presunto_aggressore").val()
						.substr(0, 2), 10);

				var data = new Date(anno, mese - 1, giorno);
				var data_attuale1 = new Date();

				if (data.getFullYear() == anno && data.getMonth() + 1 == mese
						&& data.getDate() == giorno) {
					$("#data_nascita_presunto_aggressore").css("border-color",
							"");
					$("#data_nascita_presunto_aggressore_error_msg").text("");
				} else {
					$("#data_nascita_presunto_aggressore").css("border-color",
							"red");
					$("#data_nascita_presunto_aggressore_error_msg").text(
							"Input non valido");
					flag = true;
				}

				if (data.getTime() >= data_attuale1.getTime()) {
					$('#data_nascita_presunto_aggressore').css("border-color",
							"red");
					$('#data_nascita_presunto_aggressore_error_msg').text(
							"Input non valido");
					flag = true;
				} else {
					$('#data_nascita_presunto_aggressore').css("border-color",
							"");
					$('#data_nascita_presunto_aggressore_error_msg').text("");
				}

			} else {
				$("#data_nascita_presunto_aggressore").css("border-color",
						"red");
				if ($("#data_nascita_presunto_aggressore").val() == "")
					$("#data_nascita_presunto_aggressore_error_msg").text(
							"Compila il campo");
				else
					$("#data_nascita_presunto_aggressore_error_msg").text(
							"Inserisci una data nel formato gg/mm/aaaa");

				flag = true;
			}
		}

		/*
		if($("#luogo_presunto_aggressore_select option:selected").text()=="Scegli...")
		{
			$("#luogo_presunto_aggressore_select").css("border-color","red");
			$("#luogo_presunto_aggressore_select_error_msg").text("Compila il campo");
			flag=true;
		}
		else
		{
			$("#luogo_presunto_aggressore_select").css("border-color","");
			$("#luogo_presunto_aggressore_select_error_msg").text("");
		}
		 */

		/*
		if($("#comune_nascita_presunto_aggressore_select option:selected").text()=="Scegli...")
		{
			$("#comune_nascita_presunto_aggressore_select").css("border-color","red");
			$("#comune_nascita_presunto_aggressore_select_error_msg").text("Compila il campo");
			flag=true;
		}
		else
		{
			$("#comune_nascita_presunto_aggressore_select").css("border-color","");
			$("#comune_nascita_presunto_aggressore_select_error_msg").text("");
		}
		 */

		/*
		if($("#comune_nascita_presunto_aggressore_select option:selected").val()!="")
		{
			if(re.test($("#comune_nascita_presunto_aggressore").val()))
			{
				
				$("#comune_nascita_presunto_aggressore").css("border-color","");
				$("#comune_nascita_presunto_aggressore_error_msg").text("");
			}
			else
			{
				$("#comune_nascita_presunto_aggressore").css("border-color","red");
				$("#comune_nascita_presunto_aggressore_error_msg").text("Input non valido");
				
			}
		}
		 */
		/*
		if($("#provincia_nascita_presunto_aggressore_select option:selected").text()=="Scegli...")
		{
			$("#provincia_nascita_presunto_aggressore_select").css("border-color","red");
			$("#provincia_nascita_presunto_aggressore_select_error_msg").text("Compila il campo");
			flag=true;
		}
		else
		{
			$("#provincia_nascita_presunto_aggressore_select").css("border-color","");
			$("#provincia_nascita_presunto_aggressore_select_error_msg").text("");	
		}
		 */

		/*
		if($("#indirizzo_presunto_aggressore").val()=="")
		{
			$("#indirizzo_presunto_aggressore").css("border-color","red");
			$("#indirizzo_presunto_aggressore_error_msg").text("Compila il campo");
			flag=true;
		}
		else
		{
			$("#indirizzo_presunto_aggressore").css("border-color","");
			$("#indirizzo_presunto_aggressore_error_msg").text("");
		}
		 */

		if ($("#telefono_presunto_aggressore").val() != "") {
			if (re_cel.test($("#telefono_presunto_aggressore").val())) {

				$("#telefono_presunto_aggressore").css("border-color", "");
				$("#telefono_presunto_aggressore_error_msg").text("");
			} else {
				$("#telefono_presunto_aggressore").css("border-color", "red");
				$("#telefono_presunto_aggressore_error_msg")
						.text(
								"Inserisci un numero di telefono valido di 9 o 10 cifre.");
				flag = true;
			}
		}

		if ($("#selectTitoloDiStudioAggressore option:selected").text() == "Altro") {
			if ($("#altroTitoloDiStudioAggressore").val() != "") {
				if (re.test($("#altroTitoloDiStudioAggressore").val())) {
					$("#altroTitoloDiStudioAggressore").css("border-color", "");
					$("#altroTitoloDiStudioAggressore_error_msg").text("");
				} else {
					$("#altroTitoloDiStudioAggressore").css("border-color",
							"red");
					$("#altroTitoloDiStudioAggressore_error_msg").text(
							"Input non valido");
					flag = true;
				}
			} else {
				$("#altroTitoloDiStudioAggressore").css("border-color", "red");
				$("#altroTitoloDiStudioAggressore_error_msg").text(
						"Compila il campo");
				flag = true;
			}

		}

		if ($("#selectProfessioneAggressore option:selected").text() == "Altro") {
			if ($("#altro_stato_occupazionale_aggressore").val() != "") {
				if (re.test($("#altro_stato_occupazionale_aggressore").val())) {
					$("#altro_stato_occupazionale_aggressore").css(
							"border-color", "");
					$("#altro_stato_occupazionale_aggressore_error_msg").text(
							"");
				} else {
					$("#altro_stato_occupazionale_aggressore").css(
							"border-color", "red");
					$("#altro_stato_occupazionale_aggressoree_error_msg").text(
							"Input non valido");
					flag = true;
				}
			} else {
				$("#altro_stato_occupazionale_aggressore").css("border-color",
						"red");
				$("#altro_stato_occupazionale_aggressore_error_msg").text(
						"Compila il campo");
				flag = true;
			}

		}

		if ($("#rapporto_vittima_autore_violenza option:selected").text() == "Familiare") {
			if ($("#tipologia_familiare option:selected").text() == "Scegli...") {
				$("#tipologia_familiare").css("border-color", "red");
				$("#tipologia_familiare_error_msg").text("Compila il campo");
				flag = true;
			} else {
				$("#tipologia_familiare").css("border-color", "");
				$("#tipologia_familiare_error_msg").text("");
			}
		}

		if ($("#rapporto_vittima_autore_violenza option:selected").text() == "Altro") {
			if ($("#altroRapportoVittimaAggressore").val() != "") {
				$("#altroRapportoVittimaAggressore").css("border-color", "");
				$("#altroRapportoVittimaAggressore_error_msg").text("");
				/*
				if(re.test($("#altroRapportoVittimaAggressore").val()))
				{
					$("#altroRapportoVittimaAggressore").css("border-color","");
					$("#altroRapportoVittimaAggressore_error_msg").text("");
				}
				else
				{
					$("#altroRapportoVittimaAggressore").css("border-color","red");
					$("#altroRapportoVittimaAggressore_error_msg").text("Input non valido");
					flag=true;
				}
				 */
			} else {
				$("#altroRapportoVittimaAggressore").css("border-color", "red");
				$("#altroRapportoVittimaAggressore_error_msg").text(
						"Compila il campo");
				flag = true;
			}

		}

		if ($("input[name='aggressore_servizi']:checked").val() == 'Si') {
			if ($("#tipologia_servizi_aggressore option:selected").text() == "Scegli...") {
				$("#tipologia_servizi_aggressore").css("border-color", "red");
				$("#tipologia_servizi_aggressore_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$("#tipologia_servizi_aggressore").css("border-color", "");
				$("#tipologia_servizi_aggressore_error_msg").text("");
			}
		}

		if ($("#tipologia_servizi_aggressore option:selected").text() == "Altro") {
			if ($("#altroTipologiaServiziAggressore").val() != "") {
				if (re.test($("#altroTipologiaServiziAggressore").val())) {
					$("#altroTipologiaServiziAggressore").css("border-color",
							"");
					$("#altroTipologiaServiziAggressore_error_msg").text("");
				} else {
					$("#altroTipologiaServiziAggressore").css("border-color",
							"red");
					$("#altroTipologiaServiziAggressore_error_msg").text(
							"Input non valido");
					flag = true;
				}
			} else {
				$("#altroTipologiaServiziAggressore")
						.css("border-color", "red");
				$("#altroTipologiaServiziAggressore_error_msg").text(
						"Compila il campo");
				flag = true;
			}

		}

		if (flag) {
			//$('#myModalError').modal('show'); 
			$('#error_msg_footer').text("Campi non correttamente compilati");
			return false;
		}
		$('#error_msg_footer').text("");
		return true;
	}

	function question5() {
		flag = false;

		if ($("input[name='brief_risk_1']:checked").val() == undefined) {
			$('#brief_risk_1_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#brief_risk_1_error_msg').text("");
		}

		if ($("input[name='brief_risk_2']:checked").val() == undefined) {
			$('#brief_risk_2_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#brief_risk_2_error_msg').text("");
		}

		if ($("input[name='brief_risk_3']:checked").val() == undefined) {
			$('#brief_risk_3_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#brief_risk_3_error_msg').text("");
		}

		if ($("input[name='brief_risk_4']:checked").val() == undefined) {
			$('#brief_risk_4_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#brief_risk_4_error_msg').text("");
		}

		if ($("input[name='brief_risk_5']:checked").val() == undefined) {
			$('#brief_risk_5_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#brief_risk_5_error_msg').text("");
		}

		if ($("input[name='brief_risk_6']:checked").val() == undefined) {
			$('#brief_risk_6_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#brief_risk_6_error_msg').text("");
		}

		if ($("input[name='brief_risk_7']:checked").val() == undefined) {
			$('#brief_risk_7_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#brief_risk_7_error_msg').text("");
		}

		if ($("input[name='faseDiSeparazione']:checked").val() == undefined) {
			$('#faseDiSeparazione_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#faseDiSeparazione_error_msg').text("");
		}

		if ($("input[name='separata']:checked").val() == undefined) {
			$('#separata_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#separata_error_msg').text("");

		}

		if ($("input[name='separata']:checked").val() == 'Si') {
			if ($("#tempo_separazione_select option:selected").text() == "Scegli...") {
				$("#tempo_separazione_select").css("border-color", "red");
				$("#tempo_separazione_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$("#tempo_separazione_select").css("border-color", "");
				$("#tempo_separazione_select_error_msg").text("");
			}
		}

		if ($("input[name='haComunicatoAlPartner']:checked").val() == undefined) {
			$('#haComunicatoAlPartner_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#haComunicatoAlPartner_error_msg').text("");

		}

		if ($("input[name='sporgereDenuncia']:checked").val() == undefined) {
			$('#sporgereDenuncia_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#sporgereDenuncia_error_msg').text("");

		}

		if ($("input[name='sportoDenuncia']:checked").val() == undefined) {
			$('#sportoDenuncia_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#sportoDenuncia_error_msg').text("");

		}

		if ($("input[name='sportoDenuncia']:checked").val() == 'Si') {
			if ($("#selectForzeDellOrdineDenuncia option:selected").text() == "Scegli...") {
				$("#selectForzeDellOrdineDenuncia").css("border-color", "red");
				$("#selectForzeDellOrdineDenuncia_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$("#selectForzeDellOrdineDenuncia").css("border-color", "");
				$("#selectForzeDellOrdineDenuncia_error_msg").text("");
			}

			if ($("#provincia_denuncia_select option:selected").text() == "Scegli...") {
				$("#provincia_denuncia_select").css("border-color", "red");
				$("#provincia_denuncia_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$("#provincia_denuncia_select").css("border-color", "");
				$("#provincia_denuncia_select_error_msg").text("");
			}

			if ($("#comune_denuncia_select option:selected").text() == "Scegli...") {
				$("#comune_denuncia_select").css("border-color", "red");
				$("#comune_denuncia_select_error_msg").text("Compila il campo");
				flag = true;
			} else {
				$("#comune_denuncia_select").css("border-color", "");
				$("#comune_denuncia_select_error_msg").text("");
			}
		}

		if ($("input[name='ritiratoDenuncia']:checked").val() == undefined) {
			$('#ritiratoDenuncia_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#ritiratoDenuncia_error_msg').text("");

		}

		if ($("input[name='ritiratoDenuncia']:checked").val() == 'Si') {
			if ($("#motivoRitiroDenuncia_select option:selected").text() == "Scegli...") {
				$("#motivoRitiroDenuncia_select").css("border-color", "red");
				$("#motivoRitiroDenuncia_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$("#motivoRitiroDenuncia_select").css("border-color", "");
				$("#motivoRitiroDenuncia_select_error_msg").text("");
			}
		}

		if ($("input[name='valutazione_stato_bisogno']:checked").val() == undefined) {
			$('#valutazione_stato_bisogno_error_msg').text("Compila il campo");
			flag = true;
		} else {

			if ($("input[name='valutazione_stato_bisogno']:checked").val() == "Altro") {
				if ($("#specificare_altro_ValutazioneStatoBisogno").val() != "") {
					if (re.test($("#specificare_altro_ValutazioneStatoBisogno")
							.val())) {
						$("#specificare_altro_ValutazioneStatoBisogno").css(
								"border-color", "");
						$(
								"#specificare_altro_ValutazioneStatoBisogno_error_msg")
								.text("");
					} else {
						$("#specificare_altro_ValutazioneStatoBisogno").css(
								"border-color", "red");
						$(
								"#specificare_altro_ValutazioneStatoBisogno_error_msg")
								.text("Input non valido");
						flag = true;
					}
				} else {
					$("#specificare_altro_ValutazioneStatoBisogno").css(
							"border-color", "red");
					$("#specificare_altro_ValutazioneStatoBisogno_error_msg")
							.text("Compila il campo");
					flag = true;
				}
			} else {
				$('#valutazione_stato_bisogno_error_msg').text("");
			}
		}

		if ($("input[name='presaInCarico']:checked").val() == undefined) {
			$('#presaInCarico_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#presaInCarico_error_msg').text("");
		}

		if ($("input[name='accesso_occasionale']:checked").val() == "No - In carico al servizio"
				&& $("input[name='prestazioniEffettuate']:checked").val() == undefined) {
			$('#prestazioniEffettuate_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#prestazioniEffettuate_error_msg').text("");
		}

		if ($("#attivazioneRete_select option:selected").text() == "Scegli...") {
			$('#attivazioneRete_select_error_msg').text("Compila il campo");
			$('#attivazioneRete_select').css("border-color", "red");
			flag = true;
		} else {
			$('#attivazioneRete_select_error_msg').text("");
			$('#attivazioneRete_select').css("border-color", "");
		}

		if ($("#attivazioneRete_select option:selected").text() == "Pronto Soccorso") {
			if ($('#attivazioneRete_prontosoccorso_select option:selected')
					.text() == "Scegli...") {
				$('#attivazioneRete_prontosoccorso_select').css("border-color",
						"red");
				$("#attivazioneRete_prontosoccorso_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$('#attivazioneRete_prontosoccorso_select').css("border-color",
						"");
				$("#attivazioneRete_prontosoccorso_select_error_msg").text("");
			}

			if ($(
					'#attivazioneRete_provincia_prontosoccorso_select option:selected')
					.text() == "Scegli...") {
				$('#attivazioneRete_provincia_prontosoccorso_select').css(
						"border-color", "red");
				$("#attivazioneRete_provincia_prontosoccorso_select_error_msg")
						.text("Compila il campo");
				flag = true;
			} else {
				$('#attivazioneRete_provincia_prontosoccorso_select').css(
						"border-color", "");
				$("#attivazioneRete_provincia_prontosoccorso_select_error_msg")
						.text("");
			}

			if ($(
					'#attivazioneRete_comune_prontosoccorso_select option:selected')
					.text() == "Scegli...") {
				$('#attivazioneRete_comune_prontosoccorso_select').css(
						"border-color", "red");
				$("#attivazioneRete_comune_prontosoccorso_select_error_msg")
						.text("Compila il campo");
				flag = true;
			} else {
				$('#attivazioneRete_comune_prontosoccorso_select').css(
						"border-color", "");
				$("#attivazioneRete_comune_prontosoccorso_select_error_msg")
						.text("");
			}
		}

		if ($("#attivazioneRete_select option:selected").text() == "Forze dell'Ordine") {
			if ($('#attivazioneRete_forzedellordine_select option:selected')
					.text() == "Scegli...") {
				$('#attivazioneRete_forzedellordine_select').css(
						"border-color", "red");
				$("#attivazioneRete_forzedellordine_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$('#attivazioneRete_forzedellordine_select').css(
						"border-color", "");
				$("#attivazioneRete_forzedellordine_select_error_msg").text("");
			}

			if ($(
					'#attivazioneRete_provincia_forzedellordine_select option:selected')
					.text() == "Scegli...") {
				$('#attivazioneRete_provincia_forzedellordine_select').css(
						"border-color", "red");
				$("#attivazioneRete_provincia_forzedellordine_select_error_msg")
						.text("Compila il campo");
				flag = true;
			} else {
				$('#attivazioneRete_provincia_forzedellordine_select').css(
						"border-color", "");
				$("#attivazioneRete_provincia_forzedellordine_select_error_msg")
						.text("");
			}

			if ($(
					'#attivazioneRete_comune_forzedellordine_select option:selected')
					.text() == "Scegli...") {
				$('#attivazioneRete_comune_forzedellordine_select').css(
						"border-color", "red");
				$("#attivazioneRete_comune_forzedellordine_select_error_msg")
						.text("Compila il campo");
				flag = true;
			} else {
				$('#attivazioneRete_comune_forzedellordine_select').css(
						"border-color", "");
				$("#attivazioneRete_comune_forzedellordine_select_error_msg")
						.text("");
			}
		}

		//Ho inserito il codice qua
		//Vedi qua
		if ($("#attivazioneRete_select option:selected").text() == "Servizi Sociali") {
			if ($('#serviziSociali_provincia_select option:selected').text() == "Scegli...") {
				$('#serviziSociali_provincia_select')
						.css("border-color", "red");
				$("#serviziSociali_provincia_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$('#serviziSociali_provincia_select').css("border-color", "");
				$("#serviziSociali_provincia_select_error_msg").text("");
			}
		}

		if ($("#attivazioneRete_select option:selected").text() == "Servizio Sanitario") {
			if ($('#servizioSanitario_provincia_select option:selected').text() == "Scegli...") {
				$('#servizioSanitario_provincia_select').css("border-color",
						"red");
				$("#servizioSanitario_provincia_select_error_msg").text(
						"Compila il campo");
				flag = true;
			} else {
				$('#servizioSanitario_provincia_select')
						.css("border-color", "");
				$("#servizioSanitario_provincia_select_error_msg").text("");
			}
		}

		if (flag) {
			//$('#myModalError').modal('show'); 
			$('#error_msg_footer').text("Campi non correttamente compilati");
			return false;
		}
		$('#error_msg_footer').text("");
		return true;

	}

	function stampa() {
		var doc = new jsPDF('p', 'pt', [ 595.28, 841.89 ]);

		var tab = "";
		var tab2 = "";
		var tab3 = "";
		var tab4 = "";
		var tab5 = "";

		// Domande: 1 Dati della scheda
		var identificativo_scheda = question.answer1;
		var data_compilazione = question.answer2;
		var nome_compilatore = question.answer3;
		var cognome_compilatore = question.answer4;
		var ruoloCompilatore_select = question.answer5;
		var altroruolocompilatore = question.answer6;
		var identificativoServizio_select = question.answer7;
		var altroIdentificativoServizio = question.answer8;
		var prontosoccorso_select = question.answer9;
		var provincia_prontosoccorso_select = question.answer10;
		var comune_prontosoccorso_select = question.answer11;
		var cav_nome = question.answer12;
		var provincia_cav_select = question.answer13;
		var comune_cav_select = question.answer14;
		var sportelloDiAscolto_select = question.answer15;
		var sportello_nome = question.answer16;
		var provincia_sportellodiascolto_select = question.answer17;
		var comune_sportellodiascolto_select = question.answer18;

		//Domande: 2 dati Anagrafici della donna
		var nome_vittima = question.answer19;
		var cognome_vittima = question.answer20;
		var data_nascita = question.answer21;
		var luogo_select = question.answer22;
		var provincia_nascita_select = question.answer23;
		var comune_nascita_select = question.answer24;
		var indirizzo = question.answer25;
		var telefono_personale = question.answer26;
		var altro_telefono = question.answer27;
		var cittadinanza = question.answer28;
		var cittadinanza_select = question.answer29;
		var select_lingua_italiana = question.answer30;
		var mediatoreCulturale = question.answer31;
		var statoCivile = question.answer32;
		var altrostatocivile = question.answer33;
		var figli = question.answer34;
		var numero_figli = question.answer35;
		var numero_figli_minorenni = question.answer36;
		var numero_figli_minorenni_maschi = question.answer37;
		var numero_figli_minorenni_femmine = question.answer38;
		var convivono_figliFemmine = question.answer39;
		var assistonoViolenza_figli = question.answer40;
		var subisconoViolenza_figli = question.answer41;
		var selectTitoloDiStudio = question.answer42;
		var altroTitoloDiStudio = question.answer43;
		var selectProfessione = question.answer44;
		var altro_stato_occupazionale_donna = question.answer45;
		var autonomo_economicamente = question.answer46;

		//Domande:3 Tipologia della Violenza
		var primo_accesso_servizio_antiviolenza = question.answer47;
		var numero_accessi_ripetuti = question.answer48;
		var accesso_occasionale = question.answer49;
		var selectDonnaAccompagnataAlServizioAntiviolenza = question.answer50;
		var donnaaccompagnata_forzedellordine_select = question.answer51;
		var provincia_donnaaccompagnata_forzedellordine_select = question.answer52;
		var comune_donnaaccompagnata_forzedellordine_select = question.answer53;
		var donnaaccompagnata_prontosoccorso_select = question.answer54;
		var provincia_donnaaccompagnata_prontosoccorso_select = question.answer55;
		var comune_donnaaccompagnata_prontosoccorso_select = question.answer56;
		var selectDonnaAccompagnataDaAltrePersoneInSA = question.answer57;
		var altroDonnaAccompagnataInPS = question.answer58;
		var motivoAccesso = question.answer59;
		var selectTipologiaViolenza = question.answer60;
		var sfruttamento = question.answer61;
		var violenzeRiferite = question.answer62;
		var altroViolenzaRiferita = question.answer63;

		//Domande:4 Presunto autore della Violenza
		var conosci_aggressore = question.answer64;
		var nome_presunto_aggressore = question.answer65;
		var cognome_presunto_aggressore = question.answer66;
		var data_nascita_presunto_aggressore = question.answer67;
		var luogo_presunto_aggressore_select = question.answer68;
		var provincia_nascita_presunto_aggressore_select = question.answer69;
		var comune_nascita_presunto_aggressore_select = question.answer70;
		var indirizzo_presunto_aggressore = question.answer71;
		var telefono_presunto_aggressore = question.answer72;
		var selectTitoloDiStudioAggressore = question.answer73;
		var altroTitoloDiStudioAggressore = question.answer74;
		var selectProfessioneAggressore = question.answer75;
		var altro_stato_occupazionale_aggressore = question.answer76;
		var fascia_di_eta_aggressore = question.answer77;
		var rapporto_vittima_autore_violenza = question.answer78;
		var tipologia_familiare = question.answer79;
		var altroRapportoVittimaAggressore = question.answer80;
		var aggressore_servizi = question.answer81;
		var tipologia_servizi_aggressore = question.answer82;
		var altroTipologiaServiziAggressore = question.answer83;
		var violenza_assistitaosubita = question.answer84;
		var precedenti_penali = question.answer85;

		//Domande:5 Valutazioni
		var brief_risk_1 = question.answer86;
		var brief_risk_2 = question.answer87;
		var brief_risk_3 = question.answer88;
		var brief_risk_4 = question.answer89;
		var brief_risk_5 = question.answer90;
		var brief_risk_6 = question.answer91;
		var brief_risk_7 = question.answer92;
		var faseDiSeparazione = question.answer93;
		var separata = question.answer94;
		var tempo_separazione_select = question.answer95;
		var haComunicatoAlPartner = question.answer96;
		var sporgereDenuncia = question.answer97;
		var sportoDenuncia = question.answer98;
		var selectForzeDellOrdineDenuncia = question.answer99;
		var provincia_denuncia_select = question.answer100;
		var comune_denuncia_select = question.answer101;
		var ritiratoDenuncia = question.answer102;
		var motivoRitiroDenuncia_select = question.answer103;
		var valutazione_stato_bisogno = question.answer104;
		var specificare_altro_ValutazioneStatoBisogno = question.answer105;
		var presaInCarico = question.answer106;
		var prestazioniEffettuate = question.answer107;
		var attivazioneRete_select = question.answer108;
		var attivazioneRete_prontosoccorso_select = question.answer109;
		var attivazioneRete_provincia_prontosoccorso_select = question.answer110;
		var attivazioneRete_comune_prontosoccorso_select = question.answer111;
		var attivazioneRete_forzedellordine_select = question.answer112;
		var attivazioneRete_provincia_forzedellordine_select = question.answer113;
		var attivazioneRete_comune_forzedellordine_select = question.answer114;
		var servizioSanitario_provincia_select = question.answer115;
		var serviziSociali_provincia_select = question.answer116;

		tab = "Identificativo scheda:\n" + identificativo_scheda + "\n";
		tab += "Data compilazione:\n" + data_compilazione + "\n";
		tab += "Nome del compilatore:\n" + nome_compilatore + "\n";
		tab += "Cognome del compilatore:\n" + cognome_compilatore + "\n";
		tab += "Ruolo del compilatore:\n" + ruoloCompilatore_select + "\n";

		if (ruoloCompilatore_select == "Altro")
			tab += "Altro:\n" + altroruolocompilatore + "\n";

		tab += "Identificativo servizio:\n" + identificativoServizio_select
				+ "\n";

		if (identificativoServizio_select == 'Altro')
			tab += "Altro:\n" + altroIdentificativoServizio + "\n";

		if (identificativoServizio_select == 'Centro di prima assistenza psicologica') {
			tab += "Pronto Soccorso:\n" + prontosoccorso_select + "\n";
			tab += "Provincia:\n" + provincia_prontosoccorso_select + "\n";
			tab += "Comune:\n" + comune_prontosoccorso_select + "\n";
		}

		if (identificativoServizio_select == 'Centro Antiviolenza') {
			tab += "Centro Antiviolenza:\n" + cav_nome + "\n";
			tab += "Provincia:\n" + provincia_cav_select + "\n";
			tab += "Comune:\n" + comune_cav_select + "\n";
		}

		if (identificativoServizio_select == 'Sportello di ascolto') {
			tab += "Sportello di ascolto:\n" + sportelloDiAscolto_select + "\n";
			tab += "Nome:\n" + sportello_nome + "\n";
			tab += "Provincia:\n" + provincia_sportellodiascolto_select + "\n";
			tab += "Comune:\n" + comune_sportellodiascolto_select + "\n";
		}

		tab2 += "Nome:\n" + nome_vittima + "\n";
		tab2 += "Cognome:\n" + cognome_vittima + "\n";
		tab2 += "Data di Nascita:\n" + data_nascita + "\n";
		tab2 += "Luogo di Nascita:\n" + luogo_select + "\n";
		tab2 += "Residente/Domiciliata in Provincia di:\n"
				+ provincia_nascita_select + "\n";
		tab2 += "Residente/Domiciliata nel Comune di:\n"
				+ comune_nascita_select + "\n";
		tab2 += "Indirizzo:\n" + indirizzo + "\n";
		tab2 += "Telefono personale:\n" + telefono_personale + "\n";
		tab2 += "Altro telefono:\n" + altro_telefono + "\n";
		tab2 += "Cittadinanza Italiana:\n" + cittadinanza + "\n";
		if (cittadinanza == "No")
			tab2 += "Cittadinanza:\n" + cittadinanza_select + "\n";

		tab2 += "Conoscenza lingua italiana:\n" + select_lingua_italiana + "\n";
		if (select_lingua_italiana == "Poco" || select_lingua_italiana == "No")
			tab2 += "Mediatore culturale:\n" + mediatoreCulturale + "\n";

		tab2 += "Stato civile:\n" + statoCivile + "\n";
		if (statoCivile == "Altro")
			tab2 += "Altro stato civile:\n" + altrostatocivile + "\n";

		tab2 += "Figli: " + figli + "\n";
		if (figli == "Si") {
			tab2 += "Numero totali di figli:\n" + numero_figli + "\n";
			tab2 += "Di cui minorenni:\n" + numero_figli_minorenni + "\n";
			tab2 += "Di cui maschi:\n" + numero_figli_minorenni_maschi + "\n";
			tab2 += "Di cui femmine:\n" + numero_figli_minorenni_femmine + "\n";
			tab2 += "I figli convivono con la madre?\n"
					+ convivono_figliFemmine + "\n";
			tab2 += "I figli assistono alla violenza?\n"
					+ assistonoViolenza_figli + "\n";
			tab2 += "I figli subiscono violenza diretta?\n"
					+ subisconoViolenza_figli + "\n";
		}

		tab2 += "Titolo di studio:\n" + selectTitoloDiStudio + "\n";
		if (selectTitoloDiStudio == "Altro")
			tab2 += "Altro titolo di studio:\n" + altroTitoloDiStudio + "\n";

		tab2 += "Stato occupazionale: " + selectProfessione + "\n";
		if (selectProfessione == "Altro")
			tab2 += "Altro stato occupazionale:\n"
					+ altro_stato_occupazionale_donna + "\n";

		tab2 += "Autonomo economicamente:\n" + autonomo_economicamente + "\n";

		tab3 += "Primo accesso al Servizio Antiviolenza:\n"
				+ primo_accesso_servizio_antiviolenza + "\n";
		if (primo_accesso_servizio_antiviolenza == "No") {
			tab3 += "Numero accessi precedenti:\n" + numero_accessi_ripetuti
					+ "\n";
			tab3 += "Accesso occasionale?\n" + accesso_occasionale + "\n";
		}

		tab3 += "La donna accede al Servizio Antiviolenza:\n"
				+ selectDonnaAccompagnataAlServizioAntiviolenza + "\n";

		if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata dalle Forze dell'Ordine") {
			tab3 += "Forze dell\'Ordine:\n"
					+ donnaaccompagnata_forzedellordine_select + "\n";
			tab3 += "Pronvincia:\n"
					+ provincia_donnaaccompagnata_forzedellordine_select + "\n";
			tab3 += "Comune:\n"
					+ comune_donnaaccompagnata_forzedellordine_select + "\n";
		}
		if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata dal Pronto Soccorso") {
			tab3 += "Pronto Soccorso:\n"
					+ donnaaccompagnata_prontosoccorso_select + "\n";
			tab3 += "Provincia:\n"
					+ provincia_donnaaccompagnata_prontosoccorso_select + "\n";
			tab3 += "Comune:\n"
					+ comune_donnaaccompagnata_prontosoccorso_select + "\n";
		}
		if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata da altre persone")
			tab3 += "Accompagnata da:\n"
					+ selectDonnaAccompagnataDaAltrePersoneInSA + "\n";

		if (selectDonnaAccompagnataAlServizioAntiviolenza == "Altro")
			tab3 += "Altro:\n" + altroDonnaAccompagnataInPS + "\n";

		tab3 += "Motivo dell\'Accesso:\n" + motivoAccesso + "\n";

		tab3 += "Tipologia della violenza riferita:\n"
				+ selectTipologiaViolenza + "\n";
		if (selectTipologiaViolenza == "Altro")
			tab3 += "Altro:\n" + altroViolenzaRiferita + "\n";

		if (selectTipologiaViolenza == "Violenza domestica"
				|| selectTipologiaViolenza == "Violenza extra domestica")
			tab3 += "Violenza domestica:\n" + sfruttamento + violenzeRiferite
					+ "\n";

		tab4 += "Conosce il presunto autore della violenza?\n"
				+ conosci_aggressore + "\n";

		if (conosci_aggressore == "Si") {
			tab4 += "Nome:\n" + nome_presunto_aggressore + "\n";
			tab4 += "Cognome:\n" + cognome_presunto_aggressore + "\n";
			tab4 += "Data di Nascita:\n" + data_nascita_presunto_aggressore
					+ "\n";
			tab4 += "Luogo di Nascita:\n" + luogo_presunto_aggressore_select
					+ "\n";
			tab4 += "Residente/Domiciliato in Provincia di:\n"
					+ provincia_nascita_presunto_aggressore_select + "\n";
			tab4 += "Residente/Domiciliato nel Comune di:\n"
					+ comune_nascita_presunto_aggressore_select + "\n";
			tab4 += "Indirizzo:\n" + indirizzo_presunto_aggressore + "\n";
			tab4 += "Telefono personale:\n" + telefono_presunto_aggressore
					+ "\n";
			tab4 += "Titolo di studio:\n" + selectTitoloDiStudioAggressore
					+ "\n";
			if (selectTitoloDiStudioAggressore == "Altro")
				tab4 += "Altro titolo di studio:\n"
						+ altroTitoloDiStudioAggressore + "\n";

			tab4 += "Stato occupazionale:\n" + selectProfessioneAggressore
					+ "\n";
			if (selectProfessioneAggressore == "Altro")
				tab4 += "Altro titolo di studio:\n"
						+ altro_stato_occupazionale_aggressore + "\n";

			tab4 += "Fascia di età:\n" + fascia_di_eta_aggressore + "\n";
			tab4 += "Rapporto vittima/presunto autore di violenza:\n"
					+ rapporto_vittima_autore_violenza + "\n";
			if (rapporto_vittima_autore_violenza == "Familiare")
				tab4 += "Familiare:\n" + tipologia_familiare + "\n";

			if (tipologia_familiare == "Altro")
				tab4 += "Altro:\n" + altroRapportoVittimaAggressore + "\n";

			tab4 += "Il presunto autore della violenza è in carico ai servizi (SERT, DSM, ...):\n"
					+ aggressore_servizi + "\n";
			if (aggressore_servizi == "Si") {
				tab4 += "Tipologia servizi:\n" + tipologia_servizi_aggressore
						+ "\n";
				if (tipologia_servizi_aggressore == "Altro")
					tab4 += "Altro:\n" + altroTipologiaServiziAggressore + "\n";

			}

			tab4 += "Violenza assistita o subita nella famiglia di origine:\n"
					+ violenza_assistitaosubita + "\n";
			tab4 += "Precedenti penali:\n" + precedenti_penali + "\n";

		}

		tab5 += "La frequenza e/o la gravità degli atti di violenza fisica sono aumentati\nnegli ultimi 6 mesi?\n"
				+ brief_risk_1 + "\n";
		tab5 += "L\'aggressore ha mai utilizzato un\'arma, o l\'ha minacciata con un\'arma, o ha \ntentato di strangolarla?\n"
				+ brief_risk_2 + "\n";
		tab5 += "Pensa che l\'aggressore possa farle del male (ucciderla)?\n"
				+ brief_risk_3 + "\n";
		tab5 += "L\'ha mai picchiata durante la gravidanza?\n" + brief_risk_4
				+ "\n";
		tab5 += "L\'aggressore è violentemente e costantemente geloso di lei?\n"
				+ brief_risk_5 + "\n";
		tab5 += "Riferisce Escalation della violenza?\n" + brief_risk_6 + "\n";
		tab5 += "Il presunto autore ha violato misure cautelari e/o interdittive?\n"
				+ brief_risk_7 + "\n";

		tab5 += "La donna è in fase di separazione?\n" + faseDiSeparazione
				+ "\n";
		tab5 += "La donna è separata?\n" + separata + "\n";
		if (separata == "Si")
			tab5 += "Periodo di tempo:\n" + tempo_separazione_select + "\n";

		tab5 += "La donna ha comunicato la decisione di separarsi?\n"
				+ haComunicatoAlPartner + "\n";
		tab5 += "La donna ha deciso di sporgere denuncia?\n" + sporgereDenuncia
				+ "\n";
		tab5 += "La donna ha deciso di sporgere denuncia?\n" + sportoDenuncia
				+ "\n";

		if (sportoDenuncia == "Si") {
			tab5 += "Presso:\n" + selectForzeDellOrdineDenuncia + "\n";
			tab5 += "Provincia:\n" + provincia_denuncia_select + "\n";
			tab5 += "Comune:\n" + comune_denuncia_select + "\n";
		}

		tab5 += "La donna ha ritirato la denuncia?\n" + ritiratoDenuncia + "\n";
		if (ritiratoDenuncia == "Si")
			tab5 += "La donna ha ritirato la denuncia?\n"
					+ motivoRitiroDenuncia_select + "\n";

		tab5 += "Valutazione dello stato di bisogno:\n"
				+ valutazione_stato_bisogno + "\n";
		if (valutazione_stato_bisogno == "Altro;")
			tab5 += "Altro:\n" + specificare_altro_ValutazioneStatoBisogno
					+ "\n";

		tab5 += "Presa in carico per:\n" + presaInCarico + "\n";
		tab5 += "Prestazioni effettuate:\n" + prestazioniEffettuate + "\n";

		tab5 += "Attivazione della Rete Territoriale Antiviolenza con invio a:\n"
				+ attivazioneRete_select + "\n";

		if (attivazioneRete_select == "Pronto Soccorso") {
			tab5 += "Pronto Soccorso:\n"
					+ attivazioneRete_prontosoccorso_select + "\n";
			tab5 += "Provincia:\n"
					+ attivazioneRete_provincia_prontosoccorso_select + "\n";
			tab5 += "Comune:\n" + attivazioneRete_comune_prontosoccorso_select
					+ "\n";
		}
		if (attivazioneRete_select == "Forze dell'Ordine") {
			tab5 += "Forze dell\'Ordine:\n"
					+ attivazioneRete_forzedellordine_select + "\n";
			tab5 += "Provincia:\n"
					+ attivazioneRete_provincia_forzedellordine_select + "\n";
			tab5 += "Comune:\n" + attivazioneRete_comune_forzedellordine_select
					+ "\n";
		}
		if (attivazioneRete_select == "Servizio Sanitario")
			tab5 += "ASL della Provincia di:\n"
					+ servizioSanitario_provincia_select + "\n";

		if (attivazioneRete_select == "Servizi Sociali")
			tab5 += "Servizi Sociali della Provincia di:\n"
					+ serviziSociali_provincia_select + "\n";

		doc.setFontSize(9);

		var data_orario1 = new Date();

		doc.setFontSize(20);
		doc.text(35, 50, 'Dati della Scheda');

		doc.setFontSize(9);
		doc.text(370, 10,
				'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
						+ data_orario1);
		doc.text(570, 830, '1 of 5');
		doc.text(tab, 40, 70);
		doc.addPage();

		doc.setFontSize(20);
		doc.text(35, 50, 'Dati anagrafici');

		doc.setFontSize(9);
		doc.text(370, 10,
				'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
						+ data_orario1);
		doc.text(570, 830, '2 of 5');
		doc.text(tab2, 40, 70);
		doc.addPage();

		doc.setFontSize(20);
		doc.text(35, 50, 'Tipologia della violenza');

		doc.setFontSize(9);
		doc.text(370, 10,
				'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
						+ data_orario1);
		doc.text(570, 830, '3 of 5');
		doc.text(tab3, 40, 70);
		doc.addPage();

		doc.setFontSize(20);
		doc.text(35, 50, 'Autore della violenza');

		doc.setFontSize(9);
		doc.text(370, 10,
				'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
						+ data_orario1);
		doc.text(570, 830, '4 of 5');
		doc.text(tab4, 40, 70);
		doc.addPage();

		//doc.addImage(myImage, 'JPEG', 10, 180, 250, 151);
		doc.setFontSize(20);
		doc.text(35, 50, 'Rischio e Azioni');

		doc.setFontSize(9);
		doc.text(370, 10,
				'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
						+ data_orario1);
		doc.text(570, 830, '5 of 5');
		doc.text(tab5, 40, 70);

		doc.autoPrint();
		doc.save(identificativo_scheda + '.pdf');
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
                <li><span>Nuova Scheda</span></li>
              </ul>
            </div>
          </div>
          <div class="col-sm-4 clearfix">
            <%@include file="common/user.jsp"%>
          </div>
        </div>
      </div>
      <!-- arrow & direction icon start -->
      <div class="col-12 mt-5">
        <div class="card">
          <div class="card-body" style="text-align: center;">
            <form action="">
              <button type="button" class="btn btn-rounded btn-secondary mb-3" id="button_question1" style="margin: 5px;">1. Dati della scheda</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question2" style="margin: 5px;">2. Dati anagrafici</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question3" style="margin: 5px;">3. Tipologia della violenza</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question4" style="margin: 5px;">4. Autore della violenza</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question5" style="margin: 5px;">5. Rischio e Azioni</button>
            </form>
          </div>
        </div>
      </div>
      <div id="alertSend" class="alert alert-primary" role="alert" hidden="true">
        <h4 align="center" class="alert-heading">Attenzione</h4>
        <p>Sei sicuro di voler inviare la scheda?</p>
        <hr>
        <div align="center">
          <input class="btn btn-rounded btn-primary mb-3" type="button" value="Conferma" onclick="confermaAlertSend();"> 
          <input class="btn btn-rounded btn-primary mb-3" type="button" value="Salva come bozza" onclick="removeAlert();"> 
          <!--  input class="btn btn-rounded btn-primary mb-3" type="button" value="Stampa" onclick="stampa();"-->
        </div>
      </div>
      <!-- page title area end -->
      <div class="main-content-inner">
        <!-- Prima parte -->
        <div class="row" id="question1">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <form action="">
                  <h3>1. Dati della scheda</h3>
                  <!--  <p>Please fill with your details</p> -->
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label h6s">Identificativo scheda</label> <input type="text" class="form-control" id="identificativo_scheda" style="font-size: medium;" disabled>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label h6s"> Data compilazione </label> <input type="text" placeholder="Data Compilazione" id="data_compilazione" disabled style="font-size: medium;" class="form-control">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label h6s">Nome del compilatore</label> <input type="text" value='<%=account.getNome()%> <%=account.getCav()%>' class="form-control" id="nome_compilatore" style="font-size: medium;" disabled>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label h6s">Cognome del compilatore</label> <input type="text" value='<%=account.getCognome()%>' disabled id="cognome_compilatore" style="font-size: medium;" class="form-control">
                    </div>
                  </div>
                  <div class="form-group" id="div_ruoloCompilatore">
                    <label class="form-label"><span class="h6s">Ruolo Compilatore</span>&nbsp;<span id="ruoloCompilatore_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="ruoloCompilatore_select">
                      <option value="Scegli..." selected>Scegli...</option>
                      <option value="Psicologa">Psicologa</option>
                      <option value="Assistente Sociale">Assistente Sociale</option>
                      <option value="Sociologa">Sociologa</option>
                      <option value="Avvocata">Avvocata</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altro_ruoloCompilatore">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Altro</span>&nbsp;<span id="altroruolocompilatore_error_msg" style="color: red;"></span></label> <input type="text" placeholder="Specificare" id="altroruolocompilatore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_identificativoServizio">
                    <label class="form-label"><span class="h6s">Dati identificativi del servizio</span>&nbsp;<span id="identificativoServizio_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="identificativoServizio_select">
                      <option value="Scegli..." selected>Scegli...</option>
                       <option value="CAV (centro antiviolenza)">CAV (centro antiviolenza)</option>
                       <option value="CADM (casa di accoglienza per donne maltrattate o casa rifugio)">CADM (casa di accoglienza per donne maltrattate o casa rifugio)</option>
                       <option value="CAV+CADM">CAV+CADM</option>
                       <option value="Sportello d’ascolto presso Servizio Sociale Comunale">Sportello d’ascolto presso Servizio Sociale Comunale</option>
                       <option value="Sportello d’ascolto presso Caritas/Parrocchia">Sportello d’ascolto presso Caritas/Parrocchia</option>
                       <option value="Sportello d’ascolto presso Ordine Professionale">Sportello d’ascolto presso Ordine Professionale</option>
                       <option value="Sportello d’ascolto presso Organizzazione Sindacale">Sportello d’ascolto presso Organizzazione Sindacale</option>
                       <option value="Sportello d’ascolto presso Procura/Tribunale">Sportello d’ascolto presso Procura/Tribunale</option>
                       <option value="Servizio o sportello d'ascolto c/o Azienda Ospedaliera">Servizio o sportello d'ascolto c/o Azienda Ospedaliera</option>
                       <option value="Sportello d’ascolto presso ASL Dipartimento Salute Mentale">Sportello d’ascolto presso ASL Dipartimento Salute Mentale</option>
                       <option value="Sportello d’ascolto presso Pronto soccorso di presidio ospedaliero ASL">Sportello d’ascolto presso Pronto soccorso di presidio ospedaliero ASL</option>
                       <option value="Sportello d’ascolto presso ASL - SERD - Servizio Dipendenze">Sportello d’ascolto presso ASL - SERD - Servizio Dipendenze</option>
                       <option value="Sportello d’ascolto presso ASL - Distretto sanitario">Sportello d’ascolto presso ASL - Distretto sanitario</option>
                       <option value="Sportello d’ascolto presso Università">Sportello d’ascolto presso Università</option>
                       <option value="Centro di prima assistenza psicologica">Centro di prima assistenza psicologica</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altro_identificativoServizio">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Altro</span>&nbsp;<span id="altroIdentificativoServizio_error_msg" style="color: red;"></span></label> <input type="text" placeholder="Specificare" id="altroIdentificativoServizio" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_centrodiprimaassistenzapsicologica">
                    <div class="form-group" id="div_PS_nome">
                      <div class="form-holder">
                        <label class="form-label" style="font-size: medium;"><span class="h6s">Pronto Soccorso</span>&nbsp;<span id="prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="prontosoccorso_select">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Provincia di</span>&nbsp;<span id="provincia_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_prontosoccorso_select" onChange="addComuniProntoSoccorso();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Comune di</span>&nbsp;<span id="comune_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_prontosoccorso_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="form-group" id="div_cav">
                    <div class="form-group" id="div_cav_nome">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Centro Antiviolenza</span>&nbsp;<span id="cav_nome_error_msg" style="color: red;"></span></label> <input type="text" placeholder="Centro Antiviolenza di" class="form-control" id="cav_nome" style="font-size: medium;">
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Provincia di</span>&nbsp;<span id="provincia_cav_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_cav_select" onChange="addComuniCAV();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Comune di</span>&nbsp;<span id="comune_cav_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_cav_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="form-group" id="div_sportelloDiAscolto">
                    <label class="form-label"><span class="h6s">Sportello di ascolto presso</span>&nbsp;<span id="sportelloDiAscolto_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="sportelloDiAscolto_select">
                      <option value="Scegli..." selected>Scegli...</option>
                      <option value="Caritas/Parrocchia">Caritas/Parrocchia</option>
                      <option value="Ordine Professionale">Ordine Professionale</option>
                      <option value="Comune">Comune</option>
                      <option value="Scuola">Scuola</option>
                      <option value="Organizzazione Sindacale">Organizzazione Sindacale</option>
                      <option value="Procura/Tribunale">Procura/Tribunale</option>
                      <option value="Dipartimento Salute Mentale">Dipartimento Salute Mentale</option>
                      <option value="SERD-Servizio Dipendenze">SERD-Servizio Dipendenze</option>
                      <option value="Distretto sanitario-dip. materno infantile">Distretto sanitario-dip. materno infantile</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_sportelloDiAscoltoLuogo">
                    <div class="form-group" id="div_sportellodiascolto_nome">
                      <div class="form-holder">
                        <label id="sportellodiascolto_nome" class="form-label" style="font-size: medium;"> <span class="h6s">Nome</span>&nbsp;<span id="sportello_nome_error_msg" style="color: red;"></span></label> <input type="text" placeholder="Nome sportello di ascolto" class="form-control" id="sportello_nome" style="font-size: medium;">
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Provincia di</span>&nbsp;<span id="provincia_sportellodiascolto_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_sportellodiascolto_select" onChange="addComuniSportelloDiAscolto();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Comune di</span>&nbsp;<span id="comune_sportellodiascolto_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_sportellodiascolto_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <div class="row" id="question2">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <form action="">
                  <h3>2. Dati anagrafici della donna</h3>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Nome</span>&nbsp;<span id="nome_vittima_error_msg" style="color: red;"></span></label> <input type="text" class="form-control" id="nome_vittima" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Cognome</span>&nbsp;<span id="cognome_vittima_error_msg" style="color: red;"></span></label> <input type="text" id="cognome_vittima" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Data di nascita</span>&nbsp;<span id="data_nascita_error_msg" style="color: red;"></span></label> <input id="data_nascita" style="font-size: medium;" class="form-control" placeholder="gg/mm/aaaa" />
                      <script>
																							$(
																									'#data_nascita')
																									.datepicker(
																											{
																												format : 'dd/mm/yyyy',
																												uiLibrary : 'bootstrap4'
																											});
																						</script>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Luogo di nascita</span>&nbsp;<span id="luogo_select_error_msg" style="color: red;"></span></label>
                      <!--  
											<input type="text"  id="luogo"
												class="form-control" style="font-size:medium;">
												-->
                      <select class="custom-select" id="luogo_select">
                        <option value="Scegli...">Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group row">
                    <button type="button" class="col-sm-2 btn btn-warning" onclick="checkTrace('1')">
                      Verifica accessi&nbsp;&nbsp;<i class="fas fa-user-check"></i>
                    </button>
                    &nbsp;<label class="form-label"><span id="trace_msg1"></span></label>
                  </div>
                  <div class="form-group">
                    <div id="trace_result1"></div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Residente/Domiciliata in Provincia di</span>&nbsp;<span id="provincia_nascita_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_nascita_select" onChange="addComuni();">
                        <option value="Scegli..." selected>Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Residente/Domiciliata nel Comune di</span>&nbsp;<span id="comune_nascita_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_nascita_select">
                        <option selected value="Scegli...">Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Indirizzo</span>&nbsp;<span id="indirizzo_error_msg" style="color: red;"></span></label> <input type="text" id="indirizzo" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Telefono personale</span>&nbsp;<span id="telefono_personale_error_msg" style="color: red;"></span></label> <input type="text" id="telefono_personale" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Altro telefono</span>&nbsp;<span id="altro_telefono_error_msg" style="color: red;"></span></label> <input type="text" id="altro_telefono" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" style="border-color: red;">
                    <label class="form-label"><span class="h6s">Cittadinanza italiana</span>&nbsp;<span id="cittadinanza_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_cittadinanza_italiana" value="Si" name="cittadinanza" class="custom-control-input"> <label class="custom-control-label" for="si_cittadinanza_italiana" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_cittadinanza_italiana" value="No" name="cittadinanza" class="custom-control-input"> <label class="custom-control-label" for="no_cittadinanza_italiana" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_cittadinanza_italiana" value="Dato non dichiarato" name="cittadinanza" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_cittadinanza_italiana" style="font-size: medium;">Dato non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <span id="cittadinanza_select_error_msg" style="color: red;"></span> <select class="custom-select" id="cittadinanza_select">
                        <option value="Scegli...">Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="conoscenza_lingua_italiana">
                    <label class="form-label"><span class="h6s">Conoscenza lingua italiana</span>&nbsp;<span id="select_lingua_italiana_error_msg" style="color: red;"></span></label> <select class="custom-select" id="select_lingua_italiana">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Si" style="font-size: medium;">Si</option>
                      <option value="No" style="font-size: medium;">No</option>
                      <option value="Poco" style="font-size: medium;">Poco</option>
                      <option value="Dato non dichiarato" style="font-size: medium;">Dato non dichiarato</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_mediatore_culturale">
                    <label class="form-label"><span class="h6s">Richiesto mediatore culturale</span>&nbsp;<span id="mediatoreCulturale_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_mediatore" value="Si" name="mediatoreCulturale" class="custom-control-input"> <label class="custom-control-label" for="si_mediatore" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_mediatore" value="No" name="mediatoreCulturale" class="custom-control-input"> <label class="custom-control-label" for="no_mediatore" style="font-size: medium;">No</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_statoCivile">
                    <label class="form-label"><span class="h6s">Stato civile</span>&nbsp;<span id="statoCivile_error_msg" style="color: red;"></span></label> <select class="custom-select" id="statoCivile">
                      <option value="Scegli..." selected>Scegli...</option>
                      <option value="Nubile">Nubile</option>
                      <option value="Coniugata">Coniugata</option>
                      <option value="Separata">Separata</option>
                      <option value="Divorziata">Divorziata</option>
                      <option value="Convivente">Convivente</option>
                      <option value="Vedova">Vedova</option>
                      <option value="Stato non dichiarato">Stato non dichiarato</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altro_statoCivile">
                    <div class="form-holder">
                      <span id="altrostatocivile_error_msg" style="color: red;"></span> <input type="text" placeholder="Specificare" id="altrostatocivile" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div id="nucleoFamiliare">
                    <!--<h3>Nucleo familiare</h3>-->
                    <!--  <p>Please fill with your details</p> -->
                    <div class="form-group">
                      <label class="form-label"><span class="h6s">Figli</span>&nbsp;<span id="figli_error_msg" style="color: red;"></span></label> <br />
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="si_figli" value="Si" name="figli" class="custom-control-input"> <label class="custom-control-label" for="si_figli" style="font-size: medium;">Si</label>
                      </div>
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="no_figli" value="No" name="figli" class="custom-control-input"> <label class="custom-control-label" for="no_figli" style="font-size: medium;">No</label>
                      </div>
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="non_dichiarato_figli" value="Dato non dichiarato" name="figli" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_figli" style="font-size: medium;">Dato non dichiarato</label>
                      </div>
                    </div>
                    <div class="form-group" id="div_eta_figli">
                      <label class="form-label"><span class="h6s">Numero totali di figli</span>&nbsp;<span id="numero_figli_error_msg" style="color: red;"></span></label> <br /> <input type="number" class="form-control" id="numero_figli" value="1" min="1"> <br /> <label class="form-label"><span class="h6s">Di cui minorenni</span>&nbsp;<span id="numero_figli_minorenni_error_msg" style="color: red;"></span></label> <br /> <input type="number" class="form-control" id="numero_figli_minorenni" value="0" min="0"> <br /> <label class="form-label"><span class="h6s">Di cui maschi</span>&nbsp;<span id="numero_figli_minorenni_maschi_error_msg" style="color: red;"></span></label> <br /> <input type="number" class="form-control" id="numero_figli_minorenni_maschi" value="0" min="0"> <br /> <label class="form-label"><span class="h6s">Di cui femmine</span>&nbsp;<span id="numero_figli_minorenni_femmine_error_msg" style="color: red;"></span></label> <br /> <input type="number"
                        class="form-control" id="numero_figli_minorenni_femmine" value="0" min="0"
                      > <br />
                      <div class="form-group" id="div_convivono_figliFemmine">
                        <label class="form-label"><span class="h6s">I figli convivono con la madre?</span>&nbsp;<span id="convivono_figliFemmine_error_msg" style="color: red;"></span></label> <br />
                        <div class="custom-control custom-radio custom-control-inline">
                          <input type="radio" id="si_convivono_figliFemmine" value="Si" name="convivono_figliFemmine" class="custom-control-input"> <label class="custom-control-label" for="si_convivono_figliFemmine" style="font-size: medium;">Si</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                          <input type="radio" id="no_convivono_figliFemmine" value="No" name="convivono_figliFemmine" class="custom-control-input"> <label class="custom-control-label" for="no_convivono_figliFemmine" style="font-size: medium;">No</label>
                        </div>
                      </div>
                      <div class="form-group" id="div_assistitoViolenza">
                        <label class="form-label"><span class="h6s">I figli assistono alla violenza?</span>&nbsp;<span id="assistonoViolenza_figli_error_msg" style="color: red;"></span></label> <br />
                        <div class="custom-control custom-radio custom-control-inline">
                          <input type="radio" id="si_assistanoAllaViolenza" value="Si" name="assistonoViolenza_figli" class="custom-control-input"> <label class="custom-control-label" for="si_assistanoAllaViolenza" style="font-size: medium;">Si</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                          <input type="radio" id="no_assistanoAllaViolenza" value="No" name="assistonoViolenza_figli" class="custom-control-input"> <label class="custom-control-label" for="no_assistanoAllaViolenza" style="font-size: medium;">No</label>
                        </div>
                      </div>
                      <div class="form-group" id="div_subisconoViolenza">
                        <label class="form-label"><span class="h6s">I figli subiscono violenza diretta?</span>&nbsp;<span id="subisconoViolenza_figli_error_msg" style="color: red;"></span></label> <br />
                        <div class="custom-control custom-radio custom-control-inline">
                          <input type="radio" id="si_subisconoViolenza" value="Si" name="subisconoViolenza_figli" class="custom-control-input"> <label class="custom-control-label" for="si_subisconoViolenza" style="font-size: medium;">Si</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                          <input type="radio" id="no_subisconoViolenza" value="No" name="subisconoViolenza_figli" class="custom-control-input"> <label class="custom-control-label" for="no_subisconoViolenza" style="font-size: medium;">No</label>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div id="titoloDiStudio">
                    <div class="form-group">
                      <label class="form-label"><span class="h6s">Titolo di studio</span>&nbsp;<span id="selectTitoloDiStudio_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectTitoloDiStudio">
                        <option value="Scegli..." selected>Scegli...</option>
                        <option value="Nessuno">Nessuno</option>
                        <option value="Licenza elementare">Licenza elementare</option>
                        <option value="Licenza media inferiore">Licenza media inferiore</option>
                        <option value="Diploma superiore">Diploma superiore</option>
                        <option value="Laurea">Laurea</option>
                        <option value="Dato non dichiarato">Dato non dichiarato</option>
                        <option value="Altro">Altro</option>
                      </select>
                    </div>
                    <div class="form-group" id="div_altroTitoloDiStudio">
                      <div class="form-holder">
                        <span id="altroTitoloDiStudio_error_msg" style="color: red;"></span> <input type="text" placeholder="Specificare" id="altroTitoloDiStudio" class="form-control" style="font-size: medium;">
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Stato occupazionale</span>&nbsp;<span id="selectProfessione_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectProfessione">
                      <option value="Scegli..." selected>Scegli...</option>
                      <option value="Operaia">Operaia</option>
                      <option value="Artigiana">Artigiana</option>
                      <option value="Disoccupata">Disoccupata</option>
                      <option value="Pensionata">Pensionata</option>
                      <option value="Imprenditrice">Imprenditrice</option>
                      <option value="Impiegata">Impiegata</option>
                      <option value="Libera professionista">Libera professionista</option>
                      <option value="Dato non dichiarato">Dato non dichiarato</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altro_stato_occupazionale_donna">
                    <label class="form-label"><span class="h6s">Altro</span>&nbsp;<span id="altro_stato_occupazionale_donna_error_msg" style="color: red;"></span> </label> <input type="text" class="form-control" id="altro_stato_occupazionale_donna" placeholder="Specificare">
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Autonomia economica</span>&nbsp;<span id="autonomo_economicamente_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_autonomo_economicamente" value="Si" name="autonomo_economicamente" class="custom-control-input"> <label class="custom-control-label" for="si_autonomo_economicamente" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_autonomo_economicamente" value="No" name="autonomo_economicamente" class="custom-control-input"> <label class="custom-control-label" for="no_autonomo_economicamente" style="font-size: medium;">No</label>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <div class="row" id="question3">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <form action="">
                  <h3>3. Tipologia della violenza</h3>
                  <!--  <p>Please fill with your details</p> -->
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Primo accesso al Servizio Antiviolenza</span>&nbsp;<span id="primo_accesso_servizio_antiviolenza_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_primo_accesso_servizio_antiviolenza" value="Si" name="primo_accesso_servizio_antiviolenza" class="custom-control-input"> <label class="custom-control-label" for="si_primo_accesso_servizio_antiviolenza" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_primo_accesso_servizio_antiviolenza" value="No" name="primo_accesso_servizio_antiviolenza" class="custom-control-input"> <label class="custom-control-label" for="no_primo_accesso_servizio_antiviolenza" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_primo_accesso_servizio_antiviolenza" value="Dato non dichiarato" name="primo_accesso_servizio_antiviolenza" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_primo_accesso_servizio_antiviolenza" style="font-size: medium;">Dato non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group row">
                    <button type="button" class="col-sm-2 btn btn-warning" onclick="checkTrace('2')">
                      Verifica accessi&nbsp;&nbsp;<i class="fas fa-user-check"></i>
                    </button>
                    &nbsp;<label class="form-label"><span id="trace_msg2"></span></label>
                  </div>
                  <div class="form-group">
                    <div id="trace_result2"></div>
                  </div>            
                  <div class="form-group" id="accessi_ripetuti">
                    <label class="form-label"><span class="h6s">Numero accessi precedenti</span>&nbsp;<span id="numero_accessi_ripetuti_error_msg" style="color: red;"></span></label> <br /> <input type="number" class="form-control" id="numero_accessi_ripetuti" value="1" min="1"> <br />
                    <div class="form-group">
                      <label class="form-label"><span class="h6s">Accesso occasionale?</span>&nbsp;<span id="accesso_occasionale_error_msg" style="color: red;"></span></label> <br />
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="si_accesso_occasionale" value="Si" name="accesso_occasionale" class="custom-control-input"> <label class="custom-control-label" for="si_accesso_occasionale" style="font-size: medium;">Si</label>
                      </div>
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="no_accesso_occasionale" value="No - In carico al servizio" name="accesso_occasionale" class="custom-control-input"> <label class="custom-control-label" for="no_accesso_occasionale" style="font-size: medium;">No - In carico al servizio</label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna accede al Servizio Antiviolenza</span>&nbsp;<span id="selectDonnaAccompagnataAlServizioAntiviolenza_error_msg" style="color: red;"></span></label> <br /> <select class="custom-select" id="selectDonnaAccompagnataAlServizioAntiviolenza">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Spontaneamente">Spontaneamente</option>
                      <option value="Inviata dal 1522">Inviata dal 1522</option>
                      <option value="Inviata dalle Forze dell'Ordine">Inviata dalle Forze dell'Ordine</option>
                      <option value="Inviata da operatrici/operatori di altri servizi">Inviata da operatrici/operatori di altri servizi</option>
                      <option value="Inviata dal Pronto Soccorso">Inviata dal Pronto Soccorso</option>
                      <option value="Accompagnata da altre persone">Accompagnata da altre persone</option>
                      <option value="Dato non dichiarato">Dato non dichiarato</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <!-- Inizio qui -->
                  <div class="form-group" id="div_donnaaccompagnata_forzedellordine">
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Forze dell'Ordine</span>&nbsp;<span id="donnaaccompagnata_forzedellordine_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="donnaaccompagnata_forzedellordine_select">
                          <option selected value="Scegli...">Scegli...</option>
                          <option value="Carabinieri">Carabinieri</option>
                          <option value="Polizia">Polizia</option>
                          <option value="Polizia Locale">Polizia Locale</option>
                          <option value="Guardia di Finanza">Guardia di Finanza</option>
                          <option value="Vigili del Fuoco">Vigili del Fuoco</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Della Provincia di</span>&nbsp;<span id="provincia_donnaaccompagnata_forzedellordine_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_donnaaccompagnata_forzedellordine_select" onChange="addComuniDonnaaccompagnata_forzedellordine();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Del Comune di</span>&nbsp;<span id="comune_donnaaccompagnata_forzedellordine_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_donnaaccompagnata_forzedellordine_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <!-- fine -->
                  <!-- Inizio -->
                  <div class="form-group" id="div_donnaaccompagnata_prontosoccorso">
                    <div class="form-group" id="div_donnaaccompagnata_prontosoccorso_nome">
                      <div class="form-holder">
                        <label class="form-label" style="font-size: medium;"><span class="h6s">Pronto Soccorso</span>&nbsp;<span id="donnaaccompagnata_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="donnaaccompagnata_prontosoccorso_select">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Della Provincia di</span>&nbsp;<span id="provincia_donnaaccompagnata_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_donnaaccompagnata_prontosoccorso_select" onChange="addComunidonnaaccompagnata_prontosoccorso();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Del Comune di</span>&nbsp;<span id="comune_donnaaccompagnata_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_donnaaccompagnata_prontosoccorso_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <!--  fine -->
                  <!-- Inizio -->
                  <div class="form-group" id="div_donnaaccompagnata_da_altre_persone">
                    <label class="form-label"><span class="h6s">Accompagnata da</span><span id="selectDonnaAccompagnataDaAltrePersoneInSA_error_msg" style="color: red;"></span></label> <br /> <select class="custom-select" id="selectDonnaAccompagnataDaAltrePersoneInSA">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Familiari">Familiari</option>
                      <option value="Amici">Amici</option>
                      <option value="Colleghi">Colleghi</option>
                      <option value="Conoscenti">Conoscenti</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <!-- fine -->
                  <div class="form-group" id="div_altro_donnaAccompagnataInPS">
                    <div class="form-holder">
                      <span id="altroDonnaAccompagnataInPS_error_msg" style="color: red;"></span> <input type="text" placeholder="Specificare (Es. Amici,Familiari, ecc ...)" id="altroDonnaAccompagnataInPS" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_motivoAccesso">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Motivo dell'accesso</span>&nbsp;<span id="motivoAccesso_error_msg" style="color: red;"></span></label> <br />
                      <textarea class="form-control" id="motivoAccesso" placeholder="La donna riferisce che ..." style="height: 100px;"></textarea>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Tipologia della violenza riferita</span>&nbsp;<span id="selectTipologiaViolenza_error_msg" style="color: red;"></span></label> <br /> <select class="custom-select" id="selectTipologiaViolenza">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Violenza domestica">Violenza domestica</option>
                      <option value="Violenza extra domestica">Violenza extra domestica</option>
                      <option value="Dato non dichiarato">Dato non dichiarato</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <!-- Lascialo -->
                  <div class="form-group" id="div_sfruttamento">
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="sfruttamento1" name="sfruttamento" value="Tratta ai fini dello sfruttamento"> <label class="custom-control-label" for="sfruttamento1">Tratta ai fini dello sfruttamento</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="sfruttamento2" name="sfruttamento" value="Sfruttamento ai fini sessuali"> <label class="custom-control-label" for="sfruttamento2">Sfruttamento ai fini sessuali</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="sfruttamento3" name="sfruttamento" value="Sfruttamento ai fini lavorativi"> <label class="custom-control-label" for="sfruttamento3">Sfruttamento ai fini lavorativi</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="sfruttamento4" name="sfruttamento" value="Sfruttamento ai fini di accattonaggio"> <label class="custom-control-label" for="sfruttamento4">Sfruttamento ai fini di accattonaggio</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="violenzeRiferite1" name="violenzeRiferite" value="Violenze/Maltrattamenti psicologici"> <label class="custom-control-label" for="violenzeRiferite1">Violenze/Maltrattamenti psicologici</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="violenzeRiferite2" name="violenzeRiferite" value="Atti persecutori (Stalking)"> <label class="custom-control-label" for="violenzeRiferite2">Atti persecutori (Stalking)</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="violenzeRiferite3" name="violenzeRiferite" value="Mobbing"> <label class="custom-control-label" for="violenzeRiferite3">Mobbing</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="violenzeRiferite4" name="violenzeRiferite" value="Violenza economica"> <label class="custom-control-label" for="violenzeRiferite4">Violenza economica</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="violenzeRiferite5" name="violenzeRiferite" value="Violenza sessuale"> <label class="custom-control-label" for="violenzeRiferite5">Violenza sessuale</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="violenzeRiferite6" name="violenzeRiferite" value="Mutilazioni genitali"> <label class="custom-control-label" for="violenzeRiferite6">Mutilazioni genitali</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="violenzeRiferite7" name="violenzeRiferite" value="Matrimonio forzato"> <label class="custom-control-label" for="violenzeRiferite7">Matrimonio forzato</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_violenzaRiferita">
                    <div class="form-holder">
                      <span id="altroViolenzaRiferita_error_msg" style="color: red;"></span> <input type="text" placeholder="Descrizione tipologia della violenza prevalente" id="altroViolenzaRiferita" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <!--  Seconda parte -->
        <div class="row" id="question4">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <form action="">
                  <h3>4. Presunto autore della violenza</h3>
                  <div class="form-group">
                    <label class="form-label h6s">Conosce il presunto autore della violenza?</label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_conosci_aggressore" value="Si" name="conosci_aggressore" class="custom-control-input"> <label class="custom-control-label" for="si_conosci_aggressore" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_conosci_aggressore" value="No" name="conosci_aggressore" checked class="custom-control-input"> <label class="custom-control-label" for="no_conosci_aggressore" style="font-size: medium;">No</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_nome_presunto_aggressore">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Nome</span>&nbsp;<span id="nome_presunto_aggressore_error_msg" style="color: red;"></span></label> <input type="text" class="form-control" id="nome_presunto_aggressore" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_cognome_presunto_aggressore">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Cognome</span>&nbsp;<span id="cognome_presunto_aggressore_error_msg" style="color: red;"></span></label> <input type="text" id="cognome_presunto_aggressore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_data_nascita_presunto_aggressore">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Data di nascita</span>&nbsp;<span id="data_nascita_presunto_aggressore_error_msg" style="color: red;"></span></label> <input id="data_nascita_presunto_aggressore" style="font-size: medium;" placeholder="gg/mm/aaaa" />
                      <script>
																							$(
																									'#data_nascita_presunto_aggressore')
																									.datepicker(
																											{
																												format : 'dd/mm/yyyy',
																												uiLibrary : 'bootstrap4'
																											});
																						</script>
                    </div>
                  </div>
                  <div class="form-group" id="div_luogo_presunto_aggressore_select">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Luogo di nascita</span>&nbsp;<span id="luogo_presunto_aggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="luogo_presunto_aggressore_select">
                        <option value="Scegli...">Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="div_provincia_nascita_presunto_aggressore_select">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Residente/Domiciliato in Provincia di</span>&nbsp;<span id="provincia_nascita_presunto_aggressore_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_nascita_presunto_aggressore_select" onChange="addComuniPresunto();">
                        <option value="Scegli..." selected>Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="div_comune_nascita_presunto_aggressore_select">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Residente/Domiciliato nel Comune di</span>&nbsp;<span id="comune_nascita_presunto_aggressore_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_nascita_presunto_aggressore_select">
                        <option selected value="Scegli...">Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="div_indirizzo_presunto_aggressore">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Indirizzo</span>&nbsp;<span id="indirizzo_presunto_aggressore_error_msg" style="color: red;"></span></label> <input type="text" id="indirizzo_presunto_aggressore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_telefono_presunto_aggressore">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Telefono</span>&nbsp;<span id="telefono_presunto_aggressore_error_msg" style="color: red;"></span></label> <input type="text" id="telefono_presunto_aggressore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div id="titoloDiStudio_aggressore">
                    <div class="form-group" id="div_selectTitoloDiStudioAggressore">
                      <label class="form-label"><span class="h6s">Titolo di studio</span>&nbsp;<span id="selectTitoloDiStudioAggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectTitoloDiStudioAggressore">
                        <option selected value="Scegli...">Scegli...</option>
                        <option value="Nessuno">Nessuno</option>
                        <option value="Licenza elementare">Licenza elementare</option>
                        <option value="Licenza media inferiore">Licenza media inferiore</option>
                        <option value="Diploma superiore">Diploma superiore</option>
                        <option value="Laurea">Laurea</option>
                        <option value="Dato non dichiarato">Dato non dichiarato</option>
                        <option value="Altro">Altro</option>
                      </select>
                    </div>
                    <div class="form-group" id="div_altroTitoloDiStudiAggressore">
                      <div class="form-holder">
                        <span id="altroTitoloDiStudioAggressore_error_msg" style="color: red;"></span> <input type="text" placeholder="Specificare" id="altroTitoloDiStudioAggressore" class="form-control" style="font-size: medium;">
                      </div>
                    </div>
                  </div>
                  <div class="form-group" id="div_selectProfessioneAggressore">
                    <label class="form-label"><span class="h6s">Stato occupazionale</span>&nbsp;<span id="selectProfessioneAggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectProfessioneAggressore">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Operaio">Operaio</option>
                      <option value="Artigiano">Artigiano</option>
                      <option value="Disoccupato">Disoccupato</option>
                      <option value="Pensionato">Pensionato</option>
                      <option value="Imprenditore">Imprenditore</option>
                      <option value="Dipendente di pubblica amministrazione">Dipendente di pubblica amministrazione</option>
                      <option value="Impiegato">Impiegato</option>
                      <option value="Libero professionista">Libero professionista</option>
                      <option value="Dato non dichiarato">Dato non dichiarato</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altro_stato_occupazionale_aggressore">
                    <label class="form-label"><span class="h6s">Altro</span>&nbsp;<span id="altro_stato_occupazionale_aggressore_error_msg" style="color: red;"></span> </label> <input type="text" class="form-control" id="altro_stato_occupazionale_aggressore" placeholder="Specificare">
                  </div>
                  <div class="form-group" id="div_fascia_di_eta_aggressore">
                    <label class="form-label"><span class="h6s">Fascia di et&agrave;</span>&nbsp;<span id="fascia_di_eta_aggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="fascia_di_eta_aggressore">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="< 18">&lt; 18</option>
                      <option value="19 - 29">19 - 29</option>
                      <option value="30 - 39">30 - 39</option>
                      <option value="40 - 49">40 - 49</option>
                      <option value="50 - 59">50 - 59</option>
                      <option value="60 - 69">60 - 69</option>
                      <option value="> = 70">&ge; 70</option>
                      <option value="Non dichiarato">Non dichiarato</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_rapporto_vittima_autore_violenza">
                    <label class="form-label"><span class="h6s">Rapporto vittima/presunto autore di violenza</span>&nbsp;<span id="rapporto_vittima_autore_violenza_error_msg" style="color: red;"></span></label> <select class="custom-select" id="rapporto_vittima_autore_violenza">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="Partner">Partner</option>
                      <option value="Ex - Partner">Ex - Partner</option>
                      <option value="Marito">Marito</option>
                      <option value="Ex - Marito">Ex - Marito</option>
                      <option value="Convivente">Convivente</option>
                      <option value="Ex - Convivente">Ex - Convivente</option>
                      <option value="Collega">Collega</option>
                      <option value="Ex - Collega">Ex - Collega</option>
                      <option value="Datore_di_lavoro">Datore di lavoro</option>
                      <option value="Ex - Datore di lavoro">Ex - Datore di lavoro</option>
                      <option value="Familiare">Familiare</option>
                      <option value="Conoscente">Conoscente</option>
                      <option value="Sconosciuto">Sconosciuto</option>
                      <option value="Non dichiarato">Non dichiarato</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <!--  solo se sopra ho selezionato Familiare -->
                  <div class="form-group" id="div_familiare">
                    <label class="form-label"><span class="h6s">Familiare</span>&nbsp;<span id="tipologia_familiare_error_msg" style="color: red;"></span></label> <select class="custom-select" id="tipologia_familiare">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="Padre">Padre</option>
                      <option value="Figlio">Figlio</option>
                      <option value="Fratello">Fratello</option>
                      <option value="Suocero">Suocero</option>
                      <option value="Convivente">Convivente</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altroRapportoVittimaAggressore">
                    <div class="form-holder">
                      <span id="altroRapportoVittimaAggressore_error_msg" style="color: red;"></span> <input type="text" placeholder="Specificare" id="altroRapportoVittimaAggressore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_aggressore_servizi">
                    <label class="form-label"><span class="h6s">Il presunto autore della violenza &egrave; in carico ai servizi (SERD, DSM, ...)</span>&nbsp;<span id="aggressore_servizi_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_aggressore_servizi" value="Si" name="aggressore_servizi" class="custom-control-input"> <label class="custom-control-label" for="si_aggressore_servizi" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_aggressore_servizi" value="No" name="aggressore_servizi" class="custom-control-input"> <label class="custom-control-label" for="no_aggressore_servizi" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_aggressore_servizi" value="Non dichiarato" name="aggressore_servizi" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_aggressore_servizi" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_tipologia_servizi_aggressore">
                    <label class="form-label"><span class="h6s">Tipologia servizi</span>&nbsp;<span id="tipologia_servizi_aggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="tipologia_servizi_aggressore">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="Servizi per le dipendenze patologiche (Serd)">Servizi per le dipendenze patologiche (Serd)</option>
                      <option value="Dipartimento Salute Mentale (DSM)">Dipartimento Salute Mentale (DSM)</option>
                      <option value="Servizi Sociali">Servizi Sociali</option>
                      <option value="Altro">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altroTipologiaServiziAggressore">
                    <div class="form-holder">
                      <span id="altroTipologiaServiziAggressore_error_msg" style="color: red;"></span> <input type="text" placeholder="Specificare" id="altroTipologiaServiziAggressore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <!-- Inizio -->
                  <div class="form-group" id="div_violenza_assistitaosubita">
                    <label class="form-label"><span class="h6s">Violenza assistita o subita nella famiglia di origine</span>&nbsp;<span id="violenza_assistitaosubita_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_violenza_assistitaosubita" value="Si" name="violenza_assistitaosubita" class="custom-control-input"> <label class="custom-control-label" for="si_violenza_assistitaosubita" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_violenza_assistitaosubita" value="No" name="violenza_assistitaosubita" class="custom-control-input"> <label class="custom-control-label" for="no_violenza_assistitaosubita" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_violenza_assistitaosubita" value="Non dichiarato" name="violenza_assistitaosubita" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_violenza_assistitaosubita" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <!-- fine -->
                  <div class="form-group" id="div_precedenti_penali">
                    <label class="form-label"><span class="h6s">Precedenti penali</span>&nbsp;<span id="precedenti_penali_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_precedenti_penali" value="Si" name="precedenti_penali" class="custom-control-input"> <label class="custom-control-label" for="si_precedenti_penali" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_precedenti_penali" value="No" name="precedenti_penali" class="custom-control-input"> <label class="custom-control-label" for="no_precedenti_penali" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_precedenti_penali" value="Non dichiarato" name="precedenti_penali" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_precedenti_penali" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <div class="row" id="question5">
          <!-- arrow & direction icon start -->
          <div class="col-12 mt-5">
            <div class="card">
              <div class="card-body">
                <form action="">
                  <h3>5. Rischio e Azioni</h3>
                  <br /> <label class="form-label h6s"><b>Brief Risk Assessment for the Emergency Department (DA-5). Snider e Campbell, 2</b></label> <br />
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La frequenza e/o la gravità degli atti di violenza fisica sono aumentati negli ultimi 6 mesi?</span>&nbsp;<span id="brief_risk_1_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_brief_risk_1" value="Si" name="brief_risk_1" class="custom-control-input"> <label class="custom-control-label" for="si_brief_risk_1" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_brief_risk_1" value="No" name="brief_risk_1" class="custom-control-input"> <label class="custom-control-label" for="no_brief_risk_1" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_brief_risk_1" value="Non dichiarato" name="brief_risk_1" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_brief_risk_1" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">L’aggressore ha mai utilizzato un’arma, o l’ha minacciata con un’arma, o ha tentato di strangolarla?</span>&nbsp;<span id="brief_risk_2_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_brief_risk_2" value="Si" name="brief_risk_2" class="custom-control-input"> <label class="custom-control-label" for="si_brief_risk_2" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_brief_risk_2" value="No" name="brief_risk_2" class="custom-control-input"> <label class="custom-control-label" for="no_brief_risk_2" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_brief_risk_2" value="Non dichiarato" name="brief_risk_2" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_brief_risk_2" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Pensa che l’aggressore possa farle del male (ucciderla)?</span>&nbsp;<span id="brief_risk_3_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_brief_risk_3" value="Si" name="brief_risk_3" class="custom-control-input"> <label class="custom-control-label" for="si_brief_risk_3" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_brief_risk_3" value="No" name="brief_risk_3" class="custom-control-input"> <label class="custom-control-label" for="no_brief_risk_3" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_brief_risk_3" value="Non dichiarato" name="brief_risk_3" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_brief_risk_3" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">L’ha mai picchiata durante la gravidanza?</span>&nbsp;<span id="brief_risk_4_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_brief_risk_4" value="Si" name="brief_risk_4" class="custom-control-input"> <label class="custom-control-label" for="si_brief_risk_4" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_brief_risk_4" value="No" name="brief_risk_4" class="custom-control-input"> <label class="custom-control-label" for="no_brief_risk_4" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_brief_risk_4" value="Non dichiarato" name="brief_risk_4" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_brief_risk_4" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">L’aggressore &egrave; violentemente e costantemente geloso di lei?</span>&nbsp;<span id="brief_risk_5_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_brief_risk_5" value="Si" name="brief_risk_5" class="custom-control-input"> <label class="custom-control-label" for="si_brief_risk_5" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_brief_risk_5" value="No" name="brief_risk_5" class="custom-control-input"> <label class="custom-control-label" for="no_brief_risk_5" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_brief_risk_5" value="Non dichiarato" name="brief_risk_5" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_brief_risk_5" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <hr />
                  <label class="form-label h6s"><b>Altri fattori</b></label>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Riferisce Escalation della violenza?</span>&nbsp;<span id="brief_risk_6_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_brief_risk_6" value="Si" name="brief_risk_6" class="custom-control-input"> <label class="custom-control-label" for="si_brief_risk_6" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_brief_risk_6" value="No" name="brief_risk_6" class="custom-control-input"> <label class="custom-control-label" for="no_brief_risk_6" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_brief_risk_6" value="Non dichiarato" name="brief_risk_6" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_brief_risk_6" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Il presunto autore ha violato misure cautelari e/o interdittive?</span>&nbsp;<span id="brief_risk_7_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_brief_risk_7" value="Si" name="brief_risk_7" class="custom-control-input"> <label class="custom-control-label" for="si_brief_risk_7" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_brief_risk_7" value="No" name="brief_risk_7" class="custom-control-input"> <label class="custom-control-label" for="no_brief_risk_7" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_brief_risk_7" value="Non dichiarato" name="brief_risk_7" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_brief_risk_7" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <!-- Inserisco qui -->
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna &egrave; in fase di separazione?</span>&nbsp;<span id="faseDiSeparazione_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_faseDiSeparazione" value="Si" name="faseDiSeparazione" class="custom-control-input"> <label class="custom-control-label" for="si_faseDiSeparazione" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_faseDiSeparazione" value="No" name="faseDiSeparazione" class="custom-control-input"> <label class="custom-control-label" for="no_faseDiSeparazione" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_precedenti_faseDiSeparazione" value="Non dichiarato" name="faseDiSeparazione" class="custom-control-input"> <label class="custom-control-label" for="non_precedenti_faseDiSeparazione" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna &egrave; separata?</span>&nbsp;<span id="separata_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_separata" value="Si" name="separata" class="custom-control-input"> <label class="custom-control-label" for="si_separata" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_separata" value="No" name="separata" class="custom-control-input"> <label class="custom-control-label" for="no_separata" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_precedenti_separata" value="Non dichiarato" name="separata" class="custom-control-input"> <label class="custom-control-label" for="non_precedenti_separata" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_tempo_separazione">
                    <label class="form-label"><span class="h6s">Periodo di tempo</span>&nbsp;<span id="tempo_separazione_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="tempo_separazione_select">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="0-6 mesi">0-6 mesi</option>
                      <option value="6 mesi-1 anno">6 mesi-1 anno</option>
                      <option value="Oltre 1 anno">Oltre 1 anno</option>
                    </select>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna ha comunicato la decisione di separarsi?</span>&nbsp;<span id="haComunicatoAlPartner_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_haComunicatoAlPatner" value="Si" name="haComunicatoAlPartner" class="custom-control-input"> <label class="custom-control-label" for="si_haComunicatoAlPatner" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_haComunicatoAlPartner" value="No" name="haComunicatoAlPartner" class="custom-control-input"> <label class="custom-control-label" for="no_haComunicatoAlPartner" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_precedenti_haComunicatoAlPartner" value="Non dichiarato" name="haComunicatoAlPartner" class="custom-control-input"> <label class="custom-control-label" for="non_precedenti_haComunicatoAlPartner" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna ha deciso di sporgere denuncia?</span>&nbsp;<span id="sporgereDenuncia_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_sporgereDenuncia" value="Si" name="sporgereDenuncia" class="custom-control-input"> <label class="custom-control-label" for="si_sporgereDenuncia" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_sporgereDenuncia" value="No" name="sporgereDenuncia" class="custom-control-input"> <label class="custom-control-label" for="no_sporgereDenuncia" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_precedenti_sporgereDenuncia" value="Non dichiarato" name="sporgereDenuncia" class="custom-control-input"> <label class="custom-control-label" for="non_precedenti_sporgereDenuncia" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna ha sporto denuncia?</span>&nbsp;<span id="sportoDenuncia_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_sportoDenuncia" value="Si" name="sportoDenuncia" class="custom-control-input"> <label class="custom-control-label" for="si_sportoDenuncia" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_sportoDenuncia" value="No" name="sportoDenuncia" class="custom-control-input"> <label class="custom-control-label" for="no_sportoDenuncia" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_precedenti_sportoDenuncia" value="Non dichiarato" name="sportoDenuncia" class="custom-control-input"> <label class="custom-control-label" for="non_precedenti_sportoDenuncia" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_forze_dell_ordine_denuncia">
                    <div class="form-group">
                      <label class="form-label"><span class="h6s">Presso</span>&nbsp;<span id="selectForzeDellOrdineDenuncia_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectForzeDellOrdineDenuncia">
                        <option selected value="Scegli...">Scegli...</option>
                        <option value="Carabinieri">Carabinieri</option>
                        <option value="Polizia">Polizia</option>
                      </select>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Nella Provincia di</span>&nbsp;<span id="provincia_denuncia_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="provincia_denuncia_select" onChange="addComuniDenuncia();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Nel Comune di</span>&nbsp;<span id="comune_denuncia_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="comune_denuncia_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna ha ritirato la denuncia?</span>&nbsp;<span id="ritiratoDenuncia_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_ritiratoDenuncia" value="Si" name="ritiratoDenuncia" class="custom-control-input"> <label class="custom-control-label" for="si_ritiratoDenuncia" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_ritiratoDenuncia" value="No" name="ritiratoDenuncia" class="custom-control-input"> <label class="custom-control-label" for="no_ritiratoDenuncia" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_precedenti_ritiratoDenuncia" value="Non dichiarato" name="ritiratoDenuncia" class="custom-control-input"> <label class="custom-control-label" for="non_precedenti_ritiratoDenuncia" style="font-size: medium;">Non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_motivoRitiroDenuncia_select">
                    <span id="motivoRitiroDenuncia_select_error_msg" style="color: red;"></span> <select class="custom-select" id="motivoRitiroDenuncia_select">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Spontaneamente">Spontaneamente</option>
                      <option value="Ha subito minacce/pressioni">Ha subito minacce/pressioni</option>
                    </select>
                  </div>
                  <hr />
                  <!-- Inserisco qui -->
                  <div class="form-group">
                    <label class="form-label"><span class="h6s"><b>Valutazione dello stato di bisogno:</b></span>&nbsp;<span id="valutazione_stato_bisogno_error_msg" style="color: red;"></span></label>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="sostegnoPsicologico" name="valutazione_stato_bisogno" value="Sostegno psicologico"> <label class="custom-control-label" for="sostegnoPsicologico">Sostegno psicologico</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="assistenzaLegale" name="valutazione_stato_bisogno" value="Assistenza Legale"> <label class="custom-control-label" for="assistenzaLegale">Assistenza Legale</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="assistenzaSociale" name="valutazione_stato_bisogno" value="Assistenza Sociale"> <label class="custom-control-label" for="assistenzaSociale">Assistenza Sociale</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="autonomiaEconomica" name="valutazione_stato_bisogno" value="Autonomia Economica"> <label class="custom-control-label" for="autonomiaEconomica">Autonomia Economica</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="ospitalitaFuoriDalProprioDomicilio" name="valutazione_stato_bisogno" value="Ospitalità fuori dal proprio domicilio"> <label class="custom-control-label" for="ospitalitaFuoriDalProprioDomicilio">Ospitalit&agrave; fuori dal proprio domicilio</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="serviziSociali" name="valutazione_stato_bisogno" value="Servizi Sociali"> <label class="custom-control-label" for="serviziSociali">Servizi Sociali</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="altro_ValutazioneStatoBisogno" name="valutazione_stato_bisogno" value="Altro"> <label class="custom-control-label" for="altro_ValutazioneStatoBisogno">Altro</label>
                    </div>
                  </div>
                  <div class="form-group" id="div_altro_ValutazioneStatoBisogno">
                    <span id="specificare_altro_ValutazioneStatoBisogno_error_msg" style="color: red;"></span> <input type="text" class="form-control" id="specificare_altro_ValutazioneStatoBisogno" placeholder="Specificare">
                  </div>
                  <hr />
                  <div class="form-group">
                    <label class="text-muted mb-3 d-block"><span class="h6s"><b>Presa in carico per:</b></span>&nbsp;<span id="presaInCarico_error_msg" style="color: red;"></span></label>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="assistenzaLegaleCivile" name="presaInCarico" value="Assistenza Legale Civile"> <label class="custom-control-label" for="assistenzaLegaleCivile">Assistenza Legale Civile</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="assistenzaLegalePenale" name="presaInCarico" value="Assistenza Legale Penale"> <label class="custom-control-label" for="assistenzaLegalePenale">Assistenza Legale Penale</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="gruppoSelfHelp" name="presaInCarico" value="Gruppo Self-help"> <label class="custom-control-label" for="gruppoSelfHelp">Gruppo di Self-help</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="animazioneSocialePerMinori" name="presaInCarico" value="Animazione sociale per i minori"> <label class="custom-control-label" for="animazioneSocialePerMinori">Animazione sociale per i minori</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="orientamentoAlLavoro" name="presaInCarico" value="Orientamento al lavoro"> <label class="custom-control-label" for="orientamentoAlLavoro">Orientamento al lavoro</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="sostegnoPsicologicoPresaInCarico" name="presaInCarico" value="Sostegno psicologico"> <label class="custom-control-label" for="sostegnoPsicologicoPresaInCarico">Sostegno psicologico</label>
                    </div>
                  </div>
                  <div class="form-group" id="prestazioniEffettuate">
                    <hr />
                    <label class="form-label"><span class="h6s"><b>Prestazioni effettuate:</b></span>&nbsp;<span id="prestazioniEffettuate_error_msg" style="color: red;"></span></label>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="consulenzaLegaleCivile" name="prestazioniEffettuate" value="Consulenza Legale Civile"> <label class="custom-control-label" for="consulenzaLegaleCivile">Consulenza Legale Civile</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="consulenzaLegalePenale" name="prestazioniEffettuate" value="Consulenza Legale Penale"> <label class="custom-control-label" for="consulenzaLegalePenale">Consulenza Legale Penale</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="consulenzaPsicologica" name="prestazioniEffettuate" value="Consulenza Psicologica"> <label class="custom-control-label" for="consulenzaPsicologica">Consulenza Psicologica</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="consulenzaSpecialisticaPsicodiagnostica" name="prestazioniEffettuate" value="Consulenza Specialistica Psicodiagnostica"> <label class="custom-control-label" for="consulenzaSpecialisticaPsicodiagnostica">Consulenza Specialistica Psicodiagnostica</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="gruppoDiSostegnoAllaGenitorialità" name="prestazioniEffettuate" value="Sostegno alla Genitorialità"> <label class="custom-control-label" for="gruppoDiSostegnoAllaGenitorialità">Sostegno alla Genitorialità</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="ConsulenzaSociale" name="prestazioniEffettuate" value="Consulenza Sociale"> <label class="custom-control-label" for="ConsulenzaSociale">Consulenza Sociale</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="attivazioneDelPercorsoRosa" name="prestazioniEffettuate" value="Attivazione del Percorso Rosa"> <label class="custom-control-label" for="attivazioneDelPercorsoRosa">Attivazione del Percorso Rosa</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="attestazione" name="prestazioniEffettuate" value="Attestazione"> <label class="custom-control-label" for="attestazione">Attestazione</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="MediazioneCulturale" name="prestazioniEffettuate" value="Mediazione Culturale"> <label class="custom-control-label" for="MediazioneCulturale">Mediazione Culturale</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="collocazionePressoAltroDomicilio" name="prestazioniEffettuate" value="Collocazione presso altro domicilio"> <label class="custom-control-label" for="collocazionePressoAltroDomicilio">Collocazione presso altro domicilio</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" class="custom-control-input" id="segnalazioneAlTribunale" name="prestazioniEffettuate" value="Segnalazione al tribunale"> <label class="custom-control-label" for="segnalazioneAlTribunale">Segnalazione al tribunale</label>
                    </div>
                  </div>
                  <hr />
                  <div class="form-group">
                    <label class="text-muted mb-3 d-block"><span class="h6s"><b>Attivazione della Rete Territoriale Antiviolenza con invio a:</b></span>&nbsp;<span id="attivazioneRete_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="attivazioneRete_select">
                      <option value="Scegli..." selected>Scegli...</option>
                      <option value="Pronto Soccorso">Pronto Soccorso</option>
                      <option value="Forze dell'Ordine">Forze dell'Ordine</option>
                      <option value="Servizi Sociali">Servizi Sociali</option>
                      <option value="Servizio Sanitario">Servizio Sanitario</option>
                      <option value="Centri Antiviolenza della Rete Nazionale">Centri Antiviolenza della Rete Nazionale</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_attivazioneReteOspedale">
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label" style="font-size: medium;"><span class="h6s">Pronto Soccorso</span>&nbsp;<span id="attivazioneRete_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="attivazioneRete_prontosoccorso_select">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Provincia di</span>&nbsp;<span id="attivazioneRete_provincia_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="attivazioneRete_provincia_prontosoccorso_select" onChange="addComuniAttivazioneReteProntoSoccorso();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Comune di</span>&nbsp;<span id="attivazioneRete_comune_prontosoccorso_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="attivazioneRete_comune_prontosoccorso_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="form-group" id="div_attivazioneRete_forzedellordine">
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Forze dell'Ordine</span>&nbsp;<span id="attivazioneRete_forzedellordine_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="attivazioneRete_forzedellordine_select">
                          <option selected value="Scegli...">Scegli...</option>
                          <option value="Carabinieri">Carabinieri</option>
                          <option value="Polizia">Polizia</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Della Provincia di</span>&nbsp;<span id="attivazioneRete_provincia_forzedellordine_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="attivazioneRete_provincia_forzedellordine_select" onChange="addattivazioneRete_forzedellordine();">
                          <option value="Scegli..." selected>Scegli...</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-holder">
                        <label class="form-label"><span class="h6s">Del Comune di</span>&nbsp;<span id="attivazioneRete_comune_forzedellordine_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="attivazioneRete_comune_forzedellordine_select">
                          <option selected value="Scegli...">Scegli...</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="form-group" id="div_servizioSanitario">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">ASL della Provincia di</span>&nbsp;<span id="servizioSanitario_provincia_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="servizioSanitario_provincia_select">
                        <option value="Scegli..." selected>Scegli...</option>
                        <option value="Avellino">Avellino</option>
                        <option value="Benevento">Benevento</option>
                        <option value="Caserta">Caserta</option>
                        <option value="Salerno">Salerno</option>
                        <option value="Napoli">Napoli</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="div_serviziSociali">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Servizi Sociali della Provincia di</span>&nbsp;<span id="serviziSociali_provincia_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="serviziSociali_provincia_select">
                        <option value="Scegli..." selected>Scegli...</option>
                        <option value="Avellino">Avellino</option>
                        <option value="Benevento">Benevento</option>
                        <option value="Caserta">Caserta</option>
                        <option value="Salerno">Salerno</option>
                        <option value="Napoli">Napoli</option>
                      </select>
                    </div>
                  </div>
                  <!-- Fino a qui -->
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
                  <div class="form-group" style="text-align: center;">
                    <span id="error_msg_footer" style="color: red;"></span>
                  </div>
                  <div class="btn-group btn-lg btn-block" role="group">
                    <button type="button" class="btn btn-secondary" id="backbutton" onclick="indietro();">
                      <i class="fa fa-angle-left"></i>&nbsp;Indietro
                    </button>
                    <button type="button" class="btn btn-success" onclick="check()">
                      Avanti&nbsp;<i class="fa fa-angle-right"></i>
                    </button>
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
