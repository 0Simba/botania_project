package entities;

import engine.events.Events;
import GameObject;
import init.Config;
import entities.Seed;
import entities.genetic.Genome;
import utils.Vector2;

class Flower extends GameObject
{
    static private var stateList:Array<String>;
    static private var config:Dynamic;

    private var referent:Events;
    private var stateIndex:Int;
    private var position:Vector2;
    private var seedRef:Seed;

    public var genome:Genome;

    public function new (_referent, _position, seed:Seed) {
        super();
        referent   = _referent;
        position   = _position;

        config     = Config.flower;
        stateList  = config.states;
        stateIndex = 0;
        genome     = seed.genome;

        referent.emit("state changed", stateList[stateIndex]);
        seedRef = seed;
        serverCheck();
    }


    public function harvest () {
        if (stateList[stateIndex] == "bloom") {
            stateIndex--;
            referent.emit("state changed", stateList[stateIndex]);
            lunchDelay(grow, config.time.delay);
        }
        else {
            trace("Flower.harvest -> Tentative de récolter alors que la plante n'a pas éclos");
        }
    }


    public function grow () {
        stateIndex++;
        referent.emit("state changed", stateList[stateIndex]);
        if (stateList.length - 1 > stateIndex) {
            lunchDelay(grow, config.time.delay);
        }
    }

    override public function destroy () {
        referent.emit('destroyed', null);
        if (waitingCallback == 0) {
            Flower.remove(this);
        }
        else {
            toKill = true;
        }
    }


    /***** SERVER CHECKING *****/

    private function serverCheck () {
        referent.emit("callingServer", null);

        callServer("buildFlower", getDatasForServer(), cast serverValidateFlower, cast serverRefuseFlower);
    }

    private function serverValidateFlower () {
        referent.emit("builded");
        lunchDelay(grow, config.time.delay);

        list.push(this);
        seedRef.destroy();
        seedRef = null;
    }

    private function serverRefuseFlower () {
        referent.emit("unbuilded");
    }

    private function getDatasForServer () {
        var data:Dynamic = {};
        data.position = position;
        data.genome   = genome.getCode();

        return data;
    }

    /***** YOU DON'T CARE *****/

    private var waitingCallback:Int = 0;
    private var toKill:Bool         = false;


    private function lunchDelay (callback, time) {
        waitingCallback++;
        haxe.Timer.delay(function () {
            endDelay(callback);
        }, time);
    }

    private function endDelay (callback) {
        waitingCallback--;
        if (waitingCallback == 0 && toKill == true) {
            Flower.remove(this);
        }
        else {
            callback();
        }
    }


        //List to manage destroying

    static private var list:Array<Flower> = new Array<Flower>();

    static private function remove (flower:Flower) {
        var i = list.indexOf(flower);
        list.splice(i, 1);
        flower = null;
    }
}
