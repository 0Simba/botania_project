package entities;

import engine.isoEngine.components.Animation;
import init.Config;
import utils.Vector2;
import engine.tween.Tween;


class Seagulls
{

    /*======================================
    =            STATIC SECTION            =
    ======================================*/
      // seagulls management


    static private var list:Array<Seagulls>;
    static private var config:Dynamic;


    static public function initLoop () {
        list = new Array<Seagulls>();
        config = Config.map.seagulls;
        pop();
    }


    static private function pop () {
        var time = Math.random() * (config.maxPop - config.minPop) + config.minPop;
        haxe.Timer.delay(pop, time);

        new Seagulls();
    }


    static private function destroyMe (seagull:Seagulls) {
        var index = list.indexOf(seagull);
        list[index] = null;

        list.splice(index, 1);
    }
    /*======================================
    =            SIMPLE SEAGULL            =
    ======================================*/

    private var seagull:Animation;
    private var tween:Tween;
    private var xDelta:Float;
    private var yDelta:Float;
    private var start:Vector2;
    private var end:Vector2;

    private function new () {
        start = randomStartPosition();
        end   = reandomEndPositionFromStart(start);

        xDelta = start.x - end.x;
        yDelta = start.y - end.y;

        seagull = new Animation("seagull", start, "foreground");
        seagull.movieClip.anchor.set(0.5, 0.5);

        if (start.x <= 0) seagull.movieClip.scale.set(-1, 1);


        setTween();
        tween.onUpdate(function (currentDatas) {
            var ratio       = currentDatas.get("ratio");
            var newPosition = new Vector2(start.x - xDelta * ratio, start.y + yDelta * ratio);

            seagull.replace(newPosition);
        });

        tween.onComplete(function () {
            var parent = seagull.movieClip.parent;
            parent.removeChild(seagull.movieClip);
            destroyMe(this);
        });

        tween.start();

        list.push(this);
    }


    private function setTween () {
        var from = new Map<String, Float>();
        from.set("ratio", 0);

        var to = new Map<String, Float>();
        to.set("ratio", 1);

        var time = Math.random() * (config.maxDepop - config.minDepop) + config.minDepop;
        tween = new Tween (from, to, time);
    }



    /*=============================
    =            UTILS            =
    =============================*/


    private function randomStartPosition ():Vector2 {
        var x = (Math.random() > 0.5) ? 1 : 0;
        var y = Math.random();

        return new Vector2 (x, y, "%", "%");
    }


    private function reandomEndPositionFromStart (start:Vector2):Vector2 {
        var x = (start.x <= 0) ? 1 : 0;
        var y = Math.random();

        return new Vector2 (x, y, "%", "%");
    }
}
