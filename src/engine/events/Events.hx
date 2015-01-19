package engine.events;

class Events
{
    public var listeners:Map<String, Array<Dynamic>>;

    public function new () {
        listeners = new Map<String, Array<Dynamic>>();
    }

    public function emit (name:String, data:Dynamic) {
        if (listeners.exists(name)) {
            for (i in 0...listeners.get(name).length) {
                listeners.get(name)[i](data);
            }
        }
    }

    public function on (name:String, func:Dynamic) {
        if (!listeners.exists(name)) {
            listeners.set(name, new Array<Dynamic>());
        }
        listeners.get(name).push(func);
    }
}
