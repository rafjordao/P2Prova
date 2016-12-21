package aspects;

import java.io.Serializable;

public aspect SerializableMarker {
	declare parents: healthwatcher.model..* implements Serializable;
}
