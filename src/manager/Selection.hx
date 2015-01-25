package manager;

import engine.events.Events;

class Selection
{
    static public var events:Events = new Events();

    static public var actionType:String = "ground";
    static public var contain:String    = "grass";

    static private var lastActionType:String = null;
    static private var lastContain:String   = null;

    static public function setContain (name:String = null) {
        if (contain == name) return;

        if (name != null) {
            lastContain = contain;
            contain     = name;
        }
        else if (lastContain != null) {
            contain     = lastContain;
            lastContain = null;
        }
        events.emit("contain changed", contain);
        // trace("lastContain : " +  lastContain + " - contain : " + contain);
    }

    static public function setActionType (name:String = null) {
        if (actionType == name) return;

        if (name != null) {
            lastActionType = actionType;
            actionType     = name;
        }
        else if (lastActionType != null) {
            actionType     = lastActionType;
            lastActionType = null;
        }
        events.emit("actionType changed", actionType);
        // trace("lastActionType : " +  lastActionType + " - actionType : " + actionType);
    }
}
