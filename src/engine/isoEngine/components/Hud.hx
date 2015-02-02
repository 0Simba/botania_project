package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;

class Hud
{

    static public var currentOver:Hud;

            // if percentSize || percentPos > 1 => pixel
    public function set (percentSize:Vector2, percentPos:Vector2, animationName:String, textureName:String, parentLayer:String = "hud") {
        sprite = new Sprite(isoEngine.assets.getTexture(textureName));

        resize(percentSize);
        replace(percentPos);

        if (textureName != null) changeTexture(textureName);

        isoEngine.displaying.displayMcOn(sprite, parentLayer);
        initInteractivity();
    }


    public function bindEvents (_mouseover, _mouseout, _mouseclick) {
        overBind  = _mouseover;
        outBind   = _mouseout;
        clickBind = _mouseclick;
    }


    public function changeTexture (name) {
        sprite.texture = isoEngine.assets.getTexture(name);
    }


    public function replace (pos:Vector2, forcePixel:Bool = false) {
        if (pos.x > 1 || pos.y > 1 || forcePixel) {
            sprite.x = pos.x;
            sprite.y = pos.y;
        }
        else {
            sprite.x = isoEngine.width  * pos.x;
            sprite.y = isoEngine.height * pos.y;
        }
    }


    public function resize (size:Vector2, forcePixel:Bool = false) {
        if (size.x > 1 || size.y > 1 || forcePixel) {
            sprite.width  = size.x;
            sprite.height = size.y;
        }
        else {
            sprite.width  = isoEngine.width  * size.x;
            sprite.height = isoEngine.height * size.y;
        }
    }




        /****** YOU DON'T CARE *****/
    public var sprite:Sprite;
    public var isoEngine:IsoEngine;

    public function new () {
        isoEngine = IsoEngine.getInstance();
    }


    private function initInteractivity () {
        sprite.interactive = true;
        sprite.mouseover   = alwaysOver;
        sprite.mouseout    = alwaysOut;
        sprite.mouseup     = alwaysClick;
    }


    dynamic private function overBind () {};
    dynamic private function outBind  () {};
    dynamic public  function clickBind  () {};


    public function alwaysOver (mouseData) {
        Hud.currentOver = this;
        overBind();
    }

    public function alwaysOut (mouseData) {
        Hud.currentOver = null;
        outBind();
    }

    public function alwaysClick (mouseData) {
        clickBind();
    }


    static private var isBinded:Bool = false;


    static public function onClick () {
        if (currentOver != null) currentOver.clickBind();
    }
}
