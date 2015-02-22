package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;

class Breaker extends CirclesHudManager
{
    private var popUpEngine:PopUpEngineMain;

    public function new () {
        super("breaker");

        popUpEngine = PopUpEngineMain.getInstance();

        events.on("remove", removeBreaker);
        events.on("open", openPopUp);
    }

    public function removeBreaker (targetBreaker:entities.building.Breaker) {
        close();
        targetBreaker.destroy();
    }

    public function openPopUp (targetBreaker:entities.building.Breaker) {
        close();
        popUpEngine.show("breakerInterface");
    }
}
