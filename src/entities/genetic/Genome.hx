package entities.genetic;

import GameObject;
import init.Config;

class Genome
{
	public var name:String;
	public var value:Float;

	public function new (_name, _value) {
        name  = _name;
        value = _value;
	}
}

