package patterns.observable;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public abstract class ObservableList implements Iterable<Object> {

	private List<Object> list = new ArrayList<Object>();

	public int size() {
		return list.size();
	}

	protected Object getElement(int i) {
		return list.get(i);
	}
	
	@Override
	public Iterator<Object> iterator() {
		return list.iterator();
	}
	
	private void checkIndex(int pos, int d) {
		if (pos < 0 || pos + d > list.size()) {
			throw new IndexOutOfBoundsException(pos + " is out of bounds");
		}
	}
	
	protected void addElement(int pos, Object element) {
		checkIndex(pos, 0);
		list.add(pos, element);
		fireListChanged(pos);
	}
	protected void removeElement(int pos) {
		checkIndex(pos, 1);
		list.remove(pos);
		fireListChanged(pos);
	}

	protected void addElement(Object element) {
		addElement(list.size(), element);
	}
	protected void removeElement(Object element) {
		int pos = list.indexOf(element);
		if (pos >= 0) {
			removeElement(pos);
		}
	}
	
	//
	
	private List<ListListener> listListeners = new ArrayList<ListListener>();

	public void addListListener(ListListener listListener) {
		if (! listListeners.contains(listListener)) {
			listListeners.add(listListener);
		}
	}

	public void removeListListener(ListListener listListener) {
		listListeners.remove(listListener);
	}
	
	protected void fireListChanged(int pos) {
		for (ListListener listListener : listListeners) {
			listListener.listChanged(this, pos);
		}
	}
}