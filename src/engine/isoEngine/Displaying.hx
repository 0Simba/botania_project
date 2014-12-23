package engine.isoEngine;

import js.Browser;
import pixi.primitives.Graphics;
import pixi.display.MovieClip;
import pixi.display.Stage;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.Camera;

class Displaying
{
    static private var instance;

    public function displayMcOn (mc:MovieClip, layer:String) {
        layers.get(layer).addChild(mc);
    }

    public function displayOn (movieClip:MovieClip, layerName:String) {

    }



        /***** YOU DON'T CARE *****/

    private var layers:Map<String, Graphics>;
    private var stage:Stage;

    public function getCamera ():Graphics {
        return layers.get('camera');
    }

    private function new (_stage:Stage) {
        layers = new Map<String, Graphics>();
        stage = _stage;

        createMainLayer("camera");
        createChildLayer("tiles", "camera");
        createChildLayer("overTiles", "camera");
    }

    private function createMainLayer (name:String) {
        var layer = new Graphics();
        stage.addChild(layer);
        layers.set(name, layer);
    }

    private function createChildLayer (name:String, parent:String) {
        var layer = new Graphics();
        layers.get(parent).addChild(layer);
        layers.set(name, layer);
    }

    public static function getInstance (stage:Stage = null) {
        if (instance == null) instance = new Displaying(stage);
        return instance;
    }
}
