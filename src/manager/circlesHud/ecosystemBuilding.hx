package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;

class EcosystemBuilding extends CirclesHudManager
{
    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("Mellifera");

        managedHud.addOnce("remove", "trashBasic", removeBreaker);
        managedHud.addOnce("open"  , "fertilizerBasic", openPopUp);

        popUpEngine = PopUpEngineMain.getInstance();
    }

    public function removeBreaker (targetBreaker:entities.Building) {
        close();
        targetBreaker.destroyFromServer();
    }

    public function openPopUp (targetBreaker:entities.Building) {
        close();
        popUpEngine.show("breakerInterface");
    }
}
