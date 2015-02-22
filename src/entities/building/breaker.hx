package entities.building;

import engine.events.Events;
import GameObject;
import utils.Vector2;

class Breaker extends GameObject
{
    private var referent:Events;
    private var position:Vector2;

    public function new (_referent:Events, _position:Vector2, checkServer:Bool = true) {
        super();
        referent = _referent;
        position = _position;

        if (checkServer) {
            serverCheck();
        }
    }

    public function serverCheck () {
        referent.emit("callingServer", null);

        var data:Dynamic = {};
        data.position = position;

        callServer("buildBreaker", data, cast serverValidate, cast serverRefuse);
    }

    private function serverValidate () {
        referent.emit("serverResponse", true);
    }

    private function serverRefuse () {
        referent.emit("serverResponse", false);
        destroy();
    }

    override public function destroy () {
        referent.emit("destroying", null);
    }
}
