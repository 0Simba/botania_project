package manager;

import engine.circleHud.CirclesHudEngine;
import entities.Tile;
import utils.Vector2;

class MouseTile
{

    static public function over (tile:Tile) {
        if (Selection.contain == null) return;

        if (Selection.actionType == "ground") {
            tile.graphicTile.changeGround(Selection.contain);
        }
        else if (Selection.actionType == "build" && tile.currentBuild == null) {
            tile.graphicTile.changeBuild(Selection.contain);
        }

    }

    static public function out (tile:Tile) {
        if (Selection.actionType == "ground") {
            tile.graphicTile.changeGround(tile.currentGround);
        }
        else if (Selection.actionType == "build" && tile.currentBuild == null) {
            tile.graphicTile.changeBuild(tile.currentBuild);
        }
    }

    static public function click (tile:Tile) {
        if (Selection.contain == null) return;

        if (Selection.actionType == "ground") {
            tile.currentGround = Selection.contain;
            tile.graphicTile.changeGround(tile.currentGround);
        }
        else if (Selection.actionType == "build") {
            if (tile.currentBuild == null) {
                tile.createFlower();                             //!\ MOVE THIS ! /!\
            }
            else {
                CirclesHudEngine.getInstance().get("flower").show(engine.isoEngine.IsoUtils.coordToPx(tile.coord.x, tile.coord.y));
            }
        }
    }

}
