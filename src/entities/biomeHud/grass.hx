package entities.biomeHud;

import utils.Vector2;
import manager.Selection;

class Grass extends GameObject
{

    public function new()
    {
        super();
        addComponent("hudElement");
        hudElement.set(new Vector2(0.1, 0.1), new Vector2(0.9, 0.15), "ground", "grass");
        hudElement.bindEvents(mouseover, mousequit, mouseClick);
    }

    public function mouseover () {
        hudElement.replace(new Vector2(0.88, 0.15));
    }

    public function mousequit () {
        hudElement.replace(new Vector2(0.9, 0.15));
    }

    public function mouseClick () {
        Selection.contain = "grass";
    }

}