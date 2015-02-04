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

    // public function break (seedsA:Seeds, seedsB:Seeds):Seeds {
        
    // }


    override public function destroy () {
        referent.emit("destroying", null);
    }
}
