package engine.popUpEngine;

import utils.Vector2;
import pixi.display.DisplayObjectContainer;

class Button
{
    public var size:Vector2;
    public var pos:Vector2;
    public var basicTexture:String;
    public var hoverTexture:String;
    public var clickTexture:String;


    dynamic public function clickEvent () {}

    public function new (_size:Vector2, _pos:Vector2, _basicTexture:String, _hoverTexture:String, _clickTexture:String, _clickEvent) {
        size         = _size;
        pos          = _pos;
        basicTexture = _basicTexture;
        hoverTexture = _hoverTexture;
        clickTexture = _clickTexture;
        clickEvent   = _clickEvent;
    }


    public function addOn (pixiDisplayableElement:DisplayObjectContainer, pxSize:Vector2, layerName:String):engine.isoEngine.components.Button {
        var button = new engine.isoEngine.components.Button();
        // if (size.x <= 1 && size.y <= 1 && pos.x <= 1 && pos.y <= 1) {
        //     size.x *= pxSize.x;
        //     size.y *= pxSize.y;
        //     pos.x  *= pxSize.x;
        //     pos.y  *= pxSize.y;
        // }

        button.set(size, pos, basicTexture, layerName, pxSize);
        button.setTextures(basicTexture, hoverTexture, clickTexture);
        button.onClick(clickEvent);

        return button;
    }
}
