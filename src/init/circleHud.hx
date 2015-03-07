package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class CircleHud
{

    static public var centerRadius;
    static public var elementsRadius;

    static public function load () {
        var circleHudEngine = CirclesHudEngine.getInstance();
        circleHudEngine.setBlockOffset(Config.display.tile.xSize / 2, 0);


        centerRadius   = Config.display.hud.circle.centerRadius;
        elementsRadius = Config.display.hud.circle.elementsRadius;
        circleHudEngine.setDefaultsRadius(centerRadius, elementsRadius);


        new manager.circlesHud.Flower();
        new manager.circlesHud.Breaker();

    }

}
