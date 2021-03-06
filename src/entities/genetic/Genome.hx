package entities.genetic;

import GameObject;
import init.Config;
import entities.genetic.Segment;
import entities.genetic.Chromosome.Type;

import entities.genetic.chromosomes.Family;
import entities.genetic.chromosomes.Genre;
import entities.genetic.chromosomes.Order;

class Genome
{
	public var principal:Segment;
	public var secondary:Segment;
	public var tertiaire:Segment;

    static public function newFromCodeList (list:Map<String, Float>):Genome {
        var values  = new Array<Float>();
        var strings = new Array<String>();

        splitListToOrderArrays(list, values, strings);

        var principal = Segment.newFromCode(strings[0], values[0]);
        var secondarySegment = (values[1] != null) ? Segment.newFromCode(strings[1], values[1]) : null;
        var tertiaireSegment = (values[2] != null) ? Segment.newFromCode(strings[2], values[2]) : null;

        return new Genome(
            principal,
            secondarySegment,
            tertiaireSegment
        );
    }

    static public function newFromCode (code:String):Genome {
        var principal = null;
        var secondary = null;
        var tertiaire = null;

        var segments = code.split("-");

        var splitTypeToStrength = segments[0].split("#");
        principal = Segment.newFromCode(splitTypeToStrength[0], Std.parseFloat(splitTypeToStrength[1]));

        if (segments[1] != null) {
            splitTypeToStrength = segments[1].split("#");
            secondary = Segment.newFromCode(splitTypeToStrength[0], Std.parseFloat(splitTypeToStrength[1]));
        }

        if (segments[2] != null) {
            splitTypeToStrength = segments[2].split("#");
            tertiaire = Segment.newFromCode(splitTypeToStrength[0], Std.parseFloat(splitTypeToStrength[1]));
        }

        return new Genome (principal, secondary, tertiaire);
    }


    public function randomize (force:Float) {
        var total:Float = 0;
        if (tertiaire != null) {
            tertiaire.strength *= (Math.random() * (force * 2)) - force + 1;
            tertiaire.strength = Math.floor(tertiaire.strength * 100) / 100;
            total += tertiaire.strength;
        }
        if (secondary != null) {
            secondary.strength *= (Math.random() * (force * 2)) - force + 1;
            secondary.strength = Math.floor(secondary.strength * 100) / 100;
            total += secondary.strength;
        }

        principal.strength = Math.round((1 - total) * 100) / 100;
    }


	public function new (_principal:Segment, _secondary:Segment = null, _tertiaire:Segment = null) {
        principal = _principal;
        secondary = _secondary;
        tertiaire = _tertiaire;
	}


    public function clone () {
        return newFromCode(getCode());
    }

    public function listSegmentCode (list:Map<String, Float> = null):Map<String, Float> {
        if (list == null) list = new Map<String, Float>();

        addSegmentOnList(principal, list);
        if (secondary != null) addSegmentOnList(secondary, list);
        if (tertiaire != null) addSegmentOnList(tertiaire, list);

        return list;
    }

    public function getAppearanceName () {
        return principal.getAsName();
    }


    public function getCode ():String {
        var code:String = "";
        code += principal.getAsName() + "#" + principal.strength;
        if (secondary != null) code += "-" + secondary.getAsName() + "#" + secondary.strength;
        if (tertiaire != null) code += "-" + tertiaire.getAsName() + "#" + tertiaire.strength;

        return code;
    }

    private function addSegmentOnList (segment:Segment, list:Map<String, Float>) {
        var name  = segment.getAsName();
        var value = list.exists(name) ? list.get(name) : 0;
        value += segment.strength;
        list.set(name, value);
    }

    static private function splitListToOrderArrays (list:Map<String, Float>, valueA:Array<Float>, strA:Array<String>) {

        var keysI = list.keys();

        for (key in keysI) {
            var added = false;
            var value = list.get(key);

            for (i in 0...valueA.length) {
                if (value > valueA[i]) {
                    added = true;
                    strA.insert(i, key);
                    valueA.insert(i, value);

                    break;
                }
            }
            if (!added) {
                strA.push(key);
                valueA.push(value);
            }
        }
    }

}

