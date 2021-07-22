package it.unisa.ofvd.utils;

import java.awt.Color;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Logger;

public class Utility {
	public static Logger logger = Logger.getLogger(Constants.appName);

	public static void info(String... messages) {
		String message = "";
		for (String s : messages) {
			message += s + "\n";
		}
		if (isDevelopment())
			System.out.println("INFO: " + message);
		else
			logger.info(message);
	}

	public static void severe(String message) {
		if (isDevelopment())
			System.err.println("ERROR: " + message);
		else
			logger.severe(message);
	}

	public static void exception(Exception e) {
		severe(e.getMessage());

		e.printStackTrace();
	}

	public static String encode(String text) {
		String encoded = "";

		if (text != null) {
			try {
				encoded = URLEncoder.encode(text, java.nio.charset.StandardCharsets.UTF_8.toString());
			} catch (UnsupportedEncodingException e) {
			}
		}

		return encoded;
	}

	public static void sleep(long delay) {
		if (delay <= 0)
			return;
		try {
			Thread.sleep(delay);
		} catch (InterruptedException e) {
		}
	}

	public static boolean isDevelopment() {
		try {
			if (System.getenv("LOGNAME").equals(Constants.developmentLoginName)) {
				return true;
			}
		} catch (RuntimeException e) {
		}

		return false;
	}

	public static void printDevelopment() {
		if (isDevelopment())
			Utility.info("Development user: " + System.getenv("LOGNAME"));
	}

	public static String capitalizeString(String string) {
		char[] chars = string.toLowerCase().toCharArray();
		boolean found = false;
		for (int i = 0; i < chars.length; i++) {
			if (!found && Character.isLetter(chars[i])) {
				chars[i] = Character.toUpperCase(chars[i]);
				found = true;
			} else if (Character.isWhitespace(chars[i]) || chars[i] == '.' || chars[i] == '\'') { // You can add other
																									// chars here
				found = false;
			}
		}
		return String.valueOf(chars);
	}

	public static Color colorDecode(String color) {
		Color c = Color.black;

		if (null == color) {
			return c;
		}
		try {
			c = Color.decode(color.trim());
		} catch (NumberFormatException e) {
			return c;
		}
		return c;
	}

	public static boolean isEncodedCrypt(String source) {
		return (source != null && source.startsWith(Constants.encryption) && source.length() == 36);
	}
	
	
	public static String encodeCrypt(String source) {
		if(source == null) return null;
		if(source != null && source.equals("")) return ""; 
		if(isEncodedCrypt(source)) return source;
				
		try {
			// Static getInstance method is called with hashing MD5
			MessageDigest md = MessageDigest.getInstance(Constants.cryptAlgorithm);

			// digest() method is called to calculate message digest
			// of an input digest() return array of byte
			byte[] messageDigest = md.digest(source.getBytes());

			// Convert byte array into signum representation
			BigInteger no = new BigInteger(1, messageDigest);

			// Convert message digest into hex value
			String hashtext = no.toString(16);
			while (hashtext.length() < 32) {
				hashtext = "0" + hashtext;
			}
			return Constants.encryption + hashtext;
		} catch (NoSuchAlgorithmException e) {
		}

		return source;
	}

	private static String md5(String source) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] messageDigest = md.digest(source.getBytes());
			BigInteger no = new BigInteger(1, messageDigest);
			String hashtext = no.toString(16);
			while (hashtext.length() < 32) {
				hashtext = "0" + hashtext;
			}
			return Constants.encryption + hashtext;
		} catch (NoSuchAlgorithmException e) {
		}

		return source;
	}

	public static String generateTrace(String a, String b, String c, String d) {
		if (a == null || b == null || c == null || d == null)
			return "";

		String aP = String.format("%1$-40s", a.toLowerCase().trim()).replace(' ', '0');
		String bP = String.format("%1$-40s", b.toLowerCase().trim()).replace(' ', '0');
		String cP = String.format("%1$-40s", c.toLowerCase().trim()).replace(' ', '0');
		String dP = String.format("%1$-10s", c.toLowerCase().trim()).replace(' ', '0');
		String compound = aP + bP + cP + dP;
		String md = md5(compound);
		Utility.info("TRACE: "+a+" "+b+" "+c+" "+d+" ("+md+")" );
		return md;
	}
}
