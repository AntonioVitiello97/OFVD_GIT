package it.unisa.ofvd.connection;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Indexes;

import java.net.UnknownHostException;

import org.bson.Document;

import it.unisa.ofvd.model.Info;
import it.unisa.ofvd.utils.Constants;
import it.unisa.ofvd.utils.Utility;

public class DBMongoConnectionPool {

	public static synchronized MongoClient createMongoDBConnection() throws UnknownHostException {
		return new MongoClient(Constants.mongoIp, Constants.mongoPort);
	}
	
	public static synchronized MongoCollection<Document> selectCollection(MongoClient mongoClient) {
		return mongoClient.getDatabase(Constants.mongoDb).getCollection(Constants.mongoCollection);
	}

	public static synchronized void close(MongoClient mongoClient) {
		if (mongoClient != null)
			mongoClient.close();
	}

	public static synchronized void test() throws Exception {
		MongoClient mongoClient = null;
		try {
			mongoClient = createMongoDBConnection();
			
		    Document document = mongoClient.getDatabase("test").runCommand(new Document("buildInfo",1));
			Utility.info("Mongo database", "Ip: " + Constants.mongoIp, 
					"Port: " + Constants.mongoPort, 
					"Version: "+document.getString("version"));
			
			Info.setMongoVersion("Mongo database Ip: " + Constants.mongoIp + " Port: " + Constants.mongoPort + " Version: "+document.getString("version"));
			
			MongoCursor<String> dbs = mongoClient.listDatabaseNames().iterator();

			while (dbs.hasNext()) {
				String dbName = dbs.next();
				if (dbName.equals(Constants.mongoDb)) {
					MongoCursor<String> colls = mongoClient.getDatabase(dbName).listCollectionNames().iterator();
					while (colls.hasNext()) {
						String collName = colls.next();
						if (collName.equals(Constants.mongoCollection)) {
							Utility.info("Mongo database", "Database: " + Constants.mongoDb,
									"Collection: " + Constants.mongoCollection);
							
							MongoCollection<Document> collection = mongoClient.getDatabase(dbName)
									.getCollection(collName);

							boolean iden_b = false;
							boolean status_b = false;
							boolean type_b = false;
							boolean trace_b = false;
							MongoCursor<Document> indexs = collection.listIndexes().iterator();
							while (indexs.hasNext()) {
								Document index = indexs.next();
								String iName = index.getString("name");
								if (iName.equals("IdentificativoScheda_1"))
									iden_b = true;
								if (iName.equals("status_1"))
									status_b = true;
								if (iName.equals("type_1"))
									type_b = true;
								if (iName.equals("trace_1"))
									trace_b = true;
							}

							if (!iden_b) {
								Utility.info("Mongo database", "Create index: IdentificativoScheda");
								collection.createIndex(Indexes.ascending("IdentificativoScheda"));
							}
							if (!status_b) {
								Utility.info("Mongo database", "Create index: status");
								collection.createIndex(Indexes.ascending("status"));
							}
							if (!type_b) {
								Utility.info("Mongo database", "Create index: type");
								collection.createIndex(Indexes.ascending("type"));
							}
							if (!trace_b) {
								Utility.info("Mongo database", "Create index: trace");
								collection.createIndex(Indexes.ascending("trace"));
							}
							indexs = collection.listIndexes().iterator();
							while (indexs.hasNext()) {
								Document index = indexs.next();
								Utility.info("Mongo database", "Index: " + index.toString());
							}

							return;
						}
					}

				}
			}

			throw new Exception("Database/collection non disponibile");
		} finally {
			close(mongoClient);
		}
	}
}
