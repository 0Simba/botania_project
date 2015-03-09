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

    static public function createHueFilter (name:String, value:Float) {
        value = (value) * Math.PI * 2;

        var filter = new ColorMatrixFilter();
        var cosVal = Math.cos(value);
        var sinVal = Math.sin(value);
        var lumR = 0.213;
        var lumG = 0.715;
        var lumB = 0.072;
        var colorMatrix = [
            lumR + cosVal * (1 - lumR) + sinVal * (-lumR), lumG + cosVal * (-lumG) + sinVal * (-lumG), lumB + cosVal * (-lumB) + sinVal * (1 - lumB),  0,
            lumR + cosVal * (-lumR) + sinVal * (0.143), lumG + cosVal * (1 - lumG) + sinVal * (0.140), lumB + cosVal * (-lumB) + sinVal * (-0.283),    0,
            lumR + cosVal * (-lumR) + sinVal * (-(1 - lumR)), lumG + cosVal * (-lumG) + sinVal * (lumG), lumB + cosVal * (1 - lumB) + sinVal * (lumB), 0,
            0, 0, 0, 1
        ];
        filter.matrix = colorMatrix;

        filters.set(name, filter);
    }

}
