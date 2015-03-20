package manager.circlesHud.ecosystemBuildings;

import engine.popUpEngine.PopUpEngineMain;

class ButterflyTree extends CirclesHudManager
{
    private var popUpEngine:PopUpEngineMain;

    public function new (name:String) {
        super(name);

        managedHud.addOnce("remove", "trashBasic", removeBuilding);
        managedHud.addOnce("open"  , "fertilizerBasic", openPopUp);

        popUpEngine = PopUpEngineMain.getInstance();
    }

    public function openPopUp (targetBreaker:entities.Building) {
        close();
        popUpEngine.show("breakerInterface");
    }
}
