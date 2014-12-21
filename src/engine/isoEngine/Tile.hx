package engine.isoEngine;

import pixi.display.MovieClip;
import engine.isoEngine.IsoEngine;
import js.Browser;


class Tile {

    static var referent:IsoEngine;
    public var ground:MovieClip;
    public var building:MovieClip;
    public var coord:utils.ArrayCoord;

    public function addGround (name:String) {
        ground = new MovieClip(Tile.referent.animations.get(name));

        ground.width  = Tile.referent.size;
        ground.height = Tile.referent.size / 2;

        Tile.referent.camera.addChild(ground);
    }

    public function changeGround (name:String) {
        ground.texture = Tile.referent.textures.get(name);
    }

    private function place (x:Float, y:Float) {
        var pxX:Float = x * Tile.referent.size / 2 - (y * Tile.referent.size / 2);
        var pxY:Float = x * Tile.referent.size / 4 + (y * Tile.referent.size / 4);

        ground.x = pxX;
        ground.y = pxY;

    }

    public function new () {
        Tile.referent = IsoEngine.getInstance();
    }

    public function setPlace (_x, _y, _i) {
        coord = new utils.ArrayCoord(_x, _y, _i);
        place(_x, _y);

        if (coord.i >= 0) {
            Tile.referent.addMapedTile(this);
        }
    }
}

