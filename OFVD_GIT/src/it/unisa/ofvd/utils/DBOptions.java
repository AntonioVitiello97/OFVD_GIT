package it.unisa.ofvd.utils;

import java.awt.Color;
import java.sql.SQLException;

import it.unisa.ofvd.model.OptionModel;
import it.unisa.ofvd.model.dao.OptionsDao;

public class DBOptions {

	static OptionsDao options = null;

	static {
		options = new OptionsDao();
		// initializeDatabase();
	}

	public static boolean isActive() {
		return (options != null);
	}

	public static int getInt(String key) {
		int value = 0;
		String s = get(key).getValue();
		try {
			value = Integer.parseInt(s);
		} catch (NumberFormatException e) {
			value = 0;
		}

		return value;
	}

	public static String getString(String key) {
		return get(key).getValue();
	}

	public static boolean getBoolean(String key) {
		return get(key).getValue().equals("true");
	}

	public static Color getColor(String key) {
		return Utility.colorDecode(get(key).getValue());
	}

	private static void set(boolean update, String key, String module, String label, String value, int type,
			boolean modifiable) {
		try {
			OptionModel option = new OptionModel(key, module, label, value, type, modifiable);
			if (update) {
				options.upset(option);
			} else
				options.set(option);

		} catch (SQLException sqlException) {
			Utility.severe(sqlException.getMessage());
		}
	}

	private static OptionModel get(String key) {
		OptionModel option = null;
		try {
			option = options.get(key);
		} catch (SQLException sqlException) {
			Utility.severe(sqlException.getMessage());
		}
		if ((option == null) || (option.getValue().equals("NaN"))) {
			Utility.severe("Key '" + key + "' is not available in the constant DB");
			option = new OptionModel();
		}

		return option;
	}

	public static void updateDatabase() {
		setup(true);
	}

	public static void initializeDatabase() {

		try {
			options.unload();
		} catch (SQLException sqlException) {
			Utility.severe(sqlException.getMessage());
		}

		setup(false);
	}

	/**
	 * preferences types: 0 string; 1 numeric; 4 boolean; 5 color;
	 */
	private static void setup(boolean update) {
		String module = "Informazioni";
		
		set(update, "dbsVersion", module, "Versione DB", Constants.dbsVersion, 0, false);
		
		set(update, "projectName", module, "Nome progetto", "Osservatorio sul Fenomeno della Violenza sulle Donne", 0, true);
		
		set(update, "projectAcro", module, "Acronimo progetto", "OFVD", 0, true);		

	}

	public static void closure() {
		// closure
	}
}
