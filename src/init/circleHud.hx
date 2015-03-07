package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class CircleHud
{

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        circleHudEngine.setBlockOffset(Config.display.tile.xSize / 2, 0);

        var centerRadius   = Config.display.hud.circle.centerRadius;
        var elementsRadius = Config.display.hud.circle.elementsRadius;


            //FLOWER
        var flowerHudManager = new manager.circlesHud.Flower();
        var flowerHud = circleHudEngine.createModel("flower", flowerHudManager.events, centerRadius, elementsRadius);
        flowerHud.addOnce("pick"      , "pickBasic");
        flowerHud.addOnce("dig"       , "digBasic");
        flowerHud.addOnce("water"     , "waterBasic");
        flowerHud.addOnce("fertilizer", "fertilizerBasic");
        flowerHudManager.setTargetHud(flowerHud);


            //BREAKER
        var breakerHudManager = new manager.circlesHud.Breaker();
        var breakerHud = circleHudEngine.createModel("breaker", breakerHudManager.events, centerRadius, elementsRadius);
        breakerHud.addOnce("remove", "digBasic");
        breakerHud.addOnce("open", "fertilizerBasic");
        breakerHudManager.setTargetHud(breakerHud);

    }

}
