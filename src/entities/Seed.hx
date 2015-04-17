package entities;

//import engine.events.Events;
import GameObject;

import init.Config;
import entities.genetic.Genome;
import entities.genetic.Chromosome.Type;
import utils.MapManipulate;
import utils.Console;

class Seed extends GameObject
{
    static public var list:Array<Seed> = new Array<Seed>(); // TODO this simulate player's seeds data. Move it when player's data was create


	public var genome:Genome;
	public var level:Int;
    public var appearanceName:String;

    private var serverId:Int;

	public function new (_genome:Genome, _level:Int = 0, informServer = true, _serverId = null) {
        super();
        genome = _genome;
        level  = _level;
        appearanceName = genome.getAppearanceName();
        list.push(this);

        if (informServer) {
            callServer("addSeed", getSeedDatas(), cast function (data) {
                serverId = data.seedId;
            }, cast function (data){});
        }
        serverId = _serverId;
	}

    override public function destroy () {
        var index = list.indexOf(this);
        var seed  = list[index];

        if (serverId != null) {
            var data:Dynamic = {};
            data.id = serverId;
            callServer('removeSeed', data, cast function(){}, cast function(){});
        }

        list.splice(index, 1);
    }

    private function getSeedDatas ():Dynamic {
        var data:Dynamic = {};
        data.genome = genome.getCode();
        data.level  = level;

        return data;
    }

    private function normalizeTotalOf (list) {
        var total = getTotal(list);
        var ratio = 1 / total;

        var keysI = list.keys();
        for (key in keysI) {
            list.set(key, list.get(key) * ratio);
        }

        return list;
    }

    private function getTotal (list:Map<String, Float>) {
        var total:Float = 0;
        for (value in list) {
            total += value;
        }
        return total;
    }


    private function getMutationOf (genome1:Map<String, Float>, genome2:Map<String, Float>):Map<String, Float> {
        var list = new Map<String, Float>();

        var keys1I:Iterator<String> = genome1.keys();

        var delta  = Config.flower.merge.max - Config.flower.merge.min;
        var ratio1 = Math.random() * delta + Config.flower.merge.min;
        var ratio2 = Math.random() * delta + Config.flower.merge.min;

        for (key1 in keys1I) {
            var keys2I:Iterator<String> = genome2.keys();
            for (key2 in keys2I) {
                var newSegment = tryMerged(key1, key2);
                if (newSegment != null) {
                    var v1 = genome1.get(key1);
                    genome1.set(key1, v1 * ratio1);

                    var v2 = genome2.get(key2);
                    genome2.set(key2, v2 * ratio2);

                    sumListWith(list, newSegment, v1 * (1 - ratio1) + v2 * (1 - ratio2));       // ADD MUTATION TO LIST
                }
            }
            sumListWith(list, key1, genome1.get(key1));     // ADD GENOME 1 TO LIST
        }

        var keys2I = genome2.keys();
        for (key2 in keys2I) {
            sumListWith(list, key2, genome2.get(key2));     // ADD GENOME 2 TO LIST
        }

        return list;
    }

    private function sumListWith (list:Map<String, Float>, segmentCode:String, value:Float) {
        var v =  (list.exists(segmentCode)) ? list.get(segmentCode) + value : value;
        list.set(segmentCode, v);
    }

    private function tryMerged (segment1:String, segment2:String):String {
        var newSegment = "";
        var count      = 0;

        for (i in 0...3) {
            var l1 = segment1.charAt(i);
            var l2 = segment2.charAt(i);

            if (l1 == l2) {
                newSegment += l1;
            }
            else {
                newSegment += sumLetters(l1, l2);
                count++;
            }
        }
        if (count == 1) {
            return transfer0(newSegment);
        }
        else {
            return null;
        }
    }


/*=====================================
=            MERGING UTILS            =
=====================================*/

    private function keepThreeBetterOf (list:Map<String, Float>) {
        var vStr:Array<String> = new Array<String>();
        var vValue:Array<Float> = new Array<Float>();

        var keysI:Iterator<String> = list.keys();
        for (key in keysI) {
            var currentValue  = list.get(key);
            var added:Bool = false;

            for (i in 0...vValue.length) {
                if (currentValue > vValue[i]) {
                    added = true;
                    vValue.insert(i, currentValue);
                    vStr.insert(i, key);
                    break;
                }
            }

            if (!added) {
                vValue.push(currentValue);
                vStr.push(key);
            }
        }

        for (i in 3...vStr.length) {
            list.remove(vStr[i]);
        }
    }

