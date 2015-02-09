package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.text.Text.TextStyle;
import engine.isoEngine.components.IsoComponent;


class Text extends IsoComponent
{

    public var text:pixi.text.Text;


    public function set (_text:String, pos:Vector2, size:Vector2, style:TextStyle = null, parentLayer:String = "hud", parentSize:Vector2 = null) {
        text = new pixi.text.Text(_text, style);
        displayObject = text;

        replace(pos, parentSize);
        resize(size, parentSize);


        isoEngine.displaying.displayMcOn(text, parentLayer);
    }

    public function new () {
        super();
    }
}
