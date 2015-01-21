package engine.circleHud;

import engine.circleHud.CircleElement;
import engine.isoEngine.IsoEngine;

class CircleBlock
{

    public var layerName:String;
    private var centerRadius:Int;
    private var elementsRadius:Int;
    private var elements:Map<String, CircleElement>;


    public function new (_centerRadius:Int, _elementsRadius:Int, _layerName:String) {
        centerRadius   = _centerRadius;
        elementsRadius = _elementsRadius;
        layerName      = _layerName;

        IsoEngine.getInstance().displaying.createChildLayer(layerName, "circleHud");
        elements = new Map<String, CircleElement>();
    }

    public function addOnce (name:String, texture:String) {
        elements.set(name, new CircleElement(this, name, texture));
        return elements.get(name);
    }

}
