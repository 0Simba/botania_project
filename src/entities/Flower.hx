package entities;

import engine.events.Events;
import init.Config;

class Flower
{
    static private var stateList:Array<String>;
    static private var config:Dynamic;

    private var referent:Events;
    private var stateIndex:Int;

    public function new (_referent, _state = 0) {
        config     = Config.flower;
        stateList  = config.states;
        referent   = _referent;
        stateIndex = _state;

        referent.emit("state changed", stateList[stateIndex]);
        lunchDelay(grow, config.time.delay);

        Flower.add(this);
    }


    public function grow () {
        stateIndex++;
        referent.emit("state changed", stateList[stateIndex]);
        if (stateList.length - 1 > stateIndex) {
            lunchDelay(grow, config.time.delay);
        }
    }

    public function destroy () {
        referent.emit('destroying', null);
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
