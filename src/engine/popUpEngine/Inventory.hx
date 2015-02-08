package engine.popUpEngine;

import engine.popUpEngine.PopUp;
import utils.Vector2;
import engine.isoEngine.components.Hud;
import engine.isoEngine.IsoEngine;
import pixi.display.DisplayObjectContainer;
import engine.popUpEngine.Scrollbar;
import pixi.primitives.Graphics;

class Inventory
{
    public var popUp:PopUp;
    public var size:Vector2;
    public var pos:Vector2;
    public var elementSize:Vector2;
    public var nbElementX:Int;
    public var nbElementY:Int;
    public var layer:DisplayObjectContainer;
    public var layerName:String;
    public var scrollbar:Scrollbar;
    public var mask:Graphics;


    public var cellList:Array<Cell>;

    public function new (_popUp:PopUp, _pos:Vector2, _size:Vector2, _elementSize:Vector2, _nbElementX:Int = -1, _nbElementY:Int = -1) {
        popUp      = _popUp;

        nbElementX = _nbElementX;
        nbElementY = _nbElementY;
        elementSize = _elementSize;

        layerName  = "scrollable" + popUp.name;
        size       = _size;
        if (nbElementX != -1) size.x += Scrollbar.defaultSize;
        if (nbElementY != -1) size.y += Scrollbar.defaultSize;
        pos        = _pos;
        nbElementX = _nbElementX;
        nbElementY = _nbElementY;
        layer      = IsoEngine.getInstance().displaying.createChildLayer(layerName, popUp.name);
        cellList = new Array<Cell>();

        layer.x = pos.x;
        layer.y = pos.y;

        mask = new pixi.primitives.Graphics();
        mask.beginFill(576);
        mask.drawRect(0, 0, size.x, size.y);
        mask.endFill();
        layer.addChild(mask);
        layer.mask = mask;


        scrollbar = new Scrollbar(this);
    }

    public function addCell (textureName:String, meta:Dynamic = null) {
        var index:Int = cellList.length;
        var x:Int = (nbElementX != -1) ? index % nbElementX : Math.floor(index / nbElementY);
        var y:Int = (nbElementY != -1) ? index % nbElementY : Math.floor(index / nbElementX);

        var targetPos:Vector2 = new Vector2 (x * elementSize.x, y * elementSize.y);
        cellList.push(new Cell(targetPos, elementSize, textureName, layerName, index, meta));
        scrollbar.update();
    }
}
