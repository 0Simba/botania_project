package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;
import engine.circleHud.CirclesHudEngine;
import entities.popUps.DisplayGenomeStats;

class Flower extends CirclesHudManager
{

    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("flower");

        managedHud.addOnce("pick"      , "pickBasic"      , saveNewFruit);
        managedHud.addOnce("dig"       , "digBasic"       , removeFlower);
        managedHud.addOnce("water"     , "waterBasic"     , growFlower);
        managedHud.addOnce("fertilizer", "fertilizerBasic", displayStats);

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

    public function displayStats (targetFlower:entities.Flower) {
        DisplayGenomeStats.setParams(targetFlower);
        popUpEngine.show("displayGenomeStats");
    }

    public function empty () {}
}
