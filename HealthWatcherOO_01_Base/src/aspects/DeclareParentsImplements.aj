package aspects;

import healthwatcher.model.complaint.AnimalComplaint;
import healthwatcher.model.complaint.Complaint;
import healthwatcher.model.complaint.FoodComplaint;
import healthwatcher.model.complaint.SpecialComplaint;
import healthwatcher.model.complaint.DiseaseType;
import healthwatcher.model.complaint.Situation;
import healthwatcher.model.complaint.Symptom;
import java.io.Serializable;
import healthwatcher.model.employee.Employee;
import healthwatcher.model.healthguide.HealthUnit;
import healthwatcher.model.healthguide.MedicalSpeciality;

public aspect DeclareParentsImplements {
	
	declare parents: AnimalComplaint extends Complaint;
	declare parents: FoodComplaint extends Complaint;
	declare parents: SpecialComplaint extends Complaint;

	declare parents: Complaint implements java.io.Serializable;
	declare parents: DiseaseType implements java.io.Serializable;
	declare parents: Situation implements Serializable;
	declare parents: Symptom implements java.io.Serializable;
	declare parents: Employee implements Serializable;
	declare parents: HealthUnit implements java.io.Serializable;
	declare parents: MedicalSpeciality implements java.io.Serializable;
}
