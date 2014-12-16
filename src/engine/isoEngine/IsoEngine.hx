package engine.isoEngine;

import pixi.display.Stage;
import pixi.renderers.webgl.WebGLRenderer;
import pixi.utils.Detector;
import pixi.loaders.AssetLoader;
import pixi.textures.Texture;
import pixi.display.MovieClip;
import pixi.primitives.Graphics;
import js.Browser;


/**
 * ...
 * @author Jaf
 */

class IsoEngine
{

    private var renderer:WebGLRenderer;
    private var stage:Stage;
    private var instance:IsoEngine;

    private var map:Array<MovieClip>;
    private var width: Int;
    private var size:Int;
    private var camera:Graphics;


	public function new(_width:Int, _height:Int)
	{
        stage = new Stage(0xCFCFCF);
        map   = new Array<MovieClip>();
        size  = 0;
        width = _width;

        renderer = Detector.autoDetectRenderer(width, _height);
        Browser.document.body.appendChild(renderer.view);



        camera = new Graphics();

        trace(width);

        camera.x += width / 2;
        camera.y += _height / 2;

        stage.addChild(camera);
	}


    public function render () {
        renderer.render(stage);
    }


    public function load (assets:Array<String>, callback) {
        var loader:AssetLoader = new AssetLoader(assets);

        loader.onComplete = callback;
        loader.load();
    }

    public function setMap(_size:Int, _width:Int, height:Int, defaultTexture:String) {
        var texture:Array<Texture> = new Array<Texture>();
        texture.push(Texture.fromFrame(defaultTexture));

        width = _width;
        size  = _size;

        var demiSize  = size / 2;
        var quartSize = demiSize / 2;

        for (i in 0...width*height) {
            var line:Int = Math.floor(i / width);


            map[i] = new MovieClip(texture);

            map[i].width  = size;
            map[i].height = demiSize;

            var x:Int = i % width;
            var y:Int = Math.floor(i / width);

            map[i].x = x * demiSize - (y * demiSize);
            map[i].y = x * quartSize + (y * quartSize);

            camera.addChild(map[i]);
        }
    }
}
