package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;
import engine.circleHud.CirclesHudEngine;

class Flower extends CirclesHudManager
{

    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("flower");

        managedHud.addOnce("pick"      , "pickBasic"      , pickFlower);
        managedHud.addOnce("dig"       , "digBasic"       , removeFlower);
        managedHud.addOnce("water"     , "waterBasic"     , empty);
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

    public function empty () {}
}
