package entities;

import utils.Vector2;

class Biome extends GameObject
{

    public function new()
    {
        super();
        addComponent("hudElement");
        hudElement.set(new Vector2(0.2, 0.2), new Vector2(0.2, 0.2), "ground");
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