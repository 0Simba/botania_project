package engine.isoEngine;

import pixi.display.MovieClip;
import engine.isoEngine.IsoEngine;
import js.Browser;


class Tile {

    static var zize:Int = 0;        // size* unanderstand error
    static var semiSize:Int = 0;
    static var referent:IsoEngine;

    private var ground:MovieClip;
    private var building:MovieClip;

    static public function setReferent (isoEngine) {
        referent = isoEngine;
    }

    static public function setSize (_size:Int) {
        zize      = _size;
        semiSize  = Math.floor(_size / 2);
    }

    public function new (groundTexture:String) {
        ground   = new MovieClip(Tile.referent.animations.get(groundTexture));
        //building = new MovieClip();


        ground.width  = Tile.zize;
        ground.height = Tile.semiSize;

        Tile.referent.camera.addChild(ground);
    }

    public function place (x:Float, y:Float) {
        ground.x = x;
        ground.y = y;
    }
}
