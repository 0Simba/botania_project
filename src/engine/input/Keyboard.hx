package engine.input;

import js.Browser;
import js.html.KeyboardEvent;

class Keyboard
{

	static public var key:Map<String, Bool>;

	static private function onKeyDown (pEvent:KeyboardEvent) {
		keyChange(pEvent.keyCode, true);
	}

	static private function onKeyUp (pEvent:KeyboardEvent) {
		keyChange(pEvent.keyCode, false);
	}


	static private function keyChange (keyCode:Int, value:Bool) {
		var keyName:String = KeyName.list.get(keyCode);
		if (keyName != null) {
			key.set(KeyName.list.get(keyCode), value);
		}
	}

	static public function init () {
		KeyName.set();
		key = new Map<String, Bool>();
		Browser.window.onkeydown = onKeyDown;
		Browser.window.onkeyup   = onKeyUp;
	}

}