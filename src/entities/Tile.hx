package entities;

import manager.Selection;
import entities.Flower;
import entities.Building;
import entities.building.EcosystemBuilding;
import engine.events.Events;
import utils.ArrayCoord;
import utils.Vector2;
import engine.isoEngine.components.Animation;
import entities.genetic.Genome;
import engine.isoEngine.IsoEngine;

class Tile extends GameObject
{
    static private var events:Events;

    public var currentGround = "circle";

    public var groundEvents:Events;

    public var currentBuild = null;
    public var buildingEvents:Events;
    public var buildingRef:GameObject;
    public var buildingServerResponse = true;

    public var coord:ArrayCoord;
    public var flowerAnim:Animation;

    public var graphicTile:engine.isoEngine.components.Tile;

	public function new (_coord:ArrayCoord)
	{
		super();
        graphicTile = new engine.isoEngine.components.Tile();

        graphicTile.addGround("circle");
        graphicTile.hideGround();
        graphicTile.setInteractive(mouseover, mouseout, mouseclick);

        bindBuildingsEvents();

        coord = _coord;
        graphicTile.setPlace(coord.x, coord.y, coord.i);
        // graphicTile.displayCoord();

        var events = IsoEngine.getInstance().events;

        events.on("buttonOver", disableCurrentTile);
        events.on("buttonOut",  enableCurrentTile);
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
               applyAdultFlowerDisplay();
            }
            else if (state == "bloom") {
                applyAdultFlowerDisplay();
                flowerAnim = new Animation("bloom", new Vector2(graphicTile.building.x, graphicTile.building.y, "px", "px"), "overTiles");
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
            //alertError();
            destroyBuilding();
        });
        buildingEvents.on("destroying", function () {
            graphicTile.building.alpha = 0.3;
            if (flowerAnim != null) flowerAnim.destroy();
        });

        buildingEvents.on("destroyed", destroyBuilding);

    }

    private function applyAdultFlowerDisplay () {
        var flower:Flower = cast buildingRef;
        var genomeAppearance = flower.genome.getAppearanceName();
        graphicTile.changeBuild("flowerContainer");
        graphicTile.addBuildTexture("G" + genomeAppearance.charAt(2));
        graphicTile.addBuildTexture("O" + genomeAppearance.charAt(1));
        graphicTile.addBuildTexture("F" + genomeAppearance.charAt(0));

        if (flowerAnim != null) {
            flowerAnim.destroy();
            flowerAnim = null;
        }
    }


        /***** CREATING -> FIXME REFACTOR LATER *****/
    public function create (name:String) {
        createBuilding(name, false);
    }

    public function createFlower (seed:Seed) {
        currentBuild = "flower";
        buildingRef  = new Flower(buildingEvents, new Vector2(coord.x, coord.y), seed);
    }

    public function flowerLoaded (lastTimeStamp:Int, currentTimeStamp:Int, genome:Genome, stateIndex:Int) {
        currentBuild = "flower";
        buildingRef  = new Flower(buildingEvents, new Vector2(coord.x, coord.y), null, genome, lastTimeStamp, currentTimeStamp, stateIndex);
    }

    public function createBuilding (name:String, checkServer:Bool = true) {
        currentBuild = name;
        buildingRef  = new Building(name, buildingEvents, coord.toVector2(), checkServer);
        graphicTile.changeBuild(currentBuild);
    }

    public function createEcoBuilding (name:String, checkServer:Bool = true) {
        currentBuild = name;
        buildingRef  = new EcosystemBuilding(name, buildingEvents, coord.toVector2(), checkServer);
        graphicTile.changeBuild(currentBuild);
    }

    private function alertError () {
        js.Browser.window.alert("Erreur serveur");
        buildingServerResponse = true;
    }

    /***** MOUSE EVENTS -> GO TO MANAGER.MOUSETILE *****/

    static private var currentTile:Tile;
    static function disableCurrentTile (needed = null) {
        currentTile.graphicTile.hideGround();
    }
    static function enableCurrentTile (needed = null) {
        currentTile.graphicTile.showGround();
    }


    public function mouseover () {
        currentTile = this;
        if (!engine.isoEngine.components.Button.oneOver) graphicTile.showGround();
        manager.MouseTile.over(this);
    }

    public function mouseout () {
        graphicTile.hideGround();
        manager.MouseTile.out(this);
    }

    public function mouseclick () {
        manager.MouseTile.click(this);
    }
}