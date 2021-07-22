/**
 * Author: Antonio De Piano
 * Web site: http://www.depiano.it
 * email: depianoantonio@gmail.com
 */

package it.unisa.ofvd.model.dao;

import static com.mongodb.client.model.Filters.*;

import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;

import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;

import com.mongodb.BasicDBObject;
import com.mongodb.Block;
import com.mongodb.MongoClient;
import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoCollection;

import it.unisa.ofvd.connection.DBMongoConnectionPool;
import it.unisa.ofvd.model.QuestionsModel;
import it.unisa.ofvd.model.ReportsModel;
import it.unisa.ofvd.model.dao.operations.QuestionsDaoInterface;
import it.unisa.ofvd.utils.Utility;

public class QuestionsDao implements QuestionsDaoInterface {

	/**
	 * Status: Inviata to Bozze (admin) 
	 */
	@Override
	public void changeStatus(String id_question) {

		Document obj = null;
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Utility.info("QUERY: changeStatus find " + id_question);
			obj = collection.find(eq("IdentificativoScheda", id_question)).first();

			obj.replace("status", "bozze");
			obj.replace("lastUpdate", new Date());

			collection.replaceOne(eq("IdentificativoScheda", id_question), obj);

			DBMongoConnectionPool.close(client);
		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
	}

	@Override
	public Collection<QuestionsModel> checkTrace(String trace, String avoid) {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					if (qs.getType().equals("hospital"))
						qs.setHospital((String) obj.get("hospital"));
					else if (qs.getType().equals("cav"))
						qs.setCav((String) obj.get("cav"));

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));				
					}

					if (qs.getType().equals("hospital")) {
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}
					
					collObj.add(qs);

				}
			};

			BasicDBObject criteria = new BasicDBObject();
			criteria.put("trace", new BasicDBObject("$eq", trace));
			criteria.put("IdentificativoScheda", new BasicDBObject("$ne", avoid));

			Utility.info("QUERY: retrieve find trace " + trace);
			//collection.find(eq("trace", trace)).forEach(printBlock);
			collection.find(criteria).forEach(printBlock);

			DBMongoConnectionPool.close(client);
		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	@Override
	public QuestionsModel retrieve(String id_question) {
		Document obj = null;
		QuestionsModel qs = null;
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Utility.info("QUERY: retrieve find " + id_question);
			obj = collection.find(eq("IdentificativoScheda", id_question)).first();

			if (obj != null) {
				qs = new QuestionsModel();

				qs.setType((String) obj.get("type"));
				qs.setStatus((String) obj.get("status"));
				qs.setSection((Integer) obj.get("section"));
				qs.setAuthor((String) obj.get("author"));
				qs.setLastUpdate(obj.getDate("lastUpdate"));
				qs.setTrace((String) obj.get("trace"));

				if (qs.getType().equals("hospital"))
					qs.setHospital((String) obj.get("hospital"));
				else if (qs.getType().equals("cav"))
					qs.setCav((String) obj.get("cav"));

				qs.setAnswer1((String) obj.get("IdentificativoScheda"));
				qs.setAnswer2((String) obj.get("DataCompilazione"));
				qs.setAnswer3((String) obj.get("NomeCompilatore"));
				qs.setAnswer4((String) obj.get("CognomeCompilatore"));
				qs.setAnswer5((String) obj.get("ProntoSoccorso"));
				qs.setAnswer6((String) obj.get("NomeVittima"));
				qs.setAnswer7((String) obj.get("CognomeVittima"));
				qs.setAnswer8((String) obj.get("DataNascita"));
				qs.setAnswer9((String) obj.get("LuogoNascita"));
				qs.setAnswer10((String) obj.get("ProvinciaNascita"));
				qs.setAnswer11((String) obj.get("ComuneNascita"));
				qs.setAnswer12((String) obj.get("Indirizzo"));
				qs.setAnswer13((String) obj.get("Telefono"));
				qs.setAnswer14((String) obj.get("AltroTelefono"));
				qs.setAnswer15((String) obj.get("CittadinanzaIta"));
				qs.setAnswer16((String) obj.get("AltraCittadinanza"));
				qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
				qs.setAnswer18((String) obj.get("MediatoreCulturale"));
				qs.setAnswer19((String) obj.get("StatoCivile"));
				qs.setAnswer20((String) obj.get("AltroStatoCivile"));
				qs.setAnswer21((String) obj.get("Figli"));
				qs.setAnswer22((String) obj.get("NumeroFigli"));
				qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
				qs.setAnswer24((String) obj.get("TitoloDiStudio"));
				qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
				qs.setAnswer26((String) obj.get("Professione"));
				qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
				qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
				qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
				qs.setAnswer30((String) obj.get("Sfruttamento"));
				qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
				qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
				qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
				qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
				qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
				qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
				qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
				qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
				qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
				qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
				qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
				qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
				qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
				qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
				qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
				qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
				qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
				qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
				qs.setAnswer49((String) obj.get("AggressoreServizi"));
				qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
				qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
				qs.setAnswer52((String) obj.get("PrecedentiPenali"));
				qs.setAnswer53((String) obj.get("Brief_risk1"));
				qs.setAnswer54((String) obj.get("Brief_risk2"));
				qs.setAnswer55((String) obj.get("Brief_risk3"));
				qs.setAnswer56((String) obj.get("Brief_risk4"));
				qs.setAnswer57((String) obj.get("Brief_risk5"));
				qs.setAnswer58((String) obj.get("Brief_risk6"));
				qs.setAnswer59((String) obj.get("Brief_risk7"));


				if (qs.getType().equals("cav")) {
					qs.setAnswer60((String) obj.get("RuoloCompilatore"));
					qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
					qs.setAnswer62((String) obj.get("IdentificativoServizio"));
					qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
					qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
					qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
					qs.setAnswer66((String) obj.get("CavNome"));
					qs.setAnswer67((String) obj.get("PronvinciaCav"));
					qs.setAnswer68((String) obj.get("ComuneCav"));
					qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
					qs.setAnswer70((String) obj.get("SportelloNome"));
					qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
					qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
					qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
					qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
					qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
					qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
					qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
					qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
					qs.setAnswer79((String) obj.get("AccessoOccasionale"));
					qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
					qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
					qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
					qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
					qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
					qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
					qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
					qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
					qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
					qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
					qs.setAnswer90((String) obj.get("ConosciAggressore"));
					qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
					qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
					qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
					qs.setAnswer94((String) obj.get("Separata"));
					qs.setAnswer95((String) obj.get("TempoSeparazione"));
					qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
					qs.setAnswer97((String) obj.get("SporgereDenuncia"));
					qs.setAnswer98((String) obj.get("SportoDenuncia"));
					qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
					qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
					qs.setAnswer101((String) obj.get("ComuneDenuncia"));
					qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
					qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
					qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
					qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
					qs.setAnswer106((String) obj.get("PresaInCarico"));
					qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
					qs.setAnswer108((String) obj.get("AttivazioneRete"));
					qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
					qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
					qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
					qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
					qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
					qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
					qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
					qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));
				}

				if (qs.getType().equals("hospital")) {
					qs.setAnswer117((String) obj.get("Conviventi"));
					qs.setAnswer118((String) obj.get("TipologiaViolenza"));
					qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
					qs.setAnswer120((String) obj.get("ConFigliMinori"));
					qs.setAnswer121((String) obj.get("CodiceAttributo"));
					qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
					qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
					qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
					qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
					qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
					qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
					qs.setAnswer128((String) obj.get("Referto"));
					qs.setAnswer129((String) obj.get("Attestazioni"));
					qs.setAnswer130((String) obj.get("CodiceRosa"));
				}
			}

			DBMongoConnectionPool.close(client);
		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return qs;
	}

	@Override
	public void create(QuestionsModel question) {

		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Document s = new Document();

			s.append("IdentificativoScheda", question.getAnswer1());
			s.append("DataCompilazione", question.getAnswer2());
			s.append("NomeCompilatore", question.getAnswer3());
			s.append("CognomeCompilatore", question.getAnswer4());
			s.append("ProntoSoccorso", question.getAnswer5());
			s.append("NomeVittima", question.getAnswer6());
			s.append("CognomeVittima", question.getAnswer7());
			s.append("DataNascita", question.getAnswer8());
			s.append("LuogoNascita", question.getAnswer9());
			s.append("ProvinciaNascita", question.getAnswer10());
			s.append("ComuneNascita", question.getAnswer11());
			s.append("Indirizzo", question.getAnswer12());
			s.append("Telefono", question.getAnswer13());
			s.append("AltroTelefono", question.getAnswer14());
			s.append("CittadinanzaIta", question.getAnswer15());
			s.append("AltraCittadinanza", question.getAnswer16());
			s.append("ConoscenzaLinguaItaliana", question.getAnswer17());
			s.append("MediatoreCulturale", question.getAnswer18());
			s.append("StatoCivile", question.getAnswer19());
			s.append("AltroStatoCivile", question.getAnswer20());
			s.append("Figli", question.getAnswer21());
			s.append("NumeroFigli", question.getAnswer22());
			s.append("NumeroFigliMinorenni", question.getAnswer23());
			s.append("TitoloDiStudio", question.getAnswer24());
			s.append("AltroTitoloDiStudio", question.getAnswer25());
			s.append("Professione", question.getAnswer26());
			s.append("EconomicamenteAutonomo", question.getAnswer27());
			s.append("PrimoAccessoProntoSoccorso", question.getAnswer28());
			s.append("NumeroAccessiRipetuti", question.getAnswer29());
			s.append("Sfruttamento", question.getAnswer30());
			s.append("DonnaAccompagnataInPS", question.getAnswer31());
			s.append("AltroDonnaAccompagnataInPS", question.getAnswer32());
			s.append("MotivoAccessoInPS", question.getAnswer33());
			s.append("NomePresuntoAggressore", question.getAnswer34());
			s.append("CognomePresuntoAggressore", question.getAnswer35());
			s.append("DataNascitaPresuntoAggressore", question.getAnswer36());
			s.append("LuogoPresuntoAggressore", question.getAnswer37());
			s.append("ProvinciaNascitaPresuntoAggressore", question.getAnswer38());
			s.append("ComuneNascitaPresuntoAggressore", question.getAnswer39());
			s.append("IndirizzoPresuntoAggressore", question.getAnswer40());
			s.append("TelefonoPresuntoAggressore", question.getAnswer41());
			s.append("TitoloStudioPresuntoAggressore", question.getAnswer42());
			s.append("AltroTitoloStudioPresuntoAggressore", question.getAnswer43());
			s.append("ProfessionePresuntoAggressore", question.getAnswer44());
			s.append("FasciaEtaPresuntoAggressore", question.getAnswer45());
			s.append("RapportoVittimaAggressore", question.getAnswer46());
			s.append("TipologiaFamiliare", question.getAnswer47());
			s.append("AltroRapportoVittimaAggressore", question.getAnswer48());
			s.append("AggressoreServizi", question.getAnswer49());
			s.append("TipologiaServiziAggressore", question.getAnswer50());
			s.append("AltraTipologiaServiziAggressore", question.getAnswer51());
			s.append("PrecedentiPenali", question.getAnswer52());
			s.append("Brief_risk1", question.getAnswer53());
			s.append("Brief_risk2", question.getAnswer54());
			s.append("Brief_risk3", question.getAnswer55());
			s.append("Brief_risk4", question.getAnswer56());
			s.append("Brief_risk5", question.getAnswer57());
			s.append("Brief_risk6", question.getAnswer58());
			s.append("Brief_risk7", question.getAnswer59());
			
			if (question.getType().equals("cav")) {
				s.append("RuoloCompilatore", question.getAnswer60());
				s.append("AltroRuoloCompilatore", question.getAnswer61());
				s.append("IdentificativoServizio", question.getAnswer62());
				s.append("AltroIdentificatoreServizio", question.getAnswer63());
				s.append("ProvinciaProntoSoccorso", question.getAnswer64());
				s.append("ComuneProntoSoccorso", question.getAnswer65());
				s.append("CavNome", question.getAnswer66());
				s.append("ProvinciaCav", question.getAnswer67());
				s.append("ComuneCav", question.getAnswer68());
				s.append("SportelloDiAscolto", question.getAnswer69());
				s.append("SportelloNome", question.getAnswer70());
				s.append("ProvinciaSportelloDiAscolto", question.getAnswer71());
				s.append("ComuneSportelloDiAscolto", question.getAnswer72());
				s.append("NumeroFigliMinorenniMaschi", question.getAnswer73());
				s.append("NumeroFigliMinorenniFemmine", question.getAnswer74());
				s.append("ConvivonoFigliFemmine", question.getAnswer75());
				s.append("AssistonoViolenzaFigli", question.getAnswer76());
				s.append("SubisconoViolenzaFigli", question.getAnswer77());
				s.append("AltroStatoOccupazionaleDonna", question.getAnswer78());
				s.append("AccessoOccasionale", question.getAnswer79());
				s.append("DonnaAccompagnataAlServizioAntiViolenza", question.getAnswer80());
				s.append("DonnaAccompagnataForzaDellOrdine", question.getAnswer81());
				s.append("ProvinciaDonnaAccompagnataForzaDellOrdine", question.getAnswer82());
				s.append("ComuneDonnaAccompagnataForzaDellOrdine", question.getAnswer83());
				s.append("DonnaAccompagnataProntoSoccorso", question.getAnswer84());
				s.append("ProvinciaDonnaAccompagnataProntoSoccorso", question.getAnswer85());
				s.append("ComuneDonnaAccompagnataProntoSoccorso", question.getAnswer86());
				s.append("SelectTipologiaViolenza", question.getAnswer87());
				s.append("ViolenzaRiferite", question.getAnswer88());
				s.append("AltroViolenzeRiferite", question.getAnswer89());
				s.append("ConosciAggressore", question.getAnswer90());
				s.append("AltroStatoOccupazionaleAggressore", question.getAnswer91());
				s.append("ViolenzaAssistitaOSubita", question.getAnswer92());
				s.append("FaseDiSeparazione", question.getAnswer93());
				s.append("Separata", question.getAnswer94());
				s.append("TempoSeparazione", question.getAnswer95());
				s.append("HaComunicatoAlPartner", question.getAnswer96());
				s.append("SporgereDenuncia", question.getAnswer97());
				s.append("SportoDenuncia", question.getAnswer98());
				s.append("SelectForzeDellOrdine", question.getAnswer99());
				s.append("ProvinciaDenuncia", question.getAnswer100());
				s.append("ComuneDenuncia", question.getAnswer101());
				s.append("RitiratoDenuncia", question.getAnswer102());
				s.append("MotivoRitiroDenuncia", question.getAnswer103());
				s.append("ValutazioneStatoBisogno", question.getAnswer104());
				s.append("SpecificareAltraValutazioneStatoBisogno", question.getAnswer105());
				s.append("PresaInCarico", question.getAnswer106());
				s.append("PrestazioniEffettuate", question.getAnswer107());
				s.append("AttivazioneRete", question.getAnswer108());
				s.append("AttivazioneReteProntoSoccorso", question.getAnswer109());
				s.append("AttivazioneReteProvinciaProntoSoccorso", question.getAnswer110());
				s.append("AttivazioneReteComuneProntoSoccorso", question.getAnswer111());
				s.append("AttivazioneReteForzeDellOrdine", question.getAnswer112());
				s.append("AttivazioneReteProvinciaForzeDellOrdine", question.getAnswer113());
				s.append("AttivazioneReteComuneForzaDellOrdine", question.getAnswer114());
				s.append("ServizioSanitarioProvincia", question.getAnswer115());
				s.append("ServiziSocialiProvincia", question.getAnswer116());
				
				s.append("Conviventi", "");
				s.append("TipologiaViolenza", "");
				s.append("AltroViolenzaRiferita", "");
				s.append("ConFigliMinori", "");
				s.append("CodiceAttributo", "");
				s.append("ReteIntraOspedaliera", "");
				s.append("SpecificoReteIntraOspedaliera", "");
				s.append("ReteExtraOspedaliera", "");
				s.append("SpecificoReteExtraOspedaliera", "");
				s.append("ForzaDellOrdine", "");
				s.append("TempiDiPrognosi", "");
				s.append("Referto", "");
				s.append("Attestazioni", "");
				s.append("CodiceRosa", "");
			}
			
			if (question.getType().equals("hospital")) {
				s.append("RuoloCompilatore", "");
				s.append("AltroRuoloCompilatore", "");
				s.append("IdentificativoServizio", "");
				s.append("AltroIdentificatoreServizio", "");
				s.append("ProvinciaProntoSoccorso", "");
				s.append("ComuneProntoSoccorso", "");
				s.append("CavNome", "");
				s.append("ProvinciaCav", "");
				s.append("ComuneCav", "");
				s.append("SportelloDiAscolto", "");
				s.append("SportelloNome", "");
				s.append("ProvinciaSportelloDiAscolto", "");
				s.append("ComuneSportelloDiAscolto", "");
				s.append("NumeroFigliMinorenniMaschi", "");
				s.append("NumeroFigliMinorenniFemmine", "");
				s.append("ConvivonoFigliFemmine", "");
				s.append("AssistonoViolenzaFigli", "");
				s.append("SubisconoViolenzaFigli", "");
				s.append("AltroStatoOccupazionaleDonna", "");
				s.append("AccessoOccasionale", "");
				s.append("DonnaAccompagnataAlServizioAntiViolenza", "");
				s.append("DonnaAccompagnataForzaDellOrdine", "");
				s.append("ProvinciaDonnaAccompagnataForzaDellOrdine", "");
				s.append("ComuneDonnaAccompagnataForzaDellOrdine", "");
				s.append("DonnaAccompagnataProntoSoccorso", "");
				s.append("ProvinciaDonnaAccompagnataProntoSoccorso", "");
				s.append("ComuneDonnaAccompagnataProntoSoccorso", "");
				s.append("SelectTipologiaViolenza", "");
				s.append("ViolenzaRiferite", "");
				s.append("AltroViolenzeRiferite", "");
				s.append("ConosciAggressore", "");
				s.append("AltroStatoOccupazionaleAggressore", "");
				s.append("ViolenzaAssistitaOSubita", "");
				s.append("FaseDiSeparazione", "");
				s.append("Separata", "");
				s.append("TempoSeparazione", "");
				s.append("HaComunicatoAlPartner", "");
				s.append("SporgereDenuncia", "");
				s.append("SportoDenuncia", "");
				s.append("SelectForzeDellOrdine", "");
				s.append("ProvinciaDenuncia", "");
				s.append("ComuneDenuncia", "");
				s.append("RitiratoDenuncia", "");
				s.append("MotivoRitiroDenuncia", "");
				s.append("ValutazioneStatoBisogno", "");
				s.append("SpecificareAltraValutazioneStatoBisogno", "");
				s.append("PresaInCarico", "");
				s.append("PrestazioniEffettuate", "");
				s.append("AttivazioneRete", "");
				s.append("AttivazioneReteProntoSoccorso", "");
				s.append("AttivazioneReteProvinciaProntoSoccorso", "");
				s.append("AttivazioneReteComuneProntoSoccorso", "");
				s.append("AttivazioneReteForzeDellOrdine", "");
				s.append("AttivazioneReteProvinciaForzeDellOrdine", "");
				s.append("AttivazioneReteComuneForzaDellOrdine", "");
				s.append("ServizioSanitarioProvincia", "");
				s.append("ServiziSocialiProvincia", "");
				
				s.append("Conviventi", question.getAnswer117());
				s.append("TipologiaViolenza", question.getAnswer118());
				s.append("AltroViolenzaRiferita", question.getAnswer119());
				s.append("ConFigliMinori", question.getAnswer120());
				s.append("CodiceAttributo", question.getAnswer121());
				s.append("ReteIntraOspedaliera", question.getAnswer122());
				s.append("SpecificoReteIntraOspedaliera", question.getAnswer123());
				s.append("ReteExtraOspedaliera", question.getAnswer124());
				s.append("SpecificoReteExtraOspedaliera", question.getAnswer125());
				s.append("ForzaDellOrdine", question.getAnswer126());
				s.append("TempiDiPrognosi", question.getAnswer127());
				s.append("Referto", question.getAnswer128());
				s.append("Attestazioni", question.getAnswer129());
				s.append("CodiceRosa", question.getAnswer130());
			}

			s.append("type", question.getType());
			s.append("status", question.getStatus());
			s.append("section", question.getSection());
			s.append("author", question.getAuthor());
			s.append("lastUpdate", new Date());
			s.append("trace", question.getTrace());

			if (question.getType().equals("hospital"))
				s.append("hospital", question.getHospital());
			else if (question.getType().equals("cav"))
				s.append("cav", question.getCav());

			if (this.retrieve(question.getAnswer1()) == null) {
				Utility.info("QUERY: create insertOne question");
				collection.insertOne(s);
			} else {
				Utility.info("QUERY: create replaceOne question ");
				collection.replaceOne(eq("IdentificativoScheda", question.getAnswer1()), s);
			}

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
	}

	@Override
	public Collection<QuestionsModel> getAll() {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					if (qs.getType().equals("hospital"))
						qs.setHospital((String) obj.get("hospital"));
					else if (qs.getType().equals("cav"))
						qs.setCav((String) obj.get("cav"));

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));					
					}

					if (qs.getType().equals("hospital")) {
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}

					collObj.add(qs);
				}
			};

			Utility.info("QUERY: getAll find all");
			collection.find().forEach(printBlock);

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	@Override
	public Collection<QuestionsModel> getBozze() {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					if (qs.getType().equals("hospital"))
						qs.setHospital((String) obj.get("hospital"));
					else if (qs.getType().equals("cav"))
						qs.setCav((String) obj.get("cav"));

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));					
					}

					if (qs.getType().equals("hospital")) {
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}

					collObj.add(qs);
				}
			};

			Utility.info("QUERY: getBozze find bozze");
			collection.find(eq("status", "bozze")).forEach(printBlock);

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	@Override
	public Collection<QuestionsModel> getInviate(JSONArray ids) {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					//TODO: change
					if (qs.getType().equals("hospital")) {
						qs.setHospital((String) obj.get("hospital"));
						qs.setCav("");
					} else if (qs.getType().equals("cav")) {
						qs.setHospital("");
						qs.setCav((String) obj.get("cav"));
					}

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));
						
						
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}

					if (qs.getType().equals("hospital")) {

						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));
						
						
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}
					collObj.add(qs);
				}
				
			};

			// TODO: change
			BasicDBObject criteria = new BasicDBObject();
			criteria.put("status", "inviata");
			ArrayList<String> list = convert(ids);
			criteria.put("IdentificativoScheda", new BasicDBObject("$in", list));

			Utility.info("QUERY: getInviate find inviata " + list);
			collection.find(criteria).forEach(printBlock);

			// collection.find(eq("status", "inviata")).forEach(printBlock);

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	@Override
	public Collection<QuestionsModel> getBozze(String author) {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					if (qs.getType().equals("hospital"))
						qs.setHospital((String) obj.get("hospital"));
					else if (qs.getType().equals("cav"))
						qs.setCav((String) obj.get("cav"));

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));
					}

					if (qs.getType().equals("hospital")) {
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}

					collObj.add(qs);
				}
			};

			Utility.info("QUERY: getBozze find bozze author");
			collection.find(and(eq("status", "bozze"), eq("author", author))).forEach(printBlock);

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	@Override
	public Collection<QuestionsModel> getInviate(String author) {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					if (qs.getType().equals("hospital"))
						qs.setHospital((String) obj.get("hospital"));
					else if (qs.getType().equals("cav"))
						qs.setCav((String) obj.get("cav"));

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));
					}

					if (qs.getType().equals("hospital")) {
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}

					collObj.add(qs);
				}
			};

			Utility.info("QUERY: getInviate find inviata author");
			collection.find(and(eq("status", "inviata"), eq("author", author))).forEach(printBlock);

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	@Override
	public Collection<QuestionsModel> getAllHospital(String hospital_name) {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					if (qs.getType().equals("hospital"))
						qs.setHospital((String) obj.get("hospital"));
					else if (qs.getType().equals("cav"))
						qs.setCav((String) obj.get("cav"));

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));
					}

					if (qs.getType().equals("hospital")) {
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}

					collObj.add(qs);
				}
			};

			Utility.info("QUERY: getAllHospital find hospital");
			collection.find(eq("type", "hospital")).forEach(printBlock);

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	@Override
	public Collection<QuestionsModel> getAllCav(String cav_name) {
		Collection<QuestionsModel> collObj = new ArrayList<QuestionsModel>();
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					QuestionsModel qs = new QuestionsModel();

					qs.setType((String) obj.get("type"));
					qs.setStatus((String) obj.get("status"));
					qs.setSection((Integer) obj.get("section"));
					qs.setAuthor((String) obj.get("author"));
					qs.setLastUpdate(obj.getDate("lastUpdate"));
					qs.setTrace((String) obj.get("trace"));

					if (qs.getType().equals("hospital"))
						qs.setHospital((String) obj.get("hospital"));
					else if (qs.getType().equals("cav"))
						qs.setCav((String) obj.get("cav"));

					qs.setAnswer1((String) obj.get("IdentificativoScheda"));
					qs.setAnswer2((String) obj.get("DataCompilazione"));
					qs.setAnswer3((String) obj.get("NomeCompilatore"));
					qs.setAnswer4((String) obj.get("CognomeCompilatore"));
					qs.setAnswer5((String) obj.get("ProntoSoccorso"));
					qs.setAnswer6((String) obj.get("NomeVittima"));
					qs.setAnswer7((String) obj.get("CognomeVittima"));
					qs.setAnswer8((String) obj.get("DataNascita"));
					qs.setAnswer9((String) obj.get("LuogoNascita"));
					qs.setAnswer10((String) obj.get("ProvinciaNascita"));
					qs.setAnswer11((String) obj.get("ComuneNascita"));
					qs.setAnswer12((String) obj.get("Indirizzo"));
					qs.setAnswer13((String) obj.get("Telefono"));
					qs.setAnswer14((String) obj.get("AltroTelefono"));
					qs.setAnswer15((String) obj.get("CittadinanzaIta"));
					qs.setAnswer16((String) obj.get("AltraCittadinanza"));
					qs.setAnswer17((String) obj.get("ConoscenzaLinguaItaliana"));
					qs.setAnswer18((String) obj.get("MediatoreCulturale"));
					qs.setAnswer19((String) obj.get("StatoCivile"));
					qs.setAnswer20((String) obj.get("AltroStatoCivile"));
					qs.setAnswer21((String) obj.get("Figli"));
					qs.setAnswer22((String) obj.get("NumeroFigli"));
					qs.setAnswer23((String) obj.get("NumeroFigliMinorenni"));
					qs.setAnswer24((String) obj.get("TitoloDiStudio"));
					qs.setAnswer25((String) obj.get("AltroTitoloDiStudio"));
					qs.setAnswer26((String) obj.get("Professione"));
					qs.setAnswer27((String) obj.get("EconomicamenteAutonomo"));
					qs.setAnswer28((String) obj.get("PrimoAccessoProntoSoccorso"));
					qs.setAnswer29((String) obj.get("NumeroAccessiRipetuti"));
					qs.setAnswer30((String) obj.get("Sfruttamento"));
					qs.setAnswer31((String) obj.get("DonnaAccompagnataInPS"));
					qs.setAnswer32((String) obj.get("AltroDonnaAccompagnataInPS"));
					qs.setAnswer33((String) obj.get("MotivoAccessoInPS"));
					qs.setAnswer34((String) obj.get("NomePresuntoAggressore"));
					qs.setAnswer35((String) obj.get("CognomePresuntoAggressore"));
					qs.setAnswer36((String) obj.get("DataNascitaPresuntoAggressore"));
					qs.setAnswer37((String) obj.get("LuogoPresuntoAggressore"));
					qs.setAnswer38((String) obj.get("ProvinciaNascitaPresuntoAggressore"));
					qs.setAnswer39((String) obj.get("ComuneNascitaPresuntoAggressore"));
					qs.setAnswer40((String) obj.get("IndirizzoPresuntoAggressore"));
					qs.setAnswer41((String) obj.get("TelefonoPresuntoAggressore"));
					qs.setAnswer42((String) obj.get("TitoloStudioPresuntoAggressore"));
					qs.setAnswer43((String) obj.get("AltroTitoloStudioPresuntoAggressore"));
					qs.setAnswer44((String) obj.get("ProfessionePresuntoAggressore"));
					qs.setAnswer45((String) obj.get("FasciaEtaPresuntoAggressore"));
					qs.setAnswer46((String) obj.get("RapportoVittimaAggressore"));
					qs.setAnswer47((String) obj.get("TipologiaFamiliare"));
					qs.setAnswer48((String) obj.get("AltroRapportoVittimaAggressore"));
					qs.setAnswer49((String) obj.get("AggressoreServizi"));
					qs.setAnswer50((String) obj.get("TipologiaServiziAggressore"));
					qs.setAnswer51((String) obj.get("AltraTipologiaServiziAggressore"));
					qs.setAnswer52((String) obj.get("PrecedentiPenali"));
					qs.setAnswer53((String) obj.get("Brief_risk1"));
					qs.setAnswer54((String) obj.get("Brief_risk2"));
					qs.setAnswer55((String) obj.get("Brief_risk3"));
					qs.setAnswer56((String) obj.get("Brief_risk4"));
					qs.setAnswer57((String) obj.get("Brief_risk5"));
					qs.setAnswer58((String) obj.get("Brief_risk6"));
					qs.setAnswer59((String) obj.get("Brief_risk7"));


					if (qs.getType().equals("cav")) {
						qs.setAnswer60((String) obj.get("RuoloCompilatore"));
						qs.setAnswer61((String) obj.get("AltroRuoloCompilatore"));
						qs.setAnswer62((String) obj.get("IdentificativoServizio"));
						qs.setAnswer63((String) obj.get("AltroIdentificativoServizio"));
						qs.setAnswer64((String) obj.get("ProvinciaPorntoSoccorso"));
						qs.setAnswer65((String) obj.get("ComuneProntoSoccorso"));
						qs.setAnswer66((String) obj.get("CavNome"));
						qs.setAnswer67((String) obj.get("PronvinciaCav"));
						qs.setAnswer68((String) obj.get("ComuneCav"));
						qs.setAnswer69((String) obj.get("SportelloDiAscolto"));
						qs.setAnswer70((String) obj.get("SportelloNome"));
						qs.setAnswer71((String) obj.get("ProvinciaSportelloDiAscolto"));
						qs.setAnswer72((String) obj.get("ComuneSportelloDiAscolto"));
						qs.setAnswer73((String) obj.get("NumeroFigliMinorenniMaschi"));
						qs.setAnswer74((String) obj.get("NumeroFigliMinorenniFemmine"));
						qs.setAnswer75((String) obj.get("ConvivonoFigliFemmine"));
						qs.setAnswer76((String) obj.get("AssistonoViolenzaFigli"));
						qs.setAnswer77((String) obj.get("SubisconoViolenzaFigli"));
						qs.setAnswer78((String) obj.get("AltroStatoOccupazionaleDonna"));
						qs.setAnswer79((String) obj.get("AccessoOccasionale"));
						qs.setAnswer80((String) obj.get("DonnaAccompagnataAlServizioAntiViolenza"));
						qs.setAnswer81((String) obj.get("DonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer82((String) obj.get("ProvinciaDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer83((String) obj.get("ComuneDonnaAccompagnataForzaDellOrdine"));
						qs.setAnswer84((String) obj.get("DonnaAccompagnataProntoSoccorso"));
						qs.setAnswer85((String) obj.get("ProvinciaDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer86((String) obj.get("ComuneDonnaAccompagnataProntoSoccorso"));
						qs.setAnswer87((String) obj.get("SelectTipologiaViolenza"));
						qs.setAnswer88((String) obj.get("ViolenzaRiferite"));
						qs.setAnswer89((String) obj.get("AltroViolenzeRiferite"));
						qs.setAnswer90((String) obj.get("ConosciAggressore"));
						qs.setAnswer91((String) obj.get("AltroStatoOccupazionaleAggressore"));
						qs.setAnswer92((String) obj.get("ViolenzaAssistitaOSubita"));
						qs.setAnswer93((String) obj.get("FaseDiSeparazione"));
						qs.setAnswer94((String) obj.get("Separata"));
						qs.setAnswer95((String) obj.get("TempoSeparazione"));
						qs.setAnswer96((String) obj.get("HaComunicatoAlPartner"));
						qs.setAnswer97((String) obj.get("SporgereDenuncia"));
						qs.setAnswer98((String) obj.get("SportoDenuncia"));
						qs.setAnswer99((String) obj.get("SelectForzeDellOrdine"));
						qs.setAnswer100((String) obj.get("ProvinciaDenuncia"));
						qs.setAnswer101((String) obj.get("ComuneDenuncia"));
						qs.setAnswer102((String) obj.get("RitiratoDenuncia"));
						qs.setAnswer103((String) obj.get("MotivoRitiroDenuncia"));
						qs.setAnswer104((String) obj.get("ValutazioneStatoBisogno"));
						qs.setAnswer105((String) obj.get("SpecificareAltraValutazioneStatoBisogno"));
						qs.setAnswer106((String) obj.get("PresaInCarico"));
						qs.setAnswer107((String) obj.get("PrestazioniEffettuate"));
						qs.setAnswer108((String) obj.get("AttivazioneRete"));
						qs.setAnswer109((String) obj.get("AttivazioneReteProntoSoccorso"));
						qs.setAnswer110((String) obj.get("AttivazioneReteProvinciaProntoSoccorso"));
						qs.setAnswer111((String) obj.get("AttivazioneReteComuneProntoSoccorso"));
						qs.setAnswer112((String) obj.get("AttivazioneReteForzeDellOrdine"));
						qs.setAnswer113((String) obj.get("AttivazioneReteProvinciaForzeDellOrdine"));
						qs.setAnswer114((String) obj.get("AttivazioneReteComuneForzaDellOrdine"));
						qs.setAnswer115((String) obj.get("ServizioSanitarioProvincia"));
						qs.setAnswer116((String) obj.get("ServiziSocialiProvincia"));
					}

					if (qs.getType().equals("hospital")) {
						qs.setAnswer117((String) obj.get("Conviventi"));
						qs.setAnswer118((String) obj.get("TipologiaViolenza"));
						qs.setAnswer119((String) obj.get("AltroViolenzaRiferita"));
						qs.setAnswer120((String) obj.get("ConFigliMinori"));
						qs.setAnswer121((String) obj.get("CodiceAttributo"));
						qs.setAnswer122((String) obj.get("ReteIntraOspedaliera"));
						qs.setAnswer123((String) obj.get("SpecificoReteIntraOspedaliera"));
						qs.setAnswer124((String) obj.get("ReteExtraOspedaliera"));
						qs.setAnswer125((String) obj.get("SpecificoReteExtraOspedaliera"));
						qs.setAnswer126((String) obj.get("ForzaDellOrdine"));
						qs.setAnswer127((String) obj.get("TempiDiPrognosi"));
						qs.setAnswer128((String) obj.get("Referto"));
						qs.setAnswer129((String) obj.get("Attestazioni"));
						qs.setAnswer130((String) obj.get("CodiceRosa"));
					}

					collObj.add(qs);
				}
			};

			Utility.info("QUERY: getAllCav find cav");
			collection.find(eq("type", "cav")).forEach(printBlock);

			DBMongoConnectionPool.close(client);

		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}
	
	@Override
	public void delete(String id_question) {
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Utility.info("QUERY: delete deleteMany");
			collection.deleteMany(eq("IdentificativoScheda", id_question));

			DBMongoConnectionPool.close(client);
		} catch (UnknownHostException e) {
			Utility.exception(e);
		}

	}
	
	@Override
	public String getNomeChart(String campo, String id) {
		Document obj = null;
		String answer = null;
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Utility.info("QUERY: getNomeChart find " + campo);
			obj = collection.find(eq(campo, id)).first();
		
			if (obj != null) {
					answer = (String) obj.get(campo);
				
			}

			DBMongoConnectionPool.close(client);
		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return answer;
	}
	

	@Override
	public Collection<ReportsModel> report(String type, String status, String description, String campo, String provincia) {
		if (description.equals("donut") || description.equals("world_map")) {
			ArrayList<ReportsModel> list = new ArrayList<ReportsModel>();

			try {
				if (type.equals("hospital")) {
					MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
					MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

					AggregateIterable<Document> iterable = collection.aggregate(
							Arrays.asList(new Document("$match", new Document("type", type).append("status", status)),
									new Document("$group",
											new Document("_id", "$" + campo).append("total", new Document("$sum", 1)))));
					
					Block<Document> printBlock = new Block<Document>() {
						@Override
						public void apply(final Document doc) {
							Utility.info("REPORT: " + doc.get("_id") + " " + doc.get("total"));
							
							QuestionsDao questiondao = new QuestionsDao();
							String nome = questiondao.getNomeChart(campo,(String) doc.get("_id"));
							if(nome != null)
								if(!nome.equals("")) {
								list.add(new ReportsModel(nome, doc.get("total").toString(), campo));
								}
						}
					};

					iterable.forEach(printBlock);

					DBMongoConnectionPool.close(client);
				} else if (type.equals("cav")) {
					MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
					MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

					AggregateIterable<Document> iterable = collection.aggregate(
							Arrays.asList(new Document("$match", new Document("type", type).append("status", status)),
									new Document("$group",
											new Document("_id", "$" + campo).append("total", new Document("$sum", 1)))));
					
					Block<Document> printBlock = new Block<Document>() {
						@Override
						public void apply(final Document doc) {
							Utility.info("REPORT: " + doc.get("_id") + " " + doc.get("total"));
							
							QuestionsDao questiondao = new QuestionsDao();
							String nome = questiondao.getNomeChart(campo,(String) doc.get("_id"));
							if(nome != null)
								if(!nome.equals("")) {
									list.add(new ReportsModel(nome, doc.get("total").toString(), campo));
								}
						}
					};

					iterable.forEach(printBlock);

					DBMongoConnectionPool.close(client);
				}

			} catch (UnknownHostException e) {
				Utility.exception(e);
			}

			return list;
		} 
		else if(description.equals("calendar")) 
		{
			ArrayList<ReportsModel> list = new ArrayList<ReportsModel>();

			try {
				if (type.equals("cav")) {
					MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
					MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

					AggregateIterable<Document> iterable = collection.aggregate(
							Arrays.asList(new Document("$match", new Document("type", type).append("status", status)),
									new Document("$group",
											new Document("_id", "$" + campo).append("total", new Document("$sum", 1)))));
					
					Block<Document> printBlock = new Block<Document>() {
						@Override
						public void apply(final Document doc) {
							Utility.info("REPORT: " + doc.get("_id") + " " + doc.get("total"));
							
							QuestionsDao questiondao = new QuestionsDao();
							String nome = questiondao.getNomeChart(campo,(String) doc.get("_id"));
							if(nome != null)
								if(!nome.equals("")) {
								String[] data = nome.split("/");
								String giorno = data[0];
								String mese = data[1];
								String anno = data[2];
								list.add(new ReportsModel(Integer.parseInt(giorno),Integer.parseInt(mese),Integer.parseInt(anno), doc.get("total").toString()));								
							}
							
						}
					};

					iterable.forEach(printBlock);

					DBMongoConnectionPool.close(client);
				} else if (type.equals("hospital")) {
					MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
					MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

					AggregateIterable<Document> iterable = collection.aggregate(
							Arrays.asList(new Document("$match", new Document("type", type).append("status", status)),
									new Document("$group",
											new Document("_id", "$" + campo).append("total", new Document("$sum", 1)))));
					
					Block<Document> printBlock = new Block<Document>() {
						@Override
						public void apply(final Document doc) {
							Utility.info("REPORT: " + doc.get("_id") + " " + doc.get("total"));
							
							QuestionsDao questiondao = new QuestionsDao();
							String nome = questiondao.getNomeChart(campo,(String) doc.get("_id"));
							if(nome != null)
								if(!nome.equals("")) {
								String[] data = nome.split("/");
								String giorno = data[0];
								String mese = data[1];
								String anno = data[2];
								list.add(new ReportsModel(Integer.parseInt(giorno),Integer.parseInt(mese),Integer.parseInt(anno), doc.get("total").toString()));								
							}
							
						}
					};

					iterable.forEach(printBlock);

					DBMongoConnectionPool.close(client);
				}
				
			} 
			catch (UnknownHostException e) {
			Utility.exception(e);
			}

		return list;	
		}
		
		//
		else if(description.equals("istogramma")) 
		{
			ArrayList<ReportsModel> list = new ArrayList<ReportsModel>();

			try {
				if (type.equals("cav")) {
					MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
					MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);
					
					AggregateIterable<Document> iterable = collection.aggregate(
							Arrays.asList(new Document("$match", new Document("type", type).append("status", status)),
									new Document("$group",
											new Document("_id", "$" + campo).append("total", new Document("$sum", 1)))));
					
					Block<Document> printBlock = new Block<Document>() {
						@Override
						public void apply(final Document doc) {
							Utility.info("REPORT: " + doc.get("_id") + " " + doc.get("total"));
							
							QuestionsDao questiondao = new QuestionsDao();
							Collection<String> collDate = questiondao.getIstoGram(campo,(String) doc.get("_id"),provincia, type);
							int count = 0;
							if(collDate != null)
							{
								for(String date : collDate)
								{
									String[] data = date.split("/");
									String anno = data[2];
									
									for(String date2 : collDate)
									{
										String[] data2 = date2.split("/");
										String anno2 = data2[2];
										if(anno.equals(anno2))
											count++;
									}
									list.add(new ReportsModel(provincia, anno, campo));
									count = 0;
								}
								
							}							
						}
					};

					iterable.forEach(printBlock);

					DBMongoConnectionPool.close(client);
				} else if (type.equals("hospital")) {
					MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
					MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);
					
					AggregateIterable<Document> iterable = collection.aggregate(
							Arrays.asList(new Document("$match", new Document("type", type).append("status", status)),
									new Document("$group",
											new Document("_id", "$" + campo).append("total", new Document("$sum", 1)))));
					
					Block<Document> printBlock = new Block<Document>() {
						@Override
						public void apply(final Document doc) {
							Utility.info("REPORT: " + doc.get("_id") + " " + doc.get("total"));
							
							QuestionsDao questiondao = new QuestionsDao();
							Collection<String> collDate = questiondao.getIstoGram(campo,(String) doc.get("_id"),provincia, type);
							int count = 0;
							if(collDate != null)
							{
								for(String date : collDate)
								{
									String[] data = date.split("/");
									String anno = data[2];
									
									for(String date2 : collDate)
									{
										String[] data2 = date2.split("/");
										String anno2 = data2[2];
										if(anno.equals(anno2))
											count++;
									}
									list.add(new ReportsModel(provincia, anno, campo));
									count = 0;
								}
								
							}							
						}
					};

					iterable.forEach(printBlock);

					DBMongoConnectionPool.close(client);
				}
				
			} 
			catch (UnknownHostException e) {
			Utility.exception(e);
			}

		return list;	
		}
		//
		
		else {
			
		}
		return null;
	}
	
	@Override
	public Collection<String> getIstoGram(String campo, String id, String provincia, String type) {
		//
		
		Collection<String> collObj = new ArrayList<String>();		
		System.out.println("Provincia = "+ provincia);
		try {
			MongoClient client = DBMongoConnectionPool.createMongoDBConnection();
			MongoCollection<Document> collection = DBMongoConnectionPool.selectCollection(client);

			Block<Document> printBlock = new Block<Document>() {
				@Override
				public void apply(final Document obj) {
					String answer = null;
					if(type.equals("cav"))
					{
						if(provincia.equals((String) obj.get("ServiziSocialiProvincia")) || provincia.equals((String) obj.get("ProvinciaProntoSoccorso")) || provincia.equals((String) obj.get("ProvinciaCav")) || provincia.equals((String) obj.get("ProvinciaSportelloDiAscolto")))
						{
					
							answer = (String) obj.get("DataCompilazione");		
						
							collObj.add(answer);
						}
					}
					//
					else if(type.equals("hospital"))
					{
						if(provincia.equals((String) obj.get("ServiziSocialiProvincia")) || provincia.equals((String) obj.get("ProvinciaProntoSoccorso")) || provincia.equals((String) obj.get("ProvinciaCav")) || provincia.equals((String) obj.get("ProvinciaSportelloDiAscolto")))
						{
					
							answer = (String) obj.get("DataCompilazione");		
						
							collObj.add(answer);
						}
					}
					//
				}
			};
			
			collection.find(eq(campo, id)).forEach(printBlock);
			
			DBMongoConnectionPool.close(client);
		} catch (UnknownHostException e) {
			Utility.exception(e);
		}
		return collObj;
	}

	private ArrayList<String> convert(JSONArray arr) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			for (int i = 0, l = arr.length(); i < l; i++) {
				list.add((String) arr.get(i));
			}
		} catch (JSONException e) {
		}

		return list;
	}
}
