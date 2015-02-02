package engine.isoEngine.managers;

import pixi.textures.Texture;
import pixi.loaders.AssetLoader;
import engine.isoEngine.IsoEngine;

class Assets
{

    private var animations:Map<String, Array<Texture>>;
    private var textures:  Map<String, Texture>;


    public function addTexture (name, from) {
        textures.set(name, Texture.fromFrame(from));
    }

    public function getTexture (name:String):Texture {
        if (textures.exists(name)) {
            return textures.get(name);
        }
        else {
            trace("isoEngine.Assets.getTexture -> la texture " + name + " n'existe pas");
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



    public function createAnimation(name:String, listTexture:Array<String>) {
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




        /***** YOU DON'T CARE *****/
    public function new () {
        textures   = new Map<String, Texture>();
        animations = new Map<String, Array<Texture>>();
    }
}
