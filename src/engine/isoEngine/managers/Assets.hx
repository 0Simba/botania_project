package engine.isoEngine.managers;

import pixi.textures.Texture;
import pixi.loaders.AssetLoader;
import engine.isoEngine.IsoEngine;

class Assets
{

    public var animations:Map<String, Array<Texture>>;
    public var textures:Map<String, Texture>;

    private var sup:IsoEngine;

    public function new (_sup:IsoEngine) {
        sup      = _sup;
        textures   = new Map<String, Texture>();
        animations = new Map<String, Array<Texture>>();
    }




    public function addTexture (name, from) {
        textures.set(name, Texture.fromFrame(from));
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
}