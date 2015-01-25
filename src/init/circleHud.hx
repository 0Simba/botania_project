package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class CircleHud
{

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        circleHudEngine.setBlockOffset(Config.display.tile.size / 2, 0);

        var flowerHudManager = new manager.circlesHud.Flower();

        var flowerHud = circleHudEngine.createModel("flower", flowerHudManager.events, Config.display.hud.circle.centerRadius, Config.display.hud.circle.elementsRadius);
        flowerHud.addOnce("pick"      , "pickBasic"      , "pickHover"      , "pickClick");
        flowerHud.addOnce("dig"       , "digBasic"       , "digHover"       , "digClick");
        flowerHud.addOnce("water"     , "waterBasic"     , "waterHover"     , "waterClick");
        flowerHud.addOnce("fertilizer", "fertilizerBasic", "fertilizerHover", "fertilizerClick");

        flowerHudManager.setTargetHud(flowerHud);
    }

}
