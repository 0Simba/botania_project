package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;

class BackgroudSprite
{

    static private var totalSize    : Vector2;
    static private var elementsSize : Vector2;
    static private var maxX         : Int;
    static private var setted       : Bool = false;
    static private var elements     : Array<BackgroudSprite> = new Array<BackgroudSprite>();
    static private var isoEngine    : IsoEngine;

    static public function setSize (_totalSize:Vector2, _elementSize:Vector2) {
        totalSize    = _totalSize;
        elementsSize = _elementSize;
        maxX         = Math.round(totalSize.x / elementsSize.x);

        isoEngine = IsoEngine.getInstance();
        setted = true;
    }

    static public function add (textureName:String, position:Vector2) {
        if (!setted) return trace("BackgroudSprite was not configured... Use setSize to configure it");

        var i = position.x + position.y * maxX;
        elements.push(new BackgroudSprite(textureName, position));
    }

    private function new (textureName:String, position:Vector2) {
        var sprite = new Sprite(isoEngine.assets.getTexture(textureName));

        sprite.x = position.x * elementsSize.x - totalSize.x / 2;
        sprite.y = position.y * elementsSize.y - totalSize.y / 2;
        sprite.width  = elementsSize.x;
        sprite.height = elementsSize.y;

        trace(sprite.width + " : " + sprite.height);
        isoEngine.displaying.displayMcOn(sprite, "grounds");
    }

}
