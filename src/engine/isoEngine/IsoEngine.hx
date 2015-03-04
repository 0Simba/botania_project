package engine.isoEngine;

import pixi.display.Stage;
import pixi.renderers.webgl.WebGLRenderer;
import pixi.utils.Detector;

import engine.isoEngine.components.ColorMatrixFilters;
import engine.isoEngine.managers.TileSelectionIndicator;
import engine.isoEngine.managers.Displaying;
import engine.isoEngine.managers.Maping;
import engine.isoEngine.managers.Assets;
import engine.isoEngine.components.Tile;
import engine.isoEngine.controls.Camera;
import engine.isoEngine.controls.Mouse;
import engine.isoEngine.IsoUtils;
import utils.Vector2;

import engine.eventsDispatcher.EventDispatcher;

import js.Browser;

class IsoEngine
{
    public static function getInstance (): IsoEngine {
        return instance;
    }


    public var tileIndicator:TileSelectionIndicator;
    public var displaying:Displaying;
    public var map:Maping;
    public var assets:Assets;
    public var events:EventDispatcher;

    public var stage:Stage;
    public var width:Int  = 0;
    public var height:Int  = 0;



            /***** YOU DON'T CARE *****/
    private static var instance: IsoEngine;
    private var renderer:WebGLRenderer;
    private var screenSize:Vector2;


    private function new (_width:Int, _height:Int) {
        width  = _width;
        height = _height;

        screenSize = new Vector2(width, height);

        build();

        renderer = Detector.autoDetectRenderer(_width, _height);
        Browser.document.body.appendChild(renderer.view);
    }


    private function build () {
        stage         = new Stage(0xCFCFCF);
        map           = new Maping();
        assets        = new Assets();
        tileIndicator = new TileSelectionIndicator();
        displaying    = new Displaying(stage, screenSize);
        events        = new EventDispatcher();
        Mouse.setMap(displaying.getLayer("playArea"));
        Mouse.setStage(stage);
        ColorMatrixFilters.init();
        Camera.setRef(this);
    }


    static public function init (width:Int = 1600, height:Int = 900) {
        if (instance == null) {
            instance = new IsoEngine(width, height);
        }
    }


    public function destroy (): Void {
        instance = null;
    }


    public function render () {
        renderer.render(stage);
    }
}
