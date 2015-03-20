package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;

class Workshop extends CirclesHudManager
{
    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("workshop");

        managedHud.addOnce("remove", "trashBasic", removeBreaker);
        managedHud.addOnce("open"  , "fertilizerBasic", openPopUp);

        popUpEngine = PopUpEngineMain.getInstance();
    }

    public function removeBreaker (targetBreaker:entities.building.Breaker) {
        close();
        targetBreaker.destroyFromServer();
    }

    public function openPopUp (targetBreaker:entities.building.Breaker) {
        close();
        popUpEngine.show("breakerInterface");
    }
}
