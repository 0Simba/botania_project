
package engine.popUpEngine;

import engine.isoEngine.IsoEngine;
import utils.Vector2;
import pixi.primitives.Graphics;
import engine.isoEngine.controls.Mouse;
import pixi.display.DisplayObjectContainer;

class Scrollbar
{
    static private var defaultSize:Float = 20;
    static private var defaultInBroder:Float = 2;


    private var inventory:Inventory;
    private var isHorizontal:Bool;
    private var inventorySize:Vector2 = Vector2.zero;
    public  var layer:DisplayObjectContainer;




    public function new (_inventory:Inventory, _isHorizontal:Bool = false) {
        isHorizontal = _isHorizontal;
        inventory = _inventory;

        createLayer();
        createScrollOut();
        createScrollIn();
    }

    public function update () {
        setScrollIn();
    }


    private function updateContainer () {
        if (isHorizontal) {
            var totalPxTraversable:Float = outWidth - inWidth;

            if (scrollIn.x < 0) scrollIn.x = 0;
            if (scrollIn.x > totalPxTraversable) scrollIn.x = totalPxTraversable;

            var ratio = scrollIn.x / totalPxTraversable;
            inventory.layer.x = ratio * -inventorySize.x;
            inventory.mask.x  = ratio * inventorySize.x;
        }
        else {
            var totalPxTraversable:Float = outHeight - inHeight;

            if (scrollIn.y < 0) scrollIn.y = 0;
            if (scrollIn.y > totalPxTraversable) scrollIn.y = totalPxTraversable;

            var ratio = scrollIn.y / totalPxTraversable;
            inventory.layer.y = ratio * -inventorySize.y;
            inventory.mask.y  = ratio * inventorySize.y;
        }
    }


        /***** LAYER *****/
    private function createLayer () {
        layer = IsoEngine.getInstance().displaying.createChildLayer(inventory.layerName + "scroll", inventory.popUp.name);
        layer.x = (!isHorizontal) ? inventory.size.x - defaultSize : 0;
        layer.y = (isHorizontal)  ? inventory.size.y - defaultSize : 0;

        trace(layer);
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
        setInteractive();
        layer.addChild(scrollIn);
    }


    private function setScrollIn () {
        (isHorizontal) ? setHorizontalScrollIn() : setVerticalScrollIn();
    }


    private function setHorizontalScrollIn () {
        inventorySize.x = (Math.floor(inventory.cellList.length / inventory.nbElementY) * inventory.elementSize.x);
        displayableRatio = inventory.elementSize.x / inventorySize.x;
        inWidth  = displayableRatio * outWidth;
        inHeight = outHeight - defaultInBroder * 2;
        drawScrollIn();
    }

    private function setVerticalScrollIn () {
        inventorySize.y = (Math.floor(inventory.cellList.length / inventory.nbElementX) * inventory.elementSize.y);
        displayableRatio = inventory.elementSize.y / inventorySize.y;
        inWidth  = outWidth - defaultInBroder * 2;
        inHeight = displayableRatio * outHeight;
        drawScrollIn();
    }


    private function drawScrollIn () {
        scrollIn.clear();
        scrollIn.beginFill(122348);
        scrollIn.drawRect(0, 0, inWidth, inHeight);
        scrollIn.endFill();
    }



    private var isMouseDown:Bool   = false;
    private var lastInPosition:Vector2    = Vector2.zero;
    private var lastMousePosition:Vector2 = Vector2.zero;

    private function setInteractive () {
        scrollIn.interactive = true;
        scrollIn.mousedown = clickScrollIn;
        Mouse.events.on("stage mousemove", moveScrollIn);
        Mouse.events.on("stage mouseup", stopScrolling);
    }

    private function clickScrollIn (mouseData):Void {
        isMouseDown = true;
        lastInPosition    = new Vector2(scrollIn.x, scrollIn.y);
        lastMousePosition = new Vector2(Mouse.stagePosition.x, Mouse.stagePosition.y);
    }
    private function stopScrolling (position:Vector2):Void {
        isMouseDown = false;
    }

    private function moveScrollIn (position:Vector2):Void {
        if (isMouseDown) {
            if (isHorizontal) {
                scrollIn.x = lastInPosition.x + (Mouse.stagePosition.x - lastMousePosition.x);
            }
            else {
                scrollIn.y = lastInPosition.y + (Mouse.stagePosition.y - lastMousePosition.y);
            }
            updateContainer();
        }
    }

        /***** SCROLL OUT *****/
    private var scrollOut:Graphics;
    private var outWidth:Float;
    private var outHeight:Float;

    private function createScrollOut () {
        setScrollOutValues();
        addScrollOut();
    }

    private function setScrollOutValues () {
        outWidth  = (isHorizontal)  ? inventory.size.x : defaultSize;
        outHeight = (!isHorizontal) ? inventory.size.y : defaultSize;
    }

    private function addScrollOut () {
        scrollOut = new Graphics();
        scrollOut.beginFill(977);
        scrollOut.drawRect(0, 0, outWidth, outHeight);
        scrollOut.endFill();
        layer.addChild(scrollOut);
    }
}
