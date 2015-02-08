package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;


class BreakerPopUpInit
{
	public static function init () {
        var popUpEngine = PopUpEngineMain.getInstance();

        var breakerPopUp = popUpEngine.createPopUp("breakerInterface", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        breakerPopUp.addBlocPattern("background");
        breakerPopUp.addBlocPattern("border");
        breakerPopUp.addBlocPattern("florist");

        breakerPopUp.setInventory(new Vector2(0.08, 0.08), new Vector2(0.6, 0.8),  new Vector2(0.5, 0.5), 2, -1);
        breakerPopUp.inventory.addCell("savana");
        breakerPopUp.inventory.addCell("grass");
        breakerPopUp.inventory.addCell("automn");
        breakerPopUp.inventory.addCell("swamp");
        breakerPopUp.inventory.addCell("savana");
        breakerPopUp.inventory.addCell("grass");
        breakerPopUp.inventory.addCell("automn");
        breakerPopUp.inventory.addCell("swamp");
        breakerPopUp.inventory.addCell("savana");
        breakerPopUp.inventory.addCell("grass");
        breakerPopUp.inventory.addCell("automn");
        breakerPopUp.inventory.addCell("swamp");

        breakerPopUp.addButtonPattern("close").onClick(function () {
            breakerPopUp.hide();
        });
	}
}

