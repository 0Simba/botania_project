
package engine.popUpEngine;

import utils.Vector2;
import pixi.primitives.Graphics;

class Scrollbar
{
    static private var defaultSize:Float = 20;
    static private var defaultInBroder:Float = 2;

    private var scrollIn:Graphics;
    private var scrollOut:Graphics;

    private var width:Float;
    private var height:Float;
    private var outX:Float;
    private var outY:Float;
    private var inventory:Inventory;
    private var isHorizontal:Bool;

    private var displayableRatio:Float;

    public function new (_inventory:Inventory, _isHorizontal:Bool = false) {
        inventory = _inventory;
        isHorizontal = _isHorizontal;
        width  = (isHorizontal)  ? inventory.size.x : defaultSize;
        height = (!isHorizontal) ? inventory.size.y : defaultSize;
        outX = (!isHorizontal) ? inventory.size.x - defaultSize : 0;
        outY = (isHorizontal)  ? inventory.size.y - defaultSize : 0;

        createScrollOut();
        createScrollIn();
    }

    public function update () {
        var inWidth:Float;
        var inHeight:Float;
        if (isHorizontal) {
            displayableRatio = inventory.elementSize.x / (Math.floor(inventory.cellList.length / inventory.nbElementY) * inventory.elementSize.x);
            inWidth  = displayableRatio * width;
            inHeight = height - defaultInBroder * 2;
        }
        else {
            displayableRatio = inventory.elementSize.y / (Math.floor(inventory.cellList.length / inventory.nbElementX) * inventory.elementSize.y);
            inWidth  = width - defaultInBroder * 2;
            inHeight = displayableRatio * height;
        }

        scrollIn.clear();
        scrollIn.beginFill(122348);
        scrollIn.drawRect(outX, outY, inWidth, inHeight);
        scrollIn.endFill();
    }

    private function createScrollIn () {
        scrollIn = new Graphics();
        update();
        inventory.layer.addChild(scrollIn);
    }

    private function createScrollOut () {
        scrollOut = new Graphics();
        scrollOut.beginFill(977);
        scrollOut.drawRect(outX, outY, width, height);
        scrollOut.endFill();
        inventory.layer.addChild(scrollOut);
    }

}
