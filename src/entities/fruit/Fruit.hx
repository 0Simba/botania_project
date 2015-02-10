package entities;

//import engine.events.Events;
import GameObject;

import init.Config;
import entities.genetic.Adn;

class Fruit extends GameObject
{
	public var adn:Adn;
	public function new(_adn:Adn){
        super();
        adn   = _adn;
	}
}