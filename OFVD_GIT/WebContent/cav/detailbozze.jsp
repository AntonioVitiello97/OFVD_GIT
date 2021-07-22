<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.model.dao.AccountsDao"%>
<%@page import="java.util.*"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
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
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet" href="../assets/wizard_layout/fonts/material-design-iconic-font/css/material-design-iconic-font.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="../assets/wizard_layout/css/style.css">
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
		var url = "bozze.jsp";
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
						if (nome_vittima == undefined)
							nome_vittima = "";
						var cognome_vittima = jsonStr['answer7'];
						if (cognome_vittima == undefined)
							cognome_vittima = "";
						var data_nascita = jsonStr['answer8'];
						if (data_nascita == undefined)
							data_nascita = "";
						var luogo_select = jsonStr['answer9'];
						if (luogo_select == undefined)
							luogo_select = "";
						var provincia_nascita_select = jsonStr['answer10'];
						if (provincia_nascita_select == undefined)
							provincia_nascita_select = "";
						var comune_nascita_select = jsonStr['answer11'];
						if (comune_nascita_select == undefined)
							comune_nascita_select = "";
						var indirizzo = jsonStr['answer12'];
						if (indirizzo == undefined)
							indirizzo = "";
						var telefono_personale = jsonStr['answer13'];
						if (telefono_personale == undefined)
							telefono_personale = "";
						var altro_telefono = jsonStr['answer14'];
						if (altro_telefono == undefined)
							altro_telefono = "";
						var cittadinanza = jsonStr['answer15'];
						if (cittadinanza == undefined)
							cittadinanza = "";
						var cittadinanza_select = jsonStr['answer16'];
						if (cittadinanza_select == undefined)
							cittadinanza_select = "";
						var select_lingua_italiana = jsonStr['answer17'];
						if (select_lingua_italiana == undefined)
							select_lingua_italiana = "";
						var mediatoreCulturale = jsonStr['answer18'];
						if (mediatoreCulturale == undefined)
							mediatoreCulturale = "";
						var statoCivile = jsonStr['answer19'];
						if (statoCivile == undefined)
							statoCivile = "";
						var altrostatocivile = jsonStr['answer20'];
						if (altrostatocivile == undefined)
							altrostatocivile = "";
						var figli = jsonStr['answer21'];
						if (figli == undefined)
							figli = "";
						var numero_figli = jsonStr['answer22'];
						if (numero_figli == undefined)
							numero_figli = "";
						var numero_figli_minorenni = jsonStr['answer23'];
						if (numero_figli_minorenni)
							numero_figli_minorenni = "";
						var numero_figli_minorenni_maschi = jsonStr['answer73'];
						if (numero_figli_minorenni_maschi == undefined)
							numero_figli_minorenni_maschi = "";
						var numero_figli_minorenni_femmine = jsonStr['answer74'];
						if (numero_figli_minorenni_femmine == undefined)
							numero_figli_minorenni_femmine = "";
						var convivono_figliFemmine = jsonStr['answer75'];
						if (convivono_figliFemmine == undefined)
							convivono_figliFemmine = "";
						var assistonoViolenza_figli = jsonStr['answer76'];
						if (assistonoViolenza_figli == undefined)
							assistonoViolenza_figli = "";
						var subisconoViolenza_figli = jsonStr['answer77'];
						if (subisconoViolenza_figli == undefined)
							subisconoViolenza_figli = "";
						var selectTitoloDiStudio = jsonStr['answer24'];
						if (selectTitoloDiStudio == undefined)
							selectTitoloDiStudio = "";
						var altroTitoloDiStudio = jsonStr['answer25'];
						if (altroTitoloDiStudio == undefined)
							altroTitoloDiStudio = "";
						var selectProfessione = jsonStr['answer26'];
						if (selectProfessione == undefined)
							selectProfessione = "";
						var altro_stato_occupazionale_donna = jsonStr['answer78'];
						if (altro_stato_occupazionale_donna == undefined)
							altro_stato_occupazionale_donna = "";
						var autonomo_economicamente = jsonStr['answer27'];
						if (autonomo_economicamente == undefined)
							autonomo_economicamente = "";

						//Domande:3 Tipologia della Violenza
						var primo_accesso_servizio_antiviolenza = jsonStr['answer28'];
						if (primo_accesso_servizio_antiviolenza == undefined)
							primo_accesso_servizio_antiviolenza = "";
						var numero_accessi_ripetuti = jsonStr['answer29'];
						if (numero_accessi_ripetuti == undefined)
							numero_accessi_ripetuti = "";
						var accesso_occasionale = jsonStr['answer79'];
						if (accesso_occasionale == undefined)
							accesso_occasionale = "";
						var selectDonnaAccompagnataAlServizioAntiviolenza = jsonStr['answer80'];
						if (selectDonnaAccompagnataAlServizioAntiviolenza == undefined)
							selectDonnaAccompagnataAlServizioAntiviolenza = "";
						var donnaaccompagnata_forzedellordine_select = jsonStr['answer81'];
						if (donnaaccompagnata_forzedellordine_select == undefined)
							donnaaccompagnata_forzedellordine_select = "";
						var provincia_donnaaccompagnata_forzedellordine_select = jsonStr['answer82'];
						if (provincia_donnaaccompagnata_forzedellordine_select == undefined)
							provincia_donnaaccompagnata_forzedellordine_select = "";
						var comune_donnaaccompagnata_forzedellordine_select = jsonStr['answer83'];
						if (comune_donnaaccompagnata_forzedellordine_select == undefined)
							comune_donnaaccompagnata_forzedellordine_select = "";
						var donnaaccompagnata_prontosoccorso_select = jsonStr['answer84'];
						if (donnaaccompagnata_prontosoccorso_select == undefined)
							donnaaccompagnata_prontosoccorso_select = "";
						var provincia_donnaaccompagnata_prontosoccorso_select = jsonStr['answer85'];
						if (provincia_donnaaccompagnata_prontosoccorso_select == undefined)
							provincia_donnaaccompagnata_prontosoccorso_select = "";
						var comune_donnaaccompagnata_prontosoccorso_select = jsonStr['answer86'];
						if (comune_donnaaccompagnata_prontosoccorso_select == undefined)
							comune_donnaaccompagnata_prontosoccorso_select = "";
						var selectDonnaAccompagnataDaAltrePersoneInSA = jsonStr['answer31'];
						if (selectDonnaAccompagnataDaAltrePersoneInSA == undefined)
							selectDonnaAccompagnataDaAltrePersoneInSA = "";
						var altroDonnaAccompagnataInPS = jsonStr['answer32'];
						if (altroDonnaAccompagnataInPS == undefined)
							altroDonnaAccompagnataInPS = "";
						var motivoAccesso = jsonStr['answer33'];
						if (motivoAccesso == undefined)
							motivoAccesso = "";
						var selectTipologiaViolenza = jsonStr['answer87'];
						if (selectTipologiaViolenza == undefined)
							selectTipologiaViolenza = "";
						var sfruttamento = jsonStr['answer30'];
						if (sfruttamento == undefined)
							sfruttamento = "";
						else
							sfruttamento = sfruttamento.replace(/;/g, "<br>");
						
						var violenzeRiferite = jsonStr['answer88'];
						if (violenzeRiferite == undefined)
							violenzeRiferite = "";
						else
							violenzeRiferite = violenzeRiferite.replace(/;/g, "<br>");
						
						var altroViolenzaRiferita = jsonStr['answer89'];
						if (altroViolenzaRiferita == undefined)
							altroViolenzaRiferita = "";

						//Domande:4 Presunto autore della Violenza
						var conosci_aggressore = jsonStr['answer90'];
						if (conosci_aggressore == undefined)
							conosci_aggressore = "";
						var nome_presunto_aggressore = jsonStr['answer34'];
						if (nome_presunto_aggressore == undefined)
							nome_presunto_aggressore = "";
						var cognome_presunto_aggressore = jsonStr['answer35'];
						if (cognome_presunto_aggressore == undefined)
							cognome_presunto_aggressore = "";
						var data_nascita_presunto_aggressore = jsonStr['answer36'];
						if (data_nascita_presunto_aggressore == undefined)
							data_nascita_presunto_aggressore = "";
						var luogo_presunto_aggressore_select = jsonStr['answer37'];
						if (luogo_presunto_aggressore_select == undefined)
							luogo_presunto_aggressore_select = "";
						var provincia_nascita_presunto_aggressore_select = jsonStr['answer38'];
						if (provincia_nascita_presunto_aggressore_select == undefined)
							provincia_nascita_presunto_aggressore_select = "";
						var comune_nascita_presunto_aggressore_select = jsonStr['answer39'];
						if (comune_nascita_presunto_aggressore_select == undefined)
							comune_nascita_presunto_aggressore_select = "";
						var indirizzo_presunto_aggressore = jsonStr['answer40'];
						if (indirizzo_presunto_aggressore == undefined)
							indirizzo_presunto_aggressore = "";
						var telefono_presunto_aggressore = jsonStr['answer41'];
						if (telefono_presunto_aggressore == undefined)
							telefono_presunto_aggressore = "";
						var selectTitoloDiStudioAggressore = jsonStr['answer42'];
						if (selectTitoloDiStudioAggressore == undefined)
							selectTitoloDiStudioAggressore = "";
						var altroTitoloDiStudioAggressore = jsonStr['answer43'];
						if (altroTitoloDiStudioAggressore == undefined)
							altroTitoloDiStudiiAggressore = "";
						var selectProfessioneAggressore = jsonStr['answer44'];
						if (selectProfessioneAggressore == undefined)
							selectProfessioneAggressore = "";
						var altro_stato_occupazionale_aggressore = jsonStr['answer91'];
						if (altro_stato_occupazionale_aggressore == undefined)
							altro_stato_occupazionale_aggressore = "";
						var fascia_di_eta_aggressore = jsonStr['answer45'];
						if (fascia_di_eta_aggressore == undefined)
							fascita_di_eta_aggressore = "";
						var rapporto_vittima_autore_violenza = jsonStr['answer46'];
						if (rapporto_vittima_autore_violenza == undefined)
							rapporto_vittima_autore_violenza = "";
						var tipologia_familiare = jsonStr['answer47'];
						if (tipologia_familiare == undefined)
							tipologia_familiare = "";
						var altroRapportoVittimaAggressore = jsonStr['answer48'];
						if (altroRapportoVittimaAggressore == undefined)
							altroRapportoVittimaAggressore = "";
						var aggressore_servizi = jsonStr['answer49'];
						if (aggressore_servizi == undefined)
							aggressore_servizi = "";
						var tipologia_servizi_aggressore = jsonStr['answer50'];
						if (tipologia_servizi_aggressore == undefined)
							tipologia_servizi_aggressore = "";
						var altroTipologiaServiziAggressore = jsonStr['answer51'];
						if (altroTipologiaServiziAggressore == undefined)
							altroTipologiaServiziAggressore = "";
						var violenza_assistitaosubita = jsonStr['answer92'];
						if (violenza_assistitaosubita == undefined)
							violenza_assistitaosubita = "";
						var precedenti_penali = jsonStr['answer52'];
						if (precedenti_penali == undefined)
							precedenti_penali = "";

						//Domande:5 Valutazioni
						var brief_risk_1 = jsonStr['answer53'];
						if (brief_risk_1 == undefined)
							brief_risk_1 = "";
						var brief_risk_2 = jsonStr['answer54'];
						if (brief_risk_2 == undefined)
							brief_risk_2 = "";
						var brief_risk_3 = jsonStr['answer55'];
						if (brief_risk_3 == undefined)
							brief_risk_3 = "";
						var brief_risk_4 = jsonStr['answer56'];
						if (brief_risk_4 == undefined)
							brief_risk_4 = "";
						var brief_risk_5 = jsonStr['answer57'];
						if (brief_risk_5 == undefined)
							brief_risk_5 = "";
						var brief_risk_6 = jsonStr['answer58'];
						if (brief_risk_6 == undefined)
							brief_risk_6 = "";
						var brief_risk_7 = jsonStr['answer59'];
						if (brief_risk_7 == undefined)
							brief_risk_7 = "";
						var faseDiSeparazione = jsonStr['answer93'];
						if (faseDiSeparazione == undefined)
							faseDiSeparazione = "";
						var separata = jsonStr['answer94'];
						if (separata == undefined)
							separata = "";
						var tempo_separazione_select = jsonStr['answer95'];
						if (tempo_separazione_select == undefined)
							tempo_separazione_select = "";
						var haComunicatoAlPartner = jsonStr['answer96'];
						if (haComunicatoAlPartner == undefined)
							haComunicatoAlPartner = "";
						var sporgereDenuncia = jsonStr['answer97'];
						if (sporgereDenuncia == undefined)
							sporgereDenuncia = "";
						var sportoDenuncia = jsonStr['answer98'];
						if (sportoDenuncia == undefined)
							sportoDenuncia = "";

						var selectForzeDellOrdineDenuncia = jsonStr['answer99'];
						if (selectForzeDellOrdineDenuncia == undefined)
							selectForzeDellOrdineDenuncia = "";
						var provincia_denuncia_select = jsonStr['answer100'];
						if (provincia_denuncia_select == undefined)
							provincia_denuncia_select = "";
						var comune_denuncia_select = jsonStr['answer101'];
						if (comune_denuncia_select == undefined)
							comune_denuncia_select = "";
						var ritiratoDenuncia = jsonStr['answer102'];
						if (ritiratoDenuncia == undefined)
							ritiratoDenuncia = "";
						var motivoRitiroDenuncia_select = jsonStr['answer103'];
						if (motivoRitiroDenuncia_select == undefined)
							motivoRitiroDenuncia_select = "";
						var valutazione_stato_bisogno = jsonStr['answer104'];
						if (valutazione_stato_bisogno == undefined)
							valutazione_stato_bisogno = "";
						else
							valutazione_stato_bisogno = valutazione_stato_bisogno.replace(/;/g, "<br>");
							
						var specificare_altro_ValutazioneStatoBisogno = jsonStr['answer105'];
						if (specificare_altro_ValutazioneStatoBisogno == undefined)
							specificare_altro_ValutazioneStatoBisogno = "";
						var presaInCarico = jsonStr['answer106'];
						if (presaInCarico == undefined)
							presaInCarico = "";
						else
							presaInCarico = presaInCarico.replace(/;/g, "<br>");
						
						var prestazioniEffettuate = jsonStr['answer107'];
						if (prestazioniEffettuate == undefined)
							prestazioniEffettuate = "";
						var attivazioneRete_select = jsonStr['answer108'];
						if (attivazioneRete_select == undefined)
							attivazioneRete_select = "";
						var attivazioneRete_prontosoccorso_select = jsonStr['answer109'];
						if (attivazioneRete_prontosoccorso_select == undefined)
							attivazioneRete_prontosoccorso_select = "";
						var attivazioneRete_provincia_prontosoccorso_select = jsonStr['answer110'];
						if (attivazioneRete_provincia_prontosoccorso_select == undefined)
							attivazioneRete_provincia_prpntosoccorso_select = "";
						var attivazioneRete_comune_prontosoccorso_select = jsonStr['answer111'];
						if (attivazioneRete_comune_prontosoccorso_select == undefined)
							attivazioneRete_comune_prontosoccorso_select = "";
						var attivazioneRete_forzedellordine_select = jsonStr['answer112'];
						if (attivazioneRete_forzedellordine_select == undefined)
							attivazioneRete_forzedellordine = "";
						var attivazioneRete_provincia_forzedellordine_select = jsonStr['answer113'];
						if (attivazioneRete_provincia_forzedellordine_select == undefined)
							attivazioneRete_provincia_forzedellordine_select = "";
						var attivazioneRete_comune_forzedellordine_select = jsonStr['answer114'];
						if (attivazioneRete_comune_forzedellordine_select == undefined)
							attivazioneRete_comune_forzedellordine_select = "";
						var servizioSanitario_provincia_select = jsonStr['answer115'];
						if (servizioSanitario_provincia_select == undefined)
							servizioSanitario_provincia_select = "";
						var serviziSociali_provincia_select = jsonStr['answer116'];
						if (serviziSociali_provincia_select == undefined)
							serviziSociali_provincia_selects = "";

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
							tab2 += "<tr><td width='65%'><label><h6>Numero totali di figli: </h6></label></td><td><label class='form-label'><h6>"
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

						tab3 += "<tr><td width='65%'><label><h6>Motivo dell'Accesso: </h6></label></td><td><label class='form-label'><h6>"
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
						tab5 += "<tr><td width='65%'><label><h6>La donna ha deciso di sporgere denuncia?</h6></label></td><td><label class='form-label'><h6>"
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
                <li><a href="bozze.jsp">Schede In Bozze</a></li>
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
