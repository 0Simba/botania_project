package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.IsoComponent;
import pixi.display.DisplayObject;
import pixi.display.Sprite;
import pixi.textures.Texture;

class DragNDrop
{
    static private var displayDragging:Sprite;
    static private var isoEngine:IsoEngine;
    static private var currentDragging:DisplayObject;
    static private var currentMeta:Dynamic;
    static private var isDragging:Bool = false;
    static private var isDropping:Bool = false;
    static private var draggingTexture:pixi.textures.Texture;



    public function new () {
        if (isoEngine == null) buildStaticDatas();

        startDragging   = new Vector2(0, 0);
        originPosition  = new Vector2(0, 0);
    }

        /****************************************
                        DROPPABLE
        /****************************************/
    public var dropFree        :Bool = false;
    public var dropSprite      :Sprite;
    public var dropSize        :Vector2;
    public var dropPos         :Vector2;
    public var lastDropTexture :Texture;
    public var dropMeta        :Dynamic;

    public function setDroppable (size:Vector2 = null, pos:Vector2 = null) {
        dropSize = (size == null) ? Vector2.full : size;
        dropPos  = (pos  == null) ? Vector2.zero : pos;

        displayObject.interactive = true;

        displayObject.mouseover = dropover;
        displayObject.mouseout  = dropout;
        displayObject.mouseup   = dropup;
    }

    public function clearDrop () {
        dropSprite.visible = false;
        dropSprite.texture = null;
    }

    private function dropover (mouseData) {
        if (isDragging) {
            isDropping = true;

            displayDragging.visible = false;
            displayDropSprite();
        }
    }

    private function dropout (mouseData) {
        if (isDragging) {
            isDropping = false;

            displayDragging.visible = true;
            hideDropSprite();
        }
    }

    private function dropup (mouseData) {
        dropSprite.alpha = 1;
        isDropping       = false;
        lastDropTexture  = dropSprite.texture;
        dropMeta         = currentMeta;
    }



    private function displayDropSprite () {
        if (dropSprite == null) {
            dropSprite = new Sprite (draggingTexture);
            displayObject.parent.addChild(dropSprite);
        }

        dropSprite.visible = true;
        dropSprite.texture = draggingTexture;
        dropSprite.width   = displayObject.width;
        dropSprite.height  = displayObject.height;
        dropSprite.x       = displayObject.x;
        dropSprite.y       = displayObject.y;
        dropSprite.alpha   = 0.5;
    }

    private function hideDropSprite () {
        if (lastDropTexture != null) {
            dropSprite.texture = lastDropTexture;
        }
        else {
            dropSprite.visible = false;
        }
    }


        /****************************************
                        DRAGGABLE
        /****************************************/
    public var meta:Dynamic;
    public var clone:DisplayObject;
    public var displayObject:pixi.display.DisplayObjectContainer;

    public var startDragging:Vector2;
    public var originPosition:Vector2;

    public function setDraggable (_meta:Dynamic = null) {
        displayObject.interactive = true;

        displayObject.mousedown = dragdown;
        displayObject.mousemove = dragmove;

        meta = _meta;
    }

    private function dragmove (mouseData) {
        if (isDragging && !isDropping) {
            setDraggingOnMouse(mouseData);
        }
    }

    private function dragdown (mouseData) {
        isDragging = true;
        currentMeta = meta;

        draggingTexture = displayObject.generateTexture(1, 1);
        displayDragging.texture = draggingTexture;
        displayDragging.visible = true;

        displayObject.alpha = 0.5;

        currentDragging = displayObject;
        isoEngine.displaying.getLayer("overlay").addChild(displayDragging);

        setDraggingOnMouse(mouseData);
    }



    static private function setDraggingOnMouse (mouseData) {
        displayDragging.x = mouseData.global.x;
        displayDragging.y = mouseData.global.y;
        displayDragging.anchor.set(0.5, 0.5);
    }

    static private function buildStaticDatas () {
        isoEngine = IsoEngine.getInstance();
        displayDragging = new Sprite(IsoEngine.getInstance().assets.getTexture("circle"));
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
