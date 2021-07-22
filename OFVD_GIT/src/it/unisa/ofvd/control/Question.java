package it.unisa.ofvd.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import it.unisa.ofvd.model.AccountsModel;

import it.unisa.ofvd.model.QuestionsModel;
import it.unisa.ofvd.model.ReportsModel;
import it.unisa.ofvd.model.dao.QuestionsDao;
import it.unisa.ofvd.utils.Utility;

/**
 * Servlet implementation class Question
 */
@WebServlet("/Question")
public class Question extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountsModel account;
	private JSONObject obj;
	private QuestionsModel qs = null;
	private Collection<ReportsModel> report = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

		account = (AccountsModel) request.getSession().getAttribute("account");
		if (account == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		String json = request.getParameter("elements");
		if (json != null) {

			try {
				this.obj = new JSONObject(json);

				// TODO: change				
				synchronized (obj) {
					dispatcher((String) obj.get("action"));

					if (obj.get("action").equals("viewDraft") || obj.get("action").equals("editDraft")) {
						String questionJsonString = new Gson().toJson(qs);
						PrintWriter out = null;
						try {
							out = response.getWriter();
						} catch (IOException e) {
							Utility.exception(e);
						}
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print(questionJsonString);
						out.flush();
						return;
					} else if (obj.get("action").equals("report")) {
						String questionJsonString = new Gson().toJson(report);
						PrintWriter out = null;
						try {
							out = response.getWriter();
						} catch (IOException e) {
							Utility.exception(e);
						}
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print(questionJsonString);
						out.flush();
						return;
					} else if (obj.get("action").equals("export")) {

						JSONArray ids = (JSONArray) obj.get("ids");

						QuestionsDao qall = new QuestionsDao();
						Collection<QuestionsModel> all = qall.getInviate(ids); // getAll();

						String questionJsonString = new Gson().toJson(all);
						PrintWriter out = null;
						try {
							out = response.getWriter();
						} catch (IOException e) {
							Utility.exception(e);
						}
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print(questionJsonString);
						out.flush();
						return;
					}
				}
			} catch (JSONException e) {
				Utility.exception(e);
			}
		}

		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	private void dispatcher(String type) {
		if (type.equals("compiled"))
			formatQuestion();
		else if (type.equals("removeDraft"))
			deleteDraft((String) this.obj.get("answer1"));
		else if (type.equals("viewDraft")) {
			viewDraft((String) this.obj.get("answer1"));
		} else if (type.equals("editDraft")) {
			viewDraft((String) this.obj.get("answer1"));
		} else if (type.equals("report")) {
			report((String) this.obj.get("type"), (String) this.obj.get("status"),
					(String) this.obj.get("description"), (String) this.obj.get("campo"), (String) this.obj.get("provincia"));
		} else if (type.equals("changeState")) {
			changeState((String) this.obj.get("answer1"));
		}
	}

	private void formatQuestion() {
		//qs = new QuestionsModel();

		QuestionsDao qd = new QuestionsDao();
		qs = qd.retrieve((String)this.obj.get("answer1"));
		if(qs == null)
			qs = new QuestionsModel();
		
		int section = (Integer) obj.get("section");

		if (account.isHospitalUser())
			qs.setType("hospital");
		else
			qs.setType("cav");

		qs.setSection(section);

		if (qs.getType().equals("hospital")) {
			for (int i = 1; i <= section; i++) {

				if (i == 1) {
					qs.setStatus("bozze");
					qs.setAuthor(this.account.getEmail());
					qs.setHospital(this.account.getHospital());

					qs.setAnswer1((String) this.obj.get("answer1"));
					qs.setAnswer2((String) this.obj.get("answer2"));
					qs.setAnswer5((String) this.obj.get("answer3"));
					qs.setAnswer3((String) this.obj.get("answer4"));
					qs.setAnswer4((String) this.obj.get("answer5"));
				} else if (i == 2) {
					String a6 = (String) this.obj.get("answer6");
					String a7 = (String) this.obj.get("answer7");
					String a9 = (String) this.obj.get("answer9");
					String a8 = (String) this.obj.get("answer8");
					if (!Utility.isEncodedCrypt(a6) && !Utility.isEncodedCrypt(a7) && !Utility.isEncodedCrypt(a8)) {
						String trace = Utility.generateTrace(a6, a7, a9, a8);
						if(!trace.equals(""))
							qs.setTrace(trace);
					}

					qs.setAnswer6(Utility.encodeCrypt(a6));
					qs.setAnswer7(Utility.encodeCrypt(a7));
					qs.setAnswer8(Utility.encodeCrypt(a8));
					qs.setAnswer9((String) this.obj.get("answer9"));
					qs.setAnswer10((String) this.obj.get("answer10"));
					qs.setAnswer11((String) this.obj.get("answer11"));					
					qs.setAnswer12(Utility.encodeCrypt((String) this.obj.get("answer12")));
					qs.setAnswer13(Utility.encodeCrypt((String) this.obj.get("answer13")));
					qs.setAnswer14(Utility.encodeCrypt((String) this.obj.get("answer14")));		
					qs.setAnswer15((String) this.obj.get("answer15"));
					qs.setAnswer16((String) this.obj.get("answer16"));
					qs.setAnswer17((String) this.obj.get("answer17"));
					qs.setAnswer18((String) this.obj.get("answer18"));
					qs.setAnswer19((String) this.obj.get("answer19"));
					qs.setAnswer20((String) this.obj.get("answer20"));
					qs.setAnswer21((String) this.obj.get("answer21"));
					qs.setAnswer22((String) this.obj.get("answer22"));
					qs.setAnswer23((String) this.obj.get("answer23"));
					qs.setAnswer117((String) this.obj.get("answer24"));
					qs.setAnswer24((String) this.obj.get("answer25"));
					qs.setAnswer25((String) this.obj.get("answer26"));
					qs.setAnswer26((String) this.obj.get("answer27"));
					qs.setAnswer27((String) this.obj.get("answer28"));
				} else if (i == 3) {
					qs.setAnswer28((String) this.obj.get("answer29"));
					qs.setAnswer29((String) this.obj.get("answer30"));
					qs.setAnswer118((String) this.obj.get("answer31"));
					qs.setAnswer119((String) this.obj.get("answer32"));
					qs.setAnswer30((String) this.obj.get("answer33"));
					qs.setAnswer120((String) this.obj.get("answer34"));
					qs.setAnswer31((String) this.obj.get("answer35"));
					qs.setAnswer32((String) this.obj.get("answer36"));
					qs.setAnswer33((String) this.obj.get("answer37"));
					qs.setAnswer121((String) this.obj.get("answer38"));
				} else if (i == 4) {
					qs.setAnswer34(Utility.encodeCrypt((String) this.obj.get("answer39")));
					qs.setAnswer35(Utility.encodeCrypt((String) this.obj.get("answer40")));
					qs.setAnswer36(Utility.encodeCrypt((String) this.obj.get("answer41")));
					qs.setAnswer37((String) this.obj.get("answer42"));
					qs.setAnswer38((String) this.obj.get("answer43"));
					qs.setAnswer39((String) this.obj.get("answer44"));
					qs.setAnswer40(Utility.encodeCrypt((String) this.obj.get("answer45")));
					qs.setAnswer41(Utility.encodeCrypt((String) this.obj.get("answer46")));
					qs.setAnswer42((String) this.obj.get("answer47"));
					qs.setAnswer43((String) this.obj.get("answer48"));
					qs.setAnswer44((String) this.obj.get("answer49"));
					qs.setAnswer45((String) this.obj.get("answer50"));
					qs.setAnswer46((String) this.obj.get("answer51"));
					qs.setAnswer47((String) this.obj.get("answer52"));
					qs.setAnswer48((String) this.obj.get("answer53"));
					qs.setAnswer49((String) this.obj.get("answer54"));
					qs.setAnswer50((String) this.obj.get("answer55"));
					qs.setAnswer51((String) this.obj.get("answer56"));
					qs.setAnswer52((String) this.obj.get("answer57"));
				} else if (i == 5) {
					qs.setAnswer53((String) this.obj.get("answer58"));
					qs.setAnswer54((String) this.obj.get("answer59"));
					qs.setAnswer55((String) this.obj.get("answer60"));
					qs.setAnswer56((String) this.obj.get("answer61"));
					qs.setAnswer57((String) this.obj.get("answer62"));
					qs.setAnswer58((String) this.obj.get("answer63"));
					qs.setAnswer59((String) this.obj.get("answer64"));
					qs.setAnswer122((String) this.obj.get("answer65"));
					qs.setAnswer123((String) this.obj.get("answer66"));
					qs.setAnswer124((String) this.obj.get("answer67"));
					qs.setAnswer125((String) this.obj.get("answer68"));
					qs.setAnswer126((String) this.obj.get("answer69"));
					qs.setAnswer127((String) this.obj.get("answer70"));
					qs.setAnswer128((String) this.obj.get("answer71"));
					qs.setAnswer129((String) this.obj.get("answer72"));
					qs.setAnswer130((String) this.obj.get("answer73"));
					qs.setStatus("inviata");
				}
			}
		} else {
			// CAV
			for (int i = 1; i <= section; i++) {
				if (i == 1) {
					qs.setStatus("bozze");

					qs.setAuthor(this.account.getEmail());

					qs.setCav(this.account.getCav());

					qs.setAnswer1((String) this.obj.get("answer1"));
					qs.setAnswer2((String) this.obj.get("answer2"));
					qs.setAnswer3((String) this.obj.get("answer3"));
					qs.setAnswer4((String) this.obj.get("answer4"));
					qs.setAnswer60((String) this.obj.get("answer5"));
					qs.setAnswer61((String) this.obj.get("answer6"));
					qs.setAnswer62((String) this.obj.get("answer7"));
					qs.setAnswer63((String) this.obj.get("answer8"));
					qs.setAnswer5((String) this.obj.get("answer9"));
					qs.setAnswer64((String) this.obj.get("answer10"));
					qs.setAnswer65((String) this.obj.get("answer11"));
					qs.setAnswer66((String) this.obj.get("answer12"));
					qs.setAnswer67((String) this.obj.get("answer13"));
					qs.setAnswer68((String) this.obj.get("answer14"));
					qs.setAnswer69((String) this.obj.get("answer15"));
					qs.setAnswer70((String) this.obj.get("answer16"));
					qs.setAnswer71((String) this.obj.get("answer17"));
					qs.setAnswer72((String) this.obj.get("answer18"));

				} else if (i == 2) {
					String a19 = (String) this.obj.get("answer19");
					String a20 = (String) this.obj.get("answer20");
					String a21 = (String) this.obj.get("answer21");
					String a22 = (String) this.obj.get("answer22");
					if (!Utility.isEncodedCrypt(a19) && !Utility.isEncodedCrypt(a20) && !Utility.isEncodedCrypt(a21)) {
						String trace = Utility.generateTrace(a19, a20, a22, a21);
						if(!trace.equals(""))
							qs.setTrace(trace);
					}					

					qs.setAnswer6(Utility.encodeCrypt((String) this.obj.get("answer19")));
					qs.setAnswer7(Utility.encodeCrypt((String) this.obj.get("answer20")));
					qs.setAnswer8(Utility.encodeCrypt((String) this.obj.get("answer21")));
					
					qs.setAnswer9((String) this.obj.get("answer22"));
					qs.setAnswer10((String) this.obj.get("answer23"));
					qs.setAnswer11((String) this.obj.get("answer24"));
					
					qs.setAnswer12(Utility.encodeCrypt((String) this.obj.get("answer25")));
					qs.setAnswer13(Utility.encodeCrypt((String) this.obj.get("answer26")));
					qs.setAnswer14(Utility.encodeCrypt((String) this.obj.get("answer27")));
					
					qs.setAnswer15((String) this.obj.get("answer28"));
					qs.setAnswer16((String) this.obj.get("answer29"));
					qs.setAnswer17((String) this.obj.get("answer30"));
					qs.setAnswer18((String) this.obj.get("answer31"));
					qs.setAnswer19((String) this.obj.get("answer32"));
					qs.setAnswer20((String) this.obj.get("answer33"));
					qs.setAnswer21((String) this.obj.get("answer34"));
					qs.setAnswer22((String) this.obj.get("answer35"));
					qs.setAnswer23((String) this.obj.get("answer36"));
					qs.setAnswer73((String) this.obj.get("answer37"));
					qs.setAnswer74((String) this.obj.get("answer38"));
					qs.setAnswer75((String) this.obj.get("answer39"));
					qs.setAnswer76((String) this.obj.get("answer40"));
					qs.setAnswer77((String) this.obj.get("answer41"));
					qs.setAnswer24((String) this.obj.get("answer42"));
					qs.setAnswer25((String) this.obj.get("answer43"));
					qs.setAnswer26((String) this.obj.get("answer44"));
					qs.setAnswer78((String) this.obj.get("answer45"));
					qs.setAnswer27((String) this.obj.get("answer46"));
				} else if (i == 3) {
					qs.setAnswer28((String) this.obj.get("answer47"));
					qs.setAnswer29((String) this.obj.get("answer48"));
					qs.setAnswer79((String) this.obj.get("answer49"));
					qs.setAnswer80((String) this.obj.get("answer50"));
					qs.setAnswer81((String) this.obj.get("answer51"));
					qs.setAnswer82((String) this.obj.get("answer52"));
					qs.setAnswer83((String) this.obj.get("answer53"));
					qs.setAnswer84((String) this.obj.get("answer54"));
					qs.setAnswer85((String) this.obj.get("answer55"));
					qs.setAnswer86((String) this.obj.get("answer56"));
					qs.setAnswer31((String) this.obj.get("answer57"));
					qs.setAnswer32((String) this.obj.get("answer58"));
					qs.setAnswer33((String) this.obj.get("answer59"));
					qs.setAnswer87((String) this.obj.get("answer60"));
					qs.setAnswer30((String) this.obj.get("answer61"));
					qs.setAnswer88((String) this.obj.get("answer62"));
					qs.setAnswer89((String) this.obj.get("answer63"));
				} else if (i == 4) {
					qs.setAnswer90((String) this.obj.get("answer64"));
					
					qs.setAnswer34(Utility.encodeCrypt((String) this.obj.get("answer65")));
					qs.setAnswer35(Utility.encodeCrypt((String) this.obj.get("answer66")));
					qs.setAnswer36(Utility.encodeCrypt((String) this.obj.get("answer67")));
					
					qs.setAnswer37((String) this.obj.get("answer68"));
					qs.setAnswer38((String) this.obj.get("answer69"));
					qs.setAnswer39((String) this.obj.get("answer70"));
					
					qs.setAnswer40(Utility.encodeCrypt((String) this.obj.get("answer71")));
					qs.setAnswer41(Utility.encodeCrypt((String) this.obj.get("answer72")));
					
					
					qs.setAnswer42((String) this.obj.get("answer73"));
					qs.setAnswer43((String) this.obj.get("answer74"));
					qs.setAnswer44((String) this.obj.get("answer75"));
					qs.setAnswer91((String) this.obj.get("answer76"));
					qs.setAnswer45((String) this.obj.get("answer77"));
					qs.setAnswer46((String) this.obj.get("answer78"));
					qs.setAnswer47((String) this.obj.get("answer79"));
					qs.setAnswer48((String) this.obj.get("answer80"));
					qs.setAnswer49((String) this.obj.get("answer81"));
					qs.setAnswer50((String) this.obj.get("answer82"));
					qs.setAnswer51((String) this.obj.get("answer83"));
					qs.setAnswer92((String) this.obj.get("answer84"));
					qs.setAnswer52((String) this.obj.get("answer85"));
				} else if (i == 5) {
					qs.setStatus("inviata");
					qs.setAnswer53((String) this.obj.get("answer86"));
					qs.setAnswer54((String) this.obj.get("answer87"));
					qs.setAnswer55((String) this.obj.get("answer88"));
					qs.setAnswer56((String) this.obj.get("answer89"));
					qs.setAnswer57((String) this.obj.get("answer90"));
					qs.setAnswer58((String) this.obj.get("answer91"));
					qs.setAnswer59((String) this.obj.get("answer92"));
					qs.setAnswer93((String) this.obj.get("answer93"));
					qs.setAnswer94((String) this.obj.get("answer94"));
					qs.setAnswer95((String) this.obj.get("answer95"));
					qs.setAnswer96((String) this.obj.get("answer96"));
					qs.setAnswer97((String) this.obj.get("answer97"));
					qs.setAnswer98((String) this.obj.get("answer98"));
					qs.setAnswer99((String) this.obj.get("answer99"));
					qs.setAnswer100((String) this.obj.get("answer100"));
					qs.setAnswer101((String) this.obj.get("answer101"));
					qs.setAnswer102((String) this.obj.get("answer102"));
					qs.setAnswer103((String) this.obj.get("answer103"));
					qs.setAnswer104((String) this.obj.get("answer104"));
					qs.setAnswer105((String) this.obj.get("answer105"));
					qs.setAnswer106((String) this.obj.get("answer106"));
					qs.setAnswer107((String) this.obj.get("answer107"));
					qs.setAnswer108((String) this.obj.get("answer108"));
					qs.setAnswer109((String) this.obj.get("answer109"));
					qs.setAnswer110((String) this.obj.get("answer110"));
					qs.setAnswer111((String) this.obj.get("answer111"));
					qs.setAnswer112((String) this.obj.get("answer112"));
					qs.setAnswer113((String) this.obj.get("answer113"));
					qs.setAnswer114((String) this.obj.get("answer114"));
					qs.setAnswer115((String) this.obj.get("answer115"));
					qs.setAnswer116((String) this.obj.get("answer116"));
				}
			}
		}
		QuestionsDao question = new QuestionsDao();
		question.create(qs);
	}

	private void deleteDraft(String id_question) {
		QuestionsDao question = new QuestionsDao();
		question.delete(id_question);
	}

	private void viewDraft(String id_question) {
		QuestionsDao question = new QuestionsDao();
		qs = question.retrieve(id_question);
	}

	private void report(String type, String status, String description, String campo, String provincia) {

		QuestionsDao question = new QuestionsDao();
		if (description.equals("donut") || description.equals("world_map") || description.contentEquals("calendar") || description.contentEquals("istogramma"))
			this.report = question.report(type, status, description, campo, provincia);
	}

	private void changeState(String id_question) {
		QuestionsDao question = new QuestionsDao();
		question.changeStatus(id_question);
	}
}
