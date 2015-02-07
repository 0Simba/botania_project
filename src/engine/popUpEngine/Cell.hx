package engine.popUpEngine;

import engine.isoEngine.components.Hud;
import utils.Vector2;
import pixi.display.DisplayObjectContainer;

class Cell
{
    public var hud:Hud;
    public var id:Int;
    public var meta:Dynamic;

    public function new (pos:Vector2, size:Vector2, textureName:String, layerName:String, _id:Int, meta:Dynamic) {
        var hud = new Hud();
        hud.set(size, pos, textureName, layerName);
    }
}
