package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.primitives.Graphics;

class Bloc
{
    public var size:Vector2;
    public var pos:Vector2;
    public var textureName:String;

    public function new (_size:Vector2, _pos:Vector2, _textureName:String) {
        size        = _size;
        pos         = _pos;
        textureName = _textureName;
    }

    public function addOn (pixiDisplayableElement:Graphics, layerName:String):Hud {
        var hud = new Hud();
        if (size.x <= 1 && size.y <= 1 && pos.x <= 1 && pos.y <= 1) {
            size.x *= pixiDisplayableElement.width;
            size.y *= pixiDisplayableElement.height;
            pos.x  = (pos.x * pixiDisplayableElement.width) + pixiDisplayableElement.x;
            pos.y  = (pos.y * pixiDisplayableElement.height) + pixiDisplayableElement.y;
        }

        hud.set(size, pos, textureName, layerName);
        return hud;
    }
}
