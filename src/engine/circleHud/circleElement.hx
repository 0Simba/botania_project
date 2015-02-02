package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;
import utils.Vector2;

class CircleElement extends GameObject
{
    private var name:String;
    private var parent:CircleBlock;
    private var referent:Events;

    public function new (_parent:CircleBlock, _name:String, basicTexture:String, hoverTexture:String, clickTexture:String) {
        super();

        parent = _parent;
        name   = _name;

        addComponent("hudButton");
        hudButton.set(new Vector2(parent.elementsRadius, parent.elementsRadius), new Vector2(0, 0), basicTexture, parent.layerName); // TODO virer le vector2(100, 100)
        hudButton.setTextures(basicTexture, hoverTexture, clickTexture);
        hudButton.bindEvents(over, out, click);
    }

    public function replace (pos:Vector2) {
        hudButton.replace(pos, true);
    }

    private function over () {
    }

    private function out () {
    }

    private function click () {
        parent.referent.emit(name, parent.targetShowed);
    }
}