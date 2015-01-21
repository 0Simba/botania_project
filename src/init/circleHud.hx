package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class CircleHud
{

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        var flowerHud       = circleHudEngine.createModel("flower", 150, 100);

        flowerHud.addOnce("pick", "pick");
        flowerHud.addOnce("dig", "dig");
        flowerHud.addOnce("water", "water");
        flowerHud.addOnce("fertilizer", "fertilizer");
        flowerHud.show(new Vector2(150, 200));
    }

}
