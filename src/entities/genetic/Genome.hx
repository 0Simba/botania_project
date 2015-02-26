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

	public function new (_principal:Segment, _secondary:Segment = null, _tertiaire:Segment = null) {
        principal = _principal;
        secondary = _secondary;
        tertiaire = _tertiaire;
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
        // var code:String = "";
        // code += "_F-";
        // code += family.principal.name + (family.principal.value * 100);
        // if (family.secondary != null) code += family.secondary.name + (family.secondary.value * 100);
        // if (family.tertiary != null) code += family.tertiary.name + (family.tertiary.value * 100);
        // code += "_O-";
        // code += order.principal.name + (order.principal.value * 100);
        // if (order.secondary != null) code += order.secondary.name + (order.secondary.value * 100);
        // if (order.tertiary != null) code += order.tertiary.name + (order.tertiary.value * 100);
        // code += "_G-";
        // code += genre.principal.name + (genre.principal.value * 100);
        // if (genre.secondary != null) code += genre.secondary.name + (genre.secondary.value * 100);
        // if (genre.tertiary != null) code += genre.tertiary.name + (genre.tertiary.value * 100);

        return "lol"; //return code;
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

