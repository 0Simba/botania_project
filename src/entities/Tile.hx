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
        graphicTile.setInteractive(mouseover, mouseout, mouseclick);

        buildingEvents = new Events();
        buildingEvents.on("state changed", function (state:String) {
            graphicTile.changeBuild(state + "Flower");
        });
    }



    public function createFlower () {
        currentBuild = "flower";
        flowerRef = new Flower(buildingEvents);
    }



    /***** MOUSE EVENTS *****/

    public function mouseover () {
        manager.MouseTile.over(this);
    }

    public function mouseout () {
        manager.MouseTile.out(this);
    }

    public function mouseclick () {
        manager.MouseTile.click(this);
    }
}