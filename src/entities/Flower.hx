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
        config = Config.flower;
        stateList = config.states;
        referent   = _referent;
        stateIndex = _state;

        referent.emit("state changed", stateList[stateIndex]);
        haxe.Timer.delay(endDelay, config.time.delay);
    }


    public function endDelay () {
        stateIndex++;
        referent.emit("state changed", stateList[stateIndex]);
        if (stateList.length - 1 > stateIndex) {
            haxe.Timer.delay(endDelay, config.time.delay);
        }
    }
}
