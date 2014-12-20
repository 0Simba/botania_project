package engine.isoEngine;

import pixi.display.MovieClip;
import engine.isoEngine.IsoEngine;
import js.Browser;


class Tile {

    static var zize:Int = 0;        // size* unanderstand error
    static var semiSize:Int = 0;
    static var referent:IsoEngine;

    public var ground:MovieClip;
    public var building:MovieClip;

    public function new () {
        ground;
        building;
        Tile.referent = IsoEngine.getInstance();
    }

    public function addGround (name:String) {
        ground = new MovieClip(Tile.referent.animations.get(name));

        ground.width  = Tile.referent.size;
        ground.height = Tile.referent.size / 2;

        Tile.referent.camera.addChild(ground);
    }

    public function place (x:Float, y:Float) {
        var pxX:Float = x * Tile.referent.size / 2  - (y * Tile.referent.size / 2);
        var pxY:Float = x * Tile.referent.size / 4 + (y * Tile.referent.size / 4);

        ground.x = pxX;
        ground.y = pxY;
    }
}
