package manager;

import engine.circleHud.CirclesHudEngine;
import entities.Tile;
import utils.Vector2;

class MouseTile
{
    static private var circlesHudEngine:CirclesHudEngine;

    static public function init () {
        circlesHudEngine = CirclesHudEngine.getInstance();
    }

    static public function over (tile:Tile) {
        if (Selection.contain == null) return;

        if (Selection.actionType == "ground") {
            tile.graphicTile.changeGround(Selection.contain);
        }
        else if (Selection.actionType == "build" && tile.currentBuild == null) {
            tile.graphicTile.changeBuild(Selection.contain);
        }
        else if (Selection.actionType == "plant" && tile.currentBuild == null) {
            tile.graphicTile.changeBuild("adultFlower");
        }

    }


    static public function out (tile:Tile) {
        if (Selection.actionType == "ground") {
            tile.graphicTile.changeGround(tile.currentGround);
        }
        else if (Selection.actionType == "build" && tile.currentBuild == null) {
            tile.graphicTile.changeBuild(tile.currentBuild);
        }
        else if (Selection.actionType == "plant" && tile.currentBuild == null) {
            tile.graphicTile.changeBuild(tile.currentBuild);
        }

    }


    static public function click (tile:Tile) {
        if (tile.currentBuild != null) {
            manager.circlesHud.CirclesHudManager.displayForTile(tile);
            return;
        }
        else if (Selection.actionType == "circleHud") {
            manager.circlesHud.CirclesHudManager.hide();
            return;
        }
        else if (Selection.contain == null) return;
        else if (Selection.actionType == "ground") {
            tile.currentGround = Selection.contain;
            tile.graphicTile.changeGround(tile.currentGround);
        }
        else if (Selection.actionType == "build" && tile.currentBuild == null) {
                /***** FIXME MOVE THIS LATER *****/
            if (Selection.contain == "breaker") {
                tile.createBreaker();
            }
            else {
                trace("MouseTile.click -> pas d'action pour Selection.contain " + Selection.contain);
            }
        }
        else if (Selection.actionType == "plant" && tile.currentBuild == null) {
            tile.createFlower(Selection.meta);
            Selection.clear();
        }
    }

}
