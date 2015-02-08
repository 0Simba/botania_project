package engine.isoEngine;

import utils.Vector2;
import engine.isoEngine.components.Tile;

    // MEMO REFACTOR

class IsoUtils
{
    static public function coordToPx (x:Int, y:Int):Vector2 {
        var px = new Vector2(0, 0);
        px.x = x * Tile.size.x / 2 - (y * Tile.size.x / 2);
        px.y = x * Tile.size.x / 4 + (y * Tile.size.x / 4);

        return px;
    }
}
