package manager;

import entities.Tile;

class Hud
{
    static public function init () {
        new entities.biomeHud.Automn();
        new entities.biomeHud.Grass();
        new entities.flowerHud.Breaker();
        new entities.flowerHud.TestFlower();
    }
}
