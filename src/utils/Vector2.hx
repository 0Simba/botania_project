package utils;


class Vector2
{

    public var x:Float;
    public var y:Float;

	public function new (_x:Float = 0, _y:Float) {
        x = _x;
        y = _y;
    }

    static public var zero = new Vector2(0, 0);

    static public var full = new Vector2(1, 1);
}