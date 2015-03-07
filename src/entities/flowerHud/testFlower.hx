package entities.flowerHud;

import utils.Vector2;
import manager.Selection;
import engine.isoEngine.components.Hud;

class TestFlower extends GameObject
{

    public var hudElement:Hud;

    public function new()
    {
        super();

        hudElement = new Hud();
        hudElement.set(new Vector2(0.1, 0.1), new Vector2(0.9, 0.35), "adultFlower");
        hudElement.bindEvents(mouseover, mousequit, mouseClick);
    }

    public function mouseover () {
        hudElement.replace(new Vector2(0.88, 0.35));
    }

    public function mousequit () {
        hudElement.replace(new Vector2(0.9, 0.35));
    }

    public function mouseClick () {
        Selection.setNew("build", "adultFlower");
    }

}