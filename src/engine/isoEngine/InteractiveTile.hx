package engine.isoEngine;

import pixi.display.MovieClip;

class InteractiveTile
{

    public function bindTo (mc:MovieClip, mouseover, mouseout) {
        mc.interactive = true;
        mc.mouseover   = function (mouseData) {
            if (isOn()) {
                mouseover();
            }
        }
        mc.mouseout   = function (mouseData) {
            if (isOn()) {
                mouseout();
            }
        }
    }

    private function isOn ():Bool {
        return true;
    }


	public function new () {}
}