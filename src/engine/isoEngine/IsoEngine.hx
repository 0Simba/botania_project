package engine.isoEngine;

import pixi.display.Stage;
import pixi.renderers.webgl.WebGLRenderer;
import pixi.utils.Detector;
import pixi.loaders.AssetLoader;
import pixi.textures.Texture;
import pixi.primitives.Graphics;
import pixi.display.MovieClip;

import engine.isoEngine.components.Tile;
import engine.isoEngine.controls.Mouse;
import engine.isoEngine.controls.TileSelectionIndicator;
import engine.isoEngine.IsoUtils;
import engine.isoEngine.controls.Displaying;
import engine.isoEngine.controls.Camera;

import js.Browser;

class IsoEngine
{


    public var animations:Map<String, Array<Texture>>;
    public var textures:Map<String, Texture>;
    public var mapTiles:Array<Array<Tile>>;
    public var tileIndicator:TileSelectionIndicator;

    private static var instance: IsoEngine;


    public function setTileSize (_size:Int) {
        size = _size;
        IsoUtils.setSize(size);
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



        /***** SURELY NOT INTEREST YOU *****/

    public function load (assets:Array<String>, callback) {
        assets.push('../assets/selection.json');
        var loader:AssetLoader = new AssetLoader(assets);

        loader.onComplete = function () {
            tileIndicator.assetLoaded();
            callback();
        };

        loader.load();
    }

    public function addMapedTile (tile:Tile) {
        if (mapTiles[tile.coord.x] == null) {
            mapTiles[tile.coord.x] = new Array<Tile>();
        }
        mapTiles[tile.coord.x][tile.coord.y] = tile;
    }






        /***** YOU DON'T CARE *****/

    private var renderer:WebGLRenderer;
    private var stage:Stage;
    private var displaying:Displaying;

    public var size:Int;
    public var camera:Graphics;


    public static function getInstance (_width:Int = 1600, _height:Int = 900): IsoEngine {
        if (instance == null) instance = new IsoEngine(_width, _height);
        return instance;
    }

    public function destroy (): Void {
        instance = null;
    }

	private function new (width:Int, height:Int)
	{
        stage         = new Stage(0xCFCFCF);
        textures      = new Map<String, Texture>();
        animations    = new Map<String, Array<Texture>>();
        mapTiles      = new Array<Array<Tile>>();
        tileIndicator = TileSelectionIndicator.getInstance();
        size          = 0;

        renderer = Detector.autoDetectRenderer(width, height);
        Browser.document.body.appendChild(renderer.view);


        displaying = Displaying.getInstance(stage);
        Mouse.setRef(stage);
        Camera.setRef(this);
	}

    public function render () {
        renderer.render(stage);
    }

    public function getMapedTile (x:Int , y:Int):Tile {
        if (mapTiles[x] != null) {
            return mapTiles[x][y];
        }

        return null;
    }
}
