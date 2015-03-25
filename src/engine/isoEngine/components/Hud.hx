package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;
import engine.isoEngine.components.IsoComponent;

class Hud extends IsoComponent
{

    static public var currentOver:Hud;
    public var sprite:Sprite;


    public function new () {
        super();
    }

    public function set (percentSize:Vector2, percentPos:Vector2, textureName:String, parentLayer:String = "hud", sizeOf:Vector2 = null) {
        sprite = new Sprite(isoEngine.assets.getTexture(textureName));
        displayObject = sprite;

        resize(percentSize, sizeOf);
        replace(percentPos, sizeOf);

        if (textureName != null) changeTexture(textureName);

        isoEngine.displaying.displayMcOn(sprite, parentLayer);
        initInteractivity();
        // setIso();
    }


    public function bindEvents (_mouseover, _mouseout, _mouseclick) {
        overBind  = _mouseover;
        outBind   = _mouseout;
        clickBind = _mouseclick;
    }


    public function changeTexture (name) {
        sprite.texture = isoEngine.assets.getTexture(name);
    }


    public function setFilter (filter) {
        sprite.filters = [filter];
    }



        /****** YOU DON'T CARE *****/


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

    public function setAnchor(x:Float, y:Float){
        sprite.anchor.set(x, y);
    }

    static private var isBinded:Bool = false;


    static public function onClick () {
        if (currentOver != null) currentOver.clickBind();
    }

    public function setTexture(texture:String){
        sprite.setTexture(isoEngine.assets.getTexture(texture));
    }

}
