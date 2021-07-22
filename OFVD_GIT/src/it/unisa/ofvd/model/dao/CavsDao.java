package it.unisa.ofvd.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.unisa.ofvd.connection.DBMySQLConnectionPool;
import it.unisa.ofvd.model.CavsModel;
import it.unisa.ofvd.model.dao.operations.CavsDaoInterface;
import it.unisa.ofvd.utils.Utility;

public class CavsDao implements CavsDaoInterface {

	public static final String TABLE_NAME = "cav";

	@Override
	public Collection<CavsModel> getAll() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Collection<CavsModel> cavList = new LinkedList<CavsModel>();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT * FROM " + CavsDao.TABLE_NAME + " ORDER BY ID");

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				CavsModel cav;
				cav = new CavsModel();

				cav.setId(rs.getString("id"));
				cav.setNome(rs.getString("nome"));
				cav.setIndirizzo(rs.getString("indirizzo"));
				cav.setEmail(rs.getString("email"));
				cav.setTelefono(rs.getString("telefono"));
				cav.setTelefono1(rs.getString("telefono1"));
				cavList.add(cav);

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
		return cavList;
	}

	@Override
	public void delete(String email) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("DELETE FROM " + CavsDao.TABLE_NAME + " WHERE " + " email = ?");
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
	public CavsModel retrieve(String email) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		CavsModel cav = null;

		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("SELECT * FROM " + CavsDao.TABLE_NAME + " WHERE email = ?");
			stmt.setString(1, email);

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				cav = new CavsModel();
				cav.setId(rs.getString("id"));
				cav.setEmail(rs.getString("email"));
				cav.setIndirizzo(rs.getString("indirizzo"));
				cav.setTelefono(rs.getString("telefono"));
				cav.setTelefono1(rs.getString("telefono1"));
				cav.setNome(rs.getString("nome"));
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

		return cav;
	}

	@Override
	public void create(CavsModel cav) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement(
					"INSERT INTO " + CavsDao.TABLE_NAME + " (email, indirizzo, telefono, telefono1, nome) VALUES (?,?,?,?,?)");
			stmt.setString(1, cav.getEmail());
			stmt.setString(2, cav.getIndirizzo());
			stmt.setString(3, cav.getTelefono());
			stmt.setString(4, cav.getTelefono1());
			stmt.setString(5, cav.getNome());

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
	public void update(CavsModel cav) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement(
					"UPDATE " + CavsDao.TABLE_NAME + " SET indirizzo = ?, telefono= ?, telefono1= ?, nome=? WHERE email = ?");

			stmt.setString(1, cav.getIndirizzo());
			stmt.setString(2, cav.getTelefono());
			stmt.setString(3, cav.getTelefono1());
			stmt.setString(4, cav.getNome());
			stmt.setString(5, cav.getEmail());

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

}
