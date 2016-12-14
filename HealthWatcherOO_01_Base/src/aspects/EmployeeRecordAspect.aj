package aspects;

import healthwatcher.business.employee.*;
import healthwatcher.model.employee.Employee;
import lib.concurrency.ConcurrencyManager;

public aspect EmployeeRecordAspect {
	
	private ConcurrencyManager manager;
	
	pointcut insert() : execution(* EmployeeRecord.insert(*));
	
	before(Employee obj) : insert() && this(obj) {
		manager.beginExecution(obj.getLogin());
	}
}
