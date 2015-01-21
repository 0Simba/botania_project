package engine.popUpEngine;

import utils.Vector2;

class PopUp extends GameObject
{
    public function new (size:Vector2, pos:Vector2, animation:String, texture:String) {
        super();

        addComponent("hudElement");
        hudElement.set(size, pos, animation, texture);
    }

    public function addYesNo () {

    }

    public function hide () {

    }

    public function show () {

    }
}
