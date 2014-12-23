package init;

import engine.isoEngine.IsoEngine;

class Assets
{

    static private var isoEngine:IsoEngine;

    static public function load () {
        isoEngine = IsoEngine.getInstance(1120, 630);
        isoEngine.setTileSize(128);

        isoEngine.load(["../assets/iso.json"], assetLoaded);
    }

    static private function assetLoaded () {
        isoEngine.addTexture("grass", "grass");
        isoEngine.addTexture("water", "water");
        var list:Array<String> = new Array<String>();
        list.push("water");
        list.push("grass");
        isoEngine.createAnimation("ground", list);

        Main.ready();
    }
}