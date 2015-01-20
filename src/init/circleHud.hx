package init;

import engine.circleHud.CirclesHudEngine;

class CircleHud
{

    static public function load () {
        var circleHud = CirclesHudEngine.getInstance();
        var flowerHud = circleHud.createModel("flower", 100, 50);

        flowerHud.addOnce("delete");
    }

}
