package engine.isoEngine.managers;

import pixi.textures.Texture;
import pixi.loaders.AssetLoader;
import engine.isoEngine.IsoEngine;
import pixi.geom.Point;
import utils.Vector2;

class Assets
{

    private var animations:Map<String, Array<Texture>>;
    private var textures  :Map<String, Texture>;
    private var anchors   :Map<String, Point>;
    private var sizes     :Map<String, Vector2>;


    public function getTexture (name:String):Texture {
        if (textures.exists(name)) {
            return textures.get(name);
        }
        else {
            trace("isoEngine.Assets.getTexture -> la texture " + name + " n'existe pas");
            return null;
        }
    }

    public function getAnchor (name:String):Point {
        var anchor;
        if ((anchor = anchors.get(name)) != null) {
            return anchor;
        }
        else {
            return new Point(0, 0);
        }
    }

    public function getSize (name:String):Vector2 {
        if (sizes.exists(name)) {
            return sizes.get(name);
        }
        else {
            trace("isoEngine.Assets.getsize -> la taile pour " + name + " n'existe pas");
            return null;
        }
    }

    public function getAnimation (name:String):Array<Texture> {
        if (animations.exists(name)) {
            return animations.get(name);
        }
        else {
            trace("isoEngine.Assets.getAnimation -> l'animation' " + name + " n'existe pas");
            return null;
        }
    }



    public function createAnimation (name:String, listTexture:Array<String>) {
        animations.set(name, new Array<Texture>());
        for (i in 0...listTexture.length) {
            animations.get(name).push(textures.get(listTexture[i]));
        }
    }


    public function load (assets:Array<String>, callback) {
        assets.push('../assets/selection.json');
        var loader:AssetLoader = new AssetLoader(assets);

        loader.onComplete = function () {
            callback();
        };

        loader.load();
    }



        /***** LOADING *****/
    public function addTexture (name, from, size) {
        textures.set(name, Texture.fromFrame(from));
        sizes.set(name, size);
    }

    public function addAnchor (name, values) {
        anchors.set(name, new Point(values.x, values.y));
    }


        /***** YOU DON'T CARE *****/
    public function new () {
        textures   = new Map<String, Texture>();
        animations = new Map<String, Array<Texture>>();
        anchors    = new Map<String, Point>();
        sizes      = new Map<String, Vector2>();
    }
}
