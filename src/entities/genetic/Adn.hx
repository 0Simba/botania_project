package entities.genetic;

import GameObject;
import init.Config;

class Adn
{
	public var family:Taxonomy;
	public var order:Taxonomy;
	public var genre:Taxonomy;

	public function new (_family, _order, _genre) {
        family = _family;
        order  = _order;
        genre  = _genre;
	}
}

