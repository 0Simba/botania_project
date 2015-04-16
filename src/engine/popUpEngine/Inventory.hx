package engine.popUpEngine;

import utils.Unique;
import engine.popUpEngine.PopUp;
import utils.Vector2;
import engine.isoEngine.components.Hud;
import engine.isoEngine.IsoEngine;
import pixi.display.DisplayObjectContainer;
import engine.popUpEngine.Scrollbar;
import pixi.primitives.Graphics;
import engine.popUpEngine.Container;

class Inventory
{
    public var container   : Container;

    public var size        : Vector2;
    public var pos         : Vector2;
    public var elementSize : Vector2;
    public var realElSize  : Vector2;

    public var nbElementX  : Int;
    public var nbElementY  : Int;

    public var layerName   : String;
    public var layer       : DisplayObjectContainer;

    public var scrollbar   : Scrollbar;
    public var mask        : Graphics;

    public var cellList:Array<Cell>;

    public function new (_container:Container, _pos:Vector2, _size:Vector2, _elementSize:Vector2, _nbElementX:Int = -1, _nbElementY:Int = -1) {
        container   = _container;
        nbElementX  = _nbElementX;
        nbElementY  = _nbElementY;
        elementSize = _elementSize;
        size        = _size;
        pos         = _pos;

        setSize();
        setLayer();
        setMask();

        cellList  = new Array<Cell>();
        scrollbar = new Scrollbar(this);

    }


    public function addCell (meta:Dynamic = null) {
        var index:Int = cellList.length;

        var x:Int = (nbElementX != -1) ? index % nbElementX : Math.floor(index / nbElementY);
        var y:Int = (nbElementY != -1) ? index % nbElementY : Math.floor(index / nbElementX);

        var targetPos:Vector2 = new Vector2 (x * elementSize.x, y * elementSize.y);

        var childrenLayerName = "cell" + Unique.getId();
        var cell = new Cell(this, childrenLayerName, layerName, targetPos, elementSize, meta);

        cellList.push(cell);
        scrollbar.update();

        return cell;
    }

    public function clear () {
        for (i in 0...cellList.length) {
            layer.removeChild(cellList[0].layer);
            cellList.splice(0, 1);
        }
    }


    /***** YOU DON'T CARE *****/

    private function setMask () {
        mask = new pixi.primitives.Graphics();
        mask.beginFill(576);
        mask.drawRect(0, 0, size.x, size.y);
        mask.endFill();
        layer.addChild(mask);
        layer.mask = mask;
    }

    private function setLayer () {
        layerName = "scrollable" + container.name;

        layer   = IsoEngine.getInstance().displaying.createChildLayer(layerName, container.name);
        layer.x = pos.x;
        layer.y = pos.y;
    }

    private function setSize () {
        if (nbElementX != -1) size.x += Scrollbar.defaultSize;
        if (nbElementY != -1) size.y += Scrollbar.defaultSize;
    }

    public function hide():Void
    {
        layer.visible = false;
        scrollbar.hide();
    }
    public function show():Void
    {
        layer.visible = true;
        if(cellList.length > 9)
            scrollbar.show();
    }
}
