package engine.popUpEngine;

import engine.isoEngine.components.Hud;
import utils.Vector2;
import pixi.display.DisplayObjectContainer;
import engine.popUpEngine.Inventory;

class Cell extends engine.popUpEngine.Container
{
    private var parentInventory:Inventory;

    public function new (_inventory:Inventory, layerName:String, parentLayerName:String, pos:Vector2, size:Vector2, _meta:Dynamic) {
        super(layerName, parentLayerName, new Vector2(1, 1), size);
        layer.x = pos.x;
        layer.y = pos.y;

        parentInventory = _inventory;
    }
}
