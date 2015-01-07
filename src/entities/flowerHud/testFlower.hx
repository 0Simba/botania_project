package entities.flowerHud;

import utils.Vector2;
import manager.Selection;

class TestFlower extends GameObject
{

    public function new()
    {
        super();
        addComponent("hudElement");
        hudElement.set(new Vector2(0.1, 0.1), new Vector2(0.9, 0.35), "ground", "adultFlower");
        hudElement.bindEvents(mouseover, mousequit, mouseClick);
    }

    public function mouseover () {
        hudElement.replace(new Vector2(0.88, 0.35));
    }

    public function mousequit () {
        hudElement.replace(new Vector2(0.9, 0.35));
    }

    public function mouseClick () {
        Selection.actionType = "build";
        Selection.contain = "adultFlower";
    }

}