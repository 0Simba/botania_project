package utils;


class Vector2
{

    public var x:Float;
    public var y:Float;
    public var metaX:String;
    public var metaY:String;

	public function new (_x:Float, _y:Float, _metaX:String = null, _metaY:String = null) {
        x = _x;
        y = _y;
        metaX = _metaX;
        metaY = _metaY;
    }

    static public var zero  = new Vector2(0 , 0);
    static public var full  = new Vector2(1 , 1);
    static public var right = new Vector2(1 , 0);
    static public var left  = new Vector2(-1, 0);
    static public var up    = new Vector2(0 , 1);
    static public var down  = new Vector2(0 , -1);
}