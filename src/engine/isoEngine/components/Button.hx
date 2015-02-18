package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;
import engine.isoEngine.components.Hud;

class Button extends Hud
{

    private var basicTexture:String;
    private var hoverTexture:String;
    private var clickTexture:String;

    public function new () {
        super();
    }

    override private function initInteractivity () {
        sprite.interactive = true;
        sprite.mouseover   = alwaysButtonOver;
        sprite.mouseout    = alwaysButtonOut;
        sprite.mouseup     = alwaysButtonClick;
    }

    public function onClick (clickCallback) {
        clickBind = clickCallback;
    }

    public function setTextures (_basicTexture:String, _hoverTexture:String, _clickTexture:String) {
        basicTexture = _basicTexture;
        hoverTexture = _hoverTexture;
        clickTexture = _clickTexture;
        changeTexture(basicTexture);
    }


    private function alwaysButtonOver (mouseData) {
        alwaysOver(mouseData);
        overBind();
        changeTexture(hoverTexture);
    }
    private function alwaysButtonOut (mouseData) {
        alwaysOut(mouseData);
        outBind();
        changeTexture(basicTexture);
    }
    private function alwaysButtonClick (mouseData) {
        clickBind();
        changeTexture(clickTexture);
    }

    override public function overBind () {};
    override public function outBind () {};
    override public function clickBind () {};

}
