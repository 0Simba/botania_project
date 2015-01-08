package engine.eventsDispatcher;

/**
 * ...
 * @author Mathieu Anthoine
 */
class EventDispatcher
{
	public var listeners: Array<Dynamic>;

	public var disposed (get, never): Bool;
	private var _disposed	: Bool;

	public function new ( ) {
		listeners = [];
	}

	/**
	 * Checks whether the EventDispatcher Dynamic has the listener registered for a specific pType of event.
	 * @param pType The pType of event.
	 * @param pListener The listener function that processes the event.
	 */
	public function hasEventListener(pType: String, pListener:Dynamic): Int {
		for ( i in 0...listeners.length ) {
			if ( listeners[i].type == pType && listeners[i].listener == pListener ) {
				return i;
			}
		}

		return -1;
	}

	/**
	 * Registers an event listener Dynamic with an EventDispatcher Dynamic so that the listener receives notification of an event.
	 * @param pType The pType of event.
	 * @param pListener The listener function that processes the event. This function must accept an Event Dynamic as its only parameter and must return nothing.
	 */
	public function addEventListener(pType: String, pListener:Dynamic): Void {
		if (_disposed) return;
		var lId: Int = hasEventListener(pType, pListener);
		if ( lId == -1 ) {
			listeners.push({ type: pType, listener: pListener,target:this,currentTarget:this });
		}
	}

	/**
	 * Removes a listener from the EventDispatcher Dynamic. If there is no matching listener registered with the EventDispatcher Dynamic, a call to this method has no effect.
	 * @param pType The pType of event.
	 * @param pListener The listener Dynamic to remove.
	 */
	public function removeEventListener(pType: String, pListener:Dynamic): Void {
		if (_disposed) return;
		var lId: Int = hasEventListener(pType, pListener);
		//trace("removeEventListener", pType, lId);
		if ( lId != -1 ) {
			listeners.splice(lId, 1);
		}

	}

	/**
	 * Dispatches an event into the event flow.
	 *
	 * The event target is the EventDispatcher Dynamic upon which the dispatchEvent() method is called.
	 *
	 * @param evt The Event Dynamic that is dispatched into the event flow.
	 */
	public function dispatchEvent(pEvt: Event): Void {

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
