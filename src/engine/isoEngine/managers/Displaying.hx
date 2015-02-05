package engine.isoEngine.managers;

import js.Browser;
//import pixi.primitives.Graphics;
import pixi.display.DisplayObjectContainer;
import pixi.display.MovieClip;
import pixi.display.Stage;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.controls.Camera;
import pixi.display.Sprite;

class Displaying
{
    static private var instance;

    public function displayMcOn (mc, layer:String) {
        if (layers.exists(layer)) {
            layers.get(layer).addChild(mc);
        }
        else {
            logLayerDoesntExist(layer);
        }
    }


    public function removeMcIn (mc:MovieClip, layer:String) {
        if (layers.exists(layer)) {
                layers.get(layer).removeChild(mc);
        }
        else {
            logLayerDoesntExist(layer);
        }
    }


    public function createChildLayer (name:String, parent:String):DisplayObjectContainer{
        if (layers.exists(name)) {
            trace("IsoEngine.displaying.createChildLayer -> un layer " + name + " existe déjà. opération refusé.");
            return null;
        }

        if (layers.get(name) == null) {
            var layer = new DisplayObjectContainer();
            layers.get(parent).addChild(layer);
            layers.set(name, layer);
            return layer;
        }
        return null;
    }



        /***** SURELY NOT INTERST YOU *****/

    public function getCamera ():DisplayObjectContainer {
        return layers.get('camera');
    }

    public function getLayer (name:String):DisplayObjectContainer {
        if (layers.exists(name)) {
            return layers.get(name);
        }
        else {
            trace("isoEngine.displaying.getLayer(name:String) -> Pas de layer existant au nom de " + name);
            return null;
        }
    }

        /***** YOU DON'T CARE *****/

    private var layers:Map<String, DisplayObjectContainer>;
    private var stage:Stage;


    public function new (_stage:Stage) {
        layers = new Map<String, DisplayObjectContainer>();
        stage = _stage;

        createMainLayer("background");
        createMainLayer("camera");
            createChildLayer("playArea", "camera");
                createChildLayer("tiles"    , "playArea");
                createChildLayer("overTiles", "playArea");
            createChildLayer("fx", "camera");
        createMainLayer("foreground");
        createMainLayer("hud");
        createMainLayer("overlay");
    }

    private function createMainLayer (name:String) {
        var layer = new DisplayObjectContainer();
        stage.addChild(layer);
        layers.set(name, layer);
    }

    private function logLayerDoesntExist (layer:String) {
        trace("Le layer " + layer + " n'existe pas");
    }
}
