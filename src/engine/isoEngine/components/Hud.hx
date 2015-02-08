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

        resize(percentSize, sizeOf);
        replace(percentPos, sizeOf);

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


    public function replace (pos:Vector2, sizeOf:Vector2 = null) {
        var target = (sizeOf != null) ? sizeOf : new Vector2(isoEngine.width, isoEngine.height);

        sprite.x = getRealPositionningValue(pos.x, pos.metaX, target.x);
        sprite.y = getRealPositionningValue(pos.y, pos.metaY, target.y);
        sprite.x = checkPositionningOfHimself(sprite.x, pos.x, pos.metaX, sprite.y);
        sprite.y = checkPositionningOfHimself(sprite.y, pos.y, pos.metaY, sprite.x);
    }


    public function resize (size:Vector2, sizeOf:Vector2 = null) {
        var target = (sizeOf != null) ? sizeOf : new Vector2(isoEngine.width, isoEngine.height);

        sprite.width  = getRealPositionningValue(size.x, size.metaX, target.x);
        sprite.height = getRealPositionningValue(size.y, size.metaY, target.y);
        sprite.width  = checkPositionningOfHimself(sprite.width , size.x, size.metaX, sprite.height);
        sprite.height = checkPositionningOfHimself(sprite.height, size.y, size.metaY, sprite.width);
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

    private function getRealPositionningValue (value:Float, posType:String, referentValue:Float):Float {
        var finalValue:Float = 0;

        finalValue = value;
        if (posType == null) {
            if (value <= 1) finalValue *= referentValue;
        }
        else if (posType == "%")  finalValue = referentValue * value;
        else if (posType == "px") finalValue = value;

        return finalValue;
    }

    private function checkPositionningOfHimself (currentValue:Float, value:Float, posType:String, referentValue:Float):Float {
        if      (posType == null && value < 0 && value >= -1) return referentValue * value * -1;
        else if (posType == "%x" || posType == "%y")          return referentValue * value;
        else                                                  return currentValue;
    }
}
