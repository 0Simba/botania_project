package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class CircleHud
{

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        circleHudEngine.setBlockOffset(Config.display.tile.size / 2, 0);

        var centerRadius   = Config.display.hud.circle.centerRadius;
        var elementsRadius = Config.display.hud.circle.elementsRadius;


            //FLOWER
        var flowerHudManager = new manager.circlesHud.Flower();
        var flowerHud = circleHudEngine.createModel("flower", flowerHudManager.events, centerRadius, elementsRadius);
        flowerHud.addOnce("pick"      , "pickBasic"      , "pickHover"      , "pickClick");
        flowerHud.addOnce("dig"       , "digBasic"       , "digHover"       , "digClick");
        flowerHud.addOnce("water"     , "waterBasic"     , "waterHover"     , "waterClick");
        flowerHud.addOnce("fertilizer", "fertilizerBasic", "fertilizerHover", "fertilizerClick");
        flowerHudManager.setTargetHud(flowerHud);


            //BREAKER
        var breakerHudManager = new manager.circlesHud.Breaker();
        var breakerHud = circleHudEngine.createModel("breaker", breakerHudManager.events, centerRadius, elementsRadius);
        breakerHud.addOnce("remove", "digBasic", "digHover", "digClick");
        breakerHud.addOnce("open", "fertilizerBasic", "fertilizerHover", "fertilizerClick");
        breakerHudManager.setTargetHud(breakerHud);

    }

}
