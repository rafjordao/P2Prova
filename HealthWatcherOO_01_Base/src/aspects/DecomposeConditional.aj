package aspects;

import healthwatcher.Constants;
import healthwatcher.business.HealthWatcherFacade;
import healthwatcher.business.HealthWatcherFacadeInit;
import healthwatcher.business.complaint.ComplaintRecord;
import healthwatcher.business.complaint.DiseaseRecord;
import healthwatcher.business.employee.EmployeeRecord;
import healthwatcher.business.healthguide.HealthUnitRecord;
import healthwatcher.business.healthguide.MedicalSpecialityRecord;
import healthwatcher.data.mem.ComplaintRepositoryArray;
import healthwatcher.data.mem.DiseaseTypeRepositoryArray;
import healthwatcher.data.mem.EmployeeRepositoryArray;
import healthwatcher.data.mem.HealthUnitRepositoryArray;
import healthwatcher.data.mem.SpecialityRepositoryArray;
import healthwatcher.data.rdb.ComplaintRepositoryRDB;
import healthwatcher.data.rdb.DiseaseTypeRepositoryRDB;
import healthwatcher.data.rdb.EmployeeRepositoryRDB;
import healthwatcher.data.rdb.HealthUnitRepositoryRDB;
import healthwatcher.data.rdb.SpecialityRepositoryRDB;
import lib.persistence.PersistenceMechanism;

public privileged aspect DecomposeConditional {
	// decompose conditional
	pointcut init(): initialization(HealthWatcherFacadeInit.new());

	after(HealthWatcherFacadeInit hwf) returning: init() && this(hwf) {
		hwf.complaintRecord = new ComplaintRecord(new ComplaintRepositoryArray());
		if (Constants.isPersistent()) {
			hwf.complaintRecord = new ComplaintRecord(
					new ComplaintRepositoryRDB((PersistenceMechanism) HealthWatcherFacade.getPm()));
		}
		hwf.healthUnitRecord = new HealthUnitRecord(new HealthUnitRepositoryArray());
		if (Constants.isPersistent()) {
			hwf.healthUnitRecord = new HealthUnitRecord(
					new HealthUnitRepositoryRDB((PersistenceMechanism) HealthWatcherFacade.getPm()));
		}
		hwf.specialityRecord = new MedicalSpecialityRecord(new SpecialityRepositoryArray());
		if (Constants.isPersistent()) {
			hwf.specialityRecord = new MedicalSpecialityRecord(
					new SpecialityRepositoryRDB((PersistenceMechanism) HealthWatcherFacade.getPm()));
		}
		DiseaseTypeRepositoryArray tp = new DiseaseTypeRepositoryArray();
		hwf.diseaseRecord = new DiseaseRecord(tp);
		if (Constants.isPersistent()) {
			hwf.diseaseRecord = new DiseaseRecord(
					new DiseaseTypeRepositoryRDB((PersistenceMechanism) HealthWatcherFacade.getPm()));
		}
		EmployeeRepositoryArray er = new EmployeeRepositoryArray();
		hwf.employeeRecord = new EmployeeRecord(er);
		if (Constants.isPersistent()) {
			hwf.employeeRecord = new EmployeeRecord(
					new EmployeeRepositoryRDB((PersistenceMechanism) HealthWatcherFacade.getPm()));
		}
	}
}
