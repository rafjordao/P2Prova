package aspects;

import healthwatcher.model.employee.Employee;
import lib.concurrency.ConcurrencyManager;
import lib.exceptions.ExceptionMessages;
import lib.exceptions.ObjectAlreadyInsertedException;
import lib.exceptions.ObjectNotFoundException;
import lib.exceptions.ObjectNotValidException;
import lib.exceptions.RepositoryException;
import healthwatcher.business.employee.EmployeeRecord;
import healthwatcher.data.IEmployeeRepository;


privileged public aspect EmployeeRecordAspect {
	
	private IEmployeeRepository EmployeeRecord.employeeRepository;
	
	private ConcurrencyManager EmployeeRecord.manager = new ConcurrencyManager();
		
	public Employee EmployeeRecord.search(String login) throws ObjectNotFoundException, RepositoryException {
		return employeeRepository.search(login);
	}
	
	public void EmployeeRecord.update(Employee employee) throws ObjectNotValidException, ObjectNotFoundException,
	ObjectNotValidException, RepositoryException {
		employeeRepository.update(employee);
	}
	
	pointcut insert() : execution(public void EmployeeRecord.insert(Employee));

	declare soft : RepositoryException : insert();
	declare soft : ObjectNotValidException : insert();
	declare soft : ObjectAlreadyInsertedException : insert();
	
	declare warning : execution(public void EmployeeRecord.insert(Employee)) : 
	    "Você está inserindo um Employee.";
	
	before(EmployeeRecord obj, Employee employee) : insert() && this(obj) && args(employee){
		obj.manager.beginExecution(employee.getLogin());
	}
	
	after(EmployeeRecord obj, Employee employee) : insert() && this(obj) && args(employee){
		obj.manager.endExecution(employee.getLogin());
	}
	
	/*before(EmployeeRecord obj, Employee employee) : execution(public void EmployeeRecord.insert(Employee))
													&& this(obj) && args(employee){
		if(obj.employeeRepository.exists(employee.getLogin())){
			throw new ObjectAlreadyInsertedException(ExceptionMessages.EXC_JA_EXISTE);
		}
	}*/
	
	
	
}
