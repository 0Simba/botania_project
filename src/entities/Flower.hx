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


/*================================
=            CREATION            =
================================*/


    public function new (_referent, _position, seed:Seed = null, _genome:Genome = null, lastTimeStamp:Int = null, _stateIndex:Int = null) {
        if (seed == null && !(_genome != null && lastTimeStamp != null && _stateIndex != null)) return;
        super();
        referent   = _referent;
        position   = _position;

        config     = Config.flower;
        stateList  = config.states;

        if (seed != null) {
            stateIndex = 0;
            genome     = seed.genome;

            seedRef = seed;
            serverCheckBuild();
        }
        else {
            stateIndex = _stateIndex;
            genome     = _genome;
            lunchDelay(grow, config.time.delay);
        }

        referent.emit("state changed", stateList[stateIndex]);
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

/*-----  End of CREATION  ------*/



/*===================================
=            SERVER PART            =
===================================*/

              /*==========  BUILD  ==========*/

    private function serverCheckBuild () {
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


              /*==========  DESTROY  ==========*/

    public function destroyFromServer () {
        referent.emit("destroying");
        callServer("destroyFlower", getPositionData(), cast serverValidateDestroy, cast serverRefuseDestroy);
    }


    private function serverValidateDestroy () {
        referent.emit("destroyed");
        destroy();
    }


    private function serverRefuseDestroy () {
        referent.emit("undestroy");
    }

              /*==========  DATAS  ==========*/

    private function getDatasForServer ():Dynamic {
        var data    = getPositionData();
        data.genome = genome.getCode();

        return data;
    }


    private function getPositionData ():Dynamic {
        var data:Dynamic = {};
        data.position = position;

        return data;
    }


/*-----  End of SERVER PART  ------*/


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


/*=======================================
=            STATIC MANAGING            =
=======================================*/


    static private var list:Array<Flower> = new Array<Flower>();

    static private function remove (flower:Flower) {
        var i = list.indexOf(flower);
        list.splice(i, 1);
        flower = null;
    }


/*-----  End of STATIC MANAGING  ------*/

}
