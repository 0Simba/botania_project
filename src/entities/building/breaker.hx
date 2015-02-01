package entities.building;

import engine.events.Events;
import GameObject;

class Breaker extends GameObject
{
    private var referent:Events;

    public function new (_referent:Events) {
        super();
        referent = _referent;
    }

    override public function destroy () {
    }
}
