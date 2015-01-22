package engine.circleHud;

import engine.circleHud.CircleBlock;
import engine.events.Events;
import utils.Vector2;
import init.Config;

class CircleElement extends GameObject
{
    private var name:String;
    private var parent:CircleBlock;
    private var referent:Events;

    public function new (_parent:CircleBlock, _name:String, texture:String) {
        super();
        parent = _parent;
        name   = _name;

        addComponent("hudElement");
        var config:Dynamic = Config.display.hud.circle;
        hudElement.set(
            new Vector2(config.percentSize, config.percentSize),
            new Vector2(config.percentPos,  config.percentPos ),
            "circleNavigation",
            texture,
            parent.layerName
        );
        hudElement.resize(new Vector2(parent.elementsRadius, parent.elementsRadius));
    }

    public function replace (pos:Vector2) {
        hudElement.replace(pos, true);
    }

}
