package engine.isoEngine.components;

import pixi.display.MovieClip;
import pixi.text.Text;
import pixi.primitives.Graphics;
import engine.isoEngine.IsoEngine;
import js.Browser;
import engine.isoEngine.IsoUtils;
import engine.isoEngine.managers.Displaying;
import utils.Vector2;
import engine.isoEngine.components.IsoComponent;

class Tile extends IsoComponent
{

    static public var size:Vector2 = new Vector2(64, 32);

    public var ground:MovieClip;
    public var building:MovieClip;
    public var coord:utils.ArrayCoord;
    public var isInteractive:Bool;

    private var coordText:Text;


            /***** GROUND *****/
    public function addGround (name:String) {
        ground = new MovieClip(isoEngine.assets.getAnimation(name));

        ground.width  = size.x;
        ground.height = size.y;
    }


    public function changeGround (name:String) {
        ground.texture = isoEngine.assets.getTexture(name);
    }


            /***** BUILDING *****/
    public function addBuild (textureName:String) {
        building = new MovieClip(isoEngine.assets.getAnimation("ground"));
        building.texture = isoEngine.assets.getTexture(textureName);

        building.width  = size.x;
        building.height = size.y * 2;

        building.x = ground.x;
        building.y = ground.y - size.y;


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
                building.texture = isoEngine.assets.getTexture(name);
            }
            building.visible = true;
        }
    }

    public function displayCoord () {
        var text = coord.x + " : " + coord.y;
        coordText = new Text(text);
        coordText.x      = ground.x + size.x / 2;
        coordText.y      = ground.y + size.y / 2;
        coordText.width  = size.x;
        coordText.height = size.y;
        coordText.pivot  = new pixi.geom.Point(0.5, 0.5);

        isoEngine.displaying.displayMcOn(coordText, "tiles");
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
    static public function setSize (_size:Vector2) {
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
        super();
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