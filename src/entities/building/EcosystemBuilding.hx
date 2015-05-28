package entities.building;

import engine.events.Events;
import GameObject;
import utils.Vector2;

class EcosystemBuilding extends entities.Building
{
    private var range:Int;
    private var bonus:Int;
    private var production:Int;
    public function new (name, _referent:Events, _position:Vector2, checkServer:Bool = true) {
        super(name, _referent, _position, checkServer);
        initAddBonusZone();
    }
    private function initAddBonusZone () {
    	trace(position);
    }
}
