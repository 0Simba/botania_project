package entities;

import manager.Selection;
import entities.Flower;
import engine.events.Events;
import utils.ArrayCoord;
import utils.Vector2;
import entities.building.Breaker;
import engine.isoEngine.components.Animation;
import entities.genetic.Genome;

class Tile extends GameObject
{

    public var currentGround = "circle";

    public var groundEvents:Events;

    public var currentBuild = null;
    public var buildingEvents:Events;
    public var buildingRef:GameObject;
    public var buildingServerResponse = true;

    public var coord:ArrayCoord;
    public var flowerAnim:Animation;

	public function new (_coord:ArrayCoord)
	{
		super();
        addComponent("graphicTile");

        graphicTile.addGround("ground");
        graphicTile.changeGround("circle");
        graphicTile.setInteractive(mouseover, mouseout, mouseclick);

        bindBuildingsEvents();

        coord = _coord;
        graphicTile.setPlace(coord.x, coord.y, coord.i);
        // graphicTile.displayCoord();
    }


    public function coordInPixel ():Vector2 {
        return graphicTile.coordInPixel();
    }


    public function destroyBuilding () {
        currentBuild = null;
        graphicTile.changeBuild();
    }

    private function bindBuildingsEvents () {
        buildingEvents = new Events();

        buildingEvents.on("state changed", function (state:String) {
            if (state == "adult") {
                var flower:Flower = cast buildingRef;
                var genomeAppearance = flower.genome.getAppearanceName();
                graphicTile.changeBuild("flowerContainer");
                graphicTile.addBuildTexture("O" + genomeAppearance.charAt(1));
                graphicTile.addBuildTexture("G" + genomeAppearance.charAt(2));
                graphicTile.addBuildTexture("F" + genomeAppearance.charAt(0));

                if (flowerAnim != null) {
                    flowerAnim.destroy();
                    flowerAnim = null;
                }
            }
            else if (state == "bloom") {
                flowerAnim = new Animation("bloom", new Vector2(graphicTile.building.x, graphicTile.building.y), "overTiles");
            }
            else {
                if (flowerAnim != null) {
                    flowerAnim.destroy();
                    flowerAnim = null;
                }
                graphicTile.changeBuild(state + "Flower");
            }
        });

        buildingEvents.on("callingServer", function () {
            graphicTile.building.alpha = 0.7;
        });
        buildingEvents.on("builded", function () {
                graphicTile.building.alpha = 1;
        });
        buildingEvents.on("unbuilded", function () {
            alertError();
            destroyBuilding();
        });

        buildingEvents.on("destroyed", destroyBuilding);

    }


        /***** CREATING -> FIXME REFACTOR LATER *****/
    public function create (name:Int) { // Server stock int, TODO refactor to get name !!!
        if (name == 1) { //breaker
            createBreaker(false);
        }
    }

    public function createFlower (seed:Seed) {
        currentBuild = "flower";
        buildingRef  = new Flower(buildingEvents, new Vector2(coord.x, coord.y), seed);
    }

    public function flowerLoaded (lastTimeStamp:Int, genome:Genome, stateIndex:Int) {
        currentBuild = "flower";
        buildingRef  = new Flower(buildingEvents, new Vector2(coord.x, coord.y), null, genome, lastTimeStamp, stateIndex);
    }

    public function createBreaker (checkServer:Bool = true) {
        currentBuild = "breaker";
        buildingRef  = new Breaker(buildingEvents, coord.toVector2(), checkServer);
        graphicTile.changeBuild(currentBuild);
    }

    private function alertError () {
        js.Browser.window.alert("Erreur serveur");
        buildingServerResponse = true;
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