package entities;

//import engine.events.Events;
import GameObject;

import init.Config;
import entities.genetic.Genome;
import entities.genetic.Chromosome.Type;
import utils.MapManipulate;

class Seed extends GameObject
{
    static public var list:Array<Seed> = new Array<Seed>(); // TODO this simulate player's seeds data. Move it when player's data was create


	public var genome:Genome;
	public var level:Int;
    public var appearanceName:String;

	public function new (_genome:Genome, _level:Int = 0) {
        super();
        genome = _genome;
        level  = _level;

        appearanceName = genome.getAppearanceName();
        list.push(this);
	}

    public function merge (seed:Seed) {
        var list = getMutationOf(seed.genome.listSegmentCode(), genome.listSegmentCode());

        trace(list);

        keepThreeBetterOf(list);
        normalizeTotalOf(list);

        new Seed(Genome.newFromCodeList(list));

        seed.destroy();
        destroy();
    }

    override public function destroy () {
        var index = list.indexOf(this);
        var seed  = list[index];
        list.splice(index, 1);
    }


    private function normalizeTotalOf (list) {
        var total = getTotal(list);
        trace(total);
        return list;
    }

    private function getTotal (list:Map<String, Float>) {
        var total:Float = 0;
        for (value in list) {
            total += value;
        }
        return total;
    }

    private function keepThreeBetterOf (list) {
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

        }
    }


    private function getMutationOf (genome1:Map<String, Float>, genome2:Map<String, Float>):Map<String, Float> {
        var list = new Map<String, Float>();

        var keys1I:Iterator<String> = genome1.keys();
        var keys2I:Iterator<String> = genome2.keys();

        for (key1 in keys1I) {
            for (key2 in keys2I) {
                var newSegment = tryMerged(key1, key2);
                if (newSegment != null) {
                    var v1 = genome1.get(key1);
                    genome1.set(key1, v1 * 0.7);

                    var v2 = genome2.get(key2);
                    genome2.set(key2, v2 * 0.7);

                    sumListWith(list, newSegment, v1 * 0.3 + v2 * 0.3);       // ADD MUTATION TO LIST
                }
            }
            sumListWith(list, key1, genome1.get(key1));     // ADD GENOME 1 TO LIST
        }

        keys2I = genome2.keys();
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



        return (count == 1) ? newSegment : null;
    }




    private function sumLetters (l1:String, l2:String):String {
        var i = letterToInt(l1) + letterToInt(l2);
        i = i % 6;                                              // TODO no hard value
        return intToLetter(i);
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


}