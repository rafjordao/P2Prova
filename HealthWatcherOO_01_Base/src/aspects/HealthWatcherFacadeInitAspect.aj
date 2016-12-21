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
		
	pointcut updateTransactionException(HealthWatcherFacadeInit obj) : handler(TransactionException) && this(obj);
	pointcut updateObjectNotValidException(HealthWatcherFacadeInit obj) : handler(ObjectNotValidException) && this(obj);
	pointcut updateObjectNotFoundException(HealthWatcherFacadeInit obj) : handler(ObjectNotFoundException) && this(obj);
	
	/*before (HealthWatcherFacadeInit obj, TransactionException e) throws TransactionException: updateTransactionException(obj) && args(e){
		obj.getPm().rollbackTransaction();
		throw e;
	}
	
	before (HealthWatcherFacadeInit obj, ObjectNotValidException e) throws TransactionException,
					ObjectNotValidException : updateObjectNotValidException(obj) && args(e){
		obj.getPm().rollbackTransaction();
		throw e;
	}
	
	before (HealthWatcherFacadeInit obj, ObjectNotFoundException e) throws TransactionException,
					ObjectNotFoundException: updateObjectNotFoundException(obj) && args(e){
		obj.getPm().rollbackTransaction();
		throw e;
	}*/
		
}
