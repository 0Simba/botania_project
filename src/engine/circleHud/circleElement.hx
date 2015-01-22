package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;
import utils.Vector2;

class CircleElement extends GameObject
{
    private var name:String;
    private var parent:CircleBlock;
    private var referent:Events;

    private var basicTexture:String;
    private var hoverTexture:String;
    private var clickTexture:String;

    public function new (_parent:CircleBlock, _name:String, _basicTexture:String, _hoverTexture:String, _clickTexture:String) {
        super();

        parent = _parent;
        name   = _name;

        basicTexture = _basicTexture;
        hoverTexture = _hoverTexture;
        clickTexture = _clickTexture;

        addComponent("hudElement");
        hudElement.set(new Vector2(100, 100) , new Vector2(0, 0) , "circleNavigation", basicTexture, parent.layerName);
        hudElement.resize(new Vector2(parent.elementsRadius, parent.elementsRadius));
        hudElement.bindEvents(over, out, click);
    }

    public function replace (pos:Vector2) {
        hudElement.replace(pos, true);
    }

    private function over () {
        hudElement.changeTexture(hoverTexture);
    }

    private function out () {
        hudElement.changeTexture(basicTexture);
    }

    private function click () {
        hudElement.changeTexture(clickTexture);
    }
}