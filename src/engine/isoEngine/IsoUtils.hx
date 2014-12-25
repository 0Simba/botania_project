package engine.isoEngine;

import utils.Vector2;

class IsoUtils
{

    static public function coordToPx (x:Int, y:Int):Vector2 {
        var px = new Vector2(0, 0);
        px.x = x * size / 2 - (y * size / 2);
        px.y = x * size / 4 + (y * size / 4);

        return px;
    }

    // static public function 



        /***** YOU DON'T CARE *****/
    static private var size:Int = 0;

    static public function setSize (_size:Int) {
        size = _size;
    }
}
