package it.unisa.ofvd.utils;

public class Constants {
	
	public static String developmentLoginName = "michelerisi";
		
	public static String title = "OFVD";
	public static String mainVersion = "1.0.";
		
	public static String appName = "ofvd";
	
	public static String appHost = "https://www.datiofvd.cr.campania.it/";
	
	public static final String appLocalUrl = "http://localhost:8080/" + appName;
	public static final String appUrl = "https://www.datiofvd.cr.campania.it/" + appName;
		
	public static String cryptAlgorithm = "MD5";
	public static String encryption = cryptAlgorithm + ":";
	
	public static String dbsVersion = "2.0.1";
	
	public static String mysqlIp = "localhost";
	public static int mysqlPort = 3306;
	public static String mysqlDb = "ofvd_access";
	public static String mysqlLogin = "ofvd";
	public static String mysqlPwd = "ofvd_178@cx";
	
	public static String mongoIp = "localhost";
	public static int mongoPort = 27017;
	public static String mongoDb = "ofvd";
	public static String mongoCollection = "question";
	
	//public static String EMAIL_ADDRESS="ofvdregionecampania@gmail.com";
	//public static String EMAIL_PWD="+SalvaVitaPS2019.NA-AV#";
	public static String EMAIL_ADDRESS="datiofvd@cr.campania.it";
	public static String EMAIL_PWD="consiglio2020";
		
	public static String PRIVACY="Privacy Policy OFVD\n" + 
    		"INFORMAZIONI SUL TRATTAMENTO DEI DATI PERSONALI\n" + 
    		"degli utenti che utilizzano la piattaforma OFVD\n" + 
    		"Ai sensi del Regolamento (UE) 2016/679 (di seguito \"Regolamento\"), questa informativa descrive le modalità di trattamento dei dati personali degli utenti che utilizzano a piattaforma OFVD (“Sito”).\n" + 
    		"TITOLARE DEL TRATTAMENTO\n" + 
    		"Consiglio regionale della Campania\n" + 
    		"Centro Direzionale, Isola F13 - 80143 Napoli\n" + 
    		"Telefono: 0817783646\n" + 
    		"E-mail: presidente@cr.campania.ii\n" + 
    		"\n" + 
    		"Designato al trattamento: Presidente pro tempore dell’Osservatorio sul Fenomeno della Violenza sulle Donne (OFVD)\n" + 
    		"Centro Direzionale Isola F8, VI piano - 80143 Napoli \n" + 
    		"Centralino: 081 7783111\n" + 
    		"E-mail: ossvido@cr.campania.it\n" + 
    		"\n" + 
    		"RESPONSABILE DELLA PROTEZIONE DEI DATI\n" + 
    		"Ai sensi dell’art. 37 del Regolamento, è stato nominato un Responsabile della Protezione dei Dati (RPD) per verificare la conformità dei trattamenti dell’Ente alla normativa italiana ed europea. \n" + 
    		"Il Responsabile della Protezione dei Dati (RPD) è raggiungibile al seguente indirizzo email: dpo@cr.campania.it\n" + 
    		"Lo stesso è a disposizione per le richieste di informazioni sul trattamento dei dati personali da parte del Titolare e costituisce il punto di contatto per l’Autorità di controllo.\n" + 
    		"BASE GIURIDICA DEL TRATTAMENTO\n" + 
    		"I dati personali raccolti dal Sito sono trattati dal Titolare esclusivamente per la corretta gestione della piattaforma OFVD il cui scopo è raccogliere dati di tipo statistico, anonimizzati già dall’operatore che inserisce le informazioni sulla piattaforma, al fine di monitorare il fenomeno della violenza sulle donne. La base giuridica di siffatto trattamento è costituita, ai sensi dell’art. 6 lett. e)  del Regolamento, dall’esecuzione di un compito di interesse pubblico e da motivi di interesse pubblico rilevante.\n" + 
    		"TIPI DI DATI TRATTATI E FINALITÀ DEL TRATTAMENTO\n" + 
    		"Con l'uso o la consultazione del presente sito il Titolare tratterà i dati dei visitatori e degli utenti per specifiche finalità quali:\n" + 
    		"- raccolta necessaria ed automatica dei dati degli operatori inerenti all’interazione con il sito web;\n" + 
    		"- trattamento correlato alla raccolta di dati immessi volontariamente dagli operatori;\n" + 
    		"- prevenzione e ricerca di eventuali attività fraudolente o abusi dannosi per il Sito web.\n" + 
    		"Dati di navigazione    \n" + 
    		"I sistemi informatici e le procedure software preposte al funzionamento di questo sito acquisiscono, nel corso del loro normale esercizio, alcuni dati personali la cui trasmissione è implicita nell'uso dei protocolli di comunicazione di Internet.\n" + 
    		"In questa categoria di dati rientrano gli indirizzi IP o i nomi a dominio dei computer e dei terminali utilizzati dagli utenti, gli indirizzi in notazione URI/URL (Uniform Resource Identifier/Locator) delle risorse richieste, l'orario della richiesta, il metodo utilizzato nel sottoporre la richiesta al server, la dimensione del file ottenuto in risposta, il codice numerico indicante lo stato della risposta data dal server (buon fine, errore, ecc.) ed altri parametri relativi al sistema operativo e all'ambiente informatico dell'utente.\n" + 
    		"Tali dati, necessari per la fruizione dei servizi web, vengono anche trattati allo scopo di:\n" + 
    		"•	ottenere informazioni statistiche sull'uso dei servizi (pagine più visitate, numero di visitatori per fascia oraria o giornaliera, aree geografiche di provenienza, ecc.);\n" + 
    		"•	controllare il corretto funzionamento dei servizi offerti.\n" + 
    		"I dati di navigazione non persistono per più di sette giorni e vengono cancellati immediatamente dopo la loro aggregazione (salve eventuali necessità di accertamento di reati da parte dell'Autorità giudiziaria). \n" + 
    		"Cookie e altri sistemi di tracciamento\n" + 
    		"Non viene fatto uso di cookie per la profilazione degli utenti, né vengono impiegati altri metodi di tracciamento.\n" + 
    		"Viene invece fatto uso di cookie di sessione (non persistenti) in modo strettamente limitato a quanto necessario per la navigazione sicura ed efficiente dei siti. La memorizzazione dei cookie di sessione nei terminali o nei browser è sotto il controllo dell'utente, laddove sui server, al termine delle sessioni HTTP, informazioni relative ai cookie restano registrate nei log dei servizi, con tempi di conservazione comunque non superiori ai sette giorni al pari degli altri dati di navigazione. Un generico cookie (persistente o di sessione) verrà generato solo dopo che l’utente ha effettuato l’accesso al sistema come operatore di centro antiviolenza, di una struttura ospedaliera o nel caso dell’amministratore del sistema. L’accesso al sito è riservato ad un numero determinato di utenti autorizzati. \n" + 
    		"DESTINATARI DEI DATI\n" + 
    		"Ai fini della fruizione dei servizi tramite il presente Sito, nonché per ottemperare ai determinati requisiti giuridici e/o regolamentari, i dati degli utenti potranno essere comunicati al personale interno dell’Osservatorio o del Consiglio Regione Campania, a società terze, contrattualmente collegate al Titolare, o altri soggetti che svolgono attività e servizi in outsourcing per conto della Titolare (fornitori di servizi tecnici terzi, hosting provider, fornitori di servizi di sviluppo e manutenzione della piattaforma web, fornitori di servizi di sviluppo, erogazione e gestione operativa delle piattaforme tecnologiche impiegate etc.), nominati laddove necessario quali Responsabili esterni del trattamento dei dati personali.\n" + 
    		"È fatta salva, in ogni caso, la comunicazione o diffusione di dati richiesti, in conformità alla legge, da Forze di Polizia, dall'Autorità Giudiziaria, da organismi di informazione e sicurezza o da altri soggetti pubblici per finalità di difesa o di sicurezza dello Stato o di prevenzione, accertamento o repressione di reati.\n" + 
    		"I dati personali raccolti non saranno diffusi.\n" + 
    		"PERIODO DI CONSERVAZIONE DEI DATI\n" + 
    		"I dati raccolti dal Sito durante il suo funzionamento sono utilizzati esclusivamente per alcune delle finalità sopra indicate e conservati per il tempo strettamente necessario a svolgere le attività precisate. \n" + 
    		"I dati raccolti dal Sito saranno conservati per tutta la durata dei servizi richiesti e, anche dopo la cessazione, per l’espletamento di tutti gli eventuali adempimenti di legge connessi o da essi derivanti.\n" + 
    		"I dati personali degli Interessati, infine, potranno essere conservati anche fino al tempo permesso dalla legge italiana a tutela dei legittimi interessi del Titolare (art. 2947, co. 1 e 3 c.c.). \n" + 
    		"\n" + 
    		"TRASFERIMENTO DEI DATI \n" + 
    		"La gestione e la conservazione dei dati personali avverranno su server ubicati all’interno dell’Unione Europea. I dati non saranno oggetto di trasferimento al di fuori dell’Unione Europea. Resta in ogni caso inteso che il Titolare, ove lo ritenga necessario, avrà facoltà di mutare l’ubicazione dei server anche in Paesi extra-UE. In tal caso, il Titolare assicura sin d’ora che il trasferimento dei dati extra-UE avverrà in conformità alle disposizioni di legge applicabili stipulando, se necessario, accordi che garantiscano un livello di protezione adeguato e/o adottando le clausole contrattuali standard previste dalla Commissione Europea ovvero solo in presenza di altro requisito conforme alla normativa italiana ed europea applicabile.\n" + 
    		"DIRITTI DEGLI INTERESSATI\n" + 
    		"Chiunque ha il diritto di ottenere dal Titolare la conferma dell'esistenza o meno dei dati personali che lo riguardano e la loro comunicazione in forma intelligibile.\n" + 
    		"Gli Utenti interessati, in particolare, hanno diritto di ottenere l'indicazione:\n" + 
    		"-	del contenuto e dell'origine dei dati personali;\n" + 
    		"-	delle finalità e modalità del trattamento;\n" + 
    		"-	della logica applicata al trattamento effettuato con l'ausilio di strumenti elettronici;\n" + 
    		"-	degli estremi identificativi del titolare e dei responsabili;\n" + 
    		"-	della durata della conservazione in relazione alle specifiche categorie di dati trattati; \n" + 
    		"-	dei soggetti o delle categorie di soggetti ai quali i dati personali possono essere comunicati o che possono venirne a conoscenza, in qualità di responsabili o incaricati;\n" + 
    		"-	l'aggiornamento, la rettificazione ovvero, quando vi hanno interesse, l'integrazione dei dati;\n" + 
    		"-	la cancellazione, la trasformazione in forma anonima o la limitazione dei dati trattati (es. se trattati in violazione di legge), compresi quelli di cui non è necessaria la conservazione in relazione agli scopi per i quali i dati sono stati raccolti o successivamente trattati;\n" + 
    		"-	in casi limitati, l’opposizione al trattamento o l’opposizione a qualsiasi processo decisionale automatizzato (compreso la profilazione);\n" + 
    		"-	la revoca di qualsiasi consenso prestato, ove previsto (si precisa che la revoca del consenso non pregiudica la liceità del trattamento basata sul consenso conferito prima della revoca);\n" + 
    		"-	l'attestazione che le operazioni di cui ai precedenti punti sono state portate a conoscenza, anche per quanto riguarda il loro contenuto, di coloro ai quali i dati sono stati comunicati o diffusi, eccettuato il caso in cui tale adempimento si rivela impossibile o comporta un impiego di mezzi manifestamente sproporzionati rispetto al diritto tutelato.\n" + 
    		"Per saperne di più, è possibile contattare il Responsabile della Protezione dei Dati al seguente indirizzo mail: dpo@cr.campania.it\n" + 
    		"\n" + 
    		"DIRITTO DI RECLAMO\n" + 
    		"Si ricorda infine che l’interessato ha sempre il diritto di proporre un reclamo all'Autorità Garante per la protezione dei dati personali per l’esercizio dei suoi diritti o per qualsiasi altra questione relativa al trattamento dei suoi dati personali (a tal proposito si invita a consultare il sito web www.garanteprivacy.it per ottenere maggiori informazioni sulle modalità di presentazione di un reclamo).\n";
}