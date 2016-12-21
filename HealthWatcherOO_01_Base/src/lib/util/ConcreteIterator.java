package lib.util;

import java.io.Serializable;
import java.util.List;

public class ConcreteIterator implements LocalIterator, Serializable {

	private List list = null;
	private int index = -1;

	public ConcreteIterator(List list) {

		this.list = list;
		this.index = 0;
	}

	public boolean hasNext() {

		if (list != null) {
			return list.size() > index;
		} else {
			return false;
		}
	}

	public Object next() {

		if (list != null) {
			return list.get(index++);
		} else {
			return null;
		}
	}

	public int getIndex() {
		return index;
	}

	public int getListSize() {
		return list.size();
	}

	public void remove() {
	}

	public void close() {
	}
}
