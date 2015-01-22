package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class CircleHud
{

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        var flowerHud       = circleHudEngine.createModel("flower", Config.display.tile.size, Config.display.tile.size);

        flowerHud.addOnce("pick", "pick");
        flowerHud.addOnce("dig", "dig");
        flowerHud.addOnce("water", "water");
        flowerHud.addOnce("fertilizer", "fertilizer");
        flowerHud.show(new Vector2(150, 200));
    }

}
