package aspects;

import lib.exceptions.ObjectNotFoundException;
import lib.exceptions.ObjectNotValidException;
import lib.exceptions.ObjectAlreadyInsertedException;
import lib.exceptions.RepositoryException;
import lib.exceptions.TransactionException;
import healthwatcher.business.HealthWatcherFacadeInit;
import healthwatcher.model.employee.Employee;

privileged public aspect HealthWatcherFacadeInitAspect {
	
	declare soft : TransactionException : execution(public void HealthWatcherFacadeInit.insert(Employee))
										|| execution(public void HealthWatcherFacadeInit.update(Employee));
	
	declare soft : ObjectNotValidException : execution(public void HealthWatcherFacadeInit.insert(Employee))
										|| execution(public void HealthWatcherFacadeInit.update(Employee));
	
	declare soft : ObjectAlreadyInsertedException : execution(public void HealthWatcherFacadeInit.insert(Employee));

	declare soft : RepositoryException : execution(public void HealthWatcherFacadeInit.update(Employee));
	
	declare soft : ObjectNotFoundException : execution(public void HealthWatcherFacadeInit.update(Employee));
	
	pointcut update(): execution(public void HealthWatcherFacadeInit.update(Employee));
	
	void around(HealthWatcherFacadeInit obj, Employee employee): update() && target(obj) && args(employee){
		try{
			try {
				proceed(obj,employee);
			} catch (TransactionException e) {
				obj.getPm().rollbackTransaction();
				throw e;
			} catch (Exception e) {
				obj.getPm().rollbackTransaction();
			}
		} catch(Exception e1){
			e1.printStackTrace();
		}
	}
	
}
