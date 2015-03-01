package manager;

import engine.events.Events;

class Selection
{
    static public var events:Events = new Events();

    static public var actionType:String = "ground";
    static public var contain:String    = "transparent";  //!\ WARNING stop use ground, useless lose perf
    static public var meta:Dynamic;

    static private var lastActionType:String = null;
    static private var lastContain:String    = null;
    static private var lastMeta:Dynamic      = null;


    static public function setNew (newAction:String, newContain:String = null, newMeta:Dynamic = null) {
        if (actionType == newAction && contain == newContain && meta == newMeta) return;

        lastActionType = actionType;
        lastContain    = contain;
        lastMeta       = meta;

        actionType = newAction;
        contain    = newContain;
        meta       = newMeta;

        events.emit("changed", null);
    }

    static public function setNull () {
        setNew ("null");
    }

    static public function backToLast () {
        actionType = lastActionType;
        contain    = lastContain;
        meta       = lastMeta;

        lastContain    = null;
        lastActionType = null;
        lastMeta       = null;
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
        trace("meta : "           + meta);
        trace("lastActionType : " + lastActionType);
        trace("lastMeta : "       + lastMeta);
        js.Browser.window.console.groupEnd();
    }
}
