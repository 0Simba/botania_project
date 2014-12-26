package entities.flowerHud;

import utils.Vector2;
import manager.Selection;

class BrownFlower extends GameObject
{

    public function new()
    {
        super();
        addComponent("hudElement");
        hudElement.set(new Vector2(0.1, 0.1), new Vector2(0.9, 0.25), "ground", "brownFlower");
        hudElement.bindEvents(mouseover, mousequit, mouseClick);
    }

    public function mouseover () {
        hudElement.replace(new Vector2(0.88, 0.25));
    }

    public function mousequit () {
        hudElement.replace(new Vector2(0.9, 0.25));
    }

    public function mouseClick () {
        Selection.actionType = "build";
        Selection.contain = "brownFlower";
    }

}