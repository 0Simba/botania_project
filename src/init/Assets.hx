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
    static private var circleNavigation:JsonLoader;
    static private var colors:JsonLoader;
    static private var florist:JsonLoader;
    static private var popup:JsonLoader;
    static private var nbToLoad;
    static private var nbLoaded = 0;

    static public function load () {
        Tile.setSize(new Vector2(Config.display.tile.xSize, Config.display.tile.xSize));
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

        colors = new JsonLoader("../assets/colors.json");
        colors.addEventListener("loaded", function (pEvent:Event) {
            preloadAssets(pEvent, colors, "colors");
        });
        colors.load();

        popup = new JsonLoader("../assets/popup.json");
        popup.addEventListener("loaded", function (pEvent:Event) {
            preloadAssets(pEvent, popup, "popup");
        });
        popup.load();

        florist = new JsonLoader("../assets/florist.json");
        florist.addEventListener("loaded", function (pEvent:Event) {
            preloadAssets(pEvent, florist, "florist");
        });
        florist.load();

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
