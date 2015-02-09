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


    public function getCode ():String {
        var code:String = "";
        code += "_F-";
        code += family.principal.name + (family.principal.value * 100);
        if (family.secondary != null) code += family.secondary.name + (family.secondary.value * 100);
        if (family.tertiary != null) code += family.tertiary.name + (family.tertiary.value * 100);
        code += "_O-";
        code += order.principal.name + (order.principal.value * 100);
        if (order.secondary != null) code += order.secondary.name + (order.secondary.value * 100);
        if (order.tertiary != null) code += order.tertiary.name + (order.tertiary.value * 100);
        code += "_G-";
        code += genre.principal.name + (genre.principal.value * 100);
        if (genre.secondary != null) code += genre.secondary.name + (genre.secondary.value * 100);
        if (genre.tertiary != null) code += genre.tertiary.name + (genre.tertiary.value * 100);

        return code;
    }
}

