package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;
import pixi.text.Text.TextStyle;

class Text
{

    public var text:String;
    public var style:TextStyle;
    public var size:Vector2;
    public var pos:Vector2;
    public var alpha:Float;


    public function new (_pos:Vector2, _size:Vector2, _text:String, _style:TextStyle = null, _alpha:Float = 1) {
        size  = _size;
        pos   = _pos;
        text  = _text;
        style = _style;
        alpha = _alpha;
    }

    public function addOn (pixiDisplayableElement:DisplayObjectContainer, pxSize:Vector2, layerName:String):engine.isoEngine.components.Text {
        var sentence = new engine.isoEngine.components.Text();
        sentence.set(text, pos, size, style, layerName, pxSize);
        return sentence;
    }
}
