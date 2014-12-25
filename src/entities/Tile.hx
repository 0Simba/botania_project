package entities;

import manager.Selection;

class Tile extends GameObject
{

    public var currentAsset = "water";

	public function new()
	{
		super();
        addComponent("graphicTile");

        graphicTile.addGround("ground");
        graphicTile.setInteractive(mouseover, mousequit, mouseClick);
    }

    public function mouseover () {
        if (Selection.contain != null) graphicTile.changeGround(Selection.contain);
    }

    public function mousequit () {
        graphicTile.changeGround(currentAsset);
    }

    public function mouseClick () {
        if (Selection.contain != null) {
            currentAsset = Selection.contain;
            graphicTile.changeGround(currentAsset);
        }
    }

}