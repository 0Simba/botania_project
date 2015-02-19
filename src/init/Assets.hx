package init;

import init.Config;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Tile;
import js.html.Event;
import pixi.loaders.JsonLoader;
import utils.Vector2;

class Assets
{

    static private var isoEngine:IsoEngine;
    static private var biomesAndBuildingData:JsonLoader;
    static private var nbLoaded = 0;


    static public function load () {
        Tile.setSize(new Vector2(Config.display.tile.xSize, Config.display.tile.ySize));
        isoEngine = IsoEngine.getInstance();

        for (i in 0...Config.assets.jsonList.length) {
            var element = new JsonLoader("./assets/" + Config.assets.jsonList[i] + ".json");
            element.addEventListener("loaded", function (pEvent:Event) {
                preloadAssets(pEvent, element, Config.assets.jsonList[i]);
            });
            element.load();
        }
    }

    static private function preloadAssets (pEvent:Event, target:JsonLoader, animationName) {
        target.removeEventListener("loaded", preloadAssets);
        var myData = cast(pEvent.target, JsonLoader).json.frames;

        var list:Array<String> = new Array<String>();
        for (n in Reflect.fields(myData)) {
            list.push(n);
            isoEngine.assets.addTexture(n, n);
        }
        isoEngine.assets.createAnimation(animationName, list);
        assetLoaded();
    }

    static private function assetLoaded () {
        nbLoaded++;
        if (nbLoaded >= Config.assets.jsonList.length) {
            Main.ready();
        }
    }
}
