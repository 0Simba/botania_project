package entities.building;

import engine.events.Events;
import GameObject;
import utils.Vector2;

class Breaker extends GameObject
{
    private var referent:Events;
    private var position:Vector2;

    public function new (_referent:Events, _position:Vector2) {
        super();
        referent = _referent;
        position = _position;
    }

    override public function destroy () {
        referent.emit("destroying", null);
    }
}
