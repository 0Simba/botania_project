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
}