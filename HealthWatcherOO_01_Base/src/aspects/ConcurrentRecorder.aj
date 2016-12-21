package aspects;

import healthwatcher.business.employee.EmployeeRecord;
import healthwatcher.model.employee.Employee;
import lib.concurrency.ConcurrencyManager;
import lib.exceptions.ExceptionMessages;
import lib.exceptions.ObjectAlreadyInsertedException;
import lib.exceptions.RepositoryException;

public privileged aspect ConcurrentRecorder {
	private final ConcurrencyManager manager = new ConcurrencyManager();

	pointcut insert(): call(public void EmployeeRecord.insert(Employee));
	
	void around(Employee employee, EmployeeRecord record) throws ObjectAlreadyInsertedException, RepositoryException: insert() && args(employee) && target(record) {
		manager.beginExecution(employee.getLogin());

		if (record.employeeRepository.exists(employee.getLogin())) {
			throw new ObjectAlreadyInsertedException(ExceptionMessages.EXC_JA_EXISTE);
		}

		proceed(employee, record);

		manager.endExecution(employee.getLogin());
	}
}