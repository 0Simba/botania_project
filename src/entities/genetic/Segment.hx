package entities.genetic;

import entities.genetic.chromosomes.Family;
import entities.genetic.chromosomes.Order;
import entities.genetic.chromosomes.Genre;
import entities.genetic.Chromosome.Type;
import entities.genetic.Chromosome.TypeUtils;
import GameObject;
import init.Config;

class Segment
{
    public var strength:Float;
	public var family:Family;
	public var order:Order;
	public var genre:Genre;

    static public function newFromCode (code:String, value:Float):Segment {
        var family = new Family(TypeUtils.fromString(code.charAt(0)));
        var order  = new Order (TypeUtils.fromString(code.charAt(1)));
        var genre  = new Genre (TypeUtils.fromString(code.charAt(2)));

        return new Segment(value, family, order, genre);
    }

	public function new (_strength:Float, _family:Family, _order:Order, _genre:Genre) {
        strength = _strength;
        family   = _family;
        order    = _order;
        genre    = _genre;
	}

    public function getAsName () {
        return family.stringValue() + order.stringValue() + genre.stringValue();
    }
}

