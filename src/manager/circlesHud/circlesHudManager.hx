package manager.circlesHud;

import engine.events.Events;
import engine.circleHud.CircleBlock;
import entities.Tile;
import Map;

class CirclesHudManager
{

    static public var list:Map<String, CirclesHudManager>;

    static public function displayForTile (tile:Tile) {
        var hudName = tile.currentBuild;

        if (list.exists(hudName)) {
            var targetManager = list.get(hudName);
            targetManager.managedHud.show(tile.coordInPixel(), tile.flowerRef);
            Selection.actionType = "hud";
        }
        else {
            trace("CirclesHudManager -> Il n'existe pas de hud au nom de " + hudName);
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

}
