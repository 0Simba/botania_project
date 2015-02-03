package manager.circlesHud;

import engine.events.Events;
import engine.circleHud.CircleBlock;
import entities.Tile;
import Map;

class CirclesHudManager
{

    static public var list:Map<String, CirclesHudManager>;
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




    public  var events:Events;
    private var managedHud:CircleBlock;

    public function new (name) {
        events = new Events();
        CirclesHudManager.addOnce(name, this);
    }

    public function setTargetHud (circleBlock:CircleBlock) {
        managedHud = circleBlock;
    }

    public function close () {
        managedHud.hide();
        hide();
    }

}
