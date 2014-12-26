package entities;

import manager.Selection;

class Tile extends GameObject
{

    public var currentAsset = "grass";
    public var currentBuild = null;

	public function new()
	{
		super();
        addComponent("graphicTile");

        graphicTile.addGround("ground");
        graphicTile.setInteractive(mouseover, mousequit, mouseClick);
    }

    public function mouseover () {
        if (Selection.contain == null) return;

        if (Selection.actionType == "ground") {
            graphicTile.changeGround(Selection.contain);
        }
        else if (Selection.actionType == "build") {
            graphicTile.changeBuild(Selection.contain);
        }
    }

    public function mousequit () {
        if (Selection.actionType == "ground") {
            graphicTile.changeGround(currentAsset);
        }
        else if (Selection.actionType == "build") {
            graphicTile.changeBuild(currentBuild);
        }
    }

    public function mouseClick () {
        if (Selection.contain == null) return;


        if (Selection.actionType == "ground") {
            currentAsset = Selection.contain;
            graphicTile.changeGround(currentAsset);
        }
        else if (Selection.actionType == "build") {
            currentBuild = Selection.contain;
            graphicTile.changeBuild(currentBuild);
        }
    }
}