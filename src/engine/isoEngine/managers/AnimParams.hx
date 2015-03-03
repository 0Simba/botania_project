package engine.isoEngine.managers;

import pixi.geom.Point;
import utils.Vector2;

class AnimParams {
    static private var animsParams = new Map<String, AnimParams>();

    static public function get (name:String) {
        return animsParams.get(name);
    }

    public var speed:Float;
    public var anchor:Point;
    public var size:Vector2;

    public function new (name, _speed, _anchor, _size) {
        speed  = _speed;
        anchor = _anchor;
        size   = _size;

        animsParams.set(name, this);
    }
}
