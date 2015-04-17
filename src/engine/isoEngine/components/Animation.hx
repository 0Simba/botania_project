package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.MovieClip;
import engine.isoEngine.components.IsoComponent;
import engine.isoEngine.managers.AnimParams;

class Animation extends IsoComponent {

    private static var animations:Array<Animation> = new Array<Animation>();

    public var movieClip:MovieClip;

    public function new (animationName:String, position:Vector2, parentLayerName:String) {
        super();
        movieClip = new MovieClip(isoEngine.assets.getAnimation(animationName));
        isoEngine.displaying.displayMcOn(movieClip, parentLayerName);
        movieClip.x = position.x;
        movieClip.y = position.y;
        movieClip.play();

        displayObject = movieClip;
        replace(position);

        applyParams(animationName);
        animations.push(this);
    }

    public function destroy () {
        var parent:pixi.display.DisplayObjectContainer = movieClip.parent;
        parent.removeChild(movieClip);

        var i = animations.indexOf(this);
        animations.splice(i, 1);
    }


    private function applyParams (animationName:String) {
        var params;
        if ((params = AnimParams.get(animationName)) != null) {
            movieClip.animationSpeed = params.speed;
            movieClip.width  = params.size.x;
            movieClip.height = params.size.y;
            movieClip.anchor = params.anchor;

        }
    }
}

