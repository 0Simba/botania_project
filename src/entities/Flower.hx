package entities;

import engine.events.Events;
import GameObject;
import init.Config;
import entities.Seed;

class Flower extends GameObject
{
    static private var stateList:Array<String>;
    static private var config:Dynamic;

    private var referent:Events;
    private var stateIndex:Int;

    public function new (_referent, seed:Seed) {
        super();
        config     = Config.flower;
        stateList  = config.states;
        referent   = _referent;
        stateIndex = 0;

        referent.emit("state changed", stateList[stateIndex]);
        lunchDelay(grow, config.time.delay);

        Flower.add(this);
        seed.destroy();
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
    static private function add (flower:Flower) {
        list.push(flower);
    }
    static private function remove (flower:Flower) {
        var i = list.indexOf(flower);
        list.splice(i, 1);
        flower = null;
    }
}
