package healthwatcher.business.employee;

import lib.exceptions.ExceptionMessages;
import lib.exceptions.ObjectAlreadyInsertedException;
import healthwatcher.data.IEmployeeRepository;
import healthwatcher.model.employee.Employee;

public class EmployeeRecord {

	private IEmployeeRepository employeeRepository;

	public EmployeeRecord(IEmployeeRepository rep) {
		this.employeeRepository = rep;
	}

	public void insert(Employee employee){
		if (employeeRepository.exists(employee.getLogin())) {
			throw new ObjectAlreadyInsertedException(ExceptionMessages.EXC_JA_EXISTE);
		} else {
			employeeRepository.insert(employee);
		}
	}
}