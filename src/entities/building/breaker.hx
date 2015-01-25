package entities.building;

import engine.events.Events;

class Breaker
{
    private var referent:Events;

    public function new (_referent:Events) {
        referent = _referent;
    }

    public function destroy () {
        
    }
}
