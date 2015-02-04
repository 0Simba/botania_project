package entities.genetic;

//import engine.events.Events;
import GameObject;
import init.Config;

class Genome extends GameObject
{
	public var name:String;
	public var value:Float;

	public function new(_name, _value){
        name  = _name;
        value = _value;
	}
}

