package entities.biomeHud;

import utils.Vector2;
import manager.Selection;

class Water extends GameObject
{

    public function new()
    {
        super();
        addComponent("hudElement");
        hudElement.set(new Vector2(0.1, 0.1), new Vector2(0.9, 0.05), "automn");
        hudElement.bindEvents(mouseover, mousequit, mouseClick);
    }

    public function mouseover () {
        hudElement.replace(new Vector2(0.88, 0.05));
    }

    public function mousequit () {
        hudElement.replace(new Vector2(0.9, 0.05));
    }

    public function mouseClick () {
        Selection.setNew("ground", "automn");
    }

}