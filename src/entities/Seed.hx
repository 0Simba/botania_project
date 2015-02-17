package entities;

//import engine.events.Events;
import GameObject;

import init.Config;
import entities.genetic.Genome;

class Seed extends GameObject
{
    static public var list:Array<Seed> = new Array<Seed>(); // TODO this simulate player's seeds data. Move it when player's data was create


	public var genome:Genome;
	public var level:Int;
	public function new (_genome:Genome, _level:Int = 0) {
        super();
        genome   = _genome;
        level = _level;

        list.push(this);
	}
}