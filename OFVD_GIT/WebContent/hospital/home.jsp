<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.utils.Utility"%>
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
		$('#div_specifico_rete_intra_ospedaliera').hide();
		$('#div_specifico_rete_extra_ospedaliera').hide();
		$('#div_tipologia_servizi_aggressore').hide();
		$('#div_forze_dell_ordine').hide();
		$('#div_familiare').hide();
		$('#div_sfruttamento').hide();

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
						$('#provincia_nascita_select')
								.empty()
								.append(
										"<option value=\"Scegli...\" selected>Scegli...</option>");

						for (var ii = 0; ii < jsonStr.length; ii++) {
							$('#provincia_nascita_select').append(
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
					}
				});

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

						addFirstAidOption('hospital_name_select');

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
												$("#div_precedenti_penali")
														.hide();
											}
										});

						$('input:radio[name=primo_accesso_ps]')
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
							if (this.value == 'Altro...') {
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

						$('#selectDonnaAccompagnataInPS').change(function() {
							if (this.value == 'Altro...') {
								$('#div_altro_donnaAccompagnataInPS').show();
							} else {
								$('#div_altro_donnaAccompagnataInPS').hide();
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

						$('#selectTitoloDiStudio').change(function() {
							if (this.value == 'Altro...') {
								$('#div_altroTitoloDiStudio').show();
							} else {
								$('#div_altroTitoloDiStudio').hide();
							}
						});

						$('#selectTitoloDiStudioAggressore').change(function() {
							if (this.value == 'Altro...') {
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
											if (this.value == 'Altro...') {
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
											if (this.value == 'Altro...') {
												$(
														'#div_altroTipologiaServiziAggressore')
														.show();
											} else {
												$(
														'#div_altroTipologiaServiziAggressore')
														.hide();
											}

										});

						$('#rete_intra_ospedaliera')
								.change(
										function() {
											if (this.value == 'Altro...') {
												$(
														'#div_specifico_rete_intra_ospedaliera')
														.show();
											} else {
												$(
														'#div_specifico_rete_intra_ospedaliera')
														.hide();
											}

										});

						$('#rete_extra_ospedaliera')
								.change(
										function() {
											if (this.value == 'Altro...') {
												$(
														'#div_specifico_rete_extra_ospedaliera')
														.show();
											} else {
												$(
														'#div_specifico_rete_extra_ospedaliera')
														.hide();
											}

										});

						$('#rete_extra_ospedaliera').change(function() {
							if (this.value == "Forze dell'Ordine") {
								$('#div_forze_dell_ordine').show();
							} else {
								$('#div_forze_dell_ordine').hide();
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

			question.answer3 = $("#hospital_name_select option:selected")
					.text();

			question.answer4 = $('#nome_compilatore').val();

			question.answer5 = $('#cognome_compilatore').val();
		} else if (index == 2) {
			question.answer6 = $('#nome_vittima').val();

			question.answer7 = $('#cognome_vittima').val();

			question.answer8 = "" + $('#data_nascita').val();

			question.answer9 = $("#luogo_select option:selected").text();

			question.answer10 = $('#provincia_nascita_select option:selected')
					.text();

			question.answer11 = $('#comune_nascita_select option:selected')
					.text();

			question.answer12 = $('#indirizzo').val();

			question.answer13 = $('#telefono_personale').val();

			question.answer14 = $('#altro_telefono').val();

			if ($("input[name='cittadinanza']:checked").val() == undefined)
				question.answer15 = "";
			else
				question.answer15 = $("input[name='cittadinanza']:checked")
						.val();

			if ($("input[name='cittadinanza']:checked").val() == "Si"
					|| $("input[name='cittadinanza']:checked").val() == "Dato non dichiarato")
				question.answer16 = "";
			else
				question.answer16 = $("#cittadinanza_select option:selected")
						.text();

			question.answer17 = $("#select_lingua_italiana option:selected")
					.text();

			if ($("input[name='mediatoreCulturale']:checked").val() == undefined)
				question.answer18 = "";
			else
				question.answer18 = $(
						"input[name='mediatoreCulturale']:checked").val();

			if (question.answer17 == "Si")
				question.answer18 = "";

			question.answer19 = $('#statoCivile option:selected').text();

			if (question.answer19 == "Altro...")
				question.answer20 = $('#altrostatocivile').val();
			else
				question.answer20 = "";

			question.answer21 = $("input[name='figli']:checked").val();

			if (question.answer21 == "Si") {
				question.answer22 = $("#numero_figli").val();
				question.answer23 = $("#numero_figli_minorenni").val();
			} else {
				question.answer22 = "0";
				question.answer23 = "0";
			}

			if ($("input[name='conviventi_maschi']:checked").val() == undefined)
				question.answer24 = "";
			else
				question.answer24 = $("input[name='conviventi_maschi']:checked")
						.val();

			question.answer25 = $("#selectTitoloDiStudio option:selected")
					.text();

			if (question.answer25 == "Altro...")
				question.answer26 = $('#altroTitoloDiStudio').val();
			else
				question.answer26 = "";

			question.answer27 = $("#selectProfessione option:selected").text();

			question.answer28 = $(
					"input[name='autonomo_economicamente']:checked").val();

		} else if (index == 3) {
			if ($("input[name='primo_accesso_ps']:checked").val() == undefined)
				question.answer29 = "";
			else
				question.answer29 = $("input[name='primo_accesso_ps']:checked")
						.val();

			if (question.answer29 == "Si"
					|| question.answer29 == "Dato non dichiarato")
				question.answer30 = "0";
			else
				question.answer30 = $("#numero_accessi_ripetuti").val();

			question.answer31 = $("#selectTipologiaViolenza option:selected")
					.text();

			if (question.answer31 == "Altro")
				question.answer32 = $("#altroViolenzaRiferita").val();
			else
				question.answer32 = "";

			question.answer33 = "";
			$("input[name='sfruttamento']").each(
					function() {
						var ischecked = $(this).is(":checked");
						if (ischecked) {
							question.answer33 = question.answer33
									+ $(this).val() + ";";
						}
					});

			$("input[name='violenzeRiferite']").each(
					function() {
						var ischecked = $(this).is(":checked");
						if (ischecked) {
							question.answer33 = question.answer33
									+ $(this).val() + ";";
						}
					});

			if (question.answer31 != "Violenza domestica"
					&& question.answer31 != "Violenza extra domestica")
				question.answer33 = "";

			if ($("input[name='con_figli_minori']:checked").val() == undefined)
				question.answer34 = "";
			else
				question.answer34 = $("input[name='con_figli_minori']:checked")
						.val();

			question.answer35 = $(
					"#selectDonnaAccompagnataInPS option:selected").text();

			if (question.answer35 == "Altro...")
				question.answer36 = $("#altroDonnaAccompagnataInPS").val();
			else
				question.answer36 = "";

			question.answer37 = $("#motivoAccessoInPS").val();

			question.answer38 = $("input[name='codiceAttribuito']:checked")
					.val();

		} else if (index == 4) {
			question.answer39 = $("#nome_presunto_aggressore").val();

			question.answer40 = $("#cognome_presunto_aggressore").val();

			question.answer41 = $("#data_nascita_presunto_aggressore").val();

			if ($("#luogo_presunto_aggressore_select option:selected").text() == "Scegli...")
				question.answer42 = "";
			else
				question.answer42 = $(
						"#luogo_presunto_aggressore_select option:selected")
						.text();

			if ($(
					"#provincia_nascita_presunto_aggressore_select option:selected")
					.text() == "Scegli...")
				question.answer43 = "";
			else
				question.answer43 = $(
						"#provincia_nascita_presunto_aggressore_select option:selected")
						.text();

			if ($("#comune_nascita_presunto_aggressore_select option:selected")
					.text() == "Scegli...")
				question.answer44 = "";
			else
				question.answer44 = $(
						"#comune_nascita_presunto_aggressore_select option:selected")
						.text();

			question.answer45 = $("#indirizzo_presunto_aggressore").val();

			question.answer46 = $("#telefono_presunto_aggressore").val();

			if ($("#selectTitoloDiStudioAggressore option:selected").text() == "Scegli...")
				question.answer47 = "";
			else
				question.answer47 = $(
						"#selectTitoloDiStudioAggressore option:selected")
						.text();

			if ($("#selectTitoloDiStudioAggressore option:selected").text() == "Altro...")
				question.answer48 = $("#altroTitoloDiStudioAggressore").val();
			else
				question.answer48 = "";

			if ($("#selectProfessioneAggressore option:selected").text() == "Scegli...")
				question.answer49 = "";
			else
				question.answer49 = $(
						"#selectProfessioneAggressore option:selected").text();

			if ($("#fascia_di_eta_aggressore option:selected").text() == "Scegli...")
				question.answer50 = "";
			else
				question.answer50 = $(
						"#fascia_di_eta_aggressore option:selected").text();

			if ($("#rapporto_vittima_autore_violenza option:selected").text() == "Scegli...")
				question.answer51 = "";
			else
				question.answer51 = $(
						"#rapporto_vittima_autore_violenza option:selected")
						.text();

			if (question.answer51 == "Familiare")
				question.answer52 = $("#tipologia_familiare option:selected")
						.text();
			else
				question.answer52 = "";

			//modifica qui metti 52
			if (question.answer52 == "Altro...")
				question.answer53 = $("#altroRapportoVittimaAggressore").val();
			else
				question.answer53 = "";

			if ($("input[name='aggressore_servizi']:checked").val() == undefined)
				question.answer54 = "";
			else
				question.answer54 = $(
						"input[name='aggressore_servizi']:checked").val();

			if ($("#tipologia_servizi_aggressore option:selected").text() == "Scegli...")
				question.answer55 = "";
			else
				question.answer55 = $(
						"#tipologia_servizi_aggressore option:selected").text();

			if ($("#tipologia_servizi_aggressore option:selected").text() == "Altro...")
				question.answer56 = $("#altroTipologiaServiziAggressore").val();
			else
				question.answer56 = "";

			if ($("input[name='precedenti_penali']:checked").val() == undefined)
				question.answer57 = "";
			else
				question.answer57 = $("input[name='precedenti_penali']:checked")
						.val();

		} else if (index == 5) {
			question.answer58 = $("input[name='brief_risk_1']:checked").val();

			question.answer59 = $("input[name='brief_risk_2']:checked").val();

			question.answer60 = $("input[name='brief_risk_3']:checked").val();

			question.answer61 = $("input[name='brief_risk_4']:checked").val();

			question.answer62 = $("input[name='brief_risk_5']:checked").val();

			question.answer63 = $("input[name='brief_risk_6']:checked").val();

			question.answer64 = $("input[name='brief_risk_7']:checked").val();

			question.answer65 = $("#rete_intra_ospedaliera option:selected")
					.text();

			if (question.answer65 == "Altro...")
				question.answer66 = $("#specifico_rete_intra_ospedaliera")
						.val();
			else
				question.answer66 = "";

			question.answer67 = $("#rete_extra_ospedaliera option:selected")
					.text();

			if (question.answer67 == "Altro...")
				question.answer68 = $("#specifico_rete_extra_ospedaliera")
						.val();
			else
				question.answer68 = "";

			if (question.answer67 == "Forze dell'Ordine") {
				if ($("input[name='forze_dell_ordine']:checked").val() == undefined)
					question.answer69 = "";
				else
					question.answer69 = $(
							"input[name='forze_dell_ordine']:checked").val();
			} else
				question.answer69 = "";

			question.answer70 = $("#tempi_di_prognosi option:selected").text();

			question.answer71 = $("input[name='referto']:checked").val();

			question.answer72 = $("input[name='attestazioni']:checked").val();

			question.answer73 = $("input[name='codiceRosa']:checked").val();
		}
	}

	function question1() {
		flag = false;
		var hospital_name = $('#hospital_name_select option:selected').text();

		if (hospital_name == "Scegli...") {
			$('#hospital_name_select').css("border-color", "red");
			$("#hospital_name_select_error_msg").text("Compila il campo");
			flag = true;
		} else {
			$('#hospital_name_select').css("border-color", "");
			$("#hospital_name_select_error_msg").text("");
		}

		if (flag) {
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
				$('#altro_telefono_error_msg').text(
						"Inserisci un numero di telefono valido di 9 o 10 cifre");
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

		if ($("#statoCivile option:selected").text() == "Altro...") {
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
			if ($('#numero_figli').val() >= 0) {
				$('#numero_figli').css("border-color", "");
				$('#numero_figli_error_msg').text("");
			} else {
				$('#numero_figli').css("border-color", "red");
				$('#numero_figli_error_msg').text("Input non valido");
				return false;
			}

			if ($('#numero_figli_minorenni').val() >= 0) {
				$('#numero_figli_minorenni').css("border-color", "");
				$('#numero_figli_minorenni_error_msg').text("");
			} else {
				$('#numero_figli_minorenni').css("border-color", "red");
				$('#numero_figli_minorenni_error_msg').text("Input non valido");
				return false;
			}

			if ($('#numero_figli').val() >= $('#numero_figli_minorenni').val()
					&& ($('#numero_figli').val() >= 0 && $(
							'#numero_figli_minorenni').val() >= 0)) {
				$('#numero_figli').css("border-color", "");
				$('#numero_figli_minorenni').css("border-color", "");

				$('#numero_figli_minorenni_error_msg').text("");
			} else {
				$('#numero_figli').css("border-color", "red");
				$('#numero_figli_minorenni').css("border-color", "red");

				$('#numero_figli_minorenni_error_msg').text("Input non valido");
				flag = true;
			}
		}

		if ($("input[name='conviventi_maschi']:checked").val() == undefined) {
			$('#conviventi_maschi_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#conviventi_maschi_error_msg').text("");
		}

		if ($("#selectTitoloDiStudio option:selected").text() == "Scegli...") {
			$('#selectTitoloDiStudio').css("border-color", "red");
			$('#selectTitoloDiStudio_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#selectTitoloDiStudio').css("border-color", "");
			$('#selectTitoloDiStudio_error_msg').text("");
		}

		if ($("#selectTitoloDiStudio option:selected").text() == "Altro...") {
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
					$('#altroTitoloDiStudio_error_msg')
							.text("Input non valido");
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

		if ($("input[name='autonomo_economicamente']:checked").val() == undefined) {
			$('#autonomo_economicamente_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#autonomo_economicamente_error_msg').text("");
		}

		if (flag) {
			$('#error_msg_footer').text("Campi non correttamente compilati");
			return false;
		}
		$('#error_msg_footer').text("");
		return true;
	}

	function question3() {
		flag = false;

		if ($("input[name='primo_accesso_ps']:checked").val() == undefined) {
			$('#primo_accesso_ps_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#primo_accesso_ps_error_msg').text("");
		}

		if ($("input[name='primo_accesso_ps']:checked").val() == "No") {
			if (re_number.test($("#numero_accessi_ripetuti").val())) {
				$('#numero_accessi_ripetuti_error_msg').text("");
				$('#numero_accessi_ripetuti').css("border-color", "");
			} else {
				$('#numero_accessi_ripetuti').css("border-color", "red");
				$('#numero_accessi_ripetuti_error_msg')
						.text("Input non valido");
				flag = true;
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

		if ($("input[name='con_figli_minori']:checked").val() == undefined) {
			$('#con_figli_minori_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#con_figli_minori_error_msg').text("");
		}

		if ($("#selectDonnaAccompagnataInPS option:selected").text() == "Scegli...") {
			$('#selectDonnaAccompagnataInPS').css("border-color", "red");
			$('#selectDonnaAccompagnataInPS_error_msg')
					.text("Compila il campo");
			flag = true;
		} else {
			$('#selectDonnaAccompagnataInPS').css("border-color", "");
			$('#selectDonnaAccompagnataInPS_error_msg').text("");
		}

		if ($("#selectDonnaAccompagnataInPS option:selected").text() == "Altro...") {
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

		if ($("#motivoAccessoInPS").val() == "") {
			$('#motivoAccessoInPS').css("border-color", "red");
			$('#motivoAccessoInPS_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#motivoAccessoInPS').css("border-color", "");
			$('#motivoAccessoInPS_error_msg').text("");
		}

		if ($("input[name='codiceAttribuito']:checked").val() == undefined) {
			$('#codiceAttribuito_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#codiceAttribuito_error_msg').text("");
		}

		if (flag) {
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

		if ($("#selectTitoloDiStudioAggressore option:selected").text() == "Altro...") {
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

		if ($("#rapporto_vittima_autore_violenza option:selected").text() == "Altro...") {
			if ($("#altroRapportoVittimaAggressore").val() != "") {
				$("#altroRapportoVittimaAggressore").css("border-color", "");
				$("#altroRapportoVittimaAggressore_error_msg").text("");
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

		if ($("#tipologia_servizi_aggressore option:selected").text() == "Altro...") {
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

		if ($("#rete_intra_ospedaliera option:selected").text() == "Scegli...") {
			$('#rete_intra_ospedaliera').css("border-color", "red");
			$('#rete_intra_ospedaliera_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#rete_intra_ospedaliera').css("border-color", "");
			$('#rete_intra_ospedaliera_error_msg').text("");
		}

		if ($("#rete_intra_ospedaliera option:selected").text() == "Altro...") {
			if (re.test($("#specifico_rete_intra_ospedaliera").val())) {
				$('#specifico_rete_intra_ospedaliera').css("border-color", "");
				$('#specifico_rete_intra_ospedaliera_error_msg').text("");
			} else {
				if ($("#specifico_rete_intra_ospedaliera").val() == "") {
					$('#specifico_rete_intra_ospedaliera').css("border-color",
							"red");
					$('#specifico_rete_intra_ospedaliera_error_msg').text(
							"Compila il campo");
					flag = true;
				} else {
					$('#specifico_rete_intra_ospedaliera').css("border-color",
							"red");
					$('#specifico_rete_intra_ospedaliera_error_msg').text(
							"Input non valido");
					flag = true;
				}

			}
		}

		if ($("#rete_extra_ospedaliera option:selected").text() == "Scegli...") {
			$('#rete_extra_ospedaliera').css("border-color", "red");
			$('#rete_extra_ospedaliera_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#rete_extra_ospedaliera').css("border-color", "");
			$('#rete_extra_ospedaliera_error_msg').text("");

		}

		if ($("#rete_extra_ospedaliera option:selected").text() == "Altro...") {
			if ($("#specifico_rete_extra_ospedaliera").val() == "") {
				$('#specifico_rete_extra_ospedaliera').css("border-color",
						"red");
				$('#specifico_rete_extra_ospedaliera_error_msg').text(
						"Compila il campo");
				flag = true;
			} else {
				if (re.test($("#specifico_rete_extra_ospedaliera").val())) {
					$('#specifico_rete_extra_ospedaliera').css("border-color",
							"");
					$('#specifico_rete_extra_ospedaliera_error_msg').text("");
				} else {
					$('#specifico_rete_extra_ospedaliera').css("border-color",
							"red");
					$('#specifico_rete_extra_ospedaliera_error_msg').text(
							"Input non valido");
					flag = true;
				}

			}
		}

		if ($("#rete_extra_ospedaliera option:selected").text() == "Forze dell'Ordine") {
			if ($("input[name='forze_dell_ordine']:checked").val() == undefined) {
				$('#forze_dell_ordine_error_msg').text("Compila il campo");
				flag = true;
			} else {
				$('#forze_dell_ordine_error_msg').text("");
			}
		}

		if ($("#tempi_di_prognosi option:selected").text() == "Scegli...") {
			$('#tempi_di_prognosi').css("border-color", "red");
			$('#tempi_di_prognosi_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#tempi_di_prognosi').css("border-color", "");
			$('#tempi_di_prognosi_error_msg').text("");
		}

		if ($("input[name='referto']:checked").val() == undefined) {
			$('#referto_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#referto_error_msg').text("");
		}

		if ($("input[name='attestazioni']:checked").val() == undefined) {
			$('#attestazioni_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#attestazioni_error_msg').text("");
		}

		if ($("input[name='codiceRosa']:checked").val() == undefined) {
			$('#codiceRosa_error_msg').text("Compila il campo");
			flag = true;
		} else {
			$('#codiceRosa_error_msg').text("");
		}

		if (flag) {

			$('#error_msg_footer').text("Campi non compilati correttamente");
			return false;
		}
		$('#error_msg_footer').text("");
		return true;

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
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question1" style="margin: 5px;">1. Dati della scheda</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question2" style="margin: 5px;">2. Dati anagrafici</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question3" style="margin: 5px;">3. Tipologia della violenza</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question4" style="margin: 5px;">4. Autore della violenza</button>
              <button type="button" class="btn btn-rounded btn-light mb-3" id="button_question5" style="margin: 5px;">5. Rischio e Azioni</button>
            </form>
          </div>
        </div>
      </div>
      <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="false">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">
                Scheda ID: <span id="id_scheda"></span>
              </h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <!--  Progress bar -->
              <p style="text-align: center">
                <img src="../assets/images/media/progress_bar.gif" width="15%" height="15%" />
              </p>
              <p id="report_dialog" style="text-algin: center;"></p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
            </div>
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
                      <label class="form-label" style="font-size: medium;"><span class="h6s">Presidio Ospedaliero</span>&nbsp;<span id="hospital_name_select_error_msg" style="color: red;"></span></label> <select id="hospital_name_select" class="custom-select">
                        <option value="Scegli..." selected>Scegli...</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label h6s">Nome del compilatore</label> <input type="text" value='<%=account.getNome()%>' class="form-control" id="nome_compilatore" style="font-size: medium;" disabled>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-holder">
                      <label class="form-label h6s">Cognome del compilatore</label> <input type="text" value='<%=account.getCognome()%>' disabled id="cognome_compilatore" style="font-size: medium;" class="form-control">
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
                      <label class="form-label"><span class="h6s">Luogo di nascita</span>&nbsp;<span id="luogo_select_error_msg" style="color: red;"></span></label> <select class="custom-select" id="luogo_select">
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
                      <option value="Altro...">Altro...</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altro_statoCivile">
                    <div class="form-holder">
                      <span id="altrostatocivile_error_msg" style="color: red;"></span> <input type="text" placeholder="Altro..." id="altrostatocivile" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div id="nucleoFamiliare">
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
                      <label class="form-label"><span class="h6s">Numero figli</span>&nbsp;<span id="numero_figli_error_msg" style="color: red;"></span></label> <br /> <input type="number" class="form-control" id="numero_figli" value="1" min="1"> <br /> <label class="form-label"><span class="h6s">Di cui minorenni</span>&nbsp;<span id="numero_figli_minorenni_error_msg" style="color: red;"></span></label> <br /> <input type="number" class="form-control" id="numero_figli_minorenni" value="0" min="0">
                    </div>
                    <div class="form-group">
                      <label class="form-label"><span class="h6s">Conviventi</span>&nbsp;<span id="conviventi_maschi_error_msg" style="color: red;"></span></label> <br />
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="si_conviventi_maschi" value="Si" name="conviventi_maschi" class="custom-control-input"> <label class="custom-control-label" for="si_conviventi_maschi" style="font-size: medium;">Si</label>
                      </div>
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="no_conviventi_maschi" value="No" name="conviventi_maschi" class="custom-control-input"> <label class="custom-control-label" for="no_conviventi_maschi" style="font-size: medium;">No</label>
                      </div>
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="non_dichiarato_conviventi_maschi" value="Dato non dichiarato" name="conviventi_maschi" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_conviventi_maschi" style="font-size: medium;">Dato non dichiarato</label>
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
                        <option value="Altro...">Altro...</option>
                      </select>
                    </div>
                    <div class="form-group" id="div_altroTitoloDiStudio">
                      <div class="form-holder">
                        <span id="altroTitoloDiStudio_error_msg" style="color: red;"></span> <input type="text" placeholder="Altro..." id="altroTitoloDiStudio" class="form-control" style="font-size: medium;">
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Stato occupazionale</span>&nbsp; <span id="selectProfessione_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectProfessione">
                      <option value="Scegli..." selected>Scegli...</option>
                      <option value="Operaia">Operaia</option>
                      <option value="Artigiana">Artigiana</option>
                      <option value="Imprenditrice">Imprenditrice</option>
                      <option value="Impiegata">Impiegata</option>
                      <option value="Disoccupata">Disoccupata</option>
                      <option value="Pensionata">Pensionata</option>
                      <option value="Libera professionista">Libera professionista</option>
                      <option value="Dato non dichiarato">Dato non dichiarato</option>
                      <option value="Altro...">Altro</option>
                    </select>
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
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Primo accesso al Pronto Soccorso</span>&nbsp;<span id="primo_accesso_ps_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_primo_accesso_ps" value="Si" name="primo_accesso_ps" class="custom-control-input"> <label class="custom-control-label" for="si_primo_accesso_ps" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_primo_accesso_ps" value="No" name="primo_accesso_ps" class="custom-control-input"> <label class="custom-control-label" for="no_primo_accesso_ps" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_primo_accesso_ps" value="Dato non dichiarato" name="primo_accesso_ps" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_primo_accesso_ps" style="font-size: medium;">Dato non dichiarato</label>
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
                    <label class="form-label"><span class="h6s">Numero accessi precedenti</span>&nbsp;<span id="numero_accessi_ripetuti_error_msg" style="color: red;"></span></label> <br /> <input type="number" class="form-control" id="numero_accessi_ripetuti" value="1" min="1">
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
                  <div class="form-group" id="con_figli_minori">
                    <label class="form-label"><span class="h6s">In presenza di figli minori</span>&nbsp;<span id="con_figli_minori_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_con_figli_minori" value="Si" name="con_figli_minori" class="custom-control-input"> <label class="custom-control-label" for="si_con_figli_minori" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_con_figli_minori" value="No" name="con_figli_minori" class="custom-control-input"> <label class="custom-control-label" for="no_con_figli_minori" style="font-size: medium;">No</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="non_dichiarato_con_figli_minori" value="Dato non dichiarato" name="con_figli_minori" class="custom-control-input"> <label class="custom-control-label" for="non_dichiarato_con_figli_minori" style="font-size: medium;">Dato non dichiarato</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">La donna accede al Pronto Soccorso</span>&nbsp;<span id="selectDonnaAccompagnataInPS_error_msg" style="color: red;"></span></label> <br /> <select class="custom-select" id="selectDonnaAccompagnataInPS">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Spontaneamente">Spontaneamente</option>
                      <option value="Accompagnata dal 118">Accompagnata dal 118</option>
                      <option value="Accompagnata dalle FFOO">Accompagnata dalle FFOO</option>
                      <option value="Accompagnata da operatrici dei Centri Antiviolenza">Accompagnata da operatrici dei Centri Antiviolenza</option>
                      <option value="Accompagnata da operatrici di altri servizi pubblici o privati">Accompagnata da operatrici di altri servizi pubblici o privati</option>
                      <option value="Dato non dichiarato">Dato non dichiarato</option>
                      <option value="Altro...">Altro...</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altro_donnaAccompagnataInPS">
                    <div class="form-holder">
                      <span id="altroDonnaAccompagnataInPS_error_msg" style="color: red;"></span> <input type="text" placeholder="Specificare (Es. Amici, Familiari, ecc...)" id="altroDonnaAccompagnataInPS" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_motivoAccessoInPS">
                    <div class="form-holder">
                      <label class="form-label"><span class="h6s">Motivo accesso in PS</span>&nbsp;<span id="motivoAccessoInPS_error_msg" style="color: red;"></span></label> <br />
                      <textarea class="form-control" id="motivoAccessoInPS" placeholder="La donna riferisce che ..." style="height: 100px;"></textarea>
                    </div>
                  </div>
                                    
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Codice attribuito</span>&nbsp;<span id="codiceAttribuito_error_msg" style="color: red;"></span></label>
                    <br />
                    <div class="custom-control custom-radio custom-control-inline" style="background-color:green;border-radius: 5px;padding:5px 30px 5px 40px;">
                      <input type="radio" id="verde_codice_attribuito" value="Verde" name="codiceAttribuito" class="custom-control-input"> 
                      <label class="custom-control-label" for="verde_codice_attribuito" style="font-size: medium;color: white;">Verde</label> &nbsp;
                    </div>
                    <div class="custom-control custom-radio custom-control-inline" style="background-color:yellow;border-radius: 5px;padding:5px 30px 5px 40px;">
                      <input type="radio" id="giallo_codice_attribuito" value="Giallo" name="codiceAttribuito" class="custom-control-input">
                      <label class="custom-control-label" for="giallo_codice_attribuito" style="font-size: medium;color: black;">Giallo</label> &nbsp;
                    </div>
                    <div class="custom-control custom-radio custom-control-inline" style="background-color:red;border-radius: 5px;padding:5px 30px 5px 40px;">
                      <input type="radio" id="rosso_codice_attribuito" value="Rosso" name="codiceAttribuito" class="custom-control-input">
                      <label class="custom-control-label" for="rosso_codice_attribuito" style="font-size: medium;color: white;">Rosso</label> &nbsp;
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
                      <label class="form-label"><span class="h6s">Data di nascita</span>&nbsp;<span id="data_nascita_presunto_aggressore_error_msg" style="color: red;"></span></label> <input id="data_nascita_presunto_aggressore" style="font-size: medium;" class="form-control" placeholder="gg/mm/aaaa" />
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
                    <!--  <h3>Titolo di studio</h3>-->
                    <!--  <p>Please fill with your details</p> -->
                    <div class="form-group" id="div_selectTitoloDiStudioAggressore">
                      <label class="form-label"><span class="h6s">Titolo di studio</span>&nbsp;<span id="selectTitoloDiStudioAggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectTitoloDiStudioAggressore">
                        <option selected value="Scegli...">Scegli...</option>
                        <option value="Nessuno">Nessuno</option>
                        <option value="Licenza elementare">Licenza elementare</option>
                        <option value="Licenza media inferiore">Licenza media inferiore</option>
                        <option value="Diploma superiore">Diploma superiore</option>
                        <option value="Laurea">Laurea</option>
                        <option value="Dato non dichiarato">Dato non dichiarato</option>
                        <option value="Altro...">Altro...</option>
                      </select>
                    </div>
                    <div class="form-group" id="div_altroTitoloDiStudiAggressore">
                      <div class="form-holder">
                        <span id="altroTitoloDiStudioAggressore_error_msg" style="color: red;"></span> <input type="text" placeholder="Altro..." id="altroTitoloDiStudioAggressore" class="form-control" style="font-size: medium;">
                      </div>
                    </div>
                  </div>
                  <div class="form-group" id="div_selectProfessioneAggressore">
                    <label class="form-label"><span class="h6s">Stato occupazionale</span>&nbsp;<span id="selectProfessioneAggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="selectProfessioneAggressore">
                      <option selected value="Scegli...">Scegli...</option>
                      <option value="Operaio">Operaio</option>
                      <option value="Artigiano">Artigiano</option>
                      <option value="Imprenditore">Imprenditore</option>
                      <option value="Impiegato">Impiegato</option>
                      <option value="Impiegato di pubblica amministrazione">Impiegato di pubblica amministrazione</option>
                      <option value="Disoccupato">Disoccupato</option>
                      <option value="Pensionato">Pensionato</option>
                      <option value="Libero professionista">Libero professionista</option>
                      <option value="Dato non dichiarato">Dato non dichiarato</option>
                      <option value="Altro...">Altro</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_fascia_di_eta_aggressore">
                    <label class="form-label"><span class="h6s">Fascia di et&agrave;</span>&nbsp;<span id="fascia_di_eta_aggressore_error_msg" style="color: red;"></span></label> <select class="custom-select" id="fascia_di_eta_aggressore">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="<18">&lt; 18</option>
                      <option value="19 - 29">19 - 29</option>
                      <option value="30 - 39">30 - 39</option>
                      <option value="40 - 49">40 - 49</option>
                      <option value="50 - 59">50 - 59</option>
                      <option value="60 - 69">60 - 69</option>
                      <option value="Altro...">Altro...</option>
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
                      <option value="Altro...">Altro...</option>
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
                      <option value="Altro...">Altro...</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altroRapportoVittimaAggressore">
                    <div class="form-holder">
                      <span id="altroRapportoVittimaAggressore_error_msg" style="color: red;"></span> <input type="text" placeholder="Altro..." id="altroRapportoVittimaAggressore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_aggressore_servizi">
                    <label class="form-label"><span class="h6s">Il presunto autore della violenza &egrave; in carico ai servizi (SERT, DSM, ...)</span>&nbsp;<span id="aggressore_servizi_error_msg" style="color: red;"></span></label> <br />
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
                      <option value="Servizi per le dipendenze patologiche (SERD)">Servizi per le dipendenze patologiche (SERD)</option>
                      <option value="Dipartimento Salute Mentale (DSM)">Dipartimento Salute Mentale (DSM)</option>
                      <option value="Servizi Sociali">Servizi Sociali</option>
                      <option value="Altro...">Altro...</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_altroTipologiaServiziAggressore">
                    <div class="form-holder">
                      <span id="altroTipologiaServiziAggressore_error_msg" style="color: red;"></span> <input type="text" placeholder="Altro..." id="altroTipologiaServiziAggressore" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
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
                  <hr />
                  <label class="form-label h6s"><b>Invio ed attivazione della rete anti - violenza intra/extra ospedaliera</b></label>
                  <div class="form-group" id="div_rete_intra_ospedaliera">
                    <label class="form-label"><span class="h6s">Intra ospedaliera</span>&nbsp;<span id="rete_intra_ospedaliera_error_msg" style="color: red;"></span></label> <select class="custom-select" id="rete_intra_ospedaliera">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="Consulenza specialistica">Consulenza specialistica</option>
                      <option value="Ricovero reparto OBI">Ricovero reparto OBI</option>
                      <option value="Ricovero in un altro reparto">Ricovero in un altro reparto</option>
                      <option value="Centro di prima assistenza psicologica">Centro di prima assistenza psicologica</option>
                      <option value="Altro...">Altro...</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_specifico_rete_intra_ospedaliera">
                    <div class="form-holder">
                      <span id="specifico_rete_intra_ospedaliera_error_msg" style="color: red;"></span> <input type="text" placeholder="Specifica ..." id="specifico_rete_intra_ospedaliera" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_rete_extra_ospedaliera">
                    <label class="form-label"><span class="h6s">Extra ospedaliera</span>&nbsp;<span id="rete_extra_ospedaliera_error_msg" style="color: red;"></span></label> <select class="custom-select" id="rete_extra_ospedaliera">
                      <option selected="selected" value="Scegli...">Scegli...</option>
                      <option value="Forze dell'Ordine">Forze dell'Ordine</option>
                      <option value="Centri anti - violenza">Centri anti - violenza</option>
                      <option value="Servizi sociali territoriali">Servizi sociali territoriali</option>
                      <option value="Casa di accoglienza per donne maltrattate">Casa di accoglienza per donne maltrattate</option>
                      <option value="Altro...">Altro...</option>
                    </select>
                  </div>
                  <div class="form-group" id="div_specifico_rete_extra_ospedaliera">
                    <div class="form-holder">
                      <span id="specifico_rete_extra_ospedaliera_error_msg" style="color: red;"></span> <input type="text" placeholder="Specifica ..." id="specifico_rete_extra_ospedaliera" class="form-control" style="font-size: medium;">
                    </div>
                  </div>
                  <div class="form-group" id="div_forze_dell_ordine">
                    <label class="form-label"><span class="h6s">Forze dell'Ordine</span>&nbsp;<span id="forze_dell_ordine_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="polizia" value="Polizia" name="forze_dell_ordine" class="custom-control-input"> <label class="custom-control-label" for="polizia" style="font-size: medium;">Polizia</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="carabinieri" value="Carabinieri" name="forze_dell_ordine" class="custom-control-input"> <label class="custom-control-label" for="carabinieri" style="font-size: medium;">Carabinieri</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="polizialocale" value="Polizia Locale" name="forze_dell_ordine" class="custom-control-input"> <label class="custom-control-label" for="polizialocale" style="font-size: medium;">Polizia Locale</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="gf" value="Guardia di Finanza" name="forze_dell_ordine" class="custom-control-input"> <label class="custom-control-label" for="gf" style="font-size: medium;">Guardia di Finanza</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="vigilidelfuoco" value="Vigili del Fuoco" name="forze_dell_ordine" class="custom-control-input"> <label class="custom-control-label" for="vigilidelfuoco" style="font-size: medium;">Vigili del Fuoco</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Tempi di prognosi</span>&nbsp;<span id="tempi_di_prognosi_error_msg" style="color: red;"></span></label> <select class="custom-select" id="tempi_di_prognosi">
                      <option selected="selected">Scegli...</option>
                      <option value="1 giorno">1 giorno</option>
                      <option value="2 - 7 giorni">2 - 7 giorni</option>
                      <option value="8 - 15 giorni">8 - 15 giorni</option>
                      <option value="16 - 20 giorni">16 - 20 giorni</option>
                      <option value="Oltre 20">Oltre 20</option>
                    </select>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Referti</span>&nbsp;<span id="referto_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_referto" value="Si" name="referto" class="custom-control-input"> <label class="custom-control-label" for="si_referto" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_referto" value="No" name="referto" class="custom-control-input"> <label class="custom-control-label" for="no_referto" style="font-size: medium;">No</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Attestazioni</span>&nbsp;<span id="attestazioni_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_attestazioni" value="Si" name="attestazioni" class="custom-control-input"> <label class="custom-control-label" for="si_attestazioni" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_attestazioni" value="No" name="attestazioni" class="custom-control-input"> <label class="custom-control-label" for="no_attestazioni" style="font-size: medium;">No</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label"><span class="h6s">Attivato Percorso Rosa</span>&nbsp;<span id="codiceRosa_error_msg" style="color: red;"></span></label> <br />
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="si_codicerosa" value="Si" name="codiceRosa" class="custom-control-input"> <label class="custom-control-label" for="si_codicerosa" style="font-size: medium;">Si</label>
                    </div>
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" id="no_codicerosa" value="No" name="codiceRosa" class="custom-control-input"> <label class="custom-control-label" for="no_codicerosa" style="font-size: medium;">No</label>
                    </div>
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
