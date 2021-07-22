package it.unisa.ofvd.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.unisa.ofvd.connection.DBMySQLConnectionPool;
import it.unisa.ofvd.exception.LocalException;
import it.unisa.ofvd.model.AccountsModel;

import it.unisa.ofvd.model.dao.operations.AccountsDaoInterface;
import it.unisa.ofvd.utils.Utility;

public class AccountsDao implements AccountsDaoInterface {

	public static final String TABLE_NAME = "operatore";
	public static final String TABLE_NAME_ADMIN = "super_user";

	@Override
	public synchronized AccountsModel login(String email, String password) throws LocalException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		AccountsModel account = null;
		boolean flag = false;

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement(
					"SELECT * FROM " + AccountsDao.TABLE_NAME + " WHERE email = ? AND password = MD5(?)");

			stmt.setString(1, email);
			stmt.setString(2, password);

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				account = new AccountsModel();
				flag = true;

				account.setMatricola(rs.getString("matricola"));
				account.setNome(rs.getString("nome"));
				account.setCognome(rs.getString("cognome"));
				account.setEmail(rs.getString("email"));
				account.setPassword(rs.getString("password"));
				account.setTelefono(rs.getString("telefono"));
				account.setAdmin(rs.getString("code_admin"));
				account.setCav(rs.getString("code_cav"));
				account.setHospital(rs.getString("code_ospedale"));
				account.setDefaultPassword(rs.getBoolean("defaultPassword"));
				account.setType();

				Utility.info("Utente type: " + account.getType());
			}

			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();

			if (!flag) {
				Utility.info("Utente admin, email:" + email + " password:" + password);

				stmt = con.prepareStatement(
						"SELECT * FROM " + AccountsDao.TABLE_NAME_ADMIN + " WHERE email = ? AND password = MD5(?)");

				stmt.setString(1, email);
				stmt.setString(2, password);

				Utility.info("QUERY: " + stmt.toString());
				rs = stmt.executeQuery();

				if (rs.next()) {
					account = new AccountsModel();
					flag = true;

					account.setNome(rs.getString("nome"));
					account.setCognome(rs.getString("cognome"));
					account.setEmail(rs.getString("email"));
					account.setPassword(rs.getString("password"));
					account.setTelefono(rs.getString("telefono"));
					account.setAdministrator();
					account.setDefaultPassword(false);
				}
			}

			if (!flag)
				throw new LocalException("Email o password non valide");

		} catch (SQLException sqlException) {
			Utility.severe(sqlException.getMessage());
			throw new LocalException("Email o password non valide");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
				throw new LocalException("Email o password non valide");
			} finally {
				try {
					if (con != null)
						DBMySQLConnectionPool.releaseConnection(con);
				} catch (SQLException sqlException) {
					Utility.severe(sqlException.getMessage());
					throw new LocalException("Email o password non valide");
				}
			}
		}
		return account;
	}

	@Override
	public synchronized Collection<AccountsModel> getAll() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Collection<AccountsModel> accountList = new LinkedList<AccountsModel>();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT * FROM " + AccountsDao.TABLE_NAME + " ORDER BY MATRICOLA");

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				AccountsModel account = new AccountsModel();
				account = new AccountsModel();
				account.setMatricola(rs.getString("matricola"));
				account.setNome(rs.getString("nome"));
				account.setCognome(rs.getString("cognome"));
				account.setEmail(rs.getString("email"));
				account.setPassword(rs.getString("password"));
				account.setTelefono(rs.getString("telefono"));
				account.setAdmin(rs.getString("code_admin"));
				account.setCav(rs.getString("code_cav"));
				account.setHospital(rs.getString("code_ospedale"));
				account.setDefaultPassword(rs.getBoolean("defaultPassword"));
				account.setType();

				accountList.add(account);
			}
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}
		return accountList;
	}

	@Override
	public synchronized Collection<AccountsModel> getAllAdmin() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Collection<AccountsModel> accountList = new LinkedList<AccountsModel>();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT * FROM super_user ORDER BY COGNOME");

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				AccountsModel account = new AccountsModel();
				account = new AccountsModel();
				account.setEmail(rs.getString("email"));
				account.setNome(rs.getString("nome"));
				account.setCognome(rs.getString("cognome"));
				account.setTelefono(rs.getString("telefono"));

				accountList.add(account);
			}
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}
		return accountList;
	}

	@Override
	public synchronized void delete(String email) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("DELETE FROM " + AccountsDao.TABLE_NAME + " WHERE " + " email = ?");
			stmt.setString(1, email);

			Utility.info("QUERY: " + stmt.toString());
			stmt.executeUpdate();
			con.commit();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}
	}

	@Override
	public synchronized AccountsModel retrieve(String email) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		AccountsModel account = null;

		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("SELECT * FROM " + AccountsDao.TABLE_NAME + " WHERE email = ?");
			stmt.setString(1, email);

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				account = new AccountsModel();

				account.setMatricola(rs.getString("matricola"));
				account.setNome(rs.getString("nome"));
				account.setCognome(rs.getString("cognome"));
				account.setEmail(rs.getString("email"));
				account.setPassword(rs.getString("password"));
				account.setTelefono(rs.getString("telefono"));
				account.setAdmin(rs.getString("code_admin"));
				account.setCav(rs.getString("code_cav"));
				account.setHospital(rs.getString("code_ospedale"));
				account.setDefaultPassword(rs.getBoolean("defaultPassword"));
				account.setType();
			}

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}
		return account;
	}

	public synchronized void create(AccountsModel account) throws SQLException, LocalException {

		Connection con = null;
		PreparedStatement stmt = null;
		AccountsModel acc = retrieve(account.getEmail());
		if (acc != null) {
			throw new LocalException("User is already present");
		}

		try {

			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("INSERT INTO " + AccountsDao.TABLE_NAME
					+ " (nome, cognome, email, password, code_ospedale, code_cav, code_admin, telefono, matricola, defaultPassword) VALUES (?, ?, ?, MD5(?), ?, ?, ?, ?, ?, ?)");

			stmt.setString(1, account.getNome());
			stmt.setString(2, account.getCognome());
			stmt.setString(3, account.getEmail());
			stmt.setString(4, account.getPassword());

			if (account.getHospital() == null || account.getHospital().equals(""))
				stmt.setString(5, null);
			else
				stmt.setString(5, account.getHospital());

			if (account.getCav() == null || account.getCav().equals(""))
				stmt.setString(6, null);
			else
				stmt.setString(6, account.getCav());

			if (account.getAdmin() == null || account.getAdmin().equals(""))
				stmt.setString(7, null);
			else
				stmt.setString(7, account.getAdmin());

			stmt.setString(8, account.getTelefono());
			stmt.setString(9, account.getMatricola());
			stmt.setBoolean(10, true);

			Utility.info("QUERY: " + stmt.toString());
			stmt.executeUpdate();
			con.commit();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}
	}

	@Override
	public synchronized void update(AccountsModel account) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = DBMySQLConnectionPool.getConnection();

			if (account.getPassword().equals("")) {

				stmt = con.prepareStatement(
						"UPDATE " + AccountsDao.TABLE_NAME + " SET matricola=?, nome=?, cognome=?, telefono=?,"
								+ " code_ospedale=?, code_cav=?, code_admin=?," + " defaultPassword=? WHERE email=?");

				stmt.setString(1, account.getMatricola());
				stmt.setString(2, account.getNome());
				stmt.setString(3, account.getCognome());
				stmt.setString(4, account.getTelefono());

				if (account.getHospital() == null || account.getHospital().equals(""))
					stmt.setString(5, null);
				else
					stmt.setString(5, account.getHospital());

				if (account.getCav() == null || account.getCav().equals(""))
					stmt.setString(6, null);
				else
					stmt.setString(6, account.getCav());

				if (account.getAdmin() == null || account.getAdmin().equals(""))
					stmt.setString(7, null);
				else
					stmt.setString(7, account.getAdmin());

				stmt.setBoolean(8, account.getDefaultPassword());
				stmt.setString(9, account.getEmail());
			} else {
				stmt = con.prepareStatement(
						"UPDATE " + AccountsDao.TABLE_NAME + " SET matricola= ?, nome=?, cognome=? ,telefono=?, "
								+ " code_ospedale=?, code_cav=?, code_admin=?,"
								+ " password=MD5(?),defaultPassword=? WHERE email=?");

				stmt.setString(1, account.getMatricola());
				stmt.setString(2, account.getNome());
				stmt.setString(3, account.getCognome());
				stmt.setString(4, account.getTelefono());

				if (account.getHospital() == null || account.getHospital().equals(""))
					stmt.setString(5, null);
				else
					stmt.setString(5, account.getHospital());

				if (account.getCav() == null || account.getCav().equals(""))
					stmt.setString(6, null);
				else
					stmt.setString(6, account.getCav());

				if (account.getAdmin() == null || account.getAdmin().equals(""))
					stmt.setString(7, null);
				else
					stmt.setString(7, account.getAdmin());

				stmt.setString(8, account.getPassword());
				stmt.setBoolean(9, account.getDefaultPassword());
				stmt.setString(10, account.getEmail());
			}

			Utility.info("QUERY: " + stmt.toString());
			stmt.executeUpdate();

			con.commit();
		} finally {
			try {
				if (stmt != null)

					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}

	}

	@Override
	public Collection<AccountsModel> getContactsHospital() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Collection<AccountsModel> accountList = new LinkedList<AccountsModel>();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT * FROM " + AccountsDao.TABLE_NAME
					+ " WHERE code_admin IS NULL AND code_ospedale IS NOT NULL");

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				AccountsModel account = new AccountsModel();
				account = new AccountsModel();
				account.setMatricola(rs.getString("matricola"));
				account.setNome(rs.getString("nome"));
				account.setCognome(rs.getString("cognome"));
				account.setEmail(rs.getString("email"));
				account.setPassword(rs.getString("password"));
				account.setTelefono(rs.getString("telefono"));
				account.setAdmin(rs.getString("code_admin"));
				account.setCav(rs.getString("code_cav"));
				account.setHospital(rs.getString("code_ospedale"));
				account.setDefaultPassword(rs.getBoolean("defaultPassword"));
				accountList.add(account);
			}
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}
		return accountList;
	}

	@Override
	public Collection<AccountsModel> getContactsCav() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Collection<AccountsModel> accountList = new LinkedList<AccountsModel>();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement(
					"SELECT * FROM " + AccountsDao.TABLE_NAME + " where code_admin is null AND code_cav is not null");

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				AccountsModel account = new AccountsModel();
				account = new AccountsModel();
				account.setMatricola(rs.getString("matricola"));
				account.setNome(rs.getString("nome"));
				account.setCognome(rs.getString("cognome"));
				account.setEmail(rs.getString("email"));
				account.setPassword(rs.getString("password"));
				account.setTelefono(rs.getString("telefono"));
				account.setAdmin(rs.getString("code_admin"));
				account.setCav(rs.getString("code_cav"));
				account.setHospital(rs.getString("code_ospedale"));
				account.setDefaultPassword(rs.getBoolean("defaultPassword"));
				accountList.add(account);
			}
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}
		return accountList;
	}

	@Override
	public synchronized void updateProfile(AccountsModel account) throws SQLException {

		Connection con = null;

		PreparedStatement stmt = null;

		try {
			con = DBMySQLConnectionPool.getConnection();

			if (account.isAdministrator()) {
				if (account.getPassword().equals("")) {
					stmt = con.prepareStatement(
							"UPDATE " + AccountsDao.TABLE_NAME_ADMIN + " SET telefono=? WHERE email = ?");

					stmt.setString(1, account.getTelefono());
					stmt.setString(2, account.getEmail());
				} else {
					stmt = con.prepareStatement("UPDATE " + AccountsDao.TABLE_NAME_ADMIN
							+ " SET  telefono=?, password=MD5(?) WHERE email =?");

					stmt.setString(1, account.getTelefono());
					stmt.setString(2, account.getPassword());
					stmt.setString(3, account.getEmail());
				}

			} else {
				if (account.getPassword().equals("")) {
					stmt = con
							.prepareStatement("UPDATE " + AccountsDao.TABLE_NAME + " SET  telefono= ? WHERE email = ?");
					stmt.setString(1, account.getTelefono());
					stmt.setString(2, account.getEmail());
				} else {
					stmt = con.prepareStatement(
							"UPDATE " + AccountsDao.TABLE_NAME + " SET  telefono= ?, password= MD5(?) WHERE email = ?");

					stmt.setString(1, account.getTelefono());
					stmt.setString(2, account.getPassword());
					stmt.setString(3, account.getEmail());
				}
			}

			Utility.info("QUERY: " + stmt.toString());
			stmt.executeUpdate();

			con.commit();
		} finally {
			try {
				if (stmt != null)

					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}

	}

	public synchronized void changeDefaultPassword(AccountsModel account, String newPassword) throws SQLException {

		Connection con = null;

		PreparedStatement stmt = null;

		try {
			con = DBMySQLConnectionPool.getConnection();

			if (account.getDefaultPassword()) {
				Utility.info("Default password, devo aggiornare");
				stmt = con.prepareStatement("UPDATE " + AccountsDao.TABLE_NAME
						+ " SET password= MD5(?), defaultPassword=false WHERE email = ? and password= '"
						+ account.getPassword() + "'");
				stmt.setString(1, newPassword);
				stmt.setString(2, account.getEmail());
			}

			Utility.info("QUERY: " + stmt.toString());
			int result = stmt.executeUpdate();
			Utility.info("Ho aggiornato #" + result + " account");

			con.commit();
		} finally {
			try {
				if (stmt != null)

					stmt.close();
			} catch (SQLException sqlException) {
				Utility.severe(sqlException.getMessage());
			} finally {
				if (con != null)
					DBMySQLConnectionPool.releaseConnection(con);
			}
		}

	}

}
