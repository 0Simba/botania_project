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

        callServer("buildBreaker", getDatasForServer(), cast serverValidateBuild, cast serverRefuseBuild);
    }

    private function serverValidateBuild () {
        referent.emit("builded", null);
    }

    private function serverRefuseBuild () {
        referent.emit("unbuilded", null);
        destroy();
    }

    override public function destroy () {
        referent.emit("destroyed", null);
    }

    public function destroyFromServer () {
        referent.emit("destroying", null);
        callServer("destroyBuilding", getDatasForServer(), cast serverValidateDestroy, cast serverRefuseDestroy);
    }

    private function serverValidateDestroy () {
        destroy();
    }

    private function serverRefuseDestroy () {
        referent.emit("not destroyed", null);
    }


    private function getDatasForServer ():Dynamic {
        var data:Dynamic = {};
        data.position = position;

        return data;
    }
}
