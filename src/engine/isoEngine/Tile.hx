package engine.isoEngine;

import pixi.display.MovieClip;
import engine.isoEngine.IsoEngine;
import js.Browser;
import engine.isoEngine.IsoUtils;
import engine.isoEngine.Displaying;

class Tile {

    static var referent:IsoEngine;

    public var ground:MovieClip;
    public var building:MovieClip;
    public var coord:utils.ArrayCoord;

    public function addGround (name:String) {
        ground = new MovieClip(Tile.referent.animations.get(name));

        ground.width  = Tile.referent.size;
        ground.height = Tile.referent.size / 2;

        Displaying.getInstance().displayMcOn(ground, "tiles");
    }

    public function changeGround (name:String) {
        ground.texture = Tile.referent.textures.get(name);
    }

    private function place (x:Int, y:Int) {
        var px = IsoUtils.coordToPx(x, y);
        ground.x = px.x;
        ground.y = px.y;
    }

    public function new () {
        Tile.referent = IsoEngine.getInstance();
        isInteractive = false;
    }

    public function setPlace (_x, _y, _i) {
        coord = new utils.ArrayCoord(_x, _y, _i);
        place(_x, _y);

        if (coord.i >= 0) {
            Tile.referent.addMapedTile(this);
        }
    }


        /***** INTERACTION *****/

    public var isInteractive:Bool;

    public function setInteractive (_mouseEnter, _mouseExit) {
        mouseEnter    = _mouseEnter;
        mouseExit     = _mouseExit;
        isInteractive = true;
    }


    dynamic public function mouseEnter () {}
    dynamic public function mouseExit () {}
}
