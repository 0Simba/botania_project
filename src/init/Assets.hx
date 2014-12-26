package init;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Tile;

class Assets
{

    static private var isoEngine:IsoEngine;

    static public function load () {
        Tile.setSize(128);
        isoEngine = IsoEngine.getInstance();

        isoEngine.assets.load(["../assets/biomesAndBuilding.json"], assetLoaded);
    }

    static private function assetLoaded () {
        isoEngine.assets.addTexture("brownFlower", "brownFlower");
        isoEngine.assets.addTexture("grass", "grass");
        isoEngine.assets.addTexture("automn", "automn");
        isoEngine.assets.addTexture("swamp", "swamp");
        isoEngine.assets.addTexture("savana", "savana");
        isoEngine.assets.addTexture("breaker", "breaker");
        var list:Array<String> = new Array<String>();
        list.push("grass");
        list.push("automn");
        list.push("swamp");
        list.push("automn");
        list.push("breaker");
        isoEngine.assets.createAnimation("ground", list);

        Main.ready();
    }
}