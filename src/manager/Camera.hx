package manager;

import engine.input.Keyboard;
import engine.isoEngine.controls.Camera;
import init.Config;
class CameraManager {

    static public var velocity:Float   = 0.1;
    static public var minSpeed:Float   = 0.1;
    static public var tempSpeedX:Float = 0;
    static public var tempSpeedY:Float = 0;
    static public function update () {
        var speed:Float = Config.camera.speed * Main.deltaTime;
        if (Keyboard.key.get("right")) {
            tempSpeedX = -speed;
            Camera.move(-speed, 0);
        }
        if (Keyboard.key.get("left")) {
            tempSpeedX = speed;
            Camera.move(speed, 0);
        }
        if (Keyboard.key.get("up")) {
            tempSpeedY = speed;
            Camera.move(0, speed);
        }
        if (Keyboard.key.get("down")) {
            tempSpeedY = -speed;
            Camera.move(0, -speed);
        }

        manageVelocity();

        if (Keyboard.key.get("a")) {
            Camera.zoom(-0.01);
        }
        if (Keyboard.key.get("q")) {
            Camera.zoom(0.01);
        }
    }

    static public function manageVelocity() {
        if(tempSpeedX != 0){
            tempSpeedX -= tempSpeedX < 0 ? -velocity : velocity;
            if(Math.sqrt(tempSpeedX * tempSpeedX) < minSpeed){
                tempSpeedX = 0;
            }
            Camera.move(tempSpeedX, 0);
        }

        if(tempSpeedY != 0){
            tempSpeedY -= tempSpeedY < 0 ? -velocity : velocity;
            if(Math.sqrt(tempSpeedY * tempSpeedY) < minSpeed){
                tempSpeedY = 0;
            }
            Camera.move(0, tempSpeedY);
        }
    }
}
