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

    private var renderer:WebGLRenderer;
    private var stage:Stage;

    private var map:Array<Tile>;
    private var textures:Map<String, Texture>;
    public var animations:Map<String, Array<Texture>>;
    private var width: Int;
    private var size:Int;

    public var camera:Graphics;


	public function new(_width:Int, _height:Int)
	{
        stage       = new Stage(0xCFCFCF);
        map         = new Array<Tile>();
        textures    = new Map<String, Texture>();
        animations  = new Map<String, Array<Texture>>();
        size        = 0;
        width       = _width;

        renderer = Detector.autoDetectRenderer(width, _height);
        Browser.document.body.appendChild(renderer.view);

        camera = new Graphics();

        stage.addChild(camera);

        Tile.setReferent(this);
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
        animations.set("defaultGround", new Array<Texture>());
        for (i in 0...listTexture.length) {
            animations.get(name).push(textures.get(listTexture[i]));
        }
    }

    public function setMap(_size:Int, _width:Int, height:Int, defaultTexture:String) {
        width = _width;
        size  = _size;

        Tile.setSize(_size);

        var demiSize  = size / 2;
        var quartSize = demiSize / 2;

        for (i in 0...width*height) {
            var line:Int = Math.floor(i / width);

            map[i] = new Tile(defaultTexture);

            var x:Int = i % width;
            var y:Int = Math.floor(i / width);

            var pxX:Float = x * demiSize  - (y * demiSize);
            var pxY:Float = x * quartSize + (y * quartSize);

            map[i].place(pxX, pxY);
        }
    }
}
