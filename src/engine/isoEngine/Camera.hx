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
    static private var currentPos:Vector2;

    static public function setRef (cameraRef, peonWhileTrue) { // IsoEngine.getInstance == crash
        camera     = cameraRef;
        isoEngine  = peonWhileTrue;
        currentPos = new Vector2(-1, -1);
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
        var px = new Vector2(mouseData.global.x, mouseData.global.y);
        px.x -= camera.x;
        px.y -= camera.y;





        var newPos = new Vector2(-1, -1);
        newPos.x = Math.round( (px.x - isoEngine.size) / (isoEngine.size) + px.y / (isoEngine.size / 2) );
        newPos.y = Math.round( px.x / (isoEngine.size) - (px.y / (isoEngine.size / 2)) ) * -1;

        if (newPos.x != currentPos.x || newPos.y != currentPos.y) {
            var tile = isoEngine.getMapedTile(cast currentPos.x, cast currentPos.y);
            if (tile != null) {
                tile.changeGround("ground");
            }
        }

        var tile = isoEngine.getMapedTile(cast newPos.x, cast newPos.y);

        if (tile != null) {
            tile.changeGround("water");
        }

        currentPos = newPos;
    }

}