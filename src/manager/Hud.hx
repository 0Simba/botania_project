package manager;

import entities.Tile;

class Hud
{
    static public function init () {
        new entities.biomeHud.Water();
        new entities.biomeHud.Grass();
        new entities.flowerHud.BrownFlower();
        new entities.flowerHud.TestFlower();
    }
}
