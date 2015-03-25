
package engine.popUpEngine;

import engine.isoEngine.IsoEngine;
import utils.Vector2;
import pixi.primitives.Graphics;
import engine.isoEngine.controls.Mouse;
import pixi.display.DisplayObjectContainer;
import engine.popUpEngine.Container;
import pixi.display.Sprite;

class Scrollbar
{
    static public  var defaultSize:Float = 10;
    static private var defaultInBroder:Float = 2;
    static private var inTextureName:String;
    static private var outTextureName:String;

    private var container:Container;
    private var inventory:Inventory;
    private var isHorizontal:Bool;
    private var inventorySize:Vector2 = new Vector2(0, 0);
    public  var layer:DisplayObjectContainer;


    static public function setTexturesNames (_outName:String, _inName:String) {
        inTextureName  = _inName;
        outTextureName = _outName;
    }


    public function new (_inventory:Inventory) {
        inventory    = _inventory;
        isHorizontal = (inventory.nbElementX == -1) ? true : false;
        createLayer();
        createScrollOut();
        createScrollIn();
        hide();
        show();
    }


    public function update () {
        setScrollIn();
    }

    public function hide(){
        layer.visible = false;
    }

    public function show(){
        layer.visible = true;
    }

    private function updateContainer () {
        if (isHorizontal) {
            var totalPxTraversable:Float = outWidth - inWidth;

            if (scrollIn.x < 0) scrollIn.x = 0;
            if (scrollIn.x > totalPxTraversable) scrollIn.x = totalPxTraversable;

            var ratio = scrollIn.x / totalPxTraversable;
            inventory.layer.x = ratio * -inventorySize.x + inventory.pos.x;
            inventory.mask.x  = ratio * inventorySize.x;
        }
        else {
            var totalPxTraversable:Float = outHeight - inHeight;

            if (scrollIn.y < 0) scrollIn.y = 0;
            if (scrollIn.y > totalPxTraversable) scrollIn.y = totalPxTraversable;

            var ratio = scrollIn.y / totalPxTraversable;
            inventory.layer.y = ratio * -inventorySize.y + inventory.pos.y;
            inventory.mask.y  = ratio * inventorySize.y;
        }
    }







        /***** LAYER *****/
    private function createLayer () {
        layer = IsoEngine.getInstance().displaying.createChildLayer(inventory.layerName + "scroll", inventory.container.name);
        layer.x = (!isHorizontal) ? inventory.size.x - defaultSize : 0;
        layer.y = (isHorizontal)  ? inventory.size.y - defaultSize : 0;
        layer.x += inventory.pos.x;
        layer.y += inventory.pos.y;
        layer.interactive = true;
        layer.buttonMode = true;
        layer.defaultCursor = "pointer";
    }







        /***** SCROLL IN *****/
    private var scrollIn:Sprite;
    private var displayableRatio:Float;
    private var inWidth:Float;
    private var inHeight:Float;
    private var inX:Float;
    private var inY:Float;

    private function createScrollIn () {
        scrollIn = new Sprite(IsoEngine.getInstance().assets.getTexture(inTextureName));
        scrollIn.width /= 1.5;
        scrollIn.height /= 1.5;
        if(isHorizontal){
            scrollOut.x += scrollIn.width / 2;
        }
        else{
            scrollOut.y += scrollIn.width / 2;
        }
        setScrollIn();
        setInteractive();
        layer.addChild(scrollIn);
    }


    private function setScrollIn () {
        (isHorizontal) ? setHorizontalScrollIn() : setVerticalScrollIn();
        layer.visible = (displayableRatio > 0) ? true : false;
    }


    private function setHorizontalScrollIn () {
        inventorySize.x = (Math.floor(inventory.cellList.length / inventory.nbElementY) * inventory.elementSize.x) - inventory.size.x;
        displayableRatio = inventory.elementSize.x / inventorySize.x;
        inWidth  = displayableRatio * outWidth;
        inHeight = outHeight - defaultInBroder * 2;
        drawScrollIn();
    }

    private function setVerticalScrollIn () {
        inventorySize.y = (Math.floor(inventory.cellList.length / inventory.nbElementX) * inventory.elementSize.y) - inventory.size.y;
        displayableRatio = inventory.elementSize.y / inventorySize.y;
        inWidth  = outWidth - defaultInBroder * 2;
        inHeight = displayableRatio * outHeight;
        drawScrollIn();
    }


    private function drawScrollIn () {
        // scrollIn.width  = inWidth;
        // scrollIn.height = inHeight;
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
    private var scrollOut:Sprite;
    private var outWidth:Float;
    private var outHeight:Float;

    private function createScrollOut () {
        setScrollOutValues();
        addScrollOut();
        setScrollOutInteractivity();
    }

    private function setScrollOutValues () {
        outWidth  = (isHorizontal)  ? inventory.size.x : defaultSize;
        outHeight = (!isHorizontal) ? inventory.size.y : defaultSize;
    }

    private function addScrollOut () {
        scrollOut = new Sprite(IsoEngine.getInstance().assets.getTexture(outTextureName));
        scrollOut.width  = outWidth;
        scrollOut.height = outHeight;
        layer.addChild(scrollOut);
    }

    private function setScrollOutInteractivity () {
        scrollOut.interactive = true;
        scrollOut.mousedown = scrollOutDown;
    }

    private function scrollOutDown (mouseData) {
        var worldPosition = scrollOut.toGlobal( new pixi.geom.Point(0, 0) );

        var x:Float = mouseData.global.x; //Don't try unify this code -> haxe gonna fuck you
        var y:Float = mouseData.global.y;
        x -= worldPosition.x;
        y -= worldPosition.y;

        if (isHorizontal) scrollIn.x = inX = x - inWidth / 2;
        else              scrollIn.y = inY = y - inHeight / 2;

        clickScrollIn(mouseData);
        updateContainer();
    }
}
