package manager;

import engine.circleHud.CirclesHudEngine;
import entities.Tile;
import utils.Vector2;
import engine.isoEngine.components.Button;
import engine.isoEngine.IsoEngine;

class MouseTile
{
    static private var circlesHudEngine:CirclesHudEngine;
    static public  var currentTile:Tile;

    static public function init () {
        circlesHudEngine = CirclesHudEngine.getInstance();
    }

    static public function over (tile:Tile) {
        currentTile = tile;
        if (!Button.oneOver) {
            tile.graphicTile.lightFilterBuilding();
        }

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

        tile.graphicTile.noFilterBuilding();
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
                tile.createBuilding(Selection.contain);
            if (Selection.contain == "breaker") {
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
