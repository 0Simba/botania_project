package manager.circlesHud;

import engine.events.Events;
import engine.circleHud.CircleBlock;

class CirclesHudManager
{

    public  var events:Events;
    private var managedHud:CircleBlock;

    public function new () {
        events = new Events();
    }

    public function setTargetHud (circleBlock:CircleBlock) {
        managedHud = circleBlock;
    }
}
