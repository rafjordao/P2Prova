package lib.persistence;

import lib.exceptions.PersistenceMechanismException;
import lib.exceptions.TransactionException;

public class PersistenceMechanismMem implements IPersistenceMechanism {
	public void connect() throws PersistenceMechanismException {
		// TODO Auto-generated method stub

	}

	public void disconnect() throws PersistenceMechanismException {
		// TODO Auto-generated method stub

	}

	public Object getCommunicationChannel() throws PersistenceMechanismException {
		// TODO Auto-generated method stub
		return null;
	}

	public void releaseCommunicationChannel() throws PersistenceMechanismException {
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
