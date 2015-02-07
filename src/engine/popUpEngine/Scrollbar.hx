
package engine.popUpEngine;

import utils.Vector2;
import pixi.primitives.Graphics;

class Scrollbar
{
    static private var defaultSize:Float = 20;
    static private var defaultInBroder:Float = 2;

    private var inventory:Inventory;
    private var isHorizontal:Bool;


    public function new (_inventory:Inventory, _isHorizontal:Bool = false) {
        isHorizontal = _isHorizontal;
        inventory = _inventory;

        createScrollOut();
        createScrollIn();
    }

    public function update () {
        setScrollIn();
    }



        /***** SCROLL IN *****/
    private var scrollIn:Graphics;
    private var displayableRatio:Float;
    private var inWidth:Float;
    private var inHeight:Float;
    private var inX:Float;
    private var inY:Float;

    private function createScrollIn () {
        scrollIn = new Graphics();
        setScrollIn();
        inventory.layer.addChild(scrollIn);
    }


    private function setScrollIn () {
        (isHorizontal) ? setHorizontalScrollIn() : setVerticalScrollIn();
    }


    private function setHorizontalScrollIn () {
        displayableRatio = inventory.elementSize.x / (Math.floor(inventory.cellList.length / inventory.nbElementY) * inventory.elementSize.x);
        inWidth  = displayableRatio * outWidth;
        inHeight = outHeight - defaultInBroder * 2;
        drawScrollIn();
    }

    private function setVerticalScrollIn () {
        displayableRatio = inventory.elementSize.y / (Math.floor(inventory.cellList.length / inventory.nbElementX) * inventory.elementSize.y);
        inWidth  = outWidth - defaultInBroder * 2;
        inHeight = displayableRatio * outHeight;
        drawScrollIn();
    }


    private function drawScrollIn () {
        scrollIn.clear();
        scrollIn.beginFill(122348);
        scrollIn.drawRect(outX, outY, inWidth, inHeight);
        scrollIn.endFill();
    }


        /***** SCROLL OUT *****/
    private var scrollOut:Graphics;
    private var outWidth:Float;
    private var outHeight:Float;
    private var outX:Float;
    private var outY:Float;

    private function createScrollOut () {
        setScrollOutValues();
        addScrollOut();
    }

    private function setScrollOutValues () {
        outWidth  = (isHorizontal)  ? inventory.size.x : defaultSize;
        outHeight = (!isHorizontal) ? inventory.size.y : defaultSize;
        outX      = (!isHorizontal) ? inventory.size.x - defaultSize : 0;
        outY      = (isHorizontal)  ? inventory.size.y - defaultSize : 0;
    }

    private function addScrollOut () {
        scrollOut = new Graphics();
        scrollOut.beginFill(977);
        scrollOut.drawRect(outX, outY, outWidth, outHeight);
        scrollOut.endFill();
        inventory.layer.addChild(scrollOut);
    }
}
