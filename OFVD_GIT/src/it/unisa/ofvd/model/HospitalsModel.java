package it.unisa.ofvd.model;

public class HospitalsModel {
	private String id;
	private String nome;
	private String email;
	private String telefono;
	private String telefono1;
	private String indirizzo;

	public HospitalsModel() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	@Override
	public String toString() {
		return "HospitalsModel [id=" + id + ", nome=" + nome + ", email=" + email + ", telefono=" + telefono
				+ ", telefono=" + telefono1 + ", indirizzo=" + indirizzo + "]";
	}

}