    private function removeToSmallOf (list:Map<String, Float>) {
        var keys = list.keys();

        for (key in keys) {
            var value = list.get(key);
            var min   = (Config.flower.minPercent) ? Config.flower.minPercent : 0.12;
            if (value < min) {
                list.remove(key);
            }
        }
    }


    private function transfer0 (segment:String):String {
        for (j in 0...3) {
            var i = 2 - j;          // simule un parcours de 2 compris a 0

            if (segment.charAt(i) == "O") {
                var iValue      = "A";
                var targetIndex = (i == 0) ? 2 : i - 1;
                var targetValue = sumLetters("A", segment.charAt(targetIndex));

                var newStr = "";
                for (k in 0...3) {
                    newStr += (k == targetIndex) ? targetValue      :
                              (k == i)           ? iValue           :
                                                   segment.charAt(k);
                }
                segment = newStr;
            }
        }

        return (segment.indexOf("O") == -1) ? segment : transfer0(segment);
    }


    private function sumLetters (l1:String, l2:String):String {
        var i = letterToInt(l1) + letterToInt(l2);
        i = i % 6;                                              // TODO no hard value
        return intToLetter(i);
    }


    private function roundTwoDecimal (list:Map<String, Float>) {
        var keysI = list.keys();

        for (key in keysI) {
            var value = list.get(key);
            value = Math.round(value * 100) / 100;
            list.set(key, value);
        }
    }


    private function letterToInt (letter:String):Int {
        return (letter == "A") ? 1 :
               (letter == "B") ? 2 :
               (letter == "C") ? 3 :
               (letter == "D") ? 4 :
               (letter == "E") ? 5 :
               (letter == "O") ? 0 :
                                null;
    }


    private function intToLetter (int:Int):String {
        return (int == 1) ? "A" :
               (int == 2) ? "B" :
               (int == 3) ? "C" :
               (int == 4) ? "D" :
               (int == 5) ? "E" :
               (int == 0) ? "O" :
                                null;
    }


/*=============================
=            MERGE            =
=============================*/

    public function merge (seed:Seed) {
        var list = getMutationOf(seed.genome.listSegmentCode(), genome.listSegmentCode());

        var newSeed = mergeWithLog(list, seed);   //Merge with log do exactly next line, but log all step in console
        //var newSeed = createSeedFromList(list);

        seed.destroy();
        destroy();
        return newSeed;
    }


    private function createSeedFromList (list:Map<String, Float>) {
        keepThreeBetterOf(list);
        normalizeTotalOf(list);
        removeToSmallOf(list);
        normalizeTotalOf(list);
        roundTwoDecimal(list);

        return new Seed(Genome.newFromCodeList(list));
    }


            // It's same as up, but log all parts
    private function mergeWithLog (list:Map<String, Float>, seed:Seed) {
        Console.group("Seed's merge");
            Console.group("OrinalSegment");
                Console.log(seed.genome.listSegmentCode().toString());
                Console.log(genome.listSegmentCode().toString());
            Console.groupEnd();

            Console.group("Treatment");
                Console.group("original");
                    Console.log(list.toString());
                Console.groupEnd();

                Console.group("Keep three better");
                    keepThreeBetterOf(list);
                    Console.log(list.toString());
                Console.groupEnd();

                Console.group("normalize values");
                    normalizeTotalOf(list);
                    removeToSmallOf(list);
                    normalizeTotalOf(list);
                    Console.log(list.toString());
                Console.groupEnd();

                Console.group("round decimal");
                    roundTwoDecimal(list);
                    Console.log(list.toString());
                Console.groupEnd();
            Console.groupEnd();

            Console.group("result");
                var seed = new Seed(Genome.newFromCodeList(list));
                Console.log(seed.genome.listSegmentCode().toString());
            Console.groupEnd();
        Console.groupEnd();

        return seed;
    }
}