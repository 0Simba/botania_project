package utils;


class ArrayCoord
{

    public var x:Int;
    public var y:Int;
    public var i:Int;

    public function new (_x:Int = 0, _y:Int, _i:Int) {
        x = _x;
        y = _y;
        i = _i;
    }

    public function toVector2 ():utils.Vector2 {
        return new Vector2(x, y);
    }
}