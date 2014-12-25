package engine.isoEngine.managers;

import pixi.display.MovieClip;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Tile;

class TileSelectionIndicator {


    static private var instance:TileSelectionIndicator;
    private var movieClip:MovieClip;
    private var isoEngine:IsoEngine;

    public function overOn (x:Int, y:Int) {
                            return; //!\               ************ DISABLED **********
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

        movieClip = new MovieClip(isoEngine.assets.animations.get("tileIndicator"));
        movieClip.width  = Tile.size;
        movieClip.height = Tile.size / 2;

        isoEngine.displaying.displayMcOn(movieClip, "overTiles");
    }

    public function createAnimation (isoEngine:IsoEngine) {
        isoEngine.assets.addTexture("over", "over");
        var list:Array<String> = new Array<String>();
        list.push("over");
        isoEngine.assets.createAnimation("tileIndicator", list);
    }

    public function new () {}
}
