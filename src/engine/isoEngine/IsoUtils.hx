package engine.isoEngine;

import utils.Vector2;
import engine.isoEngine.components.Tile;

class IsoUtils
{

    static public function coordToPx (x:Int, y:Int):Vector2 {
        var px = new Vector2(0, 0);
        px.x = x * Tile.size / 2 - (y * Tile.size / 2);
        px.y = x * Tile.size / 4 + (y * Tile.size / 4);

        return px;
    }
}
