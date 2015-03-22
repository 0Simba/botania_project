package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;
import utils.Vector2;
import engine.isoEngine.components.Button;

class CircleElement extends GameObject
{
    public var angle:Float;

    private var parent:CircleBlock;
    private var referent:Events;

    public var hudButton:Button;

    public function new (_parent:CircleBlock, basicTexture:String, _callback:Dynamic) {
        super();

        parent = _parent;

        basicHudButton(basicTexture);

        callback = _callback;
    }

    private function basicHudButton(texture:String){
        hudButton = new Button();
        hudButton.set(new Vector2(parent.elementsRadius, parent.elementsRadius), new Vector2(0, 0), texture, parent.layerName);
        hudButton.sprite.anchor.set(0.5, 0.5);
        hudButton.onClick(click);
    }

    public function replace (pos:Vector2) {
        pos.metaX = "px";
        pos.metaY = "px";
        hudButton.replace(pos);
    }

    private function over () {
    }

    private function out () {
    }

    private function click () {
        callback(parent.targetShowed);
    }

    dynamic public function callback (targetShowed) {}
}