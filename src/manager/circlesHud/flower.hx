package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;
import engine.circleHud.CirclesHudEngine;

class Flower extends CirclesHudManager
{

    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("flower");

        managedHud.addOnce("pick"      , "pickBasic");
        managedHud.addOnce("dig"       , "digBasic");
        managedHud.addOnce("water"     , "waterBasic");
        managedHud.addOnce("fertilizer", "fertilizerBasic");

        popUpEngine = PopUpEngineMain.getInstance();

        events.on("dig", removeFlower);
        events.on("pick", pickFlower);
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
