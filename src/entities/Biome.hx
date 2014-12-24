package entities;

class Tile extends GameObject
{

    public function new()
    {
        super();
        addComponent("hudElement");
    }

    public function mouseover () {
        // graphicTile.changeGround("grass");
    }

    public function mousequit () {
        // graphicTile.changeGround("water");
    }

    public function mouseClick () {
        graphicTile.changeGround("grass");
    }

}