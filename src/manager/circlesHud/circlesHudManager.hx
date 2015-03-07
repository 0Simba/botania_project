package manager.circlesHud;

import engine.events.Events;
import engine.circleHud.CircleBlock;
import entities.Tile;
import engine.circleHud.CirclesHudEngine;
import Map;

class CirclesHudManager
{

    static public  var list:Map<String, CirclesHudManager>;
    static private var currentShowed:CirclesHudManager;

    static public function displayForTile (tile:Tile) {
        var hudName = tile.currentBuild;
        hide();

        if (list.exists(hudName)) {
            currentShowed = list.get(hudName);

            if (tile.buildingRef != null) { //FIXME
                currentShowed.managedHud.show(tile.coordInPixel(), tile.buildingRef);
            }
            Selection.setNew("circleHud");
        }
        else {
            trace("CirclesHudManager -> Il n'existe pas de circleHud au nom de " + hudName);
        }
    }

    static public function hide () {
        Selection.backToLast();
        if (currentShowed != null) {
            currentShowed.managedHud.hide();
            currentShowed = null;
        }
    }

    static private function addOnce(name:String, circleHudManager:CirclesHudManager) {
        if (list == null) {
            list = new Map<String, CirclesHudManager>();
        }
        list.set(name, circleHudManager);
    }


    static private function onSelectionChanged () {
        if (Selection.actionType != "circleHud" && currentShowed != null) {
            currentShowed.managedHud.hide();
            currentShowed = null;
        }
    }



    public  var events:Events;
    private var managedHud:CircleBlock;

    public function new (name) {
        events = new Events();
        managedHud = CirclesHudEngine.getInstance().createModel(name, events);

        CirclesHudManager.addOnce(name, this);

        Selection.events.on("changed", onSelectionChanged);
    }

    public function close () {
        managedHud.hide();
        hide();
    }

}
