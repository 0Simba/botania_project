package engine.isoEngine.components;

import pixi.display.MovieClip;
import pixi.primitives.Graphics;
import engine.isoEngine.IsoEngine;
import js.Browser;
import engine.isoEngine.IsoUtils;
import engine.isoEngine.managers.Displaying;
import utils.Vector2;

class Tile {

    static var isoEngine:IsoEngine;
    static public var size:Int = 64;

    public var ground:MovieClip;
    public var building:MovieClip;
    public var coord:utils.ArrayCoord;
    public var isInteractive:Bool;



            /***** GROUND *****/
    public function addGround (name:String) {
        ground = new MovieClip(isoEngine.assets.animations.get(name));

        ground.width  = size;
        ground.height = size / 2;
    }


    public function changeGround (name:String) {
        ground.texture = isoEngine.assets.textures.get(name);
    }


            /***** BUILDING *****/
    public function addBuild (textureName:String) {
        building = new MovieClip(isoEngine.assets.animations.get("ground"));
        building.texture = isoEngine.assets.textures.get(textureName);

        building.width  = size;
        building.height = size;

        building.x = ground.x;
        building.y = ground.y - size / 2;


        var layerNumber:Int  = coord.x + coord.y;
        layerName = "buildingHeight" + layerNumber;

        isoEngine.displaying.displayMcOn(building, layerName);
    }

    public function changeBuild (name:String = null) {
        if (name == null) {
            building.visible = false;
        }
        else {
            if (building == null) {
                addBuild(name);
            }
            else {
                building.texture = isoEngine.assets.textures.get(name);
            }
            building.visible = true;
        }
    }

    public function destroyBuild () {
        isoEngine.displaying.removeMcIn(building, layerName);
    }


            /***** POSITION *****/
    private function place (x:Int, y:Int) {
        var px = IsoUtils.coordToPx(x, y);
        ground.x = px.x;
        ground.y = px.y;

        isoEngine.displaying.displayMcOn(ground, "tiles");
    }


    public function setPlace (_x, _y, _i) {
        coord = new utils.ArrayCoord(_x, _y, _i);
        place(_x, _y);

        if (coord.i >= 0) {
            isoEngine.map.addTile(this);
        }
    }

    public function coordInPixel ():Vector2 {
        return IsoUtils.coordToPx(coord.x, coord.y);
    }


        /***** SIZE *****/
    static public function setSize (_size:Int) {
        size = _size;
    }



        /***** INTERACTION *****/
    public function setInteractive (_mouseEnter, _mouseExit, _mouseClick) {
        personalMouseEnter = _mouseEnter;
        personalMouseExit  = _mouseExit;
        personalMouseClick = _mouseClick;
        isInteractive = true;
    }




        /***** YOU DON'T CARE *****/

    private var layerName:String;

    public function new () {
        isoEngine = IsoEngine.getInstance();
        isInteractive = false;
    }


    dynamic public function mouseEnter () {
        // isoEngine.emit("tileMouseEnter", this);
        personalMouseEnter();
    }
    dynamic public function mouseExit () {
        // isoEngine.emit("tileMouseExit", this);
        personalMouseExit();
    }
    dynamic public function mouseClick () {
        // isoEngine.emit("tileMouseClick", this);
        personalMouseClick();
    }


    dynamic public function personalMouseEnter () {}
    dynamic public function personalMouseExit () {}
    dynamic public function personalMouseClick () {}

}