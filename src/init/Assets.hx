package init;

import init.Config;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Tile;
import js.html.Event;
import pixi.loaders.JsonLoader;

class Assets
{

    static private var isoEngine:IsoEngine;
    static private var biomesAndBuildingData:JsonLoader;
    static private var circleNavigation:JsonLoader;
    static private var nbToLoad;
    static private var nbLoaded = 0;

    static public function load () {
        Tile.setSize(Config.display.tile.size);
        isoEngine = IsoEngine.getInstance();
        isoEngine.assets.load(["../assets/biomesAndBuilding.json", "../assets/circleNavigation.json"], assetLoaded);

        biomesAndBuildingData = new JsonLoader("../assets/biomesAndBuilding.json");
        biomesAndBuildingData.addEventListener("loaded", function (pEvent:Event) {
            preloadAssets(pEvent, biomesAndBuildingData, "ground");
        });
        biomesAndBuildingData.load();

        circleNavigation = new JsonLoader("../assets/circleNavigation.json");
        circleNavigation.addEventListener("loaded", function (pEvent:Event) {
            preloadAssets(pEvent, circleNavigation, "circleNavigation");
        });
        circleNavigation.load();
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
        nbToLoad = Config.assets.nbToLoad;
        nbLoaded++;
        if (nbLoaded >= nbToLoad) {
            Main.ready();
        }
    }
}
