package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;
import engine.circleHud.CirclesHudEngine;

class Flower extends CirclesHudManager
{

    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("flower");

        managedHud.addOnce("pick"      , "pickBasic"      , saveNewFruit);
        managedHud.addOnce("dig"       , "digBasic"       , removeFlower);
        managedHud.addOnce("water"     , "waterBasic"     , growFlower);
        managedHud.addOnce("fertilizer", "fertilizerBasic", empty);

        popUpEngine = PopUpEngineMain.getInstance();
    }

    public function removeFlower (targetFlower:entities.Flower) {
        close();
        targetFlower.destroyFromServer();
    }

    public function pickFlower (targetFlower:entities.Flower) {
        close();
        targetFlower.harvest();
    }

    public function growFlower (targetFlower:entities.Flower) {
        targetFlower.water();
    }

    public function saveNewFruit (targetFlower:entities.Flower) {
        targetFlower.harvest();
    }

    public function empty () {}
}
