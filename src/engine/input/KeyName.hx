package engine.input;

class KeyName
{
    static public var list:Map<Int, String>;

    static public function set () {
        list  = new Map<Int, String>();

        list.set(37, "left");
        list.set(38, "up");
        list.set(39, "right");
        list.set(40, "down");
    }
}