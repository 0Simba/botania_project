package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;

class Bloc
{
    public var size:Vector2;
    public var pos:Vector2;
    public var textureName:String;
    public var alpha:Float;

    public function new (_pos:Vector2, _size:Vector2, _textureName:String, _alpha:Float = 1) {
        size        = _size;
        pos         = _pos;
        textureName = _textureName;
        alpha       = _alpha;
    }

    public function addOn (pixiDisplayableElement:DisplayObjectContainer, pxSize:Vector2, layerName:String):Hud {
        var hud = new Hud();

        hud.set(size, pos, textureName, layerName, pxSize);
        hud.sprite.alpha = alpha;

        return hud;
    }
}
