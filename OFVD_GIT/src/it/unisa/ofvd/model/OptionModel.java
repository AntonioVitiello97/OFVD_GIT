package it.unisa.ofvd.model;

/**
 * This class implements an object to manage a school preferences. type: 0
 * string; 1 numeric; 2 date; 3 time; 4 boolean; 5 color; 6 month; 7 day; 8
 * year; 9 datetime;
 */
public class OptionModel {

	private String key;
	private String module;
	private String label;
	private String value;
	private int type;
	private boolean modifiable;

	public OptionModel() {
		this.key = "";
		this.module = "";
		this.label = "";
		this.value = "NaN";
		this.type = 0;
		this.modifiable = false;
	}

	public OptionModel(String key, String module, String label, String value, boolean modifiable) {
		this.key = key;
		this.module = module;
		this.label = label;
		this.value = value;
		this.type = 0;
		this.modifiable = modifiable;
	}

	public OptionModel(String key, String module, String label, String value, int type, boolean modifiable) {
		this(key, module, label, value, modifiable);
		this.type = type;
	}

	public boolean isModifiable() {
		return (modifiable == true);
	}

	public boolean isValid() {
		return (!key.equals(""));
	}

	public boolean isString() {
		return (type == 0);
	}

	public boolean isNumeric() {
		return (type == 1);
	}

	public boolean isDate() {
		return (type == 2);
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public void setModifiable(boolean modifiable) {
		this.modifiable = modifiable;
	}

}