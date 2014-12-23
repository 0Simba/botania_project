package engine.isoEngine;

import pixi.display.MovieClip;
import engine.isoEngine.IsoEngine;

class TileSelectionIndicator {


    static private var instance:TileSelectionIndicator;
    private var movieClip:MovieClip;
    private var isoEngine:IsoEngine;

    public function overOn (x:Int, y:Int) {
        var px = engine.isoEngine.IsoUtils.coordToPx(x, y);
        movieClip.x = px.x;
        movieClip.y = px.y;
        movieClip.visible = true;
    }

    public function hide () {
        movieClip.visible = false;
    }







        /***** YOU DON'T CARE *****/
    public function assetLoaded () {
        isoEngine = IsoEngine.getInstance();
        createAnimation(isoEngine);

        movieClip = new MovieClip(isoEngine.animations.get("tileIndicator"));
        movieClip.width  = isoEngine.size;
        movieClip.height = isoEngine.size / 2;

        Displaying.getInstance().displayMcOn(movieClip, "overTiles");
    }

    public function createAnimation (isoEngine:IsoEngine) {
        isoEngine.addTexture("over", "over");
        var list:Array<String> = new Array<String>();
        list.push("over");
        isoEngine.createAnimation("tileIndicator", list);
    }

    private function new () {};

    static public function getInstance () {
        if (instance == null) instance = new TileSelectionIndicator();
        return instance;
    }
}
