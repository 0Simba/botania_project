package engine.isoEngine;
import pixi.primitives.Graphics;


class Camera
{

    static private var camera:Graphics;

    static public function setRef (cameraRef) {
        camera = cameraRef;
    }

    static public function move (x:Float = 0, y:Float = 0) {
        camera.x += x;
        camera.y += y;
    }

}