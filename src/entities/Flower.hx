package entities;

import engine.events.Events;
import GameObject;
import init.Config;
import entities.Seed;
import entities.genetic.Genome;

class Flower extends GameObject
{
    static private var stateList:Array<String>;
    static private var config:Dynamic;

    private var referent:Events;
    private var stateIndex:Int;

    public var genome:Genome;

    public function new (_referent, seed:Seed) {
        super();
        config     = Config.flower;
        stateList  = config.states;
        referent   = _referent;
        stateIndex = 0;
        genome     = seed.genome;

        referent.emit("state changed", stateList[stateIndex]);
        lunchDelay(grow, config.time.delay);

        list.push(this);
        seed.destroy();
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
