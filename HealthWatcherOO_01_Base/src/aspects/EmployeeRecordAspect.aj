package aspects;

import healthwatcher.model.employee.Employee;
import lib.concurrency.ConcurrencyManager;
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

	declare warning : execution(public void EmployeeRecord.insert(Employee)) : 
	    "Você está inserindo um Employee.";
	
	before(EmployeeRecord obj, Employee e) : insert() && this(obj) && args(e){
		obj.manager.beginExecution(e.getLogin());
	}
	
	after(EmployeeRecord obj, Employee e) : insert() && this(obj) && args(e){
		obj.manager.endExecution(e.getLogin());
	}
}
