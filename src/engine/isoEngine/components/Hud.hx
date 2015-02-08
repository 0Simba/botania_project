package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;

class Hud
{

    static public var currentOver:Hud;

            // if percentSize || percentPos > 1 => pixel
    public function set (percentSize:Vector2, percentPos:Vector2, textureName:String, parentLayer:String = "hud", sizeOf:Vector2 = null) {
        sprite = new Sprite(isoEngine.assets.getTexture(textureName));

        resize(percentSize, null, sizeOf);
        replace(percentPos, null, sizeOf);

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


    public function replace (pos:Vector2, forcePixel:Bool = false, sizeOf:Vector2 = null) {
        if (pos.x > 1 || pos.y > 1 || forcePixel) {
            sprite.x = pos.x;
            sprite.y = pos.y;
        }
        else {
            var target = (sizeOf != null) ? sizeOf : new Vector2(isoEngine.width, isoEngine.height);
            sprite.x = target.x * pos.x;
            sprite.y = target.y * pos.y;
        }
        if (pos.x < 0 && pos.x >= -1) sprite.x = sprite.y * pos.x * -1;
        if (pos.y < 0 && pos.y >= -1) sprite.y = sprite.x * pos.y * -1;
    }


    public function resize (size:Vector2, forcePixel:Bool = false, sizeOf:Vector2 = null) {
        if (size.x > 1 || size.y > 1 || forcePixel) {
            sprite.width  = size.x;
            sprite.height = size.y;
        }
        else {
            var target = (sizeOf != null) ? sizeOf : new Vector2(isoEngine.width, isoEngine.height);
            sprite.width  = target.x * size.x;
            sprite.height = target.y * size.y;
        }
        if (size.x < 0 && size.x >= -1) sprite.width  = sprite.height * size.x * -1;
        if (size.y < 0 && size.y >= -1) sprite.height = sprite.width * size.y * -1;
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
