package manager;

import engine.input.Keyboard;
import engine.isoEngine.Camera;

class CameraManager {

    static public function update () {
        var speed:Float = 20 * Main.deltaTime;
        if (Keyboard.key.get("right")) {
            Camera.move(-speed, 0);
        }
        if (Keyboard.key.get("left")) {
            Camera.move(speed, 0);
        }
        if (Keyboard.key.get("up")) {
            Camera.move(0, speed);
        }
        if (Keyboard.key.get("down")) {
            Camera.move(0, -speed);
        }
    }
}
