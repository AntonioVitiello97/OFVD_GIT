package it.unisa.ofvd.model.dao.operations;

import java.sql.SQLException;
import java.util.Collection;

import it.unisa.ofvd.model.CavsModel;

public interface CavsDaoInterface {

	public Collection<CavsModel> getAll() throws SQLException;

	public void delete(String id_struct) throws SQLException;

	public CavsModel retrieve(String id_struct) throws SQLException;

	public void create(CavsModel account) throws SQLException;

	public void update(CavsModel account) throws SQLException;
}
