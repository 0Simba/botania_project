package engine.isoEngine.components;

import pixi.filters.ColorMatrixFilter;
import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;
import engine.isoEngine.components.Hud;
import engine.isoEngine.components.ColorMatrixFilters;
import engine.events.Events;

class Button extends Hud
{
    static public var oneOver:Bool = false;

    private var basicTexture:String;
    private var hoverTexture:String;
    private var clickTexture:String;

    private var overFilter:ColorMatrixFilter;
    private var clickFilter:ColorMatrixFilter;
    private var isoEvents:Events;

    public function new () {
        super();
        overFilter  = ColorMatrixFilters.get("over");
        clickFilter = ColorMatrixFilters.get("click");
        isoEvents   = IsoEngine.getInstance().events;
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
        oneOver = true;
        isoEvents.emit("buttonOver");
        alwaysOver(mouseData);
        overBind();
        sprite.filters = [overFilter];
        // Prevent pixi filter on positionning
        sprite.x +=1;
        sprite.y+=1;
    }
    private function alwaysButtonOut (mouseData) {
        oneOver = false;
        isoEvents.emit("buttonOut");
        alwaysOut(mouseData);
        outBind();
        sprite.filters = null;
        // Prevent pixi filter on positionning
        sprite.x -=1;
        sprite.y-=1;
    }
    private function alwaysButtonClick (mouseData) {
        sprite.filters = null;
        clickBind();
    }
    private function alwaysButtonDown (mouseData) {
        sprite.filters = [clickFilter];
    }

    override public function overBind () {};
    override public function outBind () {};
    override public function clickBind () {};
}
