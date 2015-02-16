package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.IsoComponent;
import pixi.display.DisplayObject;
import pixi.display.Sprite;

class DragNDrop
{
    static private var displayDragging:Sprite;
    static private var isoEngine:IsoEngine;
    static private var currentDragging:DisplayObject;
    static private var isDragging:Bool    = false;

    public var meta:Dynamic;
    public var clone:DisplayObject;
    public var displayObject:pixi.display.DisplayObjectContainer;

    public var startDragging:Vector2;
    public var originPosition:Vector2;


    public function new () {
        if (isoEngine == null) buildStaticDatas();

        startDragging   = new Vector2(0, 0);
        originPosition  = new Vector2(0, 0);
    }



    public function setDraggable () {
        displayObject.interactive = true;

        displayObject.mousedown = function (mouseData) {
            isDragging = true;

            displayDragging.texture = displayObject.generateTexture(1, 1);
            displayDragging.visible = true;

            displayObject.alpha = 0.5;

            currentDragging = displayObject;
            isoEngine.displaying.getLayer("overlay").addChild(displayDragging);


            setDraggingOnMouse(mouseData);
        }

        displayObject.mousemove = function (mouseData) {
            if (isDragging) {
                setDraggingOnMouse(mouseData);
            }
        }
    }



    static private function setDraggingOnMouse (mouseData) {
        displayDragging.x = mouseData.global.x;
        displayDragging.y = mouseData.global.y;
    }

    static private function buildStaticDatas () {
        isoEngine = IsoEngine.getInstance();
        displayDragging = new Sprite(IsoEngine.getInstance().assets.getTexture("grass"));
        displayDragging.visible = false;


        engine.isoEngine.controls.Mouse.events.on("stage mouseup", function () {
            if (isDragging) {
                isDragging = false;
                displayDragging.visible = false;
                currentDragging.alpha = 1;
                // currentDragging = null;
            }
        });
    }

}
