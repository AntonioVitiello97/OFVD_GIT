package it.unisa.ofvd.model.dao.operations;

import java.sql.SQLException;
import java.util.Collection;

import it.unisa.ofvd.model.HospitalsModel;

public interface HospitalsDaoInterface {

	public Collection<HospitalsModel> getAll() throws SQLException;

	public void delete(String email) throws SQLException;

	public HospitalsModel retrieve(String email) throws SQLException;

	public void create(HospitalsModel account) throws SQLException;

	public void update(HospitalsModel account) throws SQLException;
}
