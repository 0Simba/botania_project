package init;

import engine.isoEngine.IsoEngine;

class Assets
{

    static private var isoEngine:IsoEngine;

    static public function load () {
        isoEngine = IsoEngine.getInstance();
        isoEngine.setTileSize(128);

        isoEngine.assets.load(["../assets/iso.json"], assetLoaded);
    }

    static private function assetLoaded () {
        isoEngine.assets.addTexture("grass", "grass");
        isoEngine.assets.addTexture("water", "water");
        isoEngine.assets.addTexture("corner", "corner");
        var list:Array<String> = new Array<String>();
        list.push("water");
        list.push("grass");
        list.push("corner");
        isoEngine.assets.createAnimation("ground", list);

        Main.ready();
    }
}