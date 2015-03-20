package manager.circlesHud;

import engine.events.Events;
import engine.circleHud.CircleBlock;
import entities.Tile;
import engine.circleHud.CirclesHudEngine;
import engine.tween.Tween;
import engine.tween.Ease;
import utils.Vector2;
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
                var coord = tile.coordInPixel();
                coord.y -= 30;                  // /!\ WARNNIG
                currentShowed.managedHud.show(coord, tile.buildingRef);
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
            currentShowed.tweenHide();
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
            currentShowed.tweenHide();
            currentShowed = null;
        }
    }




    public  var events:Events;
    private var managedHud:CircleBlock;
    private var tween:Tween;

    public function new (name) {
        createTween();
        events = new Events();
        managedHud = CirclesHudEngine.getInstance().createModel(name, events);
        managedHud.onShow = tweenShow;

        CirclesHudManager.addOnce(name, this);

        Selection.events.on("changed", onSelectionChanged);
    }


    private var poping:Bool = false;

    public function tweenShow () {
        poping = true;
        tween.ease(Ease.linear);
        tween.start();
    }

    public function close () {
        tweenHide();
    }

    public function tweenHide () {
        poping = false;
        tween.ease(Ease.linearInvert);
        tween.start();
    }

    public function tweenUpdate (currentDatas) {
        managedHud.forEachElement(function (element) {
            var ratio    = currentDatas.get("ratio");

            var distance = managedHud.centerRadius * ratio;
            var sumAngle = element.angle + (1 - ratio) * Math.PI;
            var position = new Vector2(distance * Math.cos(sumAngle), distance * Math.sin(sumAngle), "px", "px");

            var size = (ratio / 2 + 0.5) * managedHud.elementsRadius;

            element.hudButton.replace(position);
            element.hudButton.resize(new Vector2(size, size, "px", "px"));
        });
    }


    private function createTween () {
        var from = new Map<String, Float>();
        from.set("ratio", 0);

        var to = new Map<String, Float>();
        to.set("ratio", 1);

        tween = new Tween (from, to, 300);
        tween.onUpdate(tweenUpdate);
        tween.onComplete(function () {
            if (!poping) managedHud.hide();
        });
    }

    public function removeBuilding(t:entities.Building){
        close();
        t.destroyFromServer();
    }
}
