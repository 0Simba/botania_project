package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.isoEngine.IsoEngine;
import engine.events.Events;

class CirclesHudEngine
{
    private static var instance:CirclesHudEngine;

    public function createModel (name:String, referent:Events, centerRadius:Int, elementsRadius:Int) {
        model.set(name, new CircleBlock(referent, centerRadius, elementsRadius, name));
        return model.get(name);
    }


    public function get (name:String):CircleBlock {
        if (model.exists(name)) {
            return model.get(name);
        }
        trace("Il n'existe pas de model " + name + " dans CirclesHudEngine");
        return null;
    }




    /****** SURELY NOT INTERSET YOU *****/

    public function setBlockOffset (_x:Float, _y:Float) {
        offsetX = _x;
        offsetY = _y;
    }

    /****** YOU DON'T CARE *****/

    private static var model:Map<String, CircleBlock>;

    public var offsetX:Float = 0;
    public var offsetY:Float = 0;

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
