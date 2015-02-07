
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





    private function updateContainer (ratioPosition) {
        if (isHorizontal) {
            inventory.layer.x += 1;
        }
        else {
            inventory.layer.y += 1;
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
            updateContainer(1);
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
