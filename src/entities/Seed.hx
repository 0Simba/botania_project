package entities;

//import engine.events.Events;
import GameObject;

import init.Config;
import entities.genetic.Adn;

class Seed extends GameObject
{
	public var adn:Adn;
	public var level:Int;
	public function new(_adn:Adn, _level = 0){
        super();
        adn   = _adn;
        level = _level;
	}
}