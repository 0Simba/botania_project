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
        movieClip.interactive = true;
        movieClip.mouseover   = alwaysButtonOver;
        movieClip.mouseout    = alwaysButtonOut;
        movieClip.mouseup     = alwaysButtonClick;
    }

    override public function bindEvents (_mouseover, _mouseout, _mouseclick) {
        overBind  = _mouseover;
        outBind   = _mouseout;
        clickBind = _mouseclick;
    }



    public function setTextures (_basicTexture:String, _hoverTexture:String, _clickTexture:String) {
        basicTexture = _basicTexture;
        hoverTexture = _hoverTexture;
        clickTexture = _clickTexture;
        changeTexture(basicTexture);
    }

    public function setInteractivity (basic) {
        movieClip.interactive = true;
        movieClip.mouseover   = alwaysOver;
        movieClip.mouseout    = alwaysOut;
        movieClip.mouseup     = alwaysClick;
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
        alwaysClick(mouseData);
        clickBind();
        changeTexture(clickTexture);
    }

    override public function overBind () {};
    override public function outBind () {};
    override public function clickBind () {};

}
