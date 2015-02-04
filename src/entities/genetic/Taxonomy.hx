package entities.genetic;

//import engine.events.Events;
import GameObject;
import init.Config;

class Taxonomy extends GameObject
{
	public var principal:Genome;
	public var secondary:Genome;
	public var tertiary:Genome;
	public function new(_principal,_secondary,_tertiary){
        principal = _principal;
        secondary = _secondary;
        tertiary  = _tertiary;
	}
}

