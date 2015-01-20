package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.isoEngine.IsoEngine;

class CirclesHudEngine
{
    private static var instance:CirclesHudEngine;
    private static var model:Map<String, CircleBlock>;

    public static function getInstance (): CirclesHudEngine {
        if (instance == null) {
            instance = new CirclesHudEngine();
        }
        return instance;
    }

    private function new () {
        model = new Map<String, CircleBlock>();
        IsoEngine.getInstance().displaying.createChildLayer("circleHud", "fx");
    }

    public function createModel (name, centerRadius:Int, elementsRadius:Int) {
        model.set(name, new CircleBlock(centerRadius, elementsRadius, name));
        return model.get(name);
    }

}
