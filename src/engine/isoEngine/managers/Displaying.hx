package engine.isoEngine.managers;

import js.Browser;
import pixi.primitives.Graphics;
import pixi.display.MovieClip;
import pixi.display.Stage;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.controls.Camera;

class Displaying
{
    static private var instance;

    public function displayMcOn (mc:MovieClip, layer:String) {
        if (layers.exists(layer)) {
            layers.get(layer).addChild(mc);
        }
        else {
            trace("Le layer " + layer + " n'existe pas");
        }
    }


    public function createChildLayer (name:String, parent:String) {
        if (layers.get(name) == null) {
            var layer = new Graphics();
            layers.get(parent).addChild(layer);
            layers.set(name, layer);
        }
    }



        /***** SURELY NOT INTERST YOU *****/

    public function getCamera ():Graphics {
        return layers.get('camera');
    }

        /***** YOU DON'T CARE *****/

    private var layers:Map<String, Graphics>;
    private var stage:Stage;


    public function new (_stage:Stage) {
        layers = new Map<String, Graphics>();
        stage = _stage;

        createMainLayer("background");
        createMainLayer("camera");
        createMainLayer("fx");
        createMainLayer("foreground");
        createMainLayer("hud");
        createMainLayer("overlay");

        createChildLayer("tiles", "camera");
        createChildLayer("overTiles", "camera");
    }

    private function createMainLayer (name:String) {
        var layer = new Graphics();
        stage.addChild(layer);
        layers.set(name, layer);
    }
}
