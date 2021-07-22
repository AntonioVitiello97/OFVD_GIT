<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>
<%@page import="it.unisa.ofvd.model.dao.AccountsDao"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.model.QuestionsModel"%>
<%@page import="it.unisa.ofvd.model.dao.QuestionsDao"%>
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
uri = uri + "/hospital/";
AccountsModel account = (AccountsModel) request.getSession().getAttribute("account");
QuestionsDao question = new QuestionsDao();

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
						var identificativoScheda = jsonStr['answer1'];
						var dataCompilazione = jsonStr['answer2'];
						var prontoSoccorso = jsonStr['answer5'];
						var nomeCompilatore = jsonStr['answer3'];
						var cognomeCompilatore = jsonStr['answer4'];

						//Domande: 2 dati Anagrafici della donna
						var nome_vittima = jsonStr["answer6"];
						if (nome_vittima == undefined)
							nome_vittima = "";

						var cognome_vittima = jsonStr['answer7'];
						if (cognome_vittima == undefined)
							cognome_vittima = "";

						var data_nascita = jsonStr['answer8'];
						if (data_nascita == undefined)
							data_nascita = "";

						var luogo_nascita = jsonStr['answer9'];
						if (luogo_nascita == undefined)
							luogo_nascita = "";

						var provincia_nascita = jsonStr['answer10'];
						if (provincia_nascita == undefined)
							provincia_nascita = "";

						var comune_nascita = jsonStr['answer11'];
						if (comune_nascita == undefined)
							comune_nascita = "";

						var indirizzo = jsonStr['answer12'];
						if (indirizzo == undefined)
							indirizzo = "";

						var telefono = jsonStr['answer13'];
						if (telefono == undefined)
							telefono = "";

						var altroTelefono = jsonStr['answer14'];
						if (altroTelefono == undefined)
							altroTelefono = "";

						var cittadinanza_italiana = jsonStr['answer15'];
						if (cittadinanza_italiana == undefined)
							cittadinanza_italiana = "";

						var altraCittadinanza = jsonStr['answer16'];
						if (altraCittadinanza == undefined)
							altraCittadinanza = "";

						var conoscenzaLinguaItaliana = jsonStr['answer17'];
						if (conoscenzaLinguaItaliana == undefined)
							conoscenzaLinguaItaliana = "";

						var mediatoreCulturale = jsonStr['answer18'];
						if (mediatoreCulturale == undefined)
							mediatoreCulturale = "";

						var statoCivile = jsonStr['answer19'];
						if (statoCivile == undefined)
							statoCivile = "";

						var altroStatoCivile = jsonStr['answer20'];
						if (altroStatoCivile == undefined)
							altroStatoCivile = "";

						var figli = jsonStr['answer21'];
						if (figli == undefined)
							figli = "";

						var numero_figli = jsonStr['answer22'];
						if (numero_figli == undefined)
							numero_figli = "";

						var numero_figli_minorenni = jsonStr['answer23'];
						if (numero_figli_minorenni == undefined)
							numero_figli_minorenni = "";

						var conviventi = jsonStr['answer117'];
						if (conviventi == undefined)
							conviventi = "";

						var titoloDiStudio = jsonStr['answer24'];
						if (titoloDiStudio == undefined)
							titoloDiStudio = "";

						var altroTitoloDiStudio = jsonStr['answer25'];
						if (altroTitoloDiStudio == undefined)
							altroTitoloDiStudio = "";

						var professione = jsonStr['answer26'];
						if (professione == undefined)
							professione = "";

						var autonomo_economicamente = jsonStr['answer27'];
						if (autonomo_economicamente == undefined)
							autonomo_economicamente = "";

						//Domande:3 Tipologia della Violenza
						var primoAccessoProntoSoccorso = jsonStr['answer28'];
						if (primoAccessoProntoSoccorso == undefined)
							primoAccessoProntoSoccorso = "";

						var numeroAccessiRipetuti = jsonStr['answer29'];
						if (numeroAccessiRipetuti == undefined)
							numeroAccessiRipetuti = "";

						var tipologiaViolenza = jsonStr['answer118'];
						if (tipologiaViolenza == undefined)
							tipologiaViolenza = "";

						var altroViolenzaRiferita = jsonStr['answer119'];
						if (altroViolenzaRiferita == undefined)
							altroViolenzaRiferita = "";

						var sfruttamento = jsonStr['answer30'];
						if (sfruttamento == undefined)
							sfruttamento = "";
						else
							sfruttamento = sfruttamento.replace(/;/g, "<br>");

						var con_figli_minori = jsonStr['answer120'];
						if (con_figli_minori == undefined)
							con_figli_minori = "";

						var donnaAccompagnataInPS = jsonStr['answer31'];
						if (donnaAccompagnataInPS == undefined)
							donnaAccompagnataInPS = "";

						var altroDonnaAccompagnataInPS = jsonStr['answer32'];
						if (altroDonnaAccompagnataInPS == undefined)
							altroDonnaAccompagnataInPS = "";

						var motivoAccessoInPS = jsonStr['answer33'];
						if (motivoAccessoInPS == undefined)
							motivoAccessoInPS = "";

						var codiceAttribuito = jsonStr['answer121'];
						if (codiceAttribuito == undefined)
							codiceAttribuito = "";

						//Domande:4 Presunto autore della Violenza
						var nomePresuntoAutore = jsonStr['answer34'];
						if (nomePresuntoAutore == undefined)
							nomePresuntoAutore = "";

						var cognomePresuntoAutore = jsonStr['answer35'];
						if (cognomePresuntoAutore == undefined)
							cognomePresuntoAutore = "";

						var dataNascitaPresuntoAutore = jsonStr['answer36'];
						if (dataNascitaPresuntoAutore == undefined)
							dataNascitaPresuntoAutore = "";

						var luogoPresuntoAutore = jsonStr['answer37'];
						if (luogoPresuntoAutore == undefined)
							luogoPresuntoAutore = "";

						var provinciaNascitaPresuntoAutore = jsonStr['answer38'];
						if (provinciaNascitaPresuntoAutore == undefined)
							provinciaNascitaPresuntoAutore = "";

						var comuneNascitaPresuntoAutore = jsonStr['answer39'];
						if (comuneNascitaPresuntoAutore == undefined)
							comuneNascitaPresuntoAutore = "";

						var indirizzoPresuntoAutore = jsonStr['answer40'];
						if (indirizzoPresuntoAutore == undefined)
							indirizzoPresuntoAutore = "";

						var telefonoPresuntoAutore = jsonStr['answer41'];
						if (telefonoPresuntoAutore == undefined)
							telefonoPresuntoAutore = "";

						var titoloDiStudioPresuntoAutore = jsonStr['answer42'];
						if (titoloDiStudioPresuntoAutore == undefined)
							titoloDiStudioPresuntoAutore = "";

						var altroTitoloDiStudioPresuntoAutore = jsonStr['answer43'];
						if (altroTitoloDiStudioPresuntoAutore == undefined)
							altroTitoloDiStudioPresuntoAutore = "";

						var professionePresuntoAutore = jsonStr['answer44'];
						if (professionePresuntoAutore == undefined)
							professionePresuntoAutore = "";

						var fasciaDiEtaPresuntoAutore = jsonStr['answer45'];
						if (fasciaDiEtaPresuntoAutore == undefined)
							fasciaDiEtaPresuntoAutore = "";

						var rapportoVittimaPresuntoAutore = jsonStr['answer46'];
						if (rapportoVittimaPresuntoAutore == undefined)
							rapportoVittimaPresuntoAutore = "";

						var tipologiaFamiliare = jsonStr['answer47'];
						if (tipologiaFamiliare == undefined)
							tipologiaFamiliare = "";

						var altroRapportoVittimaAggressore = jsonStr['answer48'];
						if (altroRapportoVittimaAggressore == undefined)
							altroRapportoVittimaAggressore = "";

						var presuntoAutoreServizi = jsonStr['answer49'];
						if (presuntoAutoreServizi == undefined)
							presuntoAutoreServizi = "";

						var tipologiaServiziPresuntoAutore = jsonStr['answer50'];
						if (tipologiaServiziPresuntoAutore == undefined)
							tipologiaServiziPresuntoAutore = "";

						var altroTipologiaServiziPresuntoAutore = jsonStr['answer51'];
						if (altroTipologiaServiziPresuntoAutore == undefined)
							altroTipologiaServiziPresuntoAutore = "";

						var precedenti_penali = jsonStr['answer52'];
						if (precedenti_penali == undefined)
							precedenti_penali = "";

						//Domande:5 Valutazioni
						var briefRisk1 = jsonStr['answer53'];
						if (briefRisk1 == undefined)
							briefRisk1 = "";

						var briefRisk2 = jsonStr['answer54'];
						if (briefRisk2 == undefined)
							briefRisk2 = "";

						var briefRisk3 = jsonStr['answer55'];
						if (briefRisk3 == undefined)
							briefRisk3 = "";

						var briefRisk4 = jsonStr['answer56'];
						if (briefRisk4 == undefined)
							briefRisk4 = "";

						var briefRisk5 = jsonStr['answer57'];
						if (briefRisk5 == undefined)
							briefRisk5 = "";

						var briefRisk6 = jsonStr['answer58'];
						if (briefRisk6 == undefined)
							briefRisk6 = "";

						var briefRisk7 = jsonStr['answer59'];
						if (briefRisk7 == undefined)
							briefRisk7 = "";

						var reteIntraOspedaliera = jsonStr['answer122'];
						if (reteIntraOspedaliera == undefined)
							reteIntraOspedaliera = "";

						var specificoReteIntraOspedaliera = jsonStr['answer123'];
						if (specificoReteIntraOspedaliera == undefined)
							specificoReteIntraOspedaliera = "";

						var reteExtraOspedaliera = jsonStr['answer124'];
						if (reteExtraOspedaliera == undefined)
							reteExtraOspedaliera = "";

						var specificoReteExtraOspedaliera = jsonStr['answer125'];
						if (specificoReteExtraOspedaliera == undefined)
							specificoReteExtraOspedaliera = "";

						var forzeDellOrdine = jsonStr['answer126'];
						if (forzeDellOrdine == undefined)
							forzeDellOrdine = "";

						var tempiDiPrognosi = jsonStr['answer127'];
						if (tempiDiPrognosi == undefined)
							tempiDiPrognosi = "";

						var referto = jsonStr['answer128'];
						if (referto == undefined)
							referto = "";

						var attestazioni = jsonStr['answer129'];
						if (attestazioni == undefined)
							attestazioni = "";

						var codiceRosa = jsonStr['answer130'];
						if (codiceRosa == undefined)
							codiceRosa = "";

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

						tab5 += "<tr><td width='65%'><label><h6>La frequenza e/o la gravità degli atti di violenza  fisica sono aumentati negli ultimi 6 mesi?</h6></label></td><td><label class='form-label'><h6>"
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
					}
				});

	}
</script>
</head>
<body onload="load();">
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
              <h2 align="center">Anteprima Scheda</h2>
              <div class="row" id="question1">
                <div class="col-12 mt-5">
                  <div class="card">
                    <div class="card-body">
                      <h3 align="center">1. Dati della scheda</h3>
                      <!--  <p>Please fill with your details</p> -->
                      <table class="table text-left">
                        <tbody id="tableQuestion1">
                        </tbody>
                      </table>
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
                      <table class="table text-left">
                        <tbody id="tableQuestion2">
                        </tbody>
                      </table>
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
