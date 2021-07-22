package it.unisa.ofvd.model;

import it.unisa.ofvd.utils.Utility;

public class AccountsModel {

	private String matricola;
	private String nome;
	private String cognome;
	private String email;
	private String password;
	private String new_password;
	private String hospital;
	private String cav;
	private String admin;
	private String telefono;
	private String telefono1;	
	private String type;
	private Boolean defaultPassword;

	public AccountsModel() {
	}

	public AccountsModel(String matricola, String nome, String cognome, String email, String password, String hospital,
			String cav, String admin, String telefono, String telefono1, String newPassword) {
		this.matricola = matricola;
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.password = password;
		this.hospital = hospital;
		this.cav = cav;
		this.admin = admin;
		this.telefono = telefono;
		this.telefono1 = telefono1;
		this.new_password = newPassword;
		this.type = null;
		this.defaultPassword = true;
	}

	public String getNew_password() {
		return new_password;
	}

	public void setNew_password(String new_password) {
		this.new_password = new_password;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setAdministrator() {
		setType("amministratore");
	}	
	
	public void setHospitalUser() {
		setType("utente_ospedale");
	}		
	
	public void setCavUser() {
		setType("utente_antiviolenza");
	}	
	
	public void setType() {
		if ((this.admin == null || this.admin == "") && (this.hospital == null || this.hospital == "")
				&& (this.cav == null || this.cav == "")) {
			setAdministrator();
			return;
		} else if ((this.admin != null || this.admin != "") && (this.hospital != null || this.hospital != "")
				&& (this.cav == null || this.cav == "")) {
			setHospitalUser();
			return;
		} else if ((this.admin != null || this.admin != "") && (this.hospital == null || this.hospital == "")
				&& (this.cav != null || this.cav != "")) {
			setCavUser();
			return;
		}

		// TODO: eliminare
		throw new RuntimeException("Utente non definito: " + this.toString());
	}

	public String getPrintType() {
		String str = getType();
		if (str == null)
			return "";
		
		str = str.replace("_", " ");
		str = Utility.capitalizeString(str);
		return str;
	}	
	
	public boolean isAdministrator() {
		return type != null && type.equals("amministratore");
	}

	public boolean isHospitalUser() {
		return type != null && type.equals("utente_ospedale");
	}

	public boolean isCavUser() {
		return type != null && type.equals("utente_antiviolenza");
	}

	public String getMatricola() {
		return matricola;
	}

	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getTelefono1() {
		return telefono1;
	}

	public void setTelefono1(String telefono1) {
		this.telefono1 = telefono1;
	}	
	
	public Boolean getDefaultPassword() {
		return defaultPassword;
	}

	public void setDefaultPassword(Boolean defaultPassword) {
		this.defaultPassword = defaultPassword;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public String getCav() {
		return cav;
	}

	public void setCav(String cav) {
		this.cav = cav;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	@Override
	public String toString() {
		return "AccountsModel [matricola=" + matricola + ", nome=" + nome + ", cognome=" + cognome + ", email=" + email
				+ ", password=" + password + ", new_password=" + new_password + ", hospital=" + hospital + ", cav="
				+ cav + ", admin=" + admin + ", telefono=" + telefono + ", telefono=" + telefono1 + ", type=" + type + ", defaultPassword="
				+ defaultPassword + "]";
	}
}
