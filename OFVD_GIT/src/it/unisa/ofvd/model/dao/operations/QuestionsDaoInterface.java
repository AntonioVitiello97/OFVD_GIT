package it.unisa.ofvd.model.dao.operations;

import java.util.Collection;

import org.json.JSONArray;

import it.unisa.ofvd.model.QuestionsModel;
import it.unisa.ofvd.model.ReportsModel;

public interface QuestionsDaoInterface {

	public Collection<QuestionsModel> getAll();

	// inviata --> bozze
	public void changeStatus(String id_question);

	public QuestionsModel retrieve(String id_question);

	public void create(QuestionsModel question);

	public Collection<QuestionsModel> getBozze();

	//TODO: change
	public Collection<QuestionsModel> getInviate(JSONArray ids);

	public Collection<QuestionsModel> getBozze(String author);

	public Collection<QuestionsModel> getInviate(String author);

	public Collection<QuestionsModel> getAllHospital(String hospital_name);

	public Collection<QuestionsModel> getAllCav(String cav_name);

	public void delete(String id_question);
	
	public String getNomeChart(String campo, String id); 
	
	public Collection<String> getIstoGram(String campo, String id, String provincia, String type);
	
	public Collection<ReportsModel> report(String type, String status, String description, String campo, String provincia);
	
	public Collection<QuestionsModel> checkTrace(String trace, String avoid);
}
