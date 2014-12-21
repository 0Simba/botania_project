package engine.isoEngine;

import pixi.primitives.Graphics;
import utils.Vector2;
import engine.isoEngine.Tile;
import engine.isoEngine.IsoEngine;

class Camera
{

    static private var camera:Graphics;
    static private var tileOn:Tile;
    static private var isoEngine:IsoEngine;

    static public function setRef (cameraRef, peonWhileTrue) { // IsoEngine.getInstance == crash
        camera    = cameraRef;
        isoEngine = peonWhileTrue;
        setMouse();
    }

    static public function move (x:Float = 0, y:Float = 0) {
        camera.x += x;
        camera.y += y;
    }

    static private function setMouse () {
        camera.interactive = true;
        camera.mousemove = mousemove;
    }

    static private function mousemove (mouseData) {
        var px:Vector2 = new Vector2(mouseData.global.x, mouseData.global.y);
        px.x -= camera.x;
        px.y -= camera.y;

        var x:Int = Math.round((px.y / isoEngine.size / 2) + (px.x / isoEngine.size));
        var y:Int = Math.round((px.y / isoEngine.size / 2) - (px.x / isoEngine.size));

        trace(x + " : " + y);
    }

}