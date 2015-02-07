
package engine.popUpEngine;

import utils.Vector2;
import pixi.primitives.Graphics;
import engine.isoEngine.controls.Mouse;

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
        setInteractive();
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
        }
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
