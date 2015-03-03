package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.MovieClip;
import engine.isoEngine.components.IsoComponent;
import engine.isoEngine.managers.AnimParams;

class Animation extends IsoComponent {

    private static var animations:Array<Animation> = new Array<Animation>();

    public function new (animationName:String, position:Vector2, parentLayerName:String) {
        super();
        var movieClip = new MovieClip(isoEngine.assets.getAnimation(animationName));
        isoEngine.displaying.displayMcOn(movieClip, parentLayerName);
        movieClip.x = position.x;
        movieClip.y = position.y;

        var params;
        if ((params = AnimParams.get(animationName)) != null) {
            trace("okokok");
            trace(params);
        }


        movieClip.play();
    }
}

