package engine.eventsDispatcher;

class Event
{
	public var type : String;
	public var target : Dynamic;
	public var currentTarget : Dynamic;

	public function new ( pType: String ) {
		type = pType;
	}

	public function formatToString (pArgs:Array<String>):String {
		var lTxt:String = "[" + Type.getClassName(Type.getClass(this));
		for ( i in 0...pArgs.length) lTxt +=" "+pArgs[i]+"="+Reflect.field(this,pArgs[i]);
		return lTxt + "]";
	}

	public function toString (): String {
		return formatToString(["type"]);
	}

 }