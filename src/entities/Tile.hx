package entities;

import manager.Selection;
import entities.Flower;
import engine.events.Events;

class Tile extends GameObject
{

    public var currentGround = "grass";
    public var currentBuild = null;

    public var groundEvents:Events;
    public var buildingEvents:Events;

    public var flowerRef:Flower;

	public function new ()
	{
		super();
        addComponent("graphicTile");

        graphicTile.addGround("ground");
        graphicTile.setInteractive(mouseover, mousequit, mouseClick);

        buildingEvents = new Events();
        buildingEvents.on("state changed", function (state:String) {
            graphicTile.changeBuild(state + "Flower");
        });
    }



    public function createFlower () {
        flowerRef = new Flower(buildingEvents);
    }



    /***** MOUSE EVENTS *****/

    public function mouseover () {
        if (Selection.contain == null) return;

        if (Selection.actionType == "ground") {
            graphicTile.changeGround(Selection.contain);
        }
        else if (Selection.actionType == "build" && currentBuild != null) {
            graphicTile.changeBuild(Selection.contain);
        }
    }

    public function mousequit () {
        if (Selection.actionType == "ground") {
            graphicTile.changeGround(currentGround);
        }
        else if (Selection.actionType == "build" && currentBuild != null) {
            graphicTile.changeBuild(currentBuild);
        }
    }

    public function mouseClick () {
        if (Selection.contain == null) return;

        if (Selection.actionType == "ground") {
            currentGround = Selection.contain;
            graphicTile.changeGround(currentGround);
        }
        else if (Selection.actionType == "build" && currentBuild == null) {
            createFlower();                             //!\ remove this after test ! /!\
        }
    }
}