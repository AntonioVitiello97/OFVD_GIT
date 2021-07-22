<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.model.dao.AccountsDao"%>
<%@page import="it.unisa.ofvd.utils.*"%>
<%@page import="it.unisa.ofvd.model.QuestionsModel"%>
<%@page import="it.unisa.ofvd.model.dao.QuestionsDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.*"%>
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

QuestionsDao question = new QuestionsDao();
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
<!-- JSpdf -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.4.1/jspdf.debug.js"></script>
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet" href="../assets/wizard_layout/fonts/material-design-iconic-font/css/material-design-iconic-font.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="../assets/wizard_layout/css/style.css">
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

	function indietro() {
		var url = "inviate.jsp";
		$(location).attr('href', url);
	}

	var question = new Object();

	function load() {
		$("#question1").hide();
		$("#question2").hide();
		$("#question3").hide();
		$("#question4").hide();
		$("#question5").hide();

		var idQuestion = new URLSearchParams(window.location.search);
		var q_id = idQuestion.get('id_question');

		question.action = "viewDraft";
		question.answer1 = "" + q_id;

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
						var tab = "";
						var tab2 = "";
						var tab3 = "";
						var tab4 = "";
						var tab5 = "";

						// Domande: 1 Dati della scheda
						var identificativo_scheda = jsonStr['answer1'];
						var data_compilazione = jsonStr['answer2'];
						var nome_compilatore = jsonStr['answer3'];
						var cognome_compilatore = jsonStr['answer4'];
						var ruoloCompilatore_select = jsonStr['answer60'];
						var altroruolocompilatore = jsonStr['answer61'];
						var identificativoServizio_select = jsonStr['answer62'];
						var altroIdentificativoServizio = jsonStr['answer63'];
						var prontosoccorso_select = jsonStr['answer5'];
						var provincia_prontosoccorso_select = jsonStr['answer64'];
						var comune_prontosoccorso_select = jsonStr['answer65'];
						var cav_nome = jsonStr['answer66'];
						var provincia_cav_select = jsonStr['answer67'];
						var comune_cav_select = jsonStr['answer68'];
						var sportelloDiAscolto_select = jsonStr['answer69'];
						var sportello_nome = jsonStr['answer70'];
						var provincia_sportellodiascolto_select = jsonStr['answer71'];
						var comune_sportellodiascolto_select = jsonStr['answer72'];

						//Domande: 2 dati Anagrafici della donna
						var nome_vittima = jsonStr['answer6'];
						var cognome_vittima = jsonStr['answer7'];
						var data_nascita = jsonStr['answer8'];
						var luogo_select = jsonStr['answer9'];
						var provincia_nascita_select = jsonStr['answer10'];
						var comune_nascita_select = jsonStr['answer11'];
						var indirizzo = jsonStr['answer12'];
						var telefono_personale = jsonStr['answer13'];
						var altro_telefono = jsonStr['answer14'];
						var cittadinanza = jsonStr['answer15'];
						var cittadinanza_select = jsonStr['answer16'];
						var select_lingua_italiana = jsonStr['answer17'];
						var mediatoreCulturale = jsonStr['answer18'];
						var statoCivile = jsonStr['answer19'];
						var altrostatocivile = jsonStr['answer20'];
						var figli = jsonStr['answer21'];
						var numero_figli = jsonStr['answer22'];
						var numero_figli_minorenni = jsonStr['answer23'];
						var numero_figli_minorenni_maschi = jsonStr['answer73'];
						var numero_figli_minorenni_femmine = jsonStr['answer74'];
						var convivono_figliFemmine = jsonStr['answer75'];
						var assistonoViolenza_figli = jsonStr['answer76'];
						var subisconoViolenza_figli = jsonStr['answer77'];
						var selectTitoloDiStudio = jsonStr['answer24'];
						var altroTitoloDiStudio = jsonStr['answer25'];
						var selectProfessione = jsonStr['answer26'];
						var altro_stato_occupazionale_donna = jsonStr['answer78'];
						var autonomo_economicamente = jsonStr['answer27'];

						//Domande:3 Tipologia della Violenza
						var primo_accesso_servizio_antiviolenza = jsonStr['answer28'];
						var numero_accessi_ripetuti = jsonStr['answer29'];
						var accesso_occasionale = jsonStr['answer79'];
						var selectDonnaAccompagnataAlServizioAntiviolenza = jsonStr['answer80'];
						var donnaaccompagnata_forzedellordine_select = jsonStr['answer81'];
						var provincia_donnaaccompagnata_forzedellordine_select = jsonStr['answer82'];
						var comune_donnaaccompagnata_forzedellordine_select = jsonStr['answer83'];
						var donnaaccompagnata_prontosoccorso_select = jsonStr['answer84'];
						var provincia_donnaaccompagnata_prontosoccorso_select = jsonStr['answer85'];
						var comune_donnaaccompagnata_prontosoccorso_select = jsonStr['answer86'];
						var selectDonnaAccompagnataDaAltrePersoneInSA = jsonStr['answer31'];
						var altroDonnaAccompagnataInPS = jsonStr['answer32'];
						var motivoAccesso = jsonStr['answer33'];
						var selectTipologiaViolenza = jsonStr['answer87'];
						var sfruttamento = jsonStr['answer30'];
						sfruttamento = sfruttamento.replace(/;/g, "<br>");

						var violenzeRiferite = jsonStr['answer88'];
						violenzeRiferite = violenzeRiferite.replace(/;/g,
								"<br>");

						var altroViolenzaRiferita = jsonStr['answer89'];

						//Domande:4 Presunto autore della Violenza
						var conosci_aggressore = jsonStr['answer90'];
						var nome_presunto_aggressore = jsonStr['answer34'];
						var cognome_presunto_aggressore = jsonStr['answer35'];
						var data_nascita_presunto_aggressore = jsonStr['answer36'];
						var luogo_presunto_aggressore_select = jsonStr['answer37'];
						var provincia_nascita_presunto_aggressore_select = jsonStr['answer38'];
						var comune_nascita_presunto_aggressore_select = jsonStr['answer39'];
						var indirizzo_presunto_aggressore = jsonStr['answer40'];
						var telefono_presunto_aggressore = jsonStr['answer41'];
						var selectTitoloDiStudioAggressore = jsonStr['answer42'];
						var altroTitoloDiStudioAggressore = jsonStr['answer43'];
						var selectProfessioneAggressore = jsonStr['answer44'];
						var altro_stato_occupazionale_aggressore = jsonStr['answer91'];
						var fascia_di_eta_aggressore = jsonStr['answer45'];
						var rapporto_vittima_autore_violenza = jsonStr['answer46'];
						var tipologia_familiare = jsonStr['answer47'];
						var altroRapportoVittimaAggressore = jsonStr['answer48'];
						var aggressore_servizi = jsonStr['answer49'];
						var tipologia_servizi_aggressore = jsonStr['answer50'];
						var altroTipologiaServiziAggressore = jsonStr['answer51'];
						var violenza_assistitaosubita = jsonStr['answer92'];
						var precedenti_penali = jsonStr['answer52'];

						//Domande:5 Valutazioni
						var brief_risk_1 = jsonStr['answer53'];
						var brief_risk_2 = jsonStr['answer54'];
						var brief_risk_3 = jsonStr['answer55'];
						var brief_risk_4 = jsonStr['answer56'];
						var brief_risk_5 = jsonStr['answer57'];
						var brief_risk_6 = jsonStr['answer58'];
						var brief_risk_7 = jsonStr['answer59'];
						var faseDiSeparazione = jsonStr['answer93'];
						var separata = jsonStr['answer94'];
						var tempo_separazione_select = jsonStr['answer95'];
						var haComunicatoAlPartner = jsonStr['answer96'];
						var sporgereDenuncia = jsonStr['answer97'];
						var sportoDenuncia = jsonStr['answer98'];
						var selectForzeDellOrdineDenuncia = jsonStr['answer99'];
						var provincia_denuncia_select = jsonStr['answer100'];
						var comune_denuncia_select = jsonStr['answer101'];
						var ritiratoDenuncia = jsonStr['answer102'];
						var motivoRitiroDenuncia_select = jsonStr['answer103'];
						var valutazione_stato_bisogno = jsonStr['answer104'];
						valutazione_stato_bisogno = valutazione_stato_bisogno
								.replace(/;/g, "<br>");

						var specificare_altro_ValutazioneStatoBisogno = jsonStr['answer105'];
						var presaInCarico = jsonStr['answer106'];
						presaInCarico = presaInCarico.replace(/;/g, "<br>");

						var prestazioniEffettuate = jsonStr['answer107'];
						var attivazioneRete_select = jsonStr['answer108'];
						var attivazioneRete_prontosoccorso_select = jsonStr['answer109'];
						var attivazioneRete_provincia_prontosoccorso_select = jsonStr['answer110'];
						var attivazioneRete_comune_prontosoccorso_select = jsonStr['answer111'];
						var attivazioneRete_forzedellordine_select = jsonStr['answer112'];
						var attivazioneRete_provincia_forzedellordine_select = jsonStr['answer113'];
						var attivazioneRete_comune_forzedellordine_select = jsonStr['answer114'];
						var servizioSanitario_provincia_select = jsonStr['answer115'];
						var serviziSociali_provincia_select = jsonStr['answer116'];

						tab = "<tr><td width='65%'><label><h6>Identificativo scheda: </h6></label></td><td><label class='form-label'><h6>"
								+ identificativo_scheda
								+ "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Data compilazione: </h6></label></td><td><label class='form-label'><h6>"
								+ data_compilazione + "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Nome del compilatore: </h6></label></td><td><label class='form-label'><h6>"
								+ nome_compilatore + "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Cognome del compilatore: </h6></label></td><td><label class='form-label'><h6>"
								+ cognome_compilatore
								+ "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Ruolo del compilatore: </h6></label></td><td><label class='form-label'><h6>"
								+ ruoloCompilatore_select
								+ "</h6></label></td></tr>";

						if (ruoloCompilatore_select == "Altro")
							tab += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ altroruolocompilatore
									+ "</h6></label></td></tr>";

						tab += "<tr><td width='65%'><label><h6>Identificativo servizio: </h6></label></td><td><label class='form-label'><h6>"
								+ identificativoServizio_select
								+ "</h6></label></td></tr>";

						if (identificativoServizio_select == 'Altro')
							tab += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ altroIdentificativoServizio
									+ "</h6></label></td></tr>";

						if (identificativoServizio_select == 'Centro di prima assistenza psicologica') {
							tab += "<tr><td width='65%'><label><h6>Pronto Soccorso: </h6></label></td><td><label class='form-label'><h6>"
									+ prontosoccorso_select
									+ "</h6></label></td></tr>";
							tab += "<tr><td width='65%'><label><h6>Provincia: </h6></label></td><td><label class='form-label'><h6>"
									+ provincia_prontosoccorso_select
									+ "</h6></label></td></tr>";
							tab += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ comune_prontosoccorso_select
									+ "</h6></label></td></tr>";
						}

						if (identificativoServizio_select == 'Centro Antiviolenza') {
							tab += "<tr><td width='65%'><label><h6>Centro Antiviolenza: </h6></label></td><td><label class='form-label'><h6>"
									+ cav_nome + "</h6></label></td></tr>";
							tab += "<tr><td width='65%'><label><h6>Provincia: </h6></label></td><td><label class='form-label'><h6>"
									+ provincia_cav_select
									+ "</h6></label></td></tr>";
							tab += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ comune_cav_select
									+ "</h6></label></td></tr>";
						}

						if (identificativoServizio_select == 'Sportello di ascolto') {
							tab += "<tr><td width='65%'><label><h6>Sportello di ascolto: </h6></label></td><td><label class='form-label'><h6>"
									+ sportelloDiAscolto_select
									+ "</h6></label></td></tr>";
							tab += "<tr><td width='65%'><label><h6>Nome: </h6></label></td><td><label class='form-label'><h6>"
									+ sportello_nome
									+ "</h6></label></td></tr>";
							tab += "<tr><td width='65%'><label><h6>Provincia: </h6></label></td><td><label class='form-label'><h6>"
									+ provincia_sportellodiascolto_select
									+ "</h6></label></td></tr>";
							tab += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ comune_sportellodiascolto_select
									+ "</h6></label></td></tr>";
						}

						tab2 += "<tr><td width='65%'><label><h6>Nome: </h6></label></td><td><label class='form-label'><h6>"
								+ nome_vittima + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Cognome: </h6></label></td><td><label class='form-label'><h6>"
								+ cognome_vittima + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Data di Nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ data_nascita + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Luogo di Nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ luogo_select + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Residente/Domiciliata in Provincia di: </h6></label></td><td><label class='form-label'><h6>"
								+ provincia_nascita_select
								+ "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Residente/Domiciliata nel Comune di: </h6></label></td><td><label class='form-label'><h6>"
								+ comune_nascita_select
								+ "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Indirizzo: </h6></label></td><td><label class='form-label'><h6>"
								+ indirizzo + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Telefono personale: </h6></label></td><td><label class='form-label'><h6>"
								+ telefono_personale
								+ "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Altro telefono: </h6></label></td><td><label class='form-label'><h6>"
								+ altro_telefono + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Cittadinanza Italiana: </h6></label></td><td><label class='form-label'><h6>"
								+ cittadinanza + "</h6></label></td></tr>";
						if (cittadinanza == "No")
							tab2 += "<tr><td width='65%'><label><h6>Cittadinanza: </h6></label></td><td><label class='form-label'><h6>"
									+ cittadinanza_select
									+ "</h6></label></td></tr>";

						tab2 += "<tr><td width='65%'><label><h6>Conoscenza lingua italiana: </h6></label></td><td><label class='form-label'><h6>"
								+ select_lingua_italiana
								+ "</h6></label></td></tr>";
						if (select_lingua_italiana == "Poco"
								|| select_lingua_italiana == "No")
							tab2 += "<tr><td width='65%'><label><h6>Mediatore culturale: </h6></label></td><td><label class='form-label'><h6>"
									+ mediatoreCulturale
									+ "</h6></label></td></tr>";

						tab2 += "<tr><td width='65%'><label><h6>Stato civile: </h6></label></td><td><label class='form-label'><h6>"
								+ statoCivile + "</h6></label></td></tr>";
						if (statoCivile == "Altro")
							tab2 += "<tr><td width='65%'><label><h6>Altro stato civile: </h6></label></td><td><label class='form-label'><h6>"
									+ altrostatocivile
									+ "</h6></label></td></tr>";

						tab2 += "<tr><td width='65%'><label><h6>Figli: </h6></label></td><td><label class='form-label'><h6>"
								+ figli + "</h6></label></td></tr>";
						if (figli == "Si") {
							tab2 += "<tr><td width='65%'><label><h6>Numero totale di figli: </h6></label></td><td><label class='form-label'><h6>"
									+ numero_figli + "</h6></label></td></tr>";
							tab2 += "<tr><td width='65%'><label><h6>Di cui minorenni: </h6></label></td><td><label class='form-label'><h6>"
									+ numero_figli_minorenni
									+ "</h6></label></td></tr>";
							tab2 += "<tr><td width='65%'><label><h6>Di cui maschi: </h6></label></td><td><label class='form-label'><h6>"
									+ numero_figli_minorenni_maschi
									+ "</h6></label></td></tr>";
							tab2 += "<tr><td width='65%'><label><h6>Di cui femmine: </h6></label></td><td><label class='form-label'><h6>"
									+ numero_figli_minorenni_femmine
									+ "</h6></label></td></tr>";
							tab2 += "<tr><td width='65%'><label><h6>I figli convivono con la madre?</h6></label></td><td><label class='form-label'><h6>"
									+ convivono_figliFemmine
									+ "</h6></label></td></tr>";
							tab2 += "<tr><td width='65%'><label><h6>I figli assistono alla violenza?</h6></label></td><td><label class='form-label'><h6>"
									+ assistonoViolenza_figli
									+ "</h6></label></td></tr>";
							tab2 += "<tr><td width='65%'><label><h6>I figli subiscono violenza diretta?</h6></label></td><td><label class='form-label'><h6>"
									+ subisconoViolenza_figli
									+ "</h6></label></td></tr>";
						}

						tab2 += "<tr><td width='65%'><label><h6>Titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
								+ selectTitoloDiStudio
								+ "</h6></label></td></tr>";
						if (selectTitoloDiStudio == "Altro")
							tab2 += "<tr><td width='65%'><label><h6>Altro titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
									+ altroTitoloDiStudio
									+ "</h6></label></td></tr>";

						tab2 += "<tr><td width='65%'><label><h6>Stato occupazionale: </h6></label></td><td><label class='form-label'><h6>"
								+ selectProfessione + "</h6></label></td></tr>";
						if (selectProfessione == "Altro")
							tab2 += "<tr><td width='65%'><label><h6>Altro stato occupazionale: </h6></label></td><td><label class='form-label'><h6>"
									+ altro_stato_occupazionale_donna
									+ "</h6></label></td></tr>";

						tab2 += "<tr><td width='65%'><label><h6>Autonomo economicamente: </h6></label></td><td><label class='form-label'><h6>"
								+ autonomo_economicamente
								+ "</h6></label></td></tr>";

						tab3 += "<tr><td width='65%'><label><h6>Primo accesso al Servizio Antiviolenza: </h6></label></td><td><label class='form-label'><h6>"
								+ primo_accesso_servizio_antiviolenza
								+ "</h6></label></td></tr>";
						if (primo_accesso_servizio_antiviolenza == "No") {
							tab3 += "<tr><td width='65%'><label><h6>Numero accessi precedenti: </h6></label></td><td><label class='form-label'><h6>"
									+ numero_accessi_ripetuti
									+ "</h6></label></td></tr>";
							tab3 += "<tr><td width='65%'><label><h6>Accesso occasionale?</h6></label></td><td><label class='form-label'><h6>"
									+ accesso_occasionale
									+ "</h6></label></td></tr>";
						}

						tab3 += "<tr><td width='65%'><label><h6>La donna accede al Servizio Antiviolenza: </h6></label></td><td><label class='form-label'><h6>"
								+ selectDonnaAccompagnataAlServizioAntiviolenza
								+ "</h6></label></td></tr>";

						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata dalle Forze dell'Ordine") {
							tab3 += "<tr><td width='65%'><label><h6>Forze dell'Ordine: </h6></label></td><td><label class='form-label'><h6>"
									+ donnaaccompagnata_forzedellordine_select
									+ "</h6></label></td></tr>";
							tab3 += "<tr><td width='65%'><label><h6>Pronvincia: </h6></label></td><td><label class='form-label'><h6>"
									+ provincia_donnaaccompagnata_forzedellordine_select
									+ "</h6></label></td></tr>";
							tab3 += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ comune_donnaaccompagnata_forzedellordine_select
									+ "</h6></label></td></tr>";
						}
						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata dal Pronto Soccorso") {
							tab3 += "<tr><td width='65%'><label><h6>Pronto Soccorso: </h6></label></td><td><label class='form-label'><h6>"
									+ donnaaccompagnata_prontosoccorso_select
									+ "</h6></label></td></tr>";
							tab3 += "<tr><td width='65%'><label><h6>Provincia: </h6></label></td><td><label class='form-label'><h6>"
									+ provincia_donnaaccompagnata_prontosoccorso_select
									+ "</h6></label></td></tr>";
							tab3 += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ comune_donnaaccompagnata_prontosoccorso_select
									+ "</h6></label></td></tr>";
						}
						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata da altre persone")
							tab3 += "<tr><td width='65%'><label><h6>Accompagnata da: </h6></label></td><td><label class='form-label'><h6>"
									+ selectDonnaAccompagnataDaAltrePersoneInSA
									+ "</h6></label></td></tr>";

						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Altro")
							tab3 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ altroDonnaAccompagnataInPS
									+ "</h6></label></td></tr>";

						tab3 += "<tr><td width='65%'><label><h6>Motivo dell'Accesso: </h6></label></td><td><label class='form-label'><h6 style='text-align: justify;text-justify: inter-word;'>"
								+ motivoAccesso + "</h6></label></td></tr>";

						tab3 += "<tr><td width='65%'><label><h6>Tipologia della violenza riferita: </h6></label></td><td><label class='form-label'><h6>"
								+ selectTipologiaViolenza
								+ "</h6></label></td></tr>";
						if (selectTipologiaViolenza == "Altro")
							tab3 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ altroViolenzaRiferita
									+ "</h6></label></td></tr>";

						if (selectTipologiaViolenza == "Violenza domestica"
								|| selectTipologiaViolenza == "Violenza extra domestica")
							tab3 += "<tr><td width='65%'><label><h6>Violenza domestica: </h6></label></td><td><label class='form-label'><h6>"
									+ sfruttamento
									+ violenzeRiferite
									+ "</h6></label></td></tr>";

						tab4 += "<tr><td width='65%'><label><h6>Conosce il presunto autore della violenza?</h6></label></td><td><label class='form-label'><h6>"
								+ conosci_aggressore
								+ "</h6></label></td></tr>";

						if (conosci_aggressore == "Si") {
							tab4 += "<tr><td width='65%'><label><h6>Nome: </h6></label></td><td><label class='form-label'><h6>"
									+ nome_presunto_aggressore
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Cognome: </h6></label></td><td><label class='form-label'><h6>"
									+ cognome_presunto_aggressore
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Data di Nascita: </h6></label></td><td><label class='form-label'><h6>"
									+ data_nascita_presunto_aggressore
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Luogo di Nascita: </h6></label></td><td><label class='form-label'><h6>"
									+ luogo_presunto_aggressore_select
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Residente/Domiciliato in Provincia di: </h6></label></td><td><label class='form-label'><h6>"
									+ provincia_nascita_presunto_aggressore_select
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Residente/Domiciliato nel Comune di: </h6></label></td><td><label class='form-label'><h6>"
									+ comune_nascita_presunto_aggressore_select
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Indirizzo: </h6></label></td><td><label class='form-label'><h6>"
									+ indirizzo_presunto_aggressore
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Telefono personale: </h6></label></td><td><label class='form-label'><h6>"
									+ telefono_presunto_aggressore
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
									+ selectTitoloDiStudioAggressore
									+ "</h6></label></td></tr>";
							if (selectTitoloDiStudioAggressore == "Altro")
								tab4 += "<tr><td width='65%'><label><h6>Altro titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
										+ altroTitoloDiStudioAggressore
										+ "</h6></label></td></tr>";

							tab4 += "<tr><td width='65%'><label><h6>Stato occupazionale: </h6></label></td><td><label class='form-label'><h6>"
									+ selectProfessioneAggressore
									+ "</h6></label></td></tr>";
							if (selectProfessioneAggressore == "Altro")
								tab4 += "<tr><td width='65%'><label><h6>Altro titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
										+ altro_stato_occupazionale_aggressore
										+ "</h6></label></td></tr>";

							tab4 += "<tr><td width='65%'><label><h6>Fascia di età: </h6></label></td><td><label class='form-label'><h6>"
									+ fascia_di_eta_aggressore
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Rapporto vittima/presunto autore di violenza: </h6></label></td><td><label class='form-label'><h6>"
									+ rapporto_vittima_autore_violenza
									+ "</h6></label></td></tr>";
							if (rapporto_vittima_autore_violenza == "Familiare")
								tab4 += "<tr><td width='65%'><label><h6>Familiare: </h6></label></td><td><label class='form-label'><h6>"
										+ tipologia_familiare
										+ "</h6></label></td></tr>";

							if (tipologia_familiare == "Altro")
								tab4 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
										+ altroRapportoVittimaAggressore
										+ "</h6></label></td></tr>";

							tab4 += "<tr><td width='65%'><label><h6>Il presunto autore della violenza è in carico ai servizi (SERT, DSM, ...): </h6></label></td><td><label class='form-label'><h6>"
									+ aggressore_servizi
									+ "</h6></label></td></tr>";
							if (aggressore_servizi == "Si") {
								tab4 += "<tr><td width='65%'><label><h6>Tipologia servizi: </h6></label></td><td><label class='form-label'><h6>"
										+ tipologia_servizi_aggressore
										+ "</h6></label></td></tr>";
								if (tipologia_servizi_aggressore == "Altro")
									tab4 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
											+ altroTipologiaServiziAggressore
											+ "</h6></label></td></tr>";

							}

							tab4 += "<tr><td width='65%'><label><h6>Violenza assistita o subita nella famiglia di origine: </h6></label></td><td><label class='form-label'><h6>"
									+ violenza_assistitaosubita
									+ "</h6></label></td></tr>";
							tab4 += "<tr><td width='65%'><label><h6>Precedenti penali: </h6></label></td><td><label class='form-label'><h6>"
									+ precedenti_penali
									+ "</h6></label></td></tr>";

						}

						tab5 += "<tr><td width='65%'><label><h6>La frequenza e/o la gravità degli atti di violenza fisica sono aumentati negli ultimi 6 mesi?</h6></label></td><td><label class='form-label'><h6>"
								+ brief_risk_1 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>L’aggressore ha mai utilizzato un’arma, o l’ha minacciata con un’arma, o ha tentato di strangolarla?</h6></label></td><td><label class='form-label'><h6>"
								+ brief_risk_2 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Pensa che l’aggressore possa farle del male (ucciderla)?</h6></label></td><td><label class='form-label'><h6>"
								+ brief_risk_3 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>L’ha mai picchiata durante la gravidanza?</h6></label></td><td><label class='form-label'><h6>"
								+ brief_risk_4 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>L’aggressore è violentemente e costantemente geloso di lei?</h6></label></td><td><label class='form-label'><h6>"
								+ brief_risk_5 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Riferisce Escalation della violenza?</h6></label></td><td><label class='form-label'><h6>"
								+ brief_risk_6 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Il presunto autore ha violato misure cautelari e/o interdittive?</h6></label></td><td><label class='form-label'><h6>"
								+ brief_risk_7 + "</h6></label></td></tr>";

						tab5 += "<tr><td width='65%'><label><h6>La donna è in fase di separazione?</h6></label></td><td><label class='form-label'><h6>"
								+ faseDiSeparazione + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>La donna è separata?</h6></label></td><td><label class='form-label'><h6>"
								+ separata + "</h6></label></td></tr>";
						if (separata == "Si")
							tab5 += "<tr><td width='65%'><label><h6>Periodo di tempo: </h6></label></td><td><label class='form-label'><h6>"
									+ tempo_separazione_select
									+ "</h6></label></td></tr>";

						tab5 += "<tr><td width='65%'><label><h6>La donna ha comunicato la decisione di separarsi?</h6></label></td><td><label class='form-label'><h6>"
								+ haComunicatoAlPartner
								+ "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>La donna ha deciso di sporgere denuncia?</h6></label></td><td><label class='form-label'><h6>"
								+ sporgereDenuncia + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>La donna ha sporto denuncia?</h6></label></td><td><label class='form-label'><h6>"
								+ sportoDenuncia + "</h6></label></td></tr>";

						if (sportoDenuncia == "Si") {
							tab5 += "<tr><td width='65%'><label><h6>Presso: </h6></label></td><td><label class='form-label'><h6>"
									+ selectForzeDellOrdineDenuncia
									+ "</h6></label></td></tr>";
							tab5 += "<tr><td width='65%'><label><h6>Provincia: </h6></label></td><td><label class='form-label'><h6>"
									+ provincia_denuncia_select
									+ "</h6></label></td></tr>";
							tab5 += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ comune_denuncia_select
									+ "</h6></label></td></tr>";
						}

						tab5 += "<tr><td width='65%'><label><h6>La donna ha ritirato la denuncia?</h6></label></td><td><label class='form-label'><h6>"
								+ ritiratoDenuncia + "</h6></label></td></tr>";
						if (ritiratoDenuncia == "Si")
							tab5 += "<tr><td width='65%'><label><h6>La donna ha ritirato la denuncia?</h6></label></td><td><label class='form-label'><h6>"
									+ motivoRitiroDenuncia_select
									+ "</h6></label></td></tr>";

						tab5 += "<tr><td width='65%'><label><h6>Valutazione dello stato di bisogno: </h6></label></td><td><label class='form-label'><h6>"
								+ valutazione_stato_bisogno
								+ "</h6></label></td></tr>";
						if (valutazione_stato_bisogno == "Altro;")
							tab5 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ specificare_altro_ValutazioneStatoBisogno
									+ "</h6></label></td></tr>";

						tab5 += "<tr><td width='65%'><label><h6>Presa in carico per: </h6></label></td><td><label class='form-label'><h6>"
								+ presaInCarico + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Prestazioni effettuate: </h6></label></td><td><label class='form-label'><h6>"
								+ prestazioniEffettuate
								+ "</h6></label></td></tr>";

						tab5 += "<tr><td width='65%'><label><h6>Attivazione della Rete Territoriale Antiviolenza con invio a: </h6></label></td><td><label class='form-label'><h6>"
								+ attivazioneRete_select
								+ "</h6></label></td></tr>";

						if (attivazioneRete_select == "Pronto Soccorso") {
							tab5 += "<tr><td width='65%'><label><h6>Pronto Soccorso: </h6></label></td><td><label class='form-label'><h6>"
									+ attivazioneRete_prontosoccorso_select
									+ "</h6></label></td></tr>";
							tab5 += "<tr><td width='65%'><label><h6>Provincia: </h6></label></td><td><label class='form-label'><h6>"
									+ attivazioneRete_provincia_prontosoccorso_select
									+ "</h6></label></td></tr>";
							tab5 += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ attivazioneRete_comune_prontosoccorso_select
									+ "</h6></label></td></tr>";
						}
						if (attivazioneRete_select == "Forze dell'Ordine") {
							tab5 += "<tr><td width='65%'><label><h6>Forze dell'Ordine: </h6></label></td><td><label class='form-label'><h6>"
									+ attivazioneRete_forzedellordine_select
									+ "</h6></label></td></tr>";
							tab5 += "<tr><td width='65%'><label><h6>Provincia: </h6></label></td><td><label class='form-label'><h6>"
									+ attivazioneRete_provincia_forzedellordine_select
									+ "</h6></label></td></tr>";
							tab5 += "<tr><td width='65%'><label><h6>Comune: </h6></label></td><td><label class='form-label'><h6>"
									+ attivazioneRete_comune_forzedellordine_select
									+ "</h6></label></td></tr>";
						}
						if (attivazioneRete_select == "Servizio Sanitario")
							tab5 += "<tr><td width='65%'><label><h6>ASL della Provincia di: </h6></label></td><td><label class='form-label'><h6>"
									+ servizioSanitario_provincia_select
									+ "</h6></label></td></tr>";

						if (attivazioneRete_select == "Servizi Sociali")
							tab5 += "<tr><td width='65%'><label><h6>Servizi Sociali della Provincia di: </h6></label></td><td><label class='form-label'><h6>"
									+ serviziSociali_provincia_select
									+ "</h6></label></td></tr>";

						var divTable1 = document
								.getElementById("tableQuestion1");
						var divTable2 = document
								.getElementById("tableQuestion2");
						var divTable3 = document
								.getElementById("tableQuestion3");
						var divTable4 = document
								.getElementById("tableQuestion4");
						var divTable5 = document
								.getElementById("tableQuestion5");

						divTable1.innerHTML = tab;
						divTable2.innerHTML = tab2;
						divTable3.innerHTML = tab3;
						divTable4.innerHTML = tab4;
						divTable5.innerHTML = tab5;

						$('#question1').show();
						$('#question2').show();
						$('#question3').show();
						$('#question4').show();
						$('#question5').show();
					}
				});
	}

	function print() {

		var idQuestion = new URLSearchParams(window.location.search);
		var q_id = idQuestion.get('id_question');

		question.action = "viewDraft";
		question.answer1 = "" + q_id;

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

						var doc = new jsPDF('p', 'pt', [ 595.28, 841.89 ]);

						var tab = "";
						var tab2 = "";
						var tab3 = "";
						var tab4 = "";
						var tab5 = "";

						// Domande: 1 Dati della scheda
						var identificativo_scheda = jsonStr['answer1'];
						var data_compilazione = jsonStr['answer2'];
						var nome_compilatore = jsonStr['answer3'];
						var cognome_compilatore = jsonStr['answer4'];
						var ruoloCompilatore_select = jsonStr['answer60'];
						var altroruolocompilatore = jsonStr['answer61'];
						var identificativoServizio_select = jsonStr['answer62'];
						var altroIdentificativoServizio = jsonStr['answer63'];
						var prontosoccorso_select = jsonStr['answer5'];
						var provincia_prontosoccorso_select = jsonStr['answer64'];
						var comune_prontosoccorso_select = jsonStr['answer65'];
						var cav_nome = jsonStr['answer66'];
						var provincia_cav_select = jsonStr['answer67'];
						var comune_cav_select = jsonStr['answer68'];
						var sportelloDiAscolto_select = jsonStr['answer69'];
						var sportello_nome = jsonStr['answer70'];
						var provincia_sportellodiascolto_select = jsonStr['answer71'];
						var comune_sportellodiascolto_select = jsonStr['answer72'];

						//Domande: 2 dati Anagrafici della donna
						var nome_vittima = jsonStr['answer6'];
						var cognome_vittima = jsonStr['answer7'];
						var data_nascita = jsonStr['answer8'];
						var luogo_select = jsonStr['answer9'];
						var provincia_nascita_select = jsonStr['answer10'];
						var comune_nascita_select = jsonStr['answer11'];
						var indirizzo = jsonStr['answer12'];
						var telefono_personale = jsonStr['answer13'];
						var altro_telefono = jsonStr['answer14'];
						var cittadinanza = jsonStr['answer15'];
						var cittadinanza_select = jsonStr['answer16'];
						var select_lingua_italiana = jsonStr['answer17'];
						var mediatoreCulturale = jsonStr['answer18'];
						var statoCivile = jsonStr['answer19'];
						var altrostatocivile = jsonStr['answer20'];
						var figli = jsonStr['answer21'];
						var numero_figli = jsonStr['answer22'];
						var numero_figli_minorenni = jsonStr['answer23'];
						var numero_figli_minorenni_maschi = jsonStr['answer73'];
						var numero_figli_minorenni_femmine = jsonStr['answer74'];
						var convivono_figliFemmine = jsonStr['answer75'];
						var assistonoViolenza_figli = jsonStr['answer76'];
						var subisconoViolenza_figli = jsonStr['answer77'];
						var selectTitoloDiStudio = jsonStr['answer24'];
						var altroTitoloDiStudio = jsonStr['answer25'];
						var selectProfessione = jsonStr['answer26'];
						var altro_stato_occupazionale_donna = jsonStr['answer78'];
						var autonomo_economicamente = jsonStr['answer27'];

						//Domande:3 Tipologia della Violenza
						var primo_accesso_servizio_antiviolenza = jsonStr['answer28'];
						var numero_accessi_ripetuti = jsonStr['answer29'];
						var accesso_occasionale = jsonStr['answer79'];
						var selectDonnaAccompagnataAlServizioAntiviolenza = jsonStr['answer80'];
						var donnaaccompagnata_forzedellordine_select = jsonStr['answer81'];
						var provincia_donnaaccompagnata_forzedellordine_select = jsonStr['answer82'];
						var comune_donnaaccompagnata_forzedellordine_select = jsonStr['answer83'];
						var donnaaccompagnata_prontosoccorso_select = jsonStr['answer84'];
						var provincia_donnaaccompagnata_prontosoccorso_select = jsonStr['answer85'];
						var comune_donnaaccompagnata_prontosoccorso_select = jsonStr['answer86'];
						var selectDonnaAccompagnataDaAltrePersoneInSA = jsonStr['answer31'];
						var altroDonnaAccompagnataInPS = jsonStr['answer32'];
						var motivoAccesso = jsonStr['answer33'];
						var selectTipologiaViolenza = jsonStr['answer87'];
						var sfruttamento = jsonStr['answer30'];
						sfruttamento = sfruttamento.replace(/;/g, "<br>");

						var violenzeRiferite = jsonStr['answer88'];
						violenzeRiferite = violenzeRiferite.replace(/;/g,
								"<br>");

						var altroViolenzaRiferita = jsonStr['answer89'];

						//Domande:4 Presunto autore della Violenza
						var conosci_aggressore = jsonStr['answer90'];
						var nome_presunto_aggressore = jsonStr['answer34'];
						var cognome_presunto_aggressore = jsonStr['answer35'];
						var data_nascita_presunto_aggressore = jsonStr['answer36'];
						var luogo_presunto_aggressore_select = jsonStr['answer37'];
						var provincia_nascita_presunto_aggressore_select = jsonStr['answer38'];
						var comune_nascita_presunto_aggressore_select = jsonStr['answer39'];
						var indirizzo_presunto_aggressore = jsonStr['answer40'];
						var telefono_presunto_aggressore = jsonStr['answer41'];
						var selectTitoloDiStudioAggressore = jsonStr['answer42'];
						var altroTitoloDiStudioAggressore = jsonStr['answer43'];
						var selectProfessioneAggressore = jsonStr['answer44'];
						var altro_stato_occupazionale_aggressore = jsonStr['answer91'];
						var fascia_di_eta_aggressore = jsonStr['answer45'];
						var rapporto_vittima_autore_violenza = jsonStr['answer46'];
						var tipologia_familiare = jsonStr['answer47'];
						var altroRapportoVittimaAggressore = jsonStr['answer48'];
						var aggressore_servizi = jsonStr['answer49'];
						var tipologia_servizi_aggressore = jsonStr['answer50'];
						var altroTipologiaServiziAggressore = jsonStr['answer51'];
						var violenza_assistitaosubita = jsonStr['answer92'];
						var precedenti_penali = jsonStr['answer52'];

						//Domande:5 Valutazioni
						var brief_risk_1 = jsonStr['answer53'];
						var brief_risk_2 = jsonStr['answer54'];
						var brief_risk_3 = jsonStr['answer55'];
						var brief_risk_4 = jsonStr['answer56'];
						var brief_risk_5 = jsonStr['answer57'];
						var brief_risk_6 = jsonStr['answer58'];
						var brief_risk_7 = jsonStr['answer59'];
						var faseDiSeparazione = jsonStr['answer93'];
						var separata = jsonStr['answer94'];
						var tempo_separazione_select = jsonStr['answer95'];
						var haComunicatoAlPartner = jsonStr['answer96'];
						var sporgereDenuncia = jsonStr['answer97'];
						var sportoDenuncia = jsonStr['answer98'];
						var selectForzeDellOrdineDenuncia = jsonStr['answer99'];
						var provincia_denuncia_select = jsonStr['answer100'];
						var comune_denuncia_select = jsonStr['answer101'];
						var ritiratoDenuncia = jsonStr['answer102'];
						var motivoRitiroDenuncia_select = jsonStr['answer103'];
						var valutazione_stato_bisogno = jsonStr['answer104'];
						valutazione_stato_bisogno = valutazione_stato_bisogno
								.replace(/;/g, "<br>");

						var specificare_altro_ValutazioneStatoBisogno = jsonStr['answer105'];
						var presaInCarico = jsonStr['answer106'];
						presaInCarico = presaInCarico.replace(/;/g, "<br>");

						var prestazioniEffettuate = jsonStr['answer107'];
						var attivazioneRete_select = jsonStr['answer108'];
						var attivazioneRete_prontosoccorso_select = jsonStr['answer109'];
						var attivazioneRete_provincia_prontosoccorso_select = jsonStr['answer110'];
						var attivazioneRete_comune_prontosoccorso_select = jsonStr['answer111'];
						var attivazioneRete_forzedellordine_select = jsonStr['answer112'];
						var attivazioneRete_provincia_forzedellordine_select = jsonStr['answer113'];
						var attivazioneRete_comune_forzedellordine_select = jsonStr['answer114'];
						var servizioSanitario_provincia_select = jsonStr['answer115'];
						var serviziSociali_provincia_select = jsonStr['answer116'];

						tab = "Identificativo scheda:\n"
								+ identificativo_scheda + "\n\n";
						tab += "Data compilazione:\n" + data_compilazione
								+ "\n\n";
						tab += "Nome del compilatore:\n" + nome_compilatore
								+ "\n\n";
						tab += "Cognome del compilatore:\n"
								+ cognome_compilatore + "\n\n";
						tab += "Ruolo del compilatore:\n"
								+ ruoloCompilatore_select + "\n\n";

						if (ruoloCompilatore_select == "Altro")
							tab += "Altro:\n" + altroruolocompilatore + "\n\n";

						tab += "Identificativo servizio:\n"
								+ identificativoServizio_select + "\n\n";

						if (identificativoServizio_select == 'Altro')
							tab += "Altro:\n" + altroIdentificativoServizio
									+ "\n\n";

						if (identificativoServizio_select == 'Centro di prima assistenza psicologica') {
							tab += "Pronto Soccorso:\n" + prontosoccorso_select
									+ "\n\n";
							tab += "Provincia: "
									+ provincia_prontosoccorso_select + "\t";
							tab += "Comune: " + comune_prontosoccorso_select
									+ "\n\n";
						}

						if (identificativoServizio_select == 'Centro Antiviolenza') {
							tab += "Centro Antiviolenza:\n" + cav_nome + "\n\n";
							tab += "Provincia: " + provincia_cav_select + "\t";
							tab += "Comune: " + comune_cav_select + "\n\n";
						}

						if (identificativoServizio_select == 'Sportello di ascolto') {
							tab += "Sportello di ascolto:\n"
									+ sportelloDiAscolto_select + "\n\n";
							tab += "Nome:\n" + sportello_nome + "\n\n";
							tab += "Provincia: "
									+ provincia_sportellodiascolto_select
									+ "\t";
							tab += "Comune: "
									+ comune_sportellodiascolto_select + "\n\n";
						}

						var statuscap = jsonStr['status'];
						tab += "Status:\n" + statuscap.charAt(0).toUpperCase()
								+ statuscap.slice(1) + "\n\n";

						tab2 += "Nome:\n" + nome_vittima + "\n\n";
						tab2 += "Cognome:\n" + cognome_vittima + "\n\n";
						tab2 += "Data di Nascita:\n" + data_nascita + "\n\n";
						tab2 += "Luogo di Nascita:\n" + luogo_select + "\n\n";
						tab2 += "Residente/Domiciliata in Provincia: "
								+ provincia_nascita_select + "\t";
						tab2 += "Comune: " + comune_nascita_select + "\n\n";

						tab2 += "Indirizzo:\n" + indirizzo + "\n\n";
						tab2 += "Telefono personale: " + telefono_personale
								+ "\t";
						tab2 += "Altro telefono: " + altro_telefono + "\n\n";
						tab2 += "Cittadinanza Italiana:\n" + cittadinanza
								+ "\n\n";
						if (cittadinanza == "No")
							tab2 += "Cittadinanza:\n" + cittadinanza_select
									+ "\n\n";

						tab2 += "Conoscenza lingua italiana:\n"
								+ select_lingua_italiana + "\n\n";
						if (select_lingua_italiana == "Poco"
								|| select_lingua_italiana == "No")
							tab2 += "Mediatore culturale:\n"
									+ mediatoreCulturale + "\n\n";

						tab2 += "Stato civile:\n" + statoCivile + "\n\n";
						if (statoCivile == "Altro")
							tab2 += "Altro stato civile:\n" + altrostatocivile
									+ "\n\n";

						tab2 += "Figli:\n" + figli + "\n\n";
						if (figli == "Si") {
							tab2 += "Numero totale di figli:\n" + numero_figli
									+ "\n\n";
							tab2 += "Di cui minorenni: "
									+ numero_figli_minorenni + "\t";
							tab2 += "Di cui maschi: "
									+ numero_figli_minorenni_maschi + "\t";
							tab2 += "Di cui femmine: "
									+ numero_figli_minorenni_femmine + "\n\n";
							tab2 += "I figli convivono con la madre?\n"
									+ convivono_figliFemmine + "\n\n";
							tab2 += "I figli assistono alla violenza?\n"
									+ assistonoViolenza_figli + "\n\n";
							tab2 += "I figli subiscono violenza diretta?\n"
									+ subisconoViolenza_figli + "\n\n";
						}

						tab2 += "Titolo di studio:\n" + selectTitoloDiStudio
								+ "\n\n";
						if (selectTitoloDiStudio == "Altro")
							tab2 += "Altro titolo di studio:\n"
									+ altroTitoloDiStudio + "\n\n";

						tab2 += "Stato occupazionale: " + selectProfessione
								+ "\n\n";
						if (selectProfessione == "Altro")
							tab2 += "Altro stato occupazionale:\n"
									+ altro_stato_occupazionale_donna + "\n\n";

						tab2 += "Autonomo economicamente:\n"
								+ autonomo_economicamente + "\n\n";

						tab3 += "Primo accesso al Servizio Antiviolenza:\n"
								+ primo_accesso_servizio_antiviolenza + "\n\n";
						if (primo_accesso_servizio_antiviolenza == "No") {
							tab3 += "Numero accessi precedenti:\n"
									+ numero_accessi_ripetuti + "\n\n";
							tab3 += "Accesso occasionale?\n"
									+ accesso_occasionale + "\n\n";
						}

						tab3 += "La donna accede al Servizio Antiviolenza:\n"
								+ selectDonnaAccompagnataAlServizioAntiviolenza
								+ "\n\n";

						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata dalle Forze dell'Ordine") {
							tab3 += "Forze dell\'Ordine: "
									+ donnaaccompagnata_forzedellordine_select
									+ "\t";
							tab3 += "Pronvincia: "
									+ provincia_donnaaccompagnata_forzedellordine_select
									+ "\t";
							tab3 += "Comune: "
									+ comune_donnaaccompagnata_forzedellordine_select
									+ "\n\n";
						}
						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata dal Pronto Soccorso") {
							tab3 += "Pronto Soccorso: "
									+ donnaaccompagnata_prontosoccorso_select
									+ "\t";
							tab3 += "Provincia: "
									+ provincia_donnaaccompagnata_prontosoccorso_select
									+ "\t";
							tab3 += "Comune: "
									+ comune_donnaaccompagnata_prontosoccorso_select
									+ "\n\n";
						}
						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Inviata da altre persone")
							tab3 += "Accompagnata da:\n"
									+ selectDonnaAccompagnataDaAltrePersoneInSA
									+ "\n\n";

						if (selectDonnaAccompagnataAlServizioAntiviolenza == "Altro")
							tab3 += "Altro:\n" + altroDonnaAccompagnataInPS
									+ "\n\n";

						tab3 += "Motivo dell\'Accesso:\n" + motivoAccesso
								+ "\n\n";

						tab3 += "Tipologia della violenza riferita:\n"
								+ selectTipologiaViolenza + "\n\n";
						if (selectTipologiaViolenza == "Altro")
							tab3 += "Altro:\n" + altroViolenzaRiferita + "\n\n";

						if (selectTipologiaViolenza == "Violenza domestica"
								|| selectTipologiaViolenza == "Violenza extra domestica")
							tab3 += "Violenza domestica:\n" + sfruttamento
									+ violenzeRiferite + "\n\n";

						tab4 += "Conosce il presunto autore della violenza?\n"
								+ conosci_aggressore + "\n\n";

						if (conosci_aggressore == "Si") {
							tab4 += "Nome:\n" + nome_presunto_aggressore
									+ "\n\n";
							tab4 += "Cognome:\n" + cognome_presunto_aggressore
									+ "\n\n";
							tab4 += "Data di Nascita:\n"
									+ data_nascita_presunto_aggressore + "\n\n";
							tab4 += "Luogo di Nascita:\n"
									+ luogo_presunto_aggressore_select + "\n\n";
							tab4 += "Residente/Domiciliato in Provincia: "
									+ provincia_nascita_presunto_aggressore_select
									+ "\t";
							tab4 += "Comune: "
									+ comune_nascita_presunto_aggressore_select
									+ "\n\n";
							tab4 += "Indirizzo:\n"
									+ indirizzo_presunto_aggressore + "\n\n";
							tab4 += "Telefono personale:\n"
									+ telefono_presunto_aggressore + "\n\n";
							tab4 += "Titolo di studio:\n"
									+ selectTitoloDiStudioAggressore + "\n\n";
							if (selectTitoloDiStudioAggressore == "Altro")
								tab4 += "Altro titolo di studio:\n"
										+ altroTitoloDiStudioAggressore
										+ "\n\n";

							tab4 += "Stato occupazionale:\n"
									+ selectProfessioneAggressore + "\n\n";
							if (selectProfessioneAggressore == "Altro")
								tab4 += "Altro titolo di studio:\n"
										+ altro_stato_occupazionale_aggressore
										+ "\n\n";

							tab4 += "Fascia di età:\n"
									+ fascia_di_eta_aggressore + "\n\n";
							tab4 += "Rapporto vittima/presunto autore di violenza:\n"
									+ rapporto_vittima_autore_violenza + "\n\n";
							if (rapporto_vittima_autore_violenza == "Familiare")
								tab4 += "Familiare:\n" + tipologia_familiare
										+ "\n\n";

							if (tipologia_familiare == "Altro")
								tab4 += "Altro:\n"
										+ altroRapportoVittimaAggressore
										+ "\n\n";

							tab4 += "Il presunto autore della violenza è in carico ai servizi (SERT, DSM, ...):\n"
									+ aggressore_servizi + "\n\n";
							if (aggressore_servizi == "Si") {
								tab4 += "Tipologia servizi:\n"
										+ tipologia_servizi_aggressore + "\n\n";
								if (tipologia_servizi_aggressore == "Altro")
									tab4 += "Altro:\n"
											+ altroTipologiaServiziAggressore
											+ "\n\n";
							}

							tab4 += "Violenza assistita o subita nella famiglia di origine:\n"
									+ violenza_assistitaosubita + "\n\n";
							tab4 += "Precedenti penali:\n" + precedenti_penali
									+ "\n\n";
						}

						tab5 += "La frequenza e/o la gravità degli atti di violenza fisica sono aumentati negli ultimi 6 mesi? "
								+ brief_risk_1 + "\n\n";
						tab5 += "L\'aggressore ha mai utilizzato un\'arma, o l\'ha minacciata con un\'arma, o ha tentato di strangolarla? "
								+ brief_risk_2 + "\n\n";
						tab5 += "Pensa che l\'aggressore possa farle del male (ucciderla)? "
								+ brief_risk_3 + "\n\n";
						tab5 += "L\'ha mai picchiata durante la gravidanza? "
								+ brief_risk_4 + "\n\n";
						tab5 += "L\'aggressore è violentemente e costantemente geloso di lei? "
								+ brief_risk_5 + "\n\n";
						tab5 += "Riferisce Escalation della violenza? "
								+ brief_risk_6 + "\n\n";
						tab5 += "Il presunto autore ha violato misure cautelari e/o interdittive? "
								+ brief_risk_7 + "\n\n";

						tab5 += "La donna è in fase di separazione?\n"
								+ faseDiSeparazione + "\n\n";
						tab5 += "La donna è separata?\n" + separata + "\n\n";
						if (separata == "Si")
							tab5 += "Periodo di tempo:\n"
									+ tempo_separazione_select + "\n\n";

						tab5 += "La donna ha comunicato la decisione di separarsi?\n"
								+ haComunicatoAlPartner + "\n\n";
						tab5 += "La donna ha deciso di sporgere denuncia?\n"
								+ sporgereDenuncia + "\n\n";
						tab5 += "La donna ha sporto denuncia?\n"
								+ sportoDenuncia + "\n\n";

						if (sportoDenuncia == "Si") {
							tab5 += "Presso: " + selectForzeDellOrdineDenuncia
									+ "\t";
							tab5 += "Provincia: " + provincia_denuncia_select
									+ "\t";
							tab5 += "Comune: " + comune_denuncia_select
									+ "\n\n";
						}

						tab5 += "La donna ha ritirato la denuncia?\n"
								+ ritiratoDenuncia + "\n\n";
						if (ritiratoDenuncia == "Si")
							tab5 += "La donna ha ritirato la denuncia?\n"
									+ motivoRitiroDenuncia_select + "\n\n";

						tab5 += "Valutazione dello stato di bisogno:\n"
								+ valutazione_stato_bisogno + "\n\n";
						if (valutazione_stato_bisogno == "Altro")
							tab5 += "Altro:\n"
									+ specificare_altro_ValutazioneStatoBisogno
									+ "\n\n";

						tab5 += "Presa in carico per:\n" + presaInCarico
								+ "\n\n";
						tab5 += "Prestazioni effettuate:\n"
								+ prestazioniEffettuate + "\n\n";

						tab5 += "Attivazione della Rete Territoriale Antiviolenza con invio a:\n"
								+ attivazioneRete_select + "\n\n";

						if (attivazioneRete_select == "Pronto Soccorso") {
							tab5 += "Pronto Soccorso: "
									+ attivazioneRete_prontosoccorso_select
									+ "\t";
							tab5 += "Provincia: "
									+ attivazioneRete_provincia_prontosoccorso_select
									+ "\t";
							tab5 += "Comune: "
									+ attivazioneRete_comune_prontosoccorso_select
									+ "\n\n";
						}
						if (attivazioneRete_select == "Forze dell'Ordine") {
							tab5 += "Forze dell\'Ordine: "
									+ attivazioneRete_forzedellordine_select
									+ "\t";
							tab5 += "Provincia: "
									+ attivazioneRete_provincia_forzedellordine_select
									+ "\t";
							tab5 += "Comune: "
									+ attivazioneRete_comune_forzedellordine_select
									+ "\n\n";
						}
						if (attivazioneRete_select == "Servizio Sanitario")
							tab5 += "ASL della Provincia di:\n"
									+ servizioSanitario_provincia_select
									+ "\n\n";

						if (attivazioneRete_select == "Servizi Sociali")
							tab5 += "Servizi Sociali della Provincia di:\n"
									+ serviziSociali_provincia_select + "\n\n";

						doc.setFontSize(9);

						var img = new Image()
						img.src = '../assets/images/logo/logo.png'
						doc.addImage(img, 'png', 360, 60, 150, 115)

						var data_orario1 = new Date();

						doc.setFontSize(20);
						doc.text(35, 70, 'Dati della Scheda');

						doc.setFontSize(9);
						doc.text(320, 30,
								'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
										+ data_orario1);
						doc.text(520, 800, '1 of 5');
						doc.text(tab, 40, 90);
						doc.addPage();

						doc.setFontSize(20);
						doc.text(35, 70, 'Dati anagrafici');

						doc.setFontSize(9);
						doc.text(320, 30,
								'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
										+ data_orario1);
						doc.text(520, 800, '2 of 5');
						doc.text(tab2, 40, 90);
						doc.addPage();

						doc.setFontSize(20);
						doc.text(35, 70, 'Tipologia della violenza');

						doc.setFontSize(9);
						doc.text(320, 30,
								'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
										+ data_orario1);
						doc.text(520, 800, '3 of 5');
						doc.text(tab3, 40, 90);
						doc.addPage();

						doc.setFontSize(20);
						doc.text(35, 70, 'Autore della violenza');

						doc.setFontSize(9);
						doc.text(320, 30,
								'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
										+ data_orario1);
						doc.text(520, 800, '4 of 5');
						doc.text(tab4, 40, 90);
						doc.addPage();

						doc.setFontSize(20);
						doc.text(35, 70, 'Rischio e Azioni');

						doc.setFontSize(9);
						doc.text(320, 30,
								'Osservatorio sul Fenomeno della Violenza sulle Donne\n'
										+ data_orario1);
						doc.text(520, 800, '5 of 5');
						doc.text(tab5, 40, 90);

						doc.autoPrint();
						doc.save(identificativo_scheda + '.pdf');

					}
				});
	}
</script>
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
                <li><a href="inviate.jsp">Schede Inviate</a></li>
                <li><span>Dettaglio scheda</span></li>
              </ul>
            </div>
          </div>
          <div class="col-sm-4 clearfix">
            <%@include file="common/user.jsp"%>
          </div>
        </div>
      </div>
      <!-- page title area end -->
      <!--<div class="main-content-inner">-->
      <!--  <div class="main-content-inner">

					<!-- basic table start -->
      <div class="row">
        <div class="col-12 mt-5">
          <div class="card">
            <div class="card-body">
              <h1 align="center">Anteprima Scheda</h1>
              <div class="row" id="question1">
                <div class="col-12 mt-5">
                  <div class="card">
                    <div class="card-body">
                      <h3 align="center">1. Dati della scheda</h3>
                      <!--  <p>Please fill with your details</p> -->
                      <div class="single-table">
                        <div class="table-responsive">
                          <table class="table text-left">
                            <tbody id="tableQuestion1">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row" id="question2">
                <div class="col-12 mt-5">
                  <div class="card">
                    <div class="card-body">
                      <h3 align="center">2. Dati anagrafici della donna</h3>
                      <!--  <p>Please fill with your details</p> -->
                      <div class="single-table">
                        <div class="table-responsive">
                          <table class="table text-left">
                            <tbody id="tableQuestion2">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row" id="question3">
                <div class="col-12 mt-5">
                  <div class="card">
                    <div class="card-body">
                      <h3 align="center">3.Tipologia della violenza</h3>
                      <!--  <p>Please fill with your details</p> -->
                      <div class="single-table">
                        <div class="table-responsive">
                          <table class="table text-left">
                            <tbody id="tableQuestion3">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row" id="question4">
                <div class="col-12 mt-5">
                  <div class="card">
                    <div class="card-body">
                      <h3 align="center">4.Presunto autore della violenza</h3>
                      <!--  <p>Please fill with your details</p> -->
                      <div class="single-table">
                        <div class="table-responsive">
                          <table class="table text-left">
                            <tbody id="tableQuestion4">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row" id="question5">
                <div class="col-12 mt-5">
                  <div class="card">
                    <div class="card-body">
                      <h3 align="center">5.Valutazioni</h3>
                      <!--  <p>Please fill with your details</p> -->
                      <div class="single-table">
                        <div class="table-responsive">
                          <table class="table text-left">
                            <tbody id="tableQuestion5">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
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
                <div class="form-group">
                  <button type="button" class="btn btn-info btn-lg btn-block" onclick="print();">Stampa</button>
                  <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="indietro();">Indietro</button>
                </div>
              </form>
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
