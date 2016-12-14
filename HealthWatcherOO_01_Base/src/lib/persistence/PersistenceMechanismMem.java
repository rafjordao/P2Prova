package lib.persistence;

import lib.exceptions.PersistenceMechanismException;
import lib.exceptions.TransactionException;

public class PersistenceMechanismMem implements IPersistenceMechanism {
	
	private static PersistenceMechanismMem singleton;
	
	public static synchronized PersistenceMechanismMem getInstance()
			throws PersistenceMechanismException {
		if (singleton == null) {
			singleton = new PersistenceMechanismMem();
		}
		return singleton;
	}

	public void connect() throws PersistenceMechanismException {
		// TODO Auto-generated method stub
		
	}

	public void disconnect() throws PersistenceMechanismException {
		// TODO Auto-generated method stub
		
	}

	public Object getCommunicationChannel()
			throws PersistenceMechanismException {
		// TODO Auto-generated method stub
		return null;
	}

	public void releaseCommunicationChannel()
			throws PersistenceMechanismException {
		// TODO Auto-generated method stub
		
	}

	public void beginTransaction() throws TransactionException {
		// TODO Auto-generated method stub
		
	}

	public void commitTransaction() throws TransactionException {
		// TODO Auto-generated method stub
		
	}

	public void rollbackTransaction() throws TransactionException {
		// TODO Auto-generated method stub
		
	}

}
