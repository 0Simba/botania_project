package engine.isoEngine.components;

import pixi.text.Text;
import pixi.primitives.Graphics;
import engine.isoEngine.IsoEngine;
import js.Browser;
import engine.isoEngine.IsoUtils;
import engine.isoEngine.managers.Displaying;
import utils.Vector2;
import engine.isoEngine.components.IsoComponent;
import pixi.display.Sprite;
import engine.isoEngine.components.ColorMatrixFilters;

class Tile extends IsoComponent
{

    static public var size:Vector2 = new Vector2(64, 32);

    public var ground:Sprite;
    public var building:Sprite;
    public var coord:utils.ArrayCoord;
    public var isInteractive:Bool;

    private var coordText:Text;


            /***** GROUND *****/
    public function addGround (name:String) {
        ground = new Sprite(isoEngine.assets.getTexture(name));

        ground.width  = size.x;
        ground.height = size.y;
    }


    public function changeGround (name:String) {
        ground.texture = isoEngine.assets.getTexture(name);
    }


    public function hideGround () {
        ground.visible = false;
    }
    public function showGround () {
        ground.visible = true;
    }

            /***** BUILDING *****/
    public function addBuild (textureName:String) {

        building = new Sprite(isoEngine.assets.getTexture(textureName));
        setBuild(textureName);

        building.x = ground.x + size.x / 2;
        building.y = ground.y + size.y / 2;


        var layerNumber:Int  = coord.x + coord.y;
        layerName = "buildingHeight" + layerNumber;

        isoEngine.displaying.displayMcOn(building, layerName);
    }

    public function changeBuild (name:String = null) {
        if (name == null) {
            if (building != null) building.visible = false;
        }
        else {
            if (building == null) {
                addBuild(name);
            }
            else {
                clearBuild();
                setBuild(name);
            }
            building.visible = true;
        }
    }

    public function addBuildTexture (name:String):Sprite {
        var texture = isoEngine.assets.getTexture(name);
        var child = new Sprite(texture);
        building.addChild(child);
        setBuild(name, child);
        return child;
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

    public function lightFilterBuilding () {
        if (building != null) {
            var filter = ColorMatrixFilters.get("over");
            building.filters = [filter];
        }
    }

    public function noFilterBuilding () {
        if (building != null) {
            building.filters = null;
        }
    }

    private function clearBuild () {
        var child = building.children;

        for (i in 0...child.length) {
            building.removeChild(child[i]);
        }
    }

    private function setBuild (textureName:String, element:Sprite = null) {
        element = (element != null) ? element : building;

        element.texture = isoEngine.assets.getTexture(textureName);
        var size = isoEngine.assets.getSize(textureName);
        element.anchor  = isoEngine.assets.getAnchor(textureName);
        element.width   = size.x;
        element.height  = size.y;
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
        var coord = IsoUtils.coordToPx(coord.x, coord.y);
        coord.x += size.x / 2;
        coord.y += size.y / 2;
        return coord;
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