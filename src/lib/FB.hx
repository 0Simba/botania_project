package lib;

@:native("FB")
extern class FB {
    public static function getLoginStatus (callback:Dynamic):Void;
    public static function ui (params:Dynamic = {}, callback:Dynamic):Void;
    public static function login (callback:Dynamic, params:Dynamic = {}):Void;
}
