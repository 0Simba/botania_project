package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;
import engine.isoEngine.IsoEngine;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Inventory;
import engine.popUpEngine.Text;

class Container extends engine.isoEngine.components.DragNDrop
{
    public var isoEngine:IsoEngine;
    public var layer:DisplayObjectContainer;
    public var popUpEngineMain:PopUpEngineMain;
    public var pxSize:Vector2;

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

    public function addBloc (textureName:String, pos:Vector2 = null, size:Vector2 = null) {
        pos = (pos == null) ? Vector2.zero : pos; size = (size == null) ? Vector2.full : size;

        var bloc = new Bloc(pos, size, textureName);
        return addSomethingOn(bloc);
    }

    public function addBlocPattern (blocName:String) {
        var bloc = popUpEngineMain.getBlocPattern(blocName);
        return addSomethingOn(bloc);
    }

    public function addButton (pos:Vector2, size:Vector2, basicTexture:String, callback) {
        var button = new Button(size, pos, basicTexture, callback);
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
}
