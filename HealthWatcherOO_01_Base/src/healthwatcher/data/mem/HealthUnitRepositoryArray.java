package healthwatcher.data.mem;

import healthwatcher.data.IHealthUnitRepository;
import healthwatcher.model.healthguide.HealthUnit;
import healthwatcher.model.healthguide.MedicalSpeciality;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lib.exceptions.ObjectAlreadyInsertedException;
import lib.exceptions.ObjectNotFoundException;
import lib.exceptions.RepositoryException;
import lib.util.ConcreteIterator;
import lib.util.IteratorDsk;

public class HealthUnitRepositoryArray implements IHealthUnitRepository {

	private HealthUnit[] vetor;

	private int indice;

	private int ponteiro; // para navegacao

	public HealthUnitRepositoryArray() {
		vetor = new HealthUnit[100];
		indice = 0;
		List specialities = new ArrayList();
		MedicalSpeciality ms = new MedicalSpeciality("Urology");
		ms.setCodigo(0);
		MedicalSpeciality ms2 = new MedicalSpeciality("Cardiology");
		ms2.setCodigo(1);
		MedicalSpeciality ms3 = new MedicalSpeciality("Oncology");
		ms3.setCodigo(2);
		specialities.add(ms);
		specialities.add(ms2);
		specialities.add(ms3);
		List specialities2 = new ArrayList();
		MedicalSpeciality ms4 = new MedicalSpeciality("Psicotherapy");
		ms4.setCodigo(3);
		MedicalSpeciality ms5 = new MedicalSpeciality("Odontology");
		ms5.setCodigo(4);
		specialities2.add(ms);
		specialities2.add(ms4);
		specialities2.add(ms5);
		specialities.add(ms5);
		try {
			this.insert(new HealthUnit("UPA Olinda (Bairro Novo)", specialities2));
			this.insert(new HealthUnit("Hosptial Portugues, Recife", specialities));
		} catch (RepositoryException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ObjectAlreadyInsertedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void update(HealthUnit unit) throws RepositoryException, ObjectNotFoundException {
		int i = getIndex(unit.getCode());
		if (i == indice) {
			throw new ObjectNotFoundException("Health unit not found");
		} else {
			vetor[i] = unit;
		}
	}

	public boolean exists(int code) throws RepositoryException {
		boolean flag = false;

		for (int i = 0; i < indice; i++) {
			if (this.vetor[i].getCode() == code) {
				flag = true;
				break;
			}
		}
		return flag;
	}

	public boolean hasNext() {
		return ponteiro < indice;
	}

	public IteratorDsk getHealthUnitList() throws RepositoryException, ObjectNotFoundException {
		if (indice == 0)
			throw new ObjectNotFoundException("There isn't registered Health units");
		return new ConcreteIterator(Arrays.asList(vetor));
	}

	public IteratorDsk getPartialHealthUnitList() throws RepositoryException, ObjectNotFoundException {
		return new ConcreteIterator(Arrays.asList(vetor));
	}

	public IteratorDsk getHealthUnitListBySpeciality(int code) throws RepositoryException, ObjectNotFoundException {
		int aux = 0;
		List response = new ArrayList();

		while (aux < indice) {

			if (vetor[aux].hasSpeciality(code)) {
				response.add(vetor[aux]);
			}
			aux++;
		}

		if (!response.isEmpty()) {
			return new ConcreteIterator(response);
		} else {
			throw new ObjectNotFoundException("There isn't registered health units for the specialty");
		}
	}

	public void reset() {
		this.ponteiro = 0;
	}

	public void insert(HealthUnit unit) throws RepositoryException, ObjectAlreadyInsertedException {
		if (unit == null) {
			throw new IllegalArgumentException();
		}
		this.vetor[indice] = unit;
		unit.setCode(indice++);
	}

	public HealthUnit search(int code) throws RepositoryException, ObjectNotFoundException {
		HealthUnit response = null;
		int i = getIndex(code);
		if (i == indice) {
			throw new ObjectNotFoundException("Health unit not found");
		} else {
			response = vetor[i];
		}
		return response;
	}

	public Object next() {
		if (ponteiro >= indice) {
			return null;
		} else {
			return vetor[ponteiro++];
		}
	}

	public void remove(int code) throws RepositoryException, ObjectNotFoundException {
		int i = getIndex(code);
		if (i == indice) {
			throw new ObjectNotFoundException("Health unit not found");
		} else {
			vetor[i] = vetor[indice - 1];
			indice = indice - 1;
		}
	}

	private int getIndex(int code) {
		int temp;
		boolean flag = false;
		int i = 0;
		while ((!flag) && (i < indice)) {
			temp = vetor[i].getCode();
			if (temp == code) {
				flag = true;
			} else {
				i = i + 1;
			}
		}
		return i;
	}
}
