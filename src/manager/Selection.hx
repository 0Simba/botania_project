package manager;

import engine.events.Events;

class Selection
{
    static public var events:Events = new Events();

    static public var actionType:String = "ground";
    static public var contain:String    = "grass";

    static private var lastActionType:String = null;
    static private var lastContain:String   = null;


    static public function setNew (newAction:String, newContain:String = null) {
        if (actionType == newAction && contain == newContain) return;

        lastActionType = actionType;
        lastContain    = contain;

        actionType = newAction;
        contain    = newContain;

        events.emit("changed", null);
    }

    static public function backToLast () {
        actionType = lastActionType;
        contain    = lastContain;

        lastContain    = null;
        lastActionType = null;
        events.emit("changed", null);
    }

    static public function clear () {
        backToLast();
        backToLast();
        events.emit("changed", null);
    }

        /***** UTILS *****/
    static public function logState () {
        js.Browser.window.console.group("Selection.logState");
        trace("actionType : "     + actionType);
        trace("contain : "        + contain);
        trace("lastActionType : " + lastActionType);
        trace("lastContain : "    + lastContain);
        js.Browser.window.console.groupEnd();
    }
}
