package it.unisa.ofvd.model.dao.operations;

import java.sql.SQLException;
import java.util.Collection;

import it.unisa.ofvd.model.OptionModel;

public interface OptionsDaoInterface {

	public Collection<OptionModel> load() throws SQLException;

	public OptionModel get(String key) throws SQLException;

	public void set(OptionModel option) throws SQLException;

	public void upset(OptionModel option) throws SQLException;

	public void unload() throws SQLException;

	public void closure() throws SQLException;
}
