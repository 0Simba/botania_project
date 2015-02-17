package entities.genetic;

import GameObject;
import init.Config;


enum Taxonomy
{
    family;
    order;
    genre;
}

enum Type
{
    A;
    B;
    C;
    D;
    E;
    F;
}

class Chromosome
{
	public var name:Taxonomy;
	public var value:Type;

	public function new (_name:Taxonomy, _value:Type) {
        name  = _name;
        value = _value;
	}
}
