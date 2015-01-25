package manager.circlesHud;

class Flower extends CirclesHudManager
{
    public function new () {
        super("flower");
        events.on('dig', removeFlower);
    }

    public function removeFlower (targetFlower:entities.Flower) {
        targetFlower.destroy();
        managedHud.hide();
        Selection.actionType = null;
    }
}
