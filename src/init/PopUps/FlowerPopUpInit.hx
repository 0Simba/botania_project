package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;

class FlowerPopUpInit
{
	public static function init () {
        var popUpEngine = PopUpEngineMain.getInstance();

	    var flowerPopUp = popUpEngine.createPopUp("flowerPopUp", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        flowerPopUp.addBlocPattern("background");
        flowerPopUp.addBlocPattern("border");
        flowerPopUp.addButtonPattern("close").onClick(function () {
            flowerPopUp.hide();
        });
	}
}

