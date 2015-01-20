package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;

class CircleElement extends GameObject
{
    private var name:String;
    private var parent:CircleBlock;
    private var referent:Events;

    public function new (_parent:CircleBlock, _name) {
        super();
        parent = _parent;
        name   = _name;
    }

}
