package entities;

import engine.events.Events;

class Flower
{
    static private var stateList:Array<String> = ["baby", "child", "teenage", "adult"];
    private var referent:Events;
    private var stateIndex:Int;

    public function new (_referent, _state = 0) {
        referent   = _referent;
        stateIndex = _state;

        referent.emit("state changed", stateList[stateIndex]);
        haxe.Timer.delay(endDelay, 2000);
    }


    public function endDelay () {
        stateIndex++;
        referent.emit("state changed", stateList[stateIndex]);
        if (stateList.length - 1 > stateIndex) {
            haxe.Timer.delay(endDelay, 2000);
        }
    }


    /***** CONFIG *****/

    private var timeToBeAdult = 5;

}
