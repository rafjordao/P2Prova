package healthwatcher.business.employee;

import lib.concurrency.ConcurrencyManager;
import lib.exceptions.ExceptionMessages;
import lib.exceptions.ObjectAlreadyInsertedException;
import lib.exceptions.ObjectNotFoundException;
import lib.exceptions.ObjectNotValidException;
import lib.exceptions.RepositoryException;
import healthwatcher.data.IEmployeeRepository;
import healthwatcher.model.employee.Employee;

public class EmployeeRecord {

	private IEmployeeRepository employeeRepository;

	public EmployeeRecord(IEmployeeRepository rep) {
		this.employeeRepository = rep;
	}

	public void insert(Employee employee) throws ObjectNotValidException,
			ObjectAlreadyInsertedException, ObjectNotValidException, RepositoryException {
		if (employeeRepository.exists(employee.getLogin())) {
			throw new ObjectAlreadyInsertedException(ExceptionMessages.EXC_JA_EXISTE);
		} else {
			employeeRepository.insert(employee);
		}
	}
}