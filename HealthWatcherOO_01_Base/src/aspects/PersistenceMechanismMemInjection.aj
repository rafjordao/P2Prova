package aspects;

import lib.exceptions.PersistenceMechanismException;
import lib.persistence.PersistenceMechanismMem;

public aspect PersistenceMechanismMemInjection {
	private static PersistenceMechanismMem PersistenceMechanismMem.singleton;

	public static synchronized PersistenceMechanismMem PersistenceMechanismMem.getInstance()
			throws PersistenceMechanismException {
		if (singleton == null) {
			singleton = new PersistenceMechanismMem();
		}
		return singleton;
	}
}
