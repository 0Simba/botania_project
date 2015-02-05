package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;


class BreakerPopUpInit
{
	public static function init () {
        var popUpEngine = PopUpEngineMain.getInstance();

        var breakerPopUp = popUpEngine.createPopUp("breakerInterface", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        breakerPopUp.addBlocPattern("background");
        breakerPopUp.addBloc(new Vector2(0.2, 0.2), new Vector2(0.7, 0.7), "automn");
        // breakerPopUp.setInventory(new Vector2(0.1, 0.1), new Vector2);

        breakerPopUp.addButtonPattern("close").onClick(function () {
            breakerPopUp.hide();
        });
	}
}

