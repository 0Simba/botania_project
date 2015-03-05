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

    public var genome:Genome;

    private var waitingCallback:Int = 0;
    private var toKill:Bool         = false;
    private var referent:Events;
    private var stateIndex:Int;
    private var position:Vector2;
    private var seedRef:Seed;


/*================================
=            CREATION            =
================================*/


    public function new (_referent, _position, seed:Seed = null, _genome:Genome = null, lastTimeStamp:Int = null, currentTimeStamp:Int = null, _stateIndex:Int = null) {
        if (seed == null && !(_genome != null && lastTimeStamp != null && currentTimeStamp != null && _stateIndex != null)) return;
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
            if (stateIndex < stateList.length - 1) {
                lunchDelay(grow, config.time.delay);
            }
        }

        lunchDelay(function () { // Needed for wait referent done
            referent.emit("state changed", stateList[stateIndex]);
        }, 10);
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




/*=======================================
=            ACTION + SERVER            =
=======================================*/


                /*==========  BUILD  ==========*/

    private function serverCheckBuild () {
        referent.emit("callingServer", null);
        callServer("buildFlower", getBuildDatas(), cast serverValidateFlower, cast serverRefuseFlower);
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



                /*==========  GROW  ==========*/

    public function grow () {
        callServer("flowerGrow", getGrowDatas(), cast serverValidateGrow, cast serverRefuseGrow);
    }


    private function serverValidateGrow () {
        stateIndex++;
        referent.emit("state changed", stateList[stateIndex]);
        if (stateList.length - 1 > stateIndex) {
            lunchDelay(grow, config.time.delay);
        }
    }


    private function serverRefuseGrow () {
        trace("Server refused grow of");
        trace(this);
        grow();
    }



                /*==========  HARVEST  ==========*/

    public function harvest () {
        if (stateList[stateIndex] == "bloom") {
            var data = getGrowDatas();
            data.stateIndex -= 2;     // get grow data increment stateIndex, but here we want desincrement
            callServer("flowerGrow", data, cast serverValidateHarvest, cast serverRefuseHarvest);
        }
        else {
            trace("Flower.harvest -> Tentative de récolter alors que la plante n'a pas éclos");
        }
    }


    private function serverValidateHarvest () {
        stateIndex--;
        referent.emit("state changed", stateList[stateIndex]);
        lunchDelay(grow, config.time.delay);
    }


    private function serverRefuseHarvest () {
        trace("Server refuse harvest for");
        trace(this);
    }

                /*==========  DATAS  ==========*/

    private function getBuildDatas ():Dynamic {
        var data    = getPositionData();
        data.genome = genome.getCode();

        return data;
    }


    private function getGrowDatas ():Dynamic {      // WARNING NOT VERIFIED BY SERVER
        var data   = getPositionData();
        data.stateIndex = Std.int(stateIndex) + 1;

        return data;
    }


    private function getPositionData ():Dynamic {
        var data:Dynamic = {};
        data.position = position;

        return data;
    }




/*=======================================
=            DELAY FUNCTIONS            =
=======================================*/

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

}
