package engine.isoEngine.components;

import pixi.filters.ColorMatrixFilter;
import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;
import engine.isoEngine.components.Hud;

class Button extends Hud
{

    private var basicTexture:String;
    private var hoverTexture:String;
    private var clickTexture:String;

    private var overFilter:ColorMatrixFilter;
    private var clickFilter:ColorMatrixFilter;


    public function new () {
        super();
        setOverFilter();
        setClickFilter();
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



        /****** YOU DON'T CARE *****/
    private function setOverFilter () {
        var colorMatrix =  [
            1.0, 0.15, 0.15, 0.0,
            0.15, 1.0, 0.15, 0.0,
            0.15, 0.15, 1.0, 0.0,
            0.0, 0.0, 0.0, 1.0
        ];
        overFilter = new ColorMatrixFilter();
        overFilter.matrix = colorMatrix;
    }
    private function setClickFilter () {
        var colorMatrix =  [
            0.85, 0.0, 0.0, 0.0,
            0.0, 0.85, 0.0, 0.0,
            0.0, 0.0, 0.85, 0.0,
            0.0, 0.0, 0.0, 1.0
        ];

        clickFilter = new ColorMatrixFilter();
        clickFilter.matrix = colorMatrix;
    }

}
