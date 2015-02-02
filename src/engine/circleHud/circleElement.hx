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


        // basicTexture = _basicTexture;
        // hoverTexture = _hoverTexture;
        // clickTexture = _clickTexture;

        addComponent("hudButton");
        hudButton.set(new Vector2(parent.elementsRadius, parent.elementsRadius), new Vector2(0, 0) , "circleNavigation", basicTexture, parent.layerName); // TODO virer le vector2(100, 100)
        hudButton.setTextures(_basicTexture, _hoverTexture, _clickTexture);
        hudButton.bindEvents(over, out, click);
    }

    public function replace (pos:Vector2) {
        hudButton.replace(pos, true);
    }

    private function over () {
        // hudButton.changeTexture(hoverTexture);
    }

    private function out () {
        // hudButton.changeTexture(basicTexture);
    }

    private function click () {
        // hudButton.changeTexture(clickTexture);
        parent.referent.emit(name, parent.targetShowed);
    }
}