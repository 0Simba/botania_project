package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;

class Flower extends CirclesHudManager
{

    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("flower");

        popUpEngine = PopUpEngineMain.getInstance();

        events.on("dig", removeFlower);
        events.on("pick", pickFlower);
    }

    public function removeFlower (targetFlower:entities.Flower) {
        close();
        targetFlower.destroy();
    }

    public function pickFlower (targetFlower:entities.Flower) {
        close();
        popUpEngine.show("flowerPopUp");
    }
}
