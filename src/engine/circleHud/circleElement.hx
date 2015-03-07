package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;
import utils.Vector2;

class CircleElement extends GameObject
{
    private var parent:CircleBlock;
    private var referent:Events;

    public function new (_parent:CircleBlock, basicTexture:String, _callback:Dynamic) {
        super();

        parent = _parent;

        addComponent("hudButton");
        hudButton.set(new Vector2(parent.elementsRadius, parent.elementsRadius), new Vector2(0, 0), basicTexture, parent.layerName);
        hudButton.onClick(click);

        callback = _callback;
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
        callback(parent.targetShowed);
    }

    dynamic public function callback (targetShowed) {}
}