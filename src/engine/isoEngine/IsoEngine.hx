package engine.isoEngine;

import pixi.display.Stage;
import pixi.renderers.webgl.WebGLRenderer;
import pixi.utils.Detector;

import engine.isoEngine.managers.TileSelectionIndicator;
import engine.isoEngine.managers.Displaying;
import engine.isoEngine.managers.Maping;
import engine.isoEngine.managers.Assets;
import engine.isoEngine.components.Tile;
import engine.isoEngine.controls.Camera;
import engine.isoEngine.controls.Mouse;
import engine.isoEngine.IsoUtils;

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

    public var stage:Stage;


    private function new (width:Int, height:Int) {
        build();

        renderer = Detector.autoDetectRenderer(width, height);
        Browser.document.body.appendChild(renderer.view);
    }


    private function build () {
        stage         = new Stage(0xCFCFCF);
        map           = new Maping();
        assets        = new Assets(this);
        tileIndicator = new TileSelectionIndicator();
        displaying    = new Displaying(stage);
        Mouse.setRef(stage);
        Camera.setRef(this);
    }


    static public function init (width:Int = 1600, height:Int = 900) {
        if (instance == null) {
            instance = new IsoEngine(width, height);
        }
    }

        /***** YOU DON'T CARE *****/

    private static var instance: IsoEngine;
    private var renderer:WebGLRenderer;

    public function destroy (): Void {
        instance = null;
    }

    public function render () {
        renderer.render(stage);
    }
}
