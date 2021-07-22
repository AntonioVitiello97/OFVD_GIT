<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.model.dao.AccountsDao"%>
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
		var url = "domande.jsp";
		$(location).attr('href', url);
	}

	var question = new Object();

	function load() {
		$("#printbutton").hide();

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
						var identificativoScheda = jsonStr['answer1'];
						var dataCompilazione = jsonStr['answer2'];
						var prontoSoccorso = jsonStr['answer5'];
						var nomeCompilatore = jsonStr['answer3'];
						var cognomeCompilatore = jsonStr['answer4'];
						var statuscap = jsonStr['status'];

						//Domande: 2 dati Anagrafici della donna
						var nome_vittima = jsonStr["answer6"];
						var cognome_vittima = jsonStr['answer7'];
						var data_nascita = jsonStr['answer8'];
						var luogo_nascita = jsonStr['answer9'];
						var provincia_nascita = jsonStr['answer10'];
						var comune_nascita = jsonStr['answer11'];
						var indirizzo = jsonStr['answer12'];
						var telefono = jsonStr['answer13'];
						var altroTelefono = jsonStr['answer14'];
						var cittadinanza_italiana = jsonStr['answer15'];
						var altraCittadinanza = jsonStr['answer16'];
						var conoscenzaLinguaItaliana = jsonStr['answer17'];
						var mediatoreCulturale = jsonStr['answer18'];
						var statoCivile = jsonStr['answer19'];
						var altroStatoCivile = jsonStr['answer20'];
						var figli = jsonStr['answer21'];
						var numero_figli = jsonStr['answer22'];
						var numero_figli_minorenni = jsonStr['answer23'];
						var conviventi = jsonStr['answer117'];
						var titoloDiStudio = jsonStr['answer24'];
						var altroTitoloDiStudio = jsonStr['answer25']
						var professione = jsonStr['answer26'];
						var autonomo_economicamente = jsonStr['answer27'];

						//Domande:3 Tipologia della Violenza
						var primoAccessoProntoSoccorso = jsonStr['answer28'];
						var numeroAccessiRipetuti = jsonStr['answer29'];
						var tipologiaViolenza = jsonStr['answer118'];
						var altroViolenzaRiferita = jsonStr['answer119'];
						var sfruttamento = jsonStr['answer30'];
						sfruttamento = sfruttamento.replace(/;/g, "<br>");

						var con_figli_minori = jsonStr['answer120'];
						var donnaAccompagnataInPS = jsonStr['answer31'];
						var altroDonnaAccompagnataInPS = jsonStr['answer32'];
						var motivoAccessoInPS = jsonStr['answer33'];
						var codiceAttribuito = jsonStr['answer121'];

						//Domande:4 Presunto autore della Violenza
						var nomePresuntoAutore = jsonStr['answer34'];
						var cognomePresuntoAutore = jsonStr['answer35'];
						var dataNascitaPresuntoAutore = jsonStr['answer36'];
						var luogoPresuntoAutore = jsonStr['answer37'];
						var provinciaNascitaPresuntoAutore = jsonStr['answer38'];
						var comuneNascitaPresuntoAutore = jsonStr['answer39'];
						var indirizzoPresuntoAutore = jsonStr['answer40'];
						var telefonoPresuntoAutore = jsonStr['answer41'];
						var titoloDiStudioPresuntoAutore = jsonStr['answer42'];
						var altroTitoloDiStudioPresuntoAutore = jsonStr['answer43'];
						var professionePresuntoAutore = jsonStr['answer44'];
						var fasciaDiEtaPresuntoAutore = jsonStr['answer45'];
						var rapportoVittimaPresuntoAutore = jsonStr['answer46'];
						var tipologiaFamiliare = jsonStr['answer47'];
						var altroRapportoVittimaAggressore = jsonStr['answer48'];
						var presuntoAutoreServizi = jsonStr['answer49'];
						var tipologiaServiziPresuntoAutore = jsonStr['answer50'];
						var altroTipologiaServiziPresuntoAutore = jsonStr['answer51'];
						var precedenti_penali = jsonStr['answer52'];

						//Domande:5 Valutazioni
						var briefRisk1 = jsonStr['answer53'];
						var briefRisk2 = jsonStr['answer54'];
						var briefRisk3 = jsonStr['answer55'];
						var briefRisk4 = jsonStr['answer56'];
						var briefRisk5 = jsonStr['answer57'];
						var briefRisk6 = jsonStr['answer58'];
						var briefRisk7 = jsonStr['answer59'];
						var reteIntraOspedaliera = jsonStr['answer122'];
						var specificoReteIntraOspedaliera = jsonStr['answer123'];
						var reteExtraOspedaliera = jsonStr['answer124'];
						var specificoReteExtraOspedaliera = jsonStr['answer125'];
						var forzeDellOrdine = jsonStr['answer126'];
						var tempiDiPrognosi = jsonStr['answer127'];
						var referto = jsonStr['answer128'];
						var attestazioni = jsonStr['answer129'];
						var codiceRosa = jsonStr['answer130'];

						tab = "<tr><td width='65%'><label><h6>Identificativo scheda: </h6></label></td><td><label class='form-label'><h6>"
								+ identificativoScheda
								+ "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Data compilazione: </h6></label></td><td><label class='form-label'><h6>"
								+ dataCompilazione + "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Presidio Ospedaliero: </h6></label></td><td><label class='form-label'><h6>"
								+ prontoSoccorso + "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Nome del compilatore: </h6></label></td><td><label class='form-label'><h6>"
								+ nomeCompilatore + "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Cognome del compilatore: </h6></label></td><td><label class='form-label'><h6>"
								+ cognomeCompilatore
								+ "</h6></label></td></tr>";
						tab += "<tr><td width='65%'><label><h6>Status: </h6></label></td><td><label class='form-label'><h6>"
								+ statuscap.charAt(0).toUpperCase()
								+ statuscap.slice(1)
								+ "</h6></label></td></tr>";

						tab2 = "<tr><td width='65%'><label><h6>Nome: </h6></label></td><td><label class='form-label'><h6>"
								+ nome_vittima + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Cognome: </h6></label></td><td><label class='form-label'><h6>"
								+ cognome_vittima + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Data di nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ data_nascita + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Luogo di nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ luogo_nascita + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Residente/Domiciliata in Provincia di: </h6></label></td><td><label class='form-label'><h6>"
								+ provincia_nascita + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Residente/Domiciliata nel Comune di: </h6></label></td><td><label class='form-label'><h6>"
								+ comune_nascita + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Indirizzo: </h6></label></td><td><label class='form-label'><h6>"
								+ indirizzo + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Telefono personale: </h6></label></td><td><label class='form-label'><h6>"
								+ telefono + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Altro telefono: </h6></label></td><td><label class='form-label'><h6>"
								+ altroTelefono + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Cittadinanza Italiana: </h6></label></td><td><label class='form-label'><h6>"
								+ cittadinanza_italiana
								+ "</h6></label></td></tr>";
						if (cittadinanza_italiana == "Altro...")
							tab2 += "<tr><td width='65%'><label><h6>Altra cittadinanza: </h6></label></td><td><label class='form-label'><h6>"
									+ altraCittadinanza
									+ "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Conoscenza lingua Italiana: </h6></label></td><td><label class='form-label'><h6>"
								+ conoscenzaLinguaItaliana
								+ "</h6></label></td></tr>";
						if (conoscenzaLinguaItaliana == "Poco"
								|| conoscenzaLinguaItaliana == "No")
							tab2 += "<tr><td width='65%'><label><h6>Richiesto mediatore culturale:  </h6></label></td><td><label class='form-label'><h6>"
									+ mediatoreCulturale
									+ "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Stato civile: </h6></label></td><td><label class='form-label'><h6>"
								+ statoCivile + "</h6></label></td></tr>";
						if (statoCivile == "Altro...")
							tab2 += "<tr><td width='65%'><label><h6>Altro stato civile: </h6></label></td><td><label class='form-label'><h6>"
									+ altroStatoCivile
									+ "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Figli: </h6></label></td><td><label class='form-label'><h6>"
								+ figli + "</h6></label></td></tr>";

						if (figli == "Si") {
							tab2 += "<tr><td width='65%'><label><h6>Numero figli: </h6></label></td><td><label class='form-label'><h6>"
									+ numero_figli + "</h6></label></td></tr>";
							tab2 += "<tr><td width='65%'><label><h6>Di cui minorenni: </h6></label></td><td><label class='form-label'><h6>"
									+ numero_figli_minorenni
									+ "</h6></label></td></tr>";
						}

						tab2 += "<tr><td width='65%'><label><h6>Conviventi: </h6></label></td><td><label class='form-label'><h6>"
								+ conviventi + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
								+ titoloDiStudio + "</h6></label></td></tr>";
						if (titoloDiStudio == "Altro...")
							tab2 += "<tr><td width='65%'><label><h6>Altro titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
									+ altroTitoloDiStudio
									+ "</h6></label></td></tr>";

						tab2 += "<tr><td width='65%'><label><h6>Stato occupazionale: </h6></label></td><td><label class='form-label'><h6>"
								+ professione + "</h6></label></td></tr>";
						tab2 += "<tr><td width='65%'><label><h6>Autonomia Economica: </h6></label></td><td><label class='form-label'><h6>"
								+ autonomo_economicamente
								+ "</h6></label></td></tr>";

						tab3 = "<tr><td width='65%'><label><h6>Primo accesso al Pronto Soccorso: </h6></label></td><td><label class='form-label'><h6>"
								+ primoAccessoProntoSoccorso
								+ "</h6></label></td></tr>";
						if (primoAccessoProntoSoccorso == "No")
							tab3 += "<tr><td width='65%'><label><h6>Numero accessi ripetuti: </h6></label></td><td><label class='form-label'><h6>"
									+ numeroAccessiRipetuti
									+ "</h6></label></td></tr>";
						tab3 += "<tr><td width='65%'><label><h6>Tipologia della violenza riferita: </h6></label></td><td><label class='form-label'><h6>"
								+ tipologiaViolenza + "</h6></label></td></tr>";
						if (tipologiaViolenza == "Altro")
							tab3 += "<tr><td width='65%'><label><h6>Descrizione tipologia della violenza prevalente: </h6></label></td><td><label class='form-label'><h6>"
									+ altroViolenzaRiferita
									+ "</h6></label></td></tr>";

						if (tipologiaViolenza == "Violenza domestica"
								|| tipologiaViolenza == "Violenza extra domestica")
							tab3 += "<tr><td width='65%'><label><h6>Violenze: </h6></label></td><td><label class='form-label'><h6>"
									+ sfruttamento + "</h6></label></td></tr>";

						tab3 += "<tr><td width='65%'><label><h6>In presenza di figli minori: </h6></label></td><td><label class='form-label'><h6>"
								+ con_figli_minori + "</h6></label></td></tr>";
						tab3 += "<tr><td width='65%'><label><h6>La donna accede al Pronto Soccorso: </h6></label></td><td><label class='form-label'><h6>"
								+ donnaAccompagnataInPS
								+ "</h6></label></td></tr>";
						if (donnaAccompagnataInPS == "Altro...")
							tab3 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ altroDonnaAccompagnataInPS
									+ "</h6></label></td></tr>";
						tab3 += "<tr><td width='65%'><label><h6>Motivo accesso in PS: </h6></label></td><td><label class='form-label'><h6 style='text-align: justify;text-justify: inter-word;'>"
								+ motivoAccessoInPS + "</h6></label></td></tr>";
						tab3 += "<tr><td width='65%'><label><h6>Codice attribuito: </h6></label></td><td><label class='form-label'><h6>"
								+ codiceAttribuito + "</h6></label></td></tr>";

						tab4 = "<tr><td width='65%'><label><h6>Nome: </h6></label></td><td><label class='form-label'><h6>"
								+ nomePresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Cognome: </h6></label></td><td><label class='form-label'><h6>"
								+ cognomePresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Data di nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ dataNascitaPresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Luogo di nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ luogoPresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Provincia di nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ provinciaNascitaPresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Comune di nascita: </h6></label></td><td><label class='form-label'><h6>"
								+ comuneNascitaPresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Indirizzo: </h6></label></td><td><label class='form-label'><h6>"
								+ indirizzoPresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Telefono: </h6></label></td><td><label class='form-label'><h6>"
								+ telefonoPresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
								+ titoloDiStudioPresuntoAutore
								+ "</h6></label></td></tr>";
						if (titoloDiStudioPresuntoAutore == "Altro...")
							tab4 += "<tr><td width='65%'><label><h6>Altro titolo di studio: </h6></label></td><td><label class='form-label'><h6>"
									+ altroTitoloDiStudioPresuntoAutore
									+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Stato occupazionale: </h6></label></td><td><label class='form-label'><h6>"
								+ professionePresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Fascia di età: </h6></label></td><td><label class='form-label'><h6>"
								+ fasciaDiEtaPresuntoAutore
								+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Rapporto vittima/presunto autore di violenza: </h6></label></td><td><label class='form-label'><h6>"
								+ rapportoVittimaPresuntoAutore
								+ "</h6></label></td></tr>";
						if (rapportoVittimaPresuntoAutore == "Familiare")
							tab4 += "<tr><td width='65%'><label><h6>Familiare: </h6></label></td><td><label class='form-label'><h6>"
									+ tipologiaFamiliare
									+ "</h6></label></td></tr>";
						if (tipologiaFamiliare == "Altro...")
							tab4 += "<tr><td width='65%'><label><h6>Altro rapporto vittima/presunto autore di violenza: </h6></label></td><td><label class='form-label'><h6>"
									+ altroRapportoVittimaAggressore
									+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Il presunto autore della violenza è in carico ai servizi (SERT, DSM, ...): </h6></label></td><td><label class='form-label'><h6>"
								+ presuntoAutoreServizi
								+ "</h6></label></td></tr>";
						if (presuntoAutoreServizi == "Si")
							tab4 += "<tr><td width='65%'><label><h6>Tipologia servizi: </h6></label></td><td><label class='form-label'><h6>"
									+ tipologiaServiziPresuntoAutore
									+ "</h6></label></td></tr>";
						if (tipologiaServiziPresuntoAutore == "Altro...")
							tab4 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ altroTipologiaServiziPresuntoAutore
									+ "</h6></label></td></tr>";
						tab4 += "<tr><td width='65%'><label><h6>Precedenti penali: </h6></label></td><td><label class='form-label'><h6>"
								+ precedenti_penali + "</h6></label></td></tr>";

						tab5 += "<tr><td width='65%'><label><h6>La frequenza e/o la gravità degli atti di violenza fisica sono aumentati negli ultimi 6 mesi?</h6></label></td><td><label class='form-label'><h6>"
								+ briefRisk1 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>L’aggressore ha mai utilizzato un’arma, o l’ha minacciata con un’arma, o ha tentato di strangolarla?</h6></label></td><td><label class='form-label'><h6>"
								+ briefRisk2 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Pensa che l’aggressore possa farle del male (ucciderla)?</h6></label></td><td><label class='form-label'><h6>"
								+ briefRisk3 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>L’ha mai picchiata durante la gravidanza?</h6></label></td><td><label class='form-label'><h6>"
								+ briefRisk4 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>L’aggressore è violentemente e costantemente geloso di lei?</h6></label></td><td><label class='form-label'><h6>"
								+ briefRisk5 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Escalation della violenza?</h6></label></td><td><label class='form-label'><h6>"
								+ briefRisk6 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Violazione misure cautelari interdittive?</h6></label></td><td><label class='form-label'><h6>"
								+ briefRisk7 + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Rete intra ospedaliera: </h6></label></td><td><label class='form-label'><h6>"
								+ reteIntraOspedaliera
								+ "</h6></label></td></tr>";
						if (reteIntraOspedaliera == "Altro...")
							tab5 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ specificoReteIntraOspedaliera
									+ "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Rete extra ospedaliera: </h6></label></td><td><label class='form-label'><h6>"
								+ reteExtraOspedaliera
								+ "</h6></label></td></tr>";
						if (reteExtraOspedaliera == "Altro...")
							tab5 += "<tr><td width='65%'><label><h6>Altro: </h6></label></td><td><label class='form-label'><h6>"
									+ specificoReteExtraOspedaliera
									+ "</h6></label></td></tr>";
						if (reteExtraOspedaliera == "Forze dell'Ordine")
							tab5 += "<tr><td width='65%'><label><h6>Forze dell'ordine: </h6></label></td><td><label class='form-label'><h6>"
									+ forzeDellOrdine
									+ "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Tempi di prognosi: </h6></label></td><td><label class='form-label'><h6>"
								+ tempiDiPrognosi + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Referti: </h6></label></td><td><label class='form-label'><h6>"
								+ referto + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Attestazioni: </h6></label></td><td><label class='form-label'><h6>"
								+ attestazioni + "</h6></label></td></tr>";
						tab5 += "<tr><td width='65%'><label><h6>Attivato percorso rosa: </h6></label></td><td><label class='form-label'><h6>"
								+ codiceRosa + "</h6></label></td></tr>";

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

						if (statuscap == "inviata") {
							$("#printbutton").show();
						}
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
						var identificativoScheda = jsonStr['answer1'];
						var dataCompilazione = jsonStr['answer2'];
						var prontoSoccorso = jsonStr['answer5'];
						var nomeCompilatore = jsonStr['answer3'];
						var cognomeCompilatore = jsonStr['answer4'];
						var statuscap = jsonStr['status'];

						//Domande: 2 dati Anagrafici della donna
						var nome_vittima = jsonStr["answer6"];
						var cognome_vittima = jsonStr['answer7'];
						var data_nascita = jsonStr['answer8'];
						var luogo_nascita = jsonStr['answer9'];
						var provincia_nascita = jsonStr['answer10'];
						var comune_nascita = jsonStr['answer11'];
						var indirizzo = jsonStr['answer12'];
						var telefono = jsonStr['answer13'];
						var altroTelefono = jsonStr['answer14'];
						var cittadinanza_italiana = jsonStr['answer15'];
						var altraCittadinanza = jsonStr['answer16'];
						var conoscenzaLinguaItaliana = jsonStr['answer17'];
						var mediatoreCulturale = jsonStr['answer18'];
						var statoCivile = jsonStr['answer19'];
						var altroStatoCivile = jsonStr['answer20'];
						var figli = jsonStr['answer21'];
						var numero_figli = jsonStr['answer22'];
						var numero_figli_minorenni = jsonStr['answer23'];
						var conviventi = jsonStr['answer117'];
						var titoloDiStudio = jsonStr['answer24'];
						var altroTitoloDiStudio = jsonStr['answer25']
						var professione = jsonStr['answer26'];
						var autonomo_economicamente = jsonStr['answer27'];

						//Domande:3 Tipologia della Violenza
						var primoAccessoProntoSoccorso = jsonStr['answer28'];
						var numeroAccessiRipetuti = jsonStr['answer29'];
						var tipologiaViolenza = jsonStr['answer118'];
						var altroViolenzaRiferita = jsonStr['answer119'];
						var sfruttamento = jsonStr['answer30'];
						sfruttamento = sfruttamento.replace(/;/g, "<br>");

						var con_figli_minori = jsonStr['answer120'];
						var donnaAccompagnataInPS = jsonStr['answer31'];
						var altroDonnaAccompagnataInPS = jsonStr['answer32'];
						var motivoAccessoInPS = jsonStr['answer33'];
						var codiceAttribuito = jsonStr['answer121'];

						//Domande:4 Presunto autore della Violenza
						var nomePresuntoAutore = jsonStr['answer34'];
						var cognomePresuntoAutore = jsonStr['answer35'];
						var dataNascitaPresuntoAutore = jsonStr['answer36'];
						var luogoPresuntoAutore = jsonStr['answer37'];
						var provinciaNascitaPresuntoAutore = jsonStr['answer38'];
						var comuneNascitaPresuntoAutore = jsonStr['answer39'];
						var indirizzoPresuntoAutore = jsonStr['answer40'];
						var telefonoPresuntoAutore = jsonStr['answer41'];
						var titoloDiStudioPresuntoAutore = jsonStr['answer42'];
						var altroTitoloDiStudioPresuntoAutore = jsonStr['answer43'];
						var professionePresuntoAutore = jsonStr['answer44'];
						var fasciaDiEtaPresuntoAutore = jsonStr['answer45'];
						var rapportoVittimaPresuntoAutore = jsonStr['answer46'];
						var tipologiaFamiliare = jsonStr['answer47'];
						var altroRapportoVittimaAggressore = jsonStr['answer48'];
						var presuntoAutoreServizi = jsonStr['answer49'];
						var tipologiaServiziPresuntoAutore = jsonStr['answer50'];
						var altroTipologiaServiziPresuntoAutore = jsonStr['answer51'];
						var precedenti_penali = jsonStr['answer52'];

						//Domande:5 Valutazioni
						var briefRisk1 = jsonStr['answer53'];
						var briefRisk2 = jsonStr['answer54'];
						var briefRisk3 = jsonStr['answer55'];
						var briefRisk4 = jsonStr['answer56'];
						var briefRisk5 = jsonStr['answer57'];
						var briefRisk6 = jsonStr['answer58'];
						var briefRisk7 = jsonStr['answer59'];
						var reteIntraOspedaliera = jsonStr['answer122'];
						var specificoReteIntraOspedaliera = jsonStr['answer123'];
						var reteExtraOspedaliera = jsonStr['answer124'];
						var specificoReteExtraOspedaliera = jsonStr['answer125'];
						var forzeDellOrdine = jsonStr['answer126'];
						var tempiDiPrognosi = jsonStr['answer127'];
						var referto = jsonStr['answer128'];
						var attestazioni = jsonStr['answer129'];
						var codiceRosa = jsonStr['answer130'];

						tab = "Identificativo scheda:\n" + identificativoScheda
								+ "\n\n";
						tab += "Data compilazione:\n" + dataCompilazione
								+ "\n\n";
						tab += "Presidio Ospedaliero:\n" + prontoSoccorso
								+ "\n\n";
						tab += "Nome del compilatore:\n" + nomeCompilatore
								+ "\n\n";
						tab += "Cognome del compilatore:\n"
								+ cognomeCompilatore + "\n\n";

						var statuscap = jsonStr['status'];
						tab += "Status:\n" + statuscap.charAt(0).toUpperCase()
								+ statuscap.slice(1) + "\n\n";

						tab2 = "Nome:\n" + nome_vittima + "\n\n";
						tab2 += "Cognome:\n" + cognome_vittima + "\n\n";
						tab2 += "Data di nascita:\n" + data_nascita + "\n\n";
						tab2 += "Luogo di nascita:\n" + luogo_nascita + "\n\n";
						tab2 += "Residente/Domiciliata in Provincia di:\n"
								+ provincia_nascita + "\n\n";
						tab2 += "Residente/Domiciliata nel Comune di:\n"
								+ comune_nascita + "\n\n";
						tab2 += "Indirizzo:\n" + indirizzo + "\n\n";
						tab2 += "Telefono personale:\n" + telefono + "\n\n";
						tab2 += "Altro telefono:\n" + altroTelefono + "\n\n";
						tab2 += "Cittadinanza Italiana:\n"
								+ cittadinanza_italiana + "\n\n";
						if (cittadinanza_italiana == "Altro...")
							tab2 += "Altra cittadinanza: " + altraCittadinanza
									+ "\n\n";
						tab2 += "Conoscenza lingua Italiana:\n"
								+ conoscenzaLinguaItaliana + "\n\n";
						if (conoscenzaLinguaItaliana == "Poco"
								|| conoscenzaLinguaItaliana == "No")
							tab2 += "Richiesto mediatore culturale:\n"
									+ mediatoreCulturale + "\n\n";
						tab2 += "Stato civile:\nRisposta" + statoCivile
								+ "\n\n";
						if (statoCivile == "Altro...")
							tab2 += "Altro stato civile:\nRispsota:"
									+ altroStatoCivile + "\n\n";
						tab2 += "Figli:\n" + figli + "\n\n";

						if (figli == "Si") {
							tab2 += "Numero figli:\n" + numero_figli + "\n\n";
							tab2 += "Di cui minorenni:\n"
									+ numero_figli_minorenni + "\n\n";
						}

						tab2 += "Conviventi:\n" + conviventi + "\n\n";
						tab2 += "Titolo di studio:\n" + titoloDiStudio + "\n\n";
						if (titoloDiStudio == "Altro...")
							tab2 += "Altro titolo di studio:\n"
									+ altroTitoloDiStudio + "\n\n";

						tab2 += "Stato occupazionale:\n" + professione + "\n\n";
						tab2 += "Autonomia Economica:\n"
								+ autonomo_economicamente + "\n\n";

						tab3 = "Primo accesso al Pronto Soccorso:\n"
								+ primoAccessoProntoSoccorso + "\n\n";
						if (primoAccessoProntoSoccorso == "No")
							tab3 += "Numero accessi ripetuti: "
									+ numeroAccessiRipetuti + "\n\n";
						tab3 += "Tipologia della violenza riferita:\n"
								+ tipologiaViolenza + "\n\n";
						if (tipologiaViolenza == "Altro")
							tab3 += "Descrizione tipologia della violenza prevalente:\n"
									+ altroViolenzaRiferita + "\n\n";

						if (tipologiaViolenza == "Violenza domestica"
								|| tipologiaViolenza == "Violenza extra domestica")
							tab3 += "Violenze:\n" + sfruttamento + "\n\n";

						tab3 += "In presenza di figli minori:\n"
								+ con_figli_minori + "\n\n";
						tab3 += "La donna accede al Pronto Soccorso:\n"
								+ donnaAccompagnataInPS + "\n\n";
						if (donnaAccompagnataInPS == "Altro...")
							tab3 += "Altro:\n" + altroDonnaAccompagnataInPS
									+ "\n\n";

						tab3 += "Motivo accesso in PS:\n" + motivoAccessoInPS
								+ "\n\n";
						tab3 += "Codice attribuito:\n" + codiceAttribuito
								+ "\n\n";

						tab4 = "Nome:\n" + nomePresuntoAutore + "\n\n";
						tab4 += "Cognome:\n" + cognomePresuntoAutore + "\n\n";
						tab4 += "Data di nascita:\n"
								+ dataNascitaPresuntoAutore + "\n\n";
						tab4 += "Luogo di nascita:\n" + luogoPresuntoAutore
								+ "\n\n";
						tab4 += "Provincia di nascita:\n"
								+ provinciaNascitaPresuntoAutore + "\n\n";
						tab4 += "Comune di nascita:\n"
								+ comuneNascitaPresuntoAutore + "\n\n";
						tab4 += "Indirizzo:\n" + indirizzoPresuntoAutore
								+ "\n\n";
						tab4 += "Telefono:\n" + telefonoPresuntoAutore + "\n\n";
						tab4 += "Titolo di studio:\n"
								+ titoloDiStudioPresuntoAutore + "\n\n";
						if (titoloDiStudioPresuntoAutore == "Altro...")
							tab4 += "Altro titolo di studio:\n"
									+ altroTitoloDiStudioPresuntoAutore
									+ "\n\n";
						tab4 += "Stato occupazionale:\n"
								+ professionePresuntoAutore + "\n\n";
						tab4 += "Fascia di età: " + fasciaDiEtaPresuntoAutore
								+ "\n\n";
						tab4 += "Rapporto vittima/presunto autore di violenza:\n"
								+ rapportoVittimaPresuntoAutore + "\n\n";
						if (rapportoVittimaPresuntoAutore == "Familiare")
							tab4 += "Familiare:\n" + tipologiaFamiliare
									+ "\n\n";
						if (tipologiaFamiliare == "Altro...")
							tab4 += "Altro rapporto vittima/presunto autore di violenza:\n"
									+ altroRapportoVittimaAggressore + "\n\n";
						tab4 += "Il presunto autore della violenza è in carico ai servizi (SERT, DSM, ...):\n"
								+ presuntoAutoreServizi + "\n\n";
						if (presuntoAutoreServizi == "Si")
							tab4 += "Tipologia servizi:\n"
									+ tipologiaServiziPresuntoAutore + "\n\n";
						if (tipologiaServiziPresuntoAutore == "Altro...")
							tab4 += "Altro:\n"
									+ altroTipologiaServiziPresuntoAutore
									+ "\n\n";
						tab4 += "Precedenti penali:\n" + precedenti_penali
								+ "\n\n";

						tab5 += "La frequenza e/o la gravità degli atti di violenza fisica sono aumentati negli ultimi 6 mesi? "
								+ briefRisk1 + "\n\n";
						tab5 += "L\'aggressore ha mai utilizzato un\'arma, o l\'ha minacciata con un\'arma, o ha tentato di strangolarla? "
								+ briefRisk2 + "\n\n";
						tab5 += "Pensa che l\'aggressore possa farle del male (ucciderla)? "
								+ briefRisk3 + "\n\n";
						tab5 += "L\'ha mai picchiata durante la gravidanza? "
								+ briefRisk4 + "\n\n";
						tab5 += "L\'aggressore è violentemente e costantemente geloso di lei? "
								+ briefRisk5 + "\n\n";
						tab5 += "Escalation della violenza? " + briefRisk6
								+ "\n\n";
						tab5 += "Violazione misure cautelari interdittive? "
								+ briefRisk7 + "\n\n";

						tab5 += "Rete intra ospedaliera:\n"
								+ reteIntraOspedaliera + "\n\n";
						if (reteIntraOspedaliera == "Altro...")
							tab5 += "Altro:\n" + specificoReteIntraOspedaliera
									+ "\n\n";
						tab5 += "Rete extra ospedaliera:\n"
								+ reteExtraOspedaliera + "\n\n";
						if (reteExtraOspedaliera == "Altro...")
							tab5 += "Altro:\n" + specificoReteExtraOspedaliera
									+ "\n\n";
						if (reteExtraOspedaliera == "Forze dell'Ordine")
							tab5 += "Forze dell\'ordine:\n" + forzeDellOrdine
									+ "\n\n";
						tab5 += "Tempi di prognosi:\n" + tempiDiPrognosi
								+ "\n\n";
						tab5 += "Referti:\n" + referto + "\n\n";
						tab5 += "Attestazioni:\n" + attestazioni + "\n\n";
						tab5 += "Attivato percorso rosa:\n" + codiceRosa
								+ "\n\n";

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
						doc.save(identificativoScheda + '.pdf');
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
                <li><a href="domande.jsp">Gestione Schede</a></li>
                <li><span>Dettaglio Scheda</span></li>
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
        <div class="col-12">
          <div class="card">
            <div class="card-body">
              <h1 align="center">Anteprima Scheda</h1>
              <div class="row" id="question1">
                <div class="col-12 mt-5">
                  <div class="card">
                    <div class="card-body">
                      <h3 align="center">1. Dati della scheda</h3>
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
                      <h3 align="center">3. Tipologia della violenza</h3>
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
                      <h3 align="center">4. Presunto autore della violenza</h3>
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
                      <h3 align="center">5. Rischio e Azioni</h3>
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
                  <button id="printbutton" type="button" class="btn btn-info btn-lg btn-block" onclick="print();">Stampa</button>
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
