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
        managedHud.addOnce("water"     , "waterBasic"     , growFlower);
        managedHud.addOnce("fertilizer", "fertilizerBasic", showOpenFruit);

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

    public function showOpenFruit () {
        popUpEngine.show("openFruit");
    }

    public function empty () {}
}
