package entities;

import manager.Selection;
import entities.Flower;
import engine.events.Events;
import utils.ArrayCoord;
import utils.Vector2;
import entities.building.Breaker;

class Tile extends GameObject
{

    public var currentGround = "grass";
    public var currentBuild = null;

    public var groundEvents:Events;
    public var buildingEvents:Events;

    public var buildingRef:GameObject;

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
        buildingEvents.on("destroying", destroyBuilding);

        coord = _coord;
        graphicTile.setPlace(coord.x, coord.y, coord.i);
    }


    public function coordInPixel ():Vector2 {
        return graphicTile.coordInPixel();
    }


    public function destroyBuilding () {
        currentBuild = null;
        graphicTile.changeBuild();
    }



        /***** CREATING -> FIXME REFACTOR LATER *****/
    public function create (name:Int) { // Server stock int, TODO refactor to get name !!!
        if (name == 1) { //breaker
            buildBreaker();
        }
    }

    public function createFlower () {
        currentBuild = "flower";
        buildingRef  = new Flower(buildingEvents);
    }

    public function createBreaker () {
        var data:Dynamic = {};
        data.position = coord.toVector2();
        callServer("buildBreaker", data, cast buildBreaker, cast alertError);
    }
    private function buildBreaker () {
        currentBuild = "breaker";
        buildingRef  = new Breaker(buildingEvents, coord.toVector2());
        graphicTile.changeBuild(currentBuild);
    }
    private function alertError () {
        js.Browser.window.alert("Erreur serveur");
    }

    /***** MOUSE EVENTS -> GO TO MANAGER.MOUSETILE *****/

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