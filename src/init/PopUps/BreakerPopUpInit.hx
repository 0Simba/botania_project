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

        breakerPopUp.setInventory(new Vector2(0.07, 0.085), new Vector2(0.6, 0.6),  new Vector2(0.25, 0.25), 4, -1);
        breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");
        breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");breakerPopUp.inventory.addCell("savana");breakerPopUp.inventory.addCell("grass");breakerPopUp.inventory.addCell("automn");breakerPopUp.inventory.addCell("swamp");

        breakerPopUp.addBloc(new Vector2(0.2, 0.7), new Vector2(-1, 0.18), "dark");
        breakerPopUp.addBloc(new Vector2(0.5, 0.7), new Vector2(-1, 0.18), "dark");

        breakerPopUp.addButtonPattern("close").onClick(function () {
            breakerPopUp.hide();
        });

        breakerPopUp.addText(new Vector2(0.25, 0.02), new Vector2(0.5, 0.5), "Concasseur", {"font" : "bold 20px verdana", "fill" : "white", "align" : "center"});

	}
}

