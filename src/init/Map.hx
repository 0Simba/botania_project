package init;
import init.Config;
class Map
{
    static public function load () {
        var map:manager.Map = manager.Map.getInstance();
        var config:Dynamic = Config.display.map;
        map.set(config.size.x, config.size.y);
    }
}