package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.isoEngine.IsoEngine;

class CirclesHudEngine
{
    private static var instance:CirclesHudEngine;

    public function createModel (name:String, centerRadius:Int, elementsRadius:Int) {
        model.set(name, new CircleBlock(centerRadius, elementsRadius, name));
        return model.get(name);
    }






    /****** YOU DON'T CARE *****/

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

}
