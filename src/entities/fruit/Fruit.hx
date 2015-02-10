package entities;

import GameObject;
import init.Config;
import entities.genetic.Adn;
import entities.Seed;

class Fruit extends GameObject
{
	static public list:Array<Fruit> =  new Array<Fruit>();
	public var adn:Adn;
	public var quality:Float;
	public var nbSeed:Int;
	
	public function new (_adn:Adn,_quality:Float = 0) {
        super();
		adn     = _adn;
		quality = _quality;
        etablishNbSeed();
        list.push(this);
	}

	public function etablishNbSeed () {
		nbSeed = 3;
	}

	public function open (knife:String):Array<Seed> {
		list.splice(list.indexOf(this),1);
		return new Array<Seed>();
	}
}