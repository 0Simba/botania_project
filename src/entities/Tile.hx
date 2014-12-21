package entities;

class Tile extends GameObject
{

	public function new()
	{
		super();
        addComponent("graphicTile");
        // addComponent("interactiveTile");

        graphicTile.addGround("ground");
        // interactiveTile.bindTo(graphicTile.ground, mouseover, mousequit);
        graphicTile.setInteractive(mouseover, mousequit);
    }

    public function mouseover () {
        graphicTile.changeGround("water");
    }

    public function mousequit () {
        graphicTile.changeGround("ground");
    }

}