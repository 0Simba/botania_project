package engine.input;

class KeyName
{
    static public var list:Map<Int, String>;

    static public function set () {
        list  = new Map<Int, String>();
        var keyboard = init.Config.camera.keyboard;
        for(keyName in Reflect.fields(keyboard)){
        	var keyCode:Int = Reflect.field(keyboard, keyName);
        	list.set(keyCode, keyName);
        }
    }
}