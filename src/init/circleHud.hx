package init;

import engine.circleHud.CirclesHudEngine;

class CircleHud
{

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        var flowerHud       = circleHudEngine.createModel("flower", 100, 50);

        flowerHud.addOnce("pick", "pick");
    }

}
