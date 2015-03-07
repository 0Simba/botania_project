package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;

class Breaker extends CirclesHudManager
{
    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("breaker");

        managedHud.addOnce("remove", "digBasic", removeBreaker);
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
