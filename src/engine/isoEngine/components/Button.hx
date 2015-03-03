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
    private var normalFilter:ColorMatrixFilter;

    public function new () {
        super();
        setOverFilter();
        setClickFilter();
        setNormalFilter();
    }

    public function setOverFilter () {
        var colorMatrix =  [
            1.0, 0.2, 0.2, 0.0,
            0.2, 1.0, 0.2, 0.0,
            0.2, 0.2, 1.0, 0.0,
            0.0, 0.0, 0.0, 1.0
        ];
        overFilter = new ColorMatrixFilter();
        overFilter.matrix = colorMatrix;
    }

    public function setClickFilter () {
        var colorMatrix =  [
            0.8, 0.0, 0.0, 0.0,
            0.0, 0.8, 0.0, 0.0,
            0.0, 0.0, 0.8, 0.0,
            0.0, 0.0, 0.0, 1.0
        ];

        clickFilter = new ColorMatrixFilter();
        clickFilter.matrix = colorMatrix;
    }

    public function setNormalFilter () {
        var colorMatrix =  [
            1.0, 0.0, 0.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            0.0, 0.0, 1.0, 0.0,
            0.0, 0.0, 0.0, 1.0
        ];

        normalFilter = new ColorMatrixFilter();
        normalFilter.matrix = colorMatrix;
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
        sprite.filters = [overFilter];
    }
    private function alwaysButtonOut (mouseData) {
        alwaysOut(mouseData);
        outBind();
        sprite.filters = [normalFilter];
    }
    private function alwaysButtonClick (mouseData) {
        clickBind();
        sprite.filters = [clickFilter];
        trace("ok click");
    }

    override public function overBind () {};
    override public function outBind () {};
    override public function clickBind () {};

}
