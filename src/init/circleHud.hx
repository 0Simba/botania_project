package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class CircleHud
{

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        var flowerHud       = circleHudEngine.createModel("flower", Config.display.tile.size, Config.display.tile.size);

        flowerHud.addOnce("pick"      , "pickBasic"      , "pickHover"      , "pickClick");
        flowerHud.addOnce("dig"       , "digBasic"       , "digHover"       , "digClick");
        flowerHud.addOnce("water"     , "waterBasic"     , "waterHover"     , "waterClick");
        flowerHud.addOnce("fertilizer", "fertilizerBasic", "fertilizerHover", "fertilizerClick");
        flowerHud.show(new Vector2(150, 200));
    }

}
