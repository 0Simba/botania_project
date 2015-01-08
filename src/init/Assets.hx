package init;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Tile;
import js.html.Event;
import pixi.loaders.JsonLoader;

class Assets
{

    static private var isoEngine:IsoEngine;
    static private var biomesAndBuildingData:JsonLoader;

    static public function load () {
        Tile.setSize(128);
        isoEngine = IsoEngine.getInstance();
        isoEngine.assets.load(["../assets/biomesAndBuilding.json"], assetLoaded);

        biomesAndBuildingData = new JsonLoader("../assets/biomesAndBuilding.json");
        biomesAndBuildingData.addEventListener("loaded", preloadAssets);
        biomesAndBuildingData.load();
    }

    static private function preloadAssets (pEvent:Event) {
        biomesAndBuildingData.removeEventListener("loaded", preloadAssets);
        var myData = cast(pEvent.target, JsonLoader).json.frames;

        var list:Array<String> = new Array<String>();
        for (n in Reflect.fields(myData)) {
            list.push(n);
            isoEngine.assets.addTexture(n, n);
        }
        isoEngine.assets.createAnimation("ground", list);
    }

    static private function assetLoaded () {
        Main.ready();
    }
}
