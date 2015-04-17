package entities;

import engine.events.Events;
import GameObject;
import utils.Vector2;

class Building extends GameObject
{
    private var referent:Events;
    private var position:Vector2;
    private var building:Dynamic;
    private var name:String;
    static public var list:Array<Building> = new Array<Building>(); // TODO this simulate player's buldings data. Move it when player's data was create

    public function new (fName:String, _referent:Events, _position:Vector2, checkServer:Bool = true) {
        super();
        referent = _referent;
        position = _position;
        name = fName;
        if (checkServer) {
            serverCheck(name);
        }
        list.push(this);
    }

    public function serverCheck (name:String) {
        referent.emit("callingServer", null);

        callServer("buildBuilding", getDatasForServer(name), cast serverValidateBuild, cast serverRefuseBuild);
    }

    private function serverValidateBuild () {
        var buildingDatas = init.ShopDatas.getBuildingByName(name);
        if(buildingDatas.price >= init.PlayerDatas.gold){
            buildingDatas.referent = referent;
            buildingDatas.position = position;
            entities.popUps.ShopConfirmationPopUp.open(buildingDatas, cast build, cast unbuild);
        }
    }

    public function build(){
        referent.emit("builded", null);
    }
    private function serverRefuseBuild (response:Dynamic) {
        unbuild();
    }
    public function unbuild () {
        referent.emit("unbuilded", null);
        destroy();
        destroyFromServer();
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

    private function getDatasForServer (type:String=""):Dynamic {
        var data:Dynamic = {};
        data.position = position;
        data.type = type;
        return data;
    }
}
