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
        new manager.circlesHud.Workshop();

        /* EcosystemBuildings */
        new manager.circlesHud.ecosystemBuildings.Hive("Cerana");
        new manager.circlesHud.ecosystemBuildings.Hive("Mellifera");

        new manager.circlesHud.ecosystemBuildings.Anthill("anthill1");
        new manager.circlesHud.ecosystemBuildings.Anthill("anthill2");
        new manager.circlesHud.ecosystemBuildings.Anthill("anthill3");

        new manager.circlesHud.ecosystemBuildings.ButterflyTree("butterflyTree1");
        new manager.circlesHud.ecosystemBuildings.ButterflyTree("butterflyTree2");
        new manager.circlesHud.ecosystemBuildings.ButterflyTree("butterflyTree3");
    }

}
