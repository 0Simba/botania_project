package manager.circlesHud;

class Breaker extends CirclesHudManager
{
    public function new () {
        super("breaker");
        events.on("remove", removeBreaker);
    }

    public function removeBreaker (targetBreaker:entities.building.Breaker) {
        targetBreaker.destroy();
        managedHud.hide();
    }
}
