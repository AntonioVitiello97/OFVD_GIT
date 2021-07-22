package it.unisa.ofvd.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.unisa.ofvd.connection.DBMySQLConnectionPool;
import it.unisa.ofvd.model.HospitalsModel;
import it.unisa.ofvd.model.dao.operations.HospitalsDaoInterface;
import it.unisa.ofvd.utils.Utility;

public class HospitalsDao implements HospitalsDaoInterface {

	public static final String TABLE_NAME = "hospital";

	@Override
	public Collection<HospitalsModel> getAll() throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Collection<HospitalsModel> hospitalList = new LinkedList<HospitalsModel>();

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("SELECT * FROM " + HospitalsDao.TABLE_NAME + " ORDER BY ID");

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			while (rs.next()) {
				HospitalsModel hospital;
				hospital = new HospitalsModel();

				hospital.setId(rs.getString("id"));
				hospital.setNome(rs.getString("nome"));
				hospital.setIndirizzo(rs.getString("indirizzo"));
				hospital.setEmail(rs.getString("email"));
				hospital.setTelefono(rs.getString("telefono"));
				hospital.setTelefono1(rs.getString("telefono1"));
				hospitalList.add(hospital);

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
		return hospitalList;
	}

	@Override
	public void delete(String email) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("DELETE FROM " + HospitalsDao.TABLE_NAME + " WHERE " + " email = ?");
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
	public HospitalsModel retrieve(String email) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		HospitalsModel hospital = null;

		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("SELECT * FROM " + HospitalsDao.TABLE_NAME + " WHERE email = ?");
			stmt.setString(1, email);

			Utility.info("QUERY: " + stmt.toString());
			rs = stmt.executeQuery();

			if (rs.next()) {

				hospital = new HospitalsModel();
				hospital.setId(rs.getString("id"));
				hospital.setEmail(rs.getString("email"));
				hospital.setIndirizzo(rs.getString("indirizzo"));
				hospital.setTelefono(rs.getString("telefono"));
				hospital.setTelefono1(rs.getString("telefono1"));
				hospital.setNome(rs.getString("nome"));

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

		return hospital;
	}

	@Override
	public void create(HospitalsModel hospital) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = DBMySQLConnectionPool.getConnection();
			stmt = con.prepareStatement("INSERT INTO " + HospitalsDao.TABLE_NAME
					+ " (email, indirizzo, telefono, telefono1, nome) VALUES (?,?,?,?,?)");
			stmt.setString(1, hospital.getEmail());
			stmt.setString(2, hospital.getIndirizzo());
			stmt.setString(3, hospital.getTelefono());
			stmt.setString(4, hospital.getTelefono1());
			stmt.setString(5, hospital.getNome());

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
	public void update(HospitalsModel hospital) throws SQLException {

		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = DBMySQLConnectionPool.getConnection();

			stmt = con.prepareStatement("UPDATE " + HospitalsDao.TABLE_NAME
					+ " SET indirizzo = ?, telefono= ?, telefono1= ?, nome=? WHERE email = ?");

			stmt.setString(1, hospital.getIndirizzo());
			stmt.setString(2, hospital.getTelefono());
			stmt.setString(3, hospital.getTelefono1());
			stmt.setString(4, hospital.getNome());
			stmt.setString(5, hospital.getEmail());

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
