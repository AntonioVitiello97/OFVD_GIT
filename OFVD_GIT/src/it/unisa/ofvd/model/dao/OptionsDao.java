package it.unisa.ofvd.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.unisa.ofvd.connection.DBMySQLConnectionPool;
import it.unisa.ofvd.model.OptionModel;
import it.unisa.ofvd.model.dao.operations.OptionsDaoInterface;
import it.unisa.ofvd.utils.DBOptions;
import it.unisa.ofvd.utils.Utility;

public class OptionsDao implements OptionsDaoInterface {
	private static final String TABLE_NAME = "options";

	public synchronized Collection<OptionModel> load() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Collection<OptionModel> optionList = new LinkedList<OptionModel>();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement(
					"SELECT * FROM " + OptionsDao.TABLE_NAME + " WHERE modifiable = 1 OR modifiable = 0 ORDER BY module, id");

			rs = stmt.executeQuery();

			while (rs.next()) {
				OptionModel option = new OptionModel();
				option.setKey(rs.getString("key"));
				option.setModule(rs.getString("module"));
				option.setLabel(rs.getString("label"));
				option.setValue(rs.getString("value"));
				option.setType(rs.getInt("type"));
				option.setModifiable(rs.getInt("modifiable") == 1);

				optionList.add(option);
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
		return optionList;
	}

	public synchronized OptionModel get(String key) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		OptionModel option = new OptionModel();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT * FROM " + OptionsDao.TABLE_NAME + " WHERE `key` = ?");
			stmt.setString(1, key);

			rs = stmt.executeQuery();

			if (rs.next()) {
				option.setKey(rs.getString("key"));
				option.setModule(rs.getString("module"));
				option.setLabel(rs.getString("label"));
				option.setValue(rs.getString("value"));
				option.setType(rs.getInt("type"));
				option.setModifiable(rs.getInt("modifiable") == 1);
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
		return option;
	}

	public synchronized void set(OptionModel option) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT `key` FROM " + OptionsDao.TABLE_NAME + " WHERE `key` = ?");
			stmt.setString(1, option.getKey());

			rs = stmt.executeQuery();

			if (rs.next()) {
				// update
				PreparedStatement stmtUpdate = con.prepareStatement("UPDATE " + OptionsDao.TABLE_NAME
						+ " SET `module` = ?, `value` = ?, `label` = ? WHERE `key` = ?");
				stmtUpdate.setString(1, option.getModule());
				stmtUpdate.setString(2, option.getValue());
				stmtUpdate.setString(3, option.getLabel());
				stmtUpdate.setString(4, option.getKey());

				stmtUpdate.executeUpdate();
				con.commit();
				try {
					if (stmtUpdate != null)
						stmtUpdate.close();
				} catch (SQLException sqlException) {
					Utility.severe(sqlException.getMessage());
				}
			} else {
				// save
				PreparedStatement stmtInsert = con.prepareStatement("INSERT INTO " + OptionsDao.TABLE_NAME
						+ "(`key`,`module`,`label`,`value`,`type`,`modifiable`)  VALUES (?,?,?,?,?,?)");

				stmtInsert.setString(1, option.getKey());
				stmtInsert.setString(2, option.getModule());
				stmtInsert.setString(3, option.getLabel());
				stmtInsert.setString(4, option.getValue());
				stmtInsert.setInt(5, option.getType());
				stmtInsert.setInt(6, (option.isModifiable() ? 1 : 0));

				stmtInsert.executeUpdate();
				con.commit();

				try {
					if (stmtInsert != null)
						stmtInsert.close();
				} catch (SQLException sqlException) {
					Utility.severe(sqlException.getMessage());
				}
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
	}

	public synchronized void upset(OptionModel option) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT `key` FROM " + OptionsDao.TABLE_NAME + " WHERE `key` = ?");
			stmt.setString(1, option.getKey());

			rs = stmt.executeQuery();

			if (!rs.next()) {
				// save
				PreparedStatement stmtInsert = con.prepareStatement("INSERT INTO " + OptionsDao.TABLE_NAME
						+ "(`key`,`module`,`label`,`value`,`type`,`modifiable`)  VALUES (?,?,?,?,?,?)");

				stmtInsert.setString(1, option.getKey());
				stmtInsert.setString(2, option.getModule());
				stmtInsert.setString(3, option.getLabel());
				stmtInsert.setString(4, option.getValue());
				stmtInsert.setInt(5, option.getType());
				stmtInsert.setInt(6, (option.isModifiable() ? 1 : 0));

				stmtInsert.executeUpdate();
				con.commit();

				try {
					if (stmtInsert != null)
						stmtInsert.close();
				} catch (SQLException sqlException) {
					Utility.severe(sqlException.getMessage());
				}
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
	}

	public synchronized void unload() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("DELETE FROM " + OptionsDao.TABLE_NAME);

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

	public void closure() throws SQLException {
		DBOptions.closure();
	}

	public void restore() throws SQLException {
		DBOptions.initializeDatabase();
	}

	public void update() throws SQLException {
		DBOptions.updateDatabase();
	}

}