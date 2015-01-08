package engine.eventsDispatcher;

/**
 * ...
 * @author Mathieu Anthoine
 */
class Event
{

	// TODO: Event qui pourrait etre déplacé dans une autre classe
	public static inline var COMPLETE: String           = "Event.COMPLETE";
	public static inline var ADDED: String              = "Event.ADDED";
	public static inline var ADDED_TO_STAGE: String     = "Event.ADDED_TO_STAGE";
	public static inline var REMOVED: String            = "Event.REMOVED";
	public static inline var REMOVED_FROM_STAGE: String = "Event.REMOVED_FROM_STAGE";

	//TODO: pas d'implémentation pour l'instant
	public static inline var ENTER_FRAME: String = "Event.ENTER_FRAME";

	// les getter/setter c'est moisi avec Reflect.field, ca retourne la variable privée
	public var type : String;
	public var target : Dynamic;
	public var currentTarget : Dynamic;

 	// TODO: voir la cohérences des parametres passés
	// en Flash : type:String, bubbles:Boolean = false, cancelable:Boolean = false
	public function new ( pType: String ) {
		type = pType;
	}

	public function formatToString (pArgs:Array<String>):String {
		var lTxt:String = "[" + Type.getClassName(Type.getClass(this));
		for ( i in 0...pArgs.length) lTxt +=" "+pArgs[i]+"="+Reflect.field(this,pArgs[i]);
		return lTxt + "]";

		//[Event type="complete" bubbles=false cancelable=false eventPhase=2]
		//[MouseEvent type="click" bubbles=true cancelable=false eventPhase=2 localX=NaN localY=NaN stageX=NaN stageY=NaN relatedObject=null ctrlKey=false altKey=false shiftKey=false buttonDown=false delta=0]

	}

	public function toString (): String {
		return formatToString(["type"]);
	}

 }