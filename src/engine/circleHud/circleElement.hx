package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;
import utils.Vector2;

class CircleElement extends GameObject
{
    private var name:String;
    private var parent:CircleBlock;
    private var referent:Events;

    public function new (_parent:CircleBlock, _name:String, texture:String) {
        super();
        parent = _parent;
        name   = _name;

        addComponent("hudElement");
        hudElement.set(new Vector2(0, 0) , new Vector2(0, 0) , "circleNavigation", texture, name);
    }

}
