package engine.isoEngine.components;

import pixi.filters.ColorMatrixFilter;
import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;
import engine.isoEngine.components.Hud;
import engine.isoEngine.components.ColorMatrixFilters;

class Button extends Hud
{

    private var basicTexture:String;
    private var hoverTexture:String;
    private var clickTexture:String;

    private var overFilter:ColorMatrixFilter;
    private var clickFilter:ColorMatrixFilter;


    public function new () {
        super();
        overFilter = ColorMatrixFilters.get("over");
        clickFilter = ColorMatrixFilters.get("click");
    }

    override private function initInteractivity () {
        sprite.interactive = true;
        sprite.mouseover   = alwaysButtonOver;
        sprite.mouseout    = alwaysButtonOut;
        sprite.mouseup     = alwaysButtonClick;
        sprite.mousedown   = alwaysButtonDown;
    }

    public function onClick (clickCallback) {
        clickBind = clickCallback;
    }

    private function alwaysButtonOver (mouseData) {
        alwaysOver(mouseData);
        overBind();
        sprite.filters = [overFilter];
    }
    private function alwaysButtonOut (mouseData) {
        alwaysOut(mouseData);
        outBind();
        sprite.filters = null;
    }
    private function alwaysButtonClick (mouseData) {
        clickBind();
    }
    private function alwaysButtonDown (mouseData) {
        sprite.filters = [clickFilter];
    }

    override public function overBind () {};
    override public function outBind () {};
    override public function clickBind () {};
}
