package it.unisa.ofvd.model;

public class EmailMessage {

	// The blind courtesy copy email addresses.
	private String blindCourtesyCopyAddresses;

	// The carbon copy e-mail addresses.
	private String carbonCopyAddresses;

	// The receiver e-mail addresses.
	private String receiverAddresses;

	// The e-mail subject.
	private String subject;

	// The e-mail message.
	private String text;

	private boolean ssl;

	public EmailMessage() {
		ssl = false;
	}

	public String getBlindCourtesyCopyAddresses() {
		return this.blindCourtesyCopyAddresses;
	}

	public String getCarbonCopyAddresses() {
		return this.carbonCopyAddresses;
	}

	public String getReceiverAddresses() {
		return receiverAddresses;
	}

	public String getSubject() {
		return subject;
	}

	public String getText() {
		return text;
	}

	public void setBlindCourtesyCopyAddress(String pBlindCourtesyCopyAddresses) {
		this.blindCourtesyCopyAddresses = pBlindCourtesyCopyAddresses;
	}

	public void setCarbonCopyAddress(String pCarbonCopyAddresses) {
		this.carbonCopyAddresses = pCarbonCopyAddresses;
	}

	public void setReceiverAddresses(String pReceiverAddresses) {
		this.receiverAddresses = pReceiverAddresses;
	}

	public void setSubject(String pSubject) {
		this.subject = pSubject;
	}

	public void setText(String pText) {
		this.text = pText;
	}

	public boolean isSsl() {
		return ssl;
	}

	public void setSsl(boolean ssl) {
		this.ssl = ssl;
	}

	public String toString() {
		String str = this.receiverAddresses + "\n";
		str += this.carbonCopyAddresses + "\n";
		str += this.blindCourtesyCopyAddresses + "\n";
		str += this.subject + "\n";
		str += this.text + "\n";
		return str;
	}
}