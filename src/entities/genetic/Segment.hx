package entities.genetic;

import entities.genetic.chromosomes.Family;
import entities.genetic.chromosomes.Order;
import entities.genetic.chromosomes.Genre;
import entities.genetic.Chromosome.Type;
import GameObject;
import init.Config;

class Segment
{
    public var strength:Float;
	public var family:Family;
	public var order:Order;
	public var genre:Genre;

    static public function newFromCode () {

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

