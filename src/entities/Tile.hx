package entities;

class Tile extends GameObject
{

	public function new()
	{
		super();
        addComponent("graphicTile");

        graphicTile.addGround("ground");
        graphicTile.setInteractive(mouseover, mousequit);
    }

    public function mouseover () {
        // graphicTile.changeGround("grass");
    }

    public function mousequit () {
        // graphicTile.changeGround("water");
    }

}