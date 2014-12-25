package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.MovieClip;

class Hud
{

    public var movieClip:MovieClip;
    public var isoEngine:IsoEngine;

    public function new () {
        isoEngine = IsoEngine.getInstance();
    }

    public function set (percentSize:Vector2, percentPos:Vector2, animationName:String) {
        movieClip = new MovieClip(isoEngine.assets.animations.get(animationName));
        isoEngine.displaying.displayMcOn(movieClip, "hud");
    }
}