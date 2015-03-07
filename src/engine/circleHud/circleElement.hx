package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;
import utils.Vector2;

class CircleElement extends GameObject
{
    private var name:String;
    private var parent:CircleBlock;
    private var referent:Events;

    public function new (_parent:CircleBlock, _name:String, basicTexture:String) {
        super();

        parent = _parent;
        name   = _name;

        addComponent("hudButton");
        hudButton.set(new Vector2(parent.elementsRadius, parent.elementsRadius), new Vector2(0, 0), basicTexture, parent.layerName);
        hudButton.onClick(click);
    }

    public function replace (pos:Vector2) {
        pos.metaX = "px";
        pos.metaY = "px";
        hudButton.replace(pos);
    }

    private function over () {
    }

    private function out () {
    }

    private function click () {
        parent.referent.emit(name, parent.targetShowed);
    }
}