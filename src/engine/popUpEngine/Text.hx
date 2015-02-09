package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;

class Text
{

    public function new (_pos:Vector2, _size:Vector2, _textureName:String, _alpha:Float = 1) {
        size        = _size;
        pos         = _pos;
        textureName = _textureName;
        alpha       = _alpha;
    }

    public function addOn (pixiDisplayableElement:DisplayObjectContainer, pxSize:Vector2, layerName:String):Hud {
        var text = new Text();

        text.set(text, layerName);
        return text;
    }
}
