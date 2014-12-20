package engine.isoEngine;

import pixi.display.Stage;
import pixi.renderers.webgl.WebGLRenderer;
import pixi.utils.Detector;
import pixi.loaders.AssetLoader;
import pixi.textures.Texture;
import pixi.display.MovieClip;
import pixi.primitives.Graphics;
import engine.isoEngine.Tile;
import js.Browser;


/**
 * ...
 * @author Jaf
 */

class IsoEngine
{

    private static var instance: IsoEngine;

    private var renderer:WebGLRenderer;
    private var stage:Stage;

    private var textures:Map<String, Texture>;
    public var animations:Map<String, Array<Texture>>;
    private var width: Int;
    public var size:Int;

    public var camera:Graphics;


    public function setTileSize (_size:Int) {
        size = _size;
    }

    public static function getInstance (_width:Int = 1600, _height:Int = 900): IsoEngine {
        if (instance == null) instance = new IsoEngine(_width, _height);
        return instance;
    }

    public function destroy (): Void {
        instance = null;
    }

	private function new(_width:Int, _height:Int)
	{
        stage       = new Stage(0xCFCFCF);
        textures    = new Map<String, Texture>();
        animations  = new Map<String, Array<Texture>>();
        size        = 0;
        width       = _width;

        renderer = Detector.autoDetectRenderer(width, _height);
        Browser.document.body.appendChild(renderer.view);

        camera = new Graphics();

        stage.addChild(camera);
	}

    public function render () {
        renderer.render(stage);
    }


    public function load (assets:Array<String>, callback) {
        var loader:AssetLoader = new AssetLoader(assets);

        loader.onComplete = function () {
            callback();
        };

        loader.load();
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

}
