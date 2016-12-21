package aspects;

import healthwatcher.business.complaint.ComplaintRecord;
import healthwatcher.model.complaint.AnimalComplaint;
import healthwatcher.model.complaint.Complaint;
import healthwatcher.model.complaint.FoodComplaint;
import lib.util.Functions;

public aspect ComplaintValidator {
	before(Complaint complaint): execution(public int ComplaintRecord.insert(Complaint)) && args(complaint) {
		validate(complaint);
	}
	
	private void validate(Complaint complaint) {
		Functions f = new Functions();

		if (complaint == null) {
			throw new IllegalArgumentException();
		}

		f.campoPreenchido(complaint.getDescricao());

		if (complaint instanceof AnimalComplaint) {
			f.campoPreenchido(((AnimalComplaint) complaint).getOccurenceLocalAddress());
			f.campoPreenchido(((AnimalComplaint) complaint).getAnimal());
		}

		if (complaint instanceof FoodComplaint) {
			f.campoPreenchido(((FoodComplaint) complaint).getQtdeComensais());
			f.campoPreenchido(((FoodComplaint) complaint).getQtdeDoentes());
		}
	}
}