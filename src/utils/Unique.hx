package utils;

class Unique
{
    static private var id:Int = 0;

    static public function getId () {
        return id++;
    }
}
