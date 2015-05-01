package entities;

import engine.events.Events;
import GameObject;
import init.Config;
import entities.Seed;
import entities.Fruit;
import entities.genetic.Genome;
import utils.Vector2;
import haxe.Timer;
import engine.popUpEngine.PopUpEngineMain;
import entities.genetic.Chromosome;
import entities.popUps.DiscoverFlower;


class Flower extends GameObject
{
    static private var stateList:Array<String>;
    static private var config:Dynamic;

    public var genome:Genome;

    private var toKill:Bool         = false;
    private var referent:Events;
    private var stateIndex:Int;
    private var position:Vector2;
    private var seedRef:Seed;
    private var timer:Timer;
    private var serverId:Int;

/*================================
=            CREATION            =
================================*/


    public function new (_referent, _position, seed:Seed = null, _genome:Genome = null, lastTimeStamp:Int = null, currentTimeStamp:Int = null, _stateIndex:Int = null, _serverId:Int = null) {
        if (seed == null && !(_genome != null && lastTimeStamp != null && currentTimeStamp != null && _stateIndex != null && _serverId != null)) return;
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
                checkMissedGrow(lastTimeStamp, currentTimeStamp);
            }
        }

        launchDelay(function () { // Needed for wait referent done
            referent.emit("state changed", stateList[stateIndex]);
        }, 10);
    }


    override public function destroy () {
        referent.emit('destroyed', null);
        if (timer != null) timer.stop();
        Flower.remove(this);
    }




/*=======================================
=            ACTION + SERVER            =
=======================================*/


                /*==========  BUILD  ==========*/

    private function serverCheckBuild () {
        referent.emit("callingServer", null);
        callServer("buildFlower", getBuildDatas(), cast serverValidateFlower, cast serverRefuseFlower);
    }

    private function serverValidateFlower (response) {
        serverId = response.flowerId;
        referent.emit("builded");
        launchDelay(grow, config.time.delay);

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

    private var rest:Int;
    private var stateIndexAtInstance:Int;

    public function checkMissedGrow (lastTs:Int, currentTs:Int) {
        var elapsedTime = currentTs - lastTs;
        var nbGrow:Int  = Math.floor(elapsedTime / config.time.delay);
        rest            = cast elapsedTime % config.time.delay;

        if (nbGrow > 0) {
            stateIndexAtInstance = cast Math.min(stateIndex + nbGrow, stateList.length - 1);
            var data = getGrowDatas();
            data.statIndex = stateIndexAtInstance;

            callServer("flowerGrow", data, cast serverValidateGrowAtInstance, cast serverRefuseGrow);
        }
        else if (stateIndex < stateList.length -1 ) {
            launchDelay(grow, cast config.time.delay - rest);
        }
    }


    private function serverValidateGrowAtInstance () {
        stateIndex = stateIndexAtInstance;

        referent.emit("state changed", stateList[stateIndex]);
        if (stateList.length - 1 > stateIndex) {
            launchDelay(grow, cast config.time.delay - rest);
        }
        if (stateIndex == stateList.length - 2) { // became adult
            saveDiscoverFlowerAndShare();
        }
    }

    private function serverValidateGrow () {
        stateIndex++;
        referent.emit("state changed", stateList[stateIndex]);
        if (stateList.length - 1 > stateIndex) {
            launchDelay(grow, config.time.delay);
        }
        if (stateIndex == stateList.length - 2) { // became adult
            saveDiscoverFlowerAndShare();
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
        new Fruit(genome, 0, true);
        launchDelay(grow, config.time.delay);
    }


    private function serverRefuseHarvest () {
        trace("Server refuse harvest for");
    }

                /*==========  WATER  ==========*/

    public function water () {
        if (stateList[stateIndex] != "bloom") {
            timer.stop();
            callServer("flowerGrow", getGrowDatas(), cast serverValidateGrow, cast serverRefuseGrow);
        }
        else {
            trace("entitie.flower.water -> can't water bloomed flower");
        }
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


/*================================================
=            FACEBOOK + LOCAL STORAGE            =
================================================*/


    private function saveDiscoverFlowerAndShare () {
        var localStorage   = js.Browser.getLocalStorage();
        var appearanceName = genome.getAppearanceName();

        if (localStorage.getItem(appearanceName) == null) {
            localStorage.setItem(appearanceName, "true");
            DiscoverFlower.params(this);
            PopUpEngineMain.getInstance().show("discoverFlowerPopUp");
        }
    }






/*=======================================
=            DELAY FUNCTIONS            =
=======================================*/

    private function launchDelay (callback, time) {
        timer = haxe.Timer.delay(function () {
            callback();
        }, time);
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



    /*================================
    =            Get Name            =
    ================================*/


    static private var stalk:Array<String> = ["Gîrda",  "Cléopatra", "Dinna",   "Arïa",    "Brogeka"];
    static private var sheet:Array<String> = ["Sîgrid", "Pépi",      "Dilo",    "Amalïel", "Tarkeni"];
    static private var head:Array<String>  = ["Sîlke",  "Arsinoé",   "Dimilce", "Elillë",  "Orroke"];

    static public function getName (genomeCode:String):String {
        var letterToInt:Map<String, Int> = Chromosome.getMapOfLetter();

        var stalkName:String = stalk[letterToInt.get(genomeCode.charAt(0))];
        var sheetName:String = sheet[letterToInt.get(genomeCode.charAt(1))];
        var headName:String  = head[letterToInt.get(genomeCode.charAt(2))];

        return stalkName + " " + sheetName + " " + headName;
    }

}
