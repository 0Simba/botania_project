package entities;

import manager.Selection;
import entities.Flower;

class Tile extends GameObject
{

    public var currentGround = "grass";
    public var currentBuild = null;

    public var flowerRef:Flower;

	public function new ()
	{
		super();
        addComponent("graphicTile");

        graphicTile.addGround("ground");
        graphicTile.setInteractive(mouseover, mousequit, mouseClick);
    }



    public function createFlower () {
        flowerRef = new Flower(this);
    }



    /***** MOUSE EVENTS *****/

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
            graphicTile.changeGround(currentGround);
        }
        else if (Selection.actionType == "build") {
            graphicTile.changeBuild(currentBuild);
        }
    }

    public function mouseClick () {
        if (Selection.contain == null) return;


        if (Selection.actionType == "ground") {
            currentGround = Selection.contain;
            graphicTile.changeGround(currentGround);
        }
        else if (Selection.actionType == "build") {
            currentBuild = Selection.contain;
            graphicTile.changeBuild(currentBuild);

            createFlower();                             //!\ remove this after test ! /!\
        }
    }
}