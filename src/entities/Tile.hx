package entities;

import manager.Selection;
import entities.Flower;
import engine.events.Events;
import utils.ArrayCoord;
import utils.Vector2;

class Tile extends GameObject
{

    public var currentGround = "grass";
    public var currentBuild = null;

    public var groundEvents:Events;
    public var buildingEvents:Events;

    public var flowerRef:Flower;

    public var coord:ArrayCoord;

	public function new (_coord:ArrayCoord)
	{
		super();
        addComponent("graphicTile");

        graphicTile.addGround("ground");
        graphicTile.setInteractive(mouseover, mouseout, mouseclick);

        buildingEvents = new Events();
        buildingEvents.on("state changed", function (state:String) {
            graphicTile.changeBuild(state + "Flower");
        });
        buildingEvents.on("destroying", function () {
            currentBuild = null;
            graphicTile.destroyBuild();
        });

        coord = _coord;
        graphicTile.setPlace(coord.x, coord.y, coord.i);
    }


    public function coordInPixel ():Vector2 {
        return graphicTile.coordInPixel();
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