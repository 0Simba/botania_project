package init.popUps;

import utils.Vector2;

class FlowerPopUpInit
{
	public static function init (popUpEngine) {
	    var flowerPopUp = popUpEngine.createPopUp("flowerPopUp", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        flowerPopUp.addBlocPattern("background");
        flowerPopUp.addBloc(new Vector2(0.7, 0.7), new Vector2(0.4, 0.2), "savana");
        flowerPopUp.addButtonPattern("close").onClick(function () {
            flowerPopUp.hide();
        });
	}
}

