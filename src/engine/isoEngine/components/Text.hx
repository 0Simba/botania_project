package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.text.Text;
import TextStyle;

class Text
{

    public var IsoEngine:IsoEngine;
    public var text:Text;

    public function set (_text:String, style:TextStyle, _pos:Vector2, _size:Vector2, parentLayer:String = "hud") {
        text = new Text(_text, style);
        isoEngine.displaying.displayMcOn(sprite, parentLayer);
    }

    public function new () {
        isoEngine = IsoEngine.getInstance();
    }
}
