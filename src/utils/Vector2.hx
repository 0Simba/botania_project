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


    public function sum (other:Vector2):Vector2 {
        return new Vector2(this.x + other.x, this.y + other.y);
    }


    static public var zero  (get, set):Vector2;
    static public var full  (get, set):Vector2;
    static public var right (get, set):Vector2;
    static public var left  (get, set):Vector2;
    static public var up    (get, set):Vector2;
    static public var down  (get, set):Vector2;
    static public var mid   (get, set):Vector2;

    static function get_zero  () {return new Vector2(0 , 0);}
    static function get_full  () {return new Vector2(1 , 1);}
    static function get_right () {return new Vector2(1 , 0);}
    static function get_left  () {return new Vector2(-1, 0);}
    static function get_up    () {return new Vector2(0 , 1);}
    static function get_down  () {return new Vector2(0 , -1);}
    static function get_mid   () {return new Vector2(0.5 , 0.5);}

    static function set_zero  (a) {return null;}
    static function set_full  (a) {return null;}
    static function set_right (a) {return null;}
    static function set_left  (a) {return null;}
    static function set_up    (a) {return null;}
    static function set_down  (a) {return null;}
    static function set_mid   (a) {return null;}

}