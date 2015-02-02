package utils;


class MapManipulate
{
    static public function toArray (map:Map<String, Dynamic>) : Array<Dynamic> {
        var keyArr = new Array<String>();
        for (key in map) {
            keyArr.push(key);
        }
        return keyArr;
    }

    static public function ifExists (map:Map<String, Dynamic>, name:String, callback, endingMessage:String = null, ?pos : haxe.PosInfos) {
        if (map.exists(name)) {
            callback();
        }
        else {
            logError(name, endingMessage, pos);
        }
    }

    static public function ifIsFree (map:Map<String, Dynamic>, name:String, callback, endingMessage:String = null, ?pos : haxe.PosInfos) {
        if (!map.exists(name)) {
            callback();
        }
        else {
            logError(name, endingMessage, pos);
        }
    }

    static private function logError (name:String, endingMessage:String, pos) {
        var message = ${pos.className} + "." + ${pos.methodName} + " -> Il n'existe pas de clef " + name;
        if (endingMessage != null) {
            message += " pour " + endingMessage;
        }
        trace(message);
    }
}