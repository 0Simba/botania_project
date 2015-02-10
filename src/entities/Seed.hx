package entities;

//import engine.events.Events;
import GameObject;

import init.Config;
import entities.genetic.Adn;

class Seed extends GameObject
{
    static public var list:Array<Seed> = new Array<Seed>(); // TODO this simulate player's seeds data. Move it when player's data was create


	public var adn:Adn;
	public var level:Int;
	public function new (_adn:Adn, _level:Int = 0) {
        super();
        adn   = _adn;
        level = _level;

        list.push(this);
	}
}