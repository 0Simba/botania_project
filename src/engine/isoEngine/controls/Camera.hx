package engine.isoEngine.controls;

import js.html.VoidCallback;
import pixi.display.DisplayObjectContainer;
import utils.Vector2;
import engine.isoEngine.components.Tile;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.managers.Displaying;
import engine.isoEngine.controls.Mouse;

class Camera
{
    static public var scale:Float = 1;

    static public function move (x:Float = 0, y:Float = 0) {
        camera.x += x;
        camera.y += y;
    }

    static public function zoom (v:Float) {
        var startDiffX = (isoEngine.width / 2)  - camera.x;
        var startDiffY = (isoEngine.height / 2) - camera.y;
        var perX = startDiffX / camera.width;
        var perY = startDiffY / camera.height;


        scale += v;
        camera.scale = new pixi.geom.Point(scale, scale);

        var endDiffX = (isoEngine.width / 2)  - (camera.x + camera.width  * perX);
        var endDiffY = (isoEngine.height / 2) - (camera.y + camera.height * perY);

        camera.x += endDiffX;
        camera.y += endDiffY;
    }


    static public function onClick () {
        var tile = isoEngine.map.getTile(cast currentPos.x, cast currentPos.y);
        if (tile != null) tile.mouseClick();
    }



        /***** YOU DON'T CARE *****/
    static private var camera:DisplayObjectContainer;
    static private var tileOn:Tile;
    static private var isoEngine:IsoEngine;
    static private var currentPos:Vector2;

    static public function setRef (peonWhileTrue) { // IsoEngine.getInstance == crash
        isoEngine  = peonWhileTrue;
        camera     = isoEngine.displaying.getCamera();
        currentPos = new Vector2(-1, -1);
        setMouse();
    }


    static private function setMouse () {
        camera.interactive = true;
        camera.mousemove = mousemove;
        Mouse.events.on("map mouseup", onClick);
    }


    static private function mousemove (mouseData) {
        var newPos = pxToCoord(new Vector2(mouseData.global.x, mouseData.global.y));

        if (tileChanged(newPos)) {
            var tile = isoEngine.map.getTile(cast currentPos.x, cast currentPos.y);
            if (tile != null) {
                tile.mouseExit();
            }

            tile = isoEngine.map.getTile(cast newPos.x, cast newPos.y);
            if (tile != null) {
                tile.mouseEnter();
                if (tile.isInteractive) {
                    isoEngine.tileIndicator.overOn(cast newPos.x, cast newPos.y);
                }
                else {
                    isoEngine.tileIndicator.hide();
                }
            }
            else {
                isoEngine.tileIndicator.hide();
            }
        }
        currentPos = newPos;
    }


    static private function tileChanged (newPos):Bool {
        return (newPos.x != currentPos.x || newPos.y != currentPos.y);
    }


    static private function pxToCoord (px:Vector2) {
        px.x -= camera.x;
        px.y -= camera.y;

        var tileW = Tile.size.x * scale;
        var tileH = Tile.size.y * scale;


        var newPos = new Vector2(-1, -1);
        newPos.x = Math.round( (px.x - tileW) / (tileW) + px.y / (tileH) );
        newPos.y = Math.round( (px.y / (tileH)) - px.x / (tileW));

        return newPos;
    }
}