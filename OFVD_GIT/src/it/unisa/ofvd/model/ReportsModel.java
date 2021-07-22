package it.unisa.ofvd.model;


public class ReportsModel {

	private String descrizione;
	private String count;
	private String campo;
	private int giorno;
	private int mese;
	private int anno;

	public ReportsModel(String descrizione, String count, String campo) {
		this.descrizione = descrizione;
		this.count = count;
		this.campo = campo;
	}

	public ReportsModel(int giorno,int mese,int anno, String count) {
		this.giorno = giorno;
		this.mese = mese;
		this.anno = anno;
		this.count = count;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getCampo() {
		return campo;
	}

	public void setCampo(String campo) {
		this.campo = campo;
	}

	public int getGiorno() {
		return giorno;
	}

	public void setGiorno(int giorno) {
		this.giorno = giorno;
	}

	public int getMese() {
		return mese;
	}

	public void setMese(int mese) {
		this.mese = mese;
	}

	public int getAnno() {
		return anno;
	}

	public void setAnno(int anno) {
		this.anno = anno;
	}
}
