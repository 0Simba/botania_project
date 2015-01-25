package manager;

class Selection
{
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
        // trace("lastActionType : " +  lastActionType + " - actionType : " + actionType);
    }
}
