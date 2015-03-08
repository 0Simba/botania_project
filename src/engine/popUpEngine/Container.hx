package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;
import engine.isoEngine.IsoEngine;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Inventory;
import engine.popUpEngine.Text;
import pixi.display.Sprite;
import engine.popUpEngine.Inventory;

class Container extends engine.isoEngine.components.IsoComponent
{
    // public var isoEngine:IsoEngine;
    public var layer:DisplayObjectContainer;
    public var popUpEngineMain:PopUpEngineMain;
    public var pxSize:Vector2;
    public var inventory:Inventory;

    private var lastPos:Vector2;

    public var name:String;

    public function new (_name:String, parentLayer:String, size:Vector2 = null, parentSize:Vector2 = null) {
        super();
        isoEngine       = IsoEngine.getInstance();
        popUpEngineMain = PopUpEngineMain.getInstance();

        size       = (size       == null) ? Vector2.full : size ;
        parentSize = (parentSize == null) ? new Vector2(isoEngine.width ,isoEngine.height) : parentSize;

        pxSize = new Vector2(size.x * parentSize.x, size.y * parentSize.y);

        name  = _name + parentLayer;
        layer = isoEngine.displaying.createChildLayer(name, parentLayer);
        displayObject = layer; // extends dragNDrop
    }

    public function applyAnchor (x:Float, y:Float) {
        if (lastPos != null) {
            displayObject.x = lastPos.x;
            displayObject.y = lastPos.y;

        }

        lastPos = new Vector2 (displayObject.x, displayObject.y);

        displayObject.x -= pxSize.x * displayObject.scale.x * x;
        displayObject.y -= pxSize.y * displayObject.scale.y * y;
    }

    public function addBloc (textureName:String, pos:Vector2 = null, size:Vector2 = null) {
        pos = (pos == null) ? Vector2.zero : pos; size = (size == null) ? Vector2.full : size;

        var bloc = new Bloc(pos, size, textureName);
        return addSomethingOn(bloc);
    }

    public function addBlocPattern (blocName:String) {
        var bloc = popUpEngineMain.getBlocPattern(blocName);
        return addSomethingOn(bloc);
    }

    public function addButton (pos:Vector2, size:Vector2, anchor:Vector2, basicTexture:String, callback) {
        var button = new Button(size, pos, anchor, basicTexture, callback);
        return addSomethingOn(button);
    }

    public function addButtonPattern (buttonName:String):engine.isoEngine.components.Button {
        var button = popUpEngineMain.getButtonPattern(buttonName);
        return addSomethingOn(button);
    }

    public function addText (pos:Vector2, size:Vector2, text:String, style:pixi.text.Text.TextStyle = null, alpha:Float = null) {
        var text = new Text (pos , size , text, style, alpha);
        return addSomethingOn(text);
    }

    public function addSomethingOn (target:Dynamic):Dynamic {
        return target.addOn(layer, pxSize, name);
    }

    public function addContainer (_size:Vector2):Container {
        return new Container(name + "Child", name, _size, pxSize);
    }

    public function setInventory (pos:Vector2, size:Vector2, _elementsSize:Vector2, _nbElementX:Int = -1, _nbElementY:Int = -1) {
        pos.x *= pxSize.x;
        pos.y *= pxSize.y;

        size.x *= pxSize.x;
        size.y *= pxSize.y;

        _elementsSize.x *= size.x;
        _elementsSize.y *= size.y;

        inventory = new Inventory(this, pos, size, _elementsSize, _nbElementX, _nbElementY);
        return inventory;
    }
}
