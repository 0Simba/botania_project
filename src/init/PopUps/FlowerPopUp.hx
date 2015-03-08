package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import init.popUps.PopUpUtils;

class FlowerPopUp extends PopUpUtils
{
	public function new () {
	    super("flowerPopUp", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));

        addBlocPattern("background");
        addBlocPattern("border");
        addButtonPattern("close").onClick(tweenHide);
        onShow = tweenShow;
	}
}

