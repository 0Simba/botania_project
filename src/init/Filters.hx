package init;

import engine.isoEngine.components.ColorMatrixFilters;
import Map;

class Filters
{

    static public function load () {
        var hues = Config.flower.typeToHue;
        ColorMatrixFilters.createHueFilter("hueA", hues.A);
        ColorMatrixFilters.createHueFilter("hueB", hues.B);
        ColorMatrixFilters.createHueFilter("hueC", hues.C);
        ColorMatrixFilters.createHueFilter("hueD", hues.D);
        ColorMatrixFilters.createHueFilter("hueE", hues.E);
    }
}
