package entities;

class Tile extends GameObject
{

	public function new()
	{
		super();
        addComponent("graphicTile");
	}

}