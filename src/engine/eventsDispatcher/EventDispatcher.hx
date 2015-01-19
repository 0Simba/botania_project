package engine.eventsDispatcher;

class EventDispatcher
{
	public var listeners: Array<Dynamic>;

	public var disposed (get, never): Bool;
	private var _disposed	: Bool;

	public function new ( ) {
		listeners = [];
	}

	public function get(pType: String, pListener:Dynamic): Int {
		for ( i in 0...listeners.length ) {
			if ( listeners[i].type == pType && listeners[i].listener == pListener ) {
				return i;
			}
		}

		return -1;
	}

	public function on (pType: String, pListener:Dynamic): Void {
		if (_disposed) return;
		var lId: Int = get(pType, pListener);
		if ( lId == -1 ) {
			listeners.push({ type: pType, listener: pListener,target:this,currentTarget:this });
		}
	}

	public function remove(pType: String, pListener:Dynamic): Void {
		if (_disposed) return;
		var lId: Int = get(pType, pListener);
		//trace("removeEventListener", pType, lId);
		if ( lId != -1 ) {
			listeners.splice(lId, 1);
		}

	}

	public function emit(pEvt: Event): Void {

		// TODO : Improve proofness
		var lDispatch:Array<Dynamic>= [];

		for ( i in 0...listeners.length ) {
			if ( listeners[i].type == pEvt.type ) {
				lDispatch.push(listeners[i]);
			}
		}

		pEvt.currentTarget = this;
		pEvt.target = this;

		for ( i in 0...lDispatch.length ) {
			Reflect.callMethod(this, lDispatch[i].listener, [pEvt]);
		}

	}

	public function destroy(pEvent : Event = null) : Void {
		listeners = null;
		_disposed = true;
	}

	public function get_disposed() : Bool {
		return _disposed;
	}


 }
