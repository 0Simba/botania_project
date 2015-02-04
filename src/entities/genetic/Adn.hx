package entities;

//import engine.events.Events;
import GameObject;
import init.Config;

class Adn extends GameObject
{
	public var family:Taxonomy;
	public var order:Taxonomy;
	public var genre:Taxonomy;
	public function new(_family, _order, _genre)
	{
		family = _family;
		order = _order;
		genre = _genre;
	}
}

