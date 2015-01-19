
package engine.eventsDispatcher;

import engine.events.Event;

class LoaderEvent extends Event {

	public static inline var PROGRESS:String = "LoaderEvent.PROGRESS";
	public static inline var COMPLETE:String = "LoaderEvent.COMPLETE";

	public var progress:Float;

	public function new ( pType:String,pProgress:Float=-1 ) {
		super(pType);
		progress = pProgress;

	}

	override public function toString():String {
		if ( type==PROGRESS) return formatToString(["type","progress"]);
		return super.toString();
	}

 }