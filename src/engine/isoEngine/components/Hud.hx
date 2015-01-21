package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.MovieClip;

class Hud
{

    static public var currentOver:Hud;

            // if percentSize || percentPos > 1 => pixel
    public function set (percentSize:Vector2, percentPos:Vector2, animationName:String, textureName:String = null, parentLayer:String = "hud") {
        movieClip = new MovieClip(isoEngine.assets.animations.get(animationName));

        resize(percentSize);
        replace(percentPos);

        if (textureName != null) changeTexture(textureName);

        isoEngine.displaying.displayMcOn(movieClip, parentLayer);
        initInteractivity();
    }


    public function bindEvents (_mouseover, _mouseout, _mouseclick) {
        overBind  = _mouseover;
        outBind   = _mouseout;
        clickBind = _mouseclick;
    }


    public function changeTexture (name) {
        movieClip.texture = isoEngine.assets.textures.get(name);
    }


    public function replace (pos:Vector2, forcePixel:Bool = false) {
        if (pos.x > 1 || pos.y > 1 || forcePixel) {
            movieClip.x = pos.x;
            movieClip.y = pos.y;
        }
        else {
            movieClip.x = isoEngine.width  * pos.x;
            movieClip.y = isoEngine.height * pos.y;
        }
    }


    public function resize (size:Vector2) {
        if (size.x > 1 || size.y > 1) {
            movieClip.width  = size.x;
            movieClip.height = size.y;
        }
        else {
            movieClip.width  = isoEngine.width  * size.x;
            movieClip.height = isoEngine.height * size.y;
        }
    }




        /****** YOU DON'T CARE *****/
    public var movieClip:MovieClip;
    public var isoEngine:IsoEngine;

    public function new () {
        isoEngine = IsoEngine.getInstance();
        if (!Hud.isBinded) Hud.bindToCamera();
    }


    private function initInteractivity () {
        movieClip.interactive = true;
        movieClip.mouseover   = alwaysOver;
        movieClip.mouseout    = alwaysOut;
    }


    dynamic private function overBind () {};
    dynamic private function outBind  () {};
    dynamic public function clickBind  () {};


    public function alwaysOver (mouseData) {
        Hud.currentOver = this;
        overBind();
    }


    public function alwaysOut (mouseData) {
        Hud.currentOver = null;
        outBind();
    }



    static private var isBinded:Bool = false;

    static private function bindToCamera () {
        engine.isoEngine.controls.Mouse.addOnClickEvent(cast onClick); //WARNING --> unsafe
    }

    static public function onClick () {
        if (currentOver != null) currentOver.clickBind();
    }
}
