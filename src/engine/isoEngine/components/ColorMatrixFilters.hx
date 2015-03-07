package engine.isoEngine.components;

import pixi.filters.ColorMatrixFilter;
import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.Sprite;
import engine.isoEngine.components.Hud;

class ColorMatrixFilters extends Hud
{

    static private var filters:Map<String, ColorMatrixFilter>;

    static public function init () {
        filters = new Map<String, ColorMatrixFilter>();
        setOverFilter();
        setClickFilter();
    }

    static public function add (name:String, filter:ColorMatrixFilter) {
        filters.set(name, filter);
    }

    static public function get (name:String) {
        return filters.get(name);
    }


    static private function setOverFilter () {
        var filter;
        var colorMatrix =  [
            1.0,  0.15, 0.15, 0.0,
            0.15, 1.0,  0.15, 0.0,
            0.15, 0.15, 1.0,  0.0,
            0.0,  0.0,  0.0,  1.0
        ];
        filter = new ColorMatrixFilter();
        filter.matrix = colorMatrix;
        filters.set("over", filter);
    }
    static private function setClickFilter () {
        var filter;
        var colorMatrix =  [
            0.85, 0.0, 0.0, 0.0,
            0.0, 0.85, 0.0, 0.0,
            0.0, 0.0, 0.85, 0.0,
            0.0, 0.0, 0.0, 1.0
        ];

        filter = new ColorMatrixFilter();
        filter.matrix = colorMatrix;
        filters.set("click", filter);
    }

}
