package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;

class BreakerPopUpInit
{
	public static function init () {
        var popUpEngine = PopUpEngineMain.getInstance();

        var breakerPopUp = popUpEngine.createPopUp("breakerInterface", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        breakerPopUp.addBlocPattern("background");
        breakerPopUp.addBlocPattern("border");
        breakerPopUp.addBlocPattern("florist").setDroppable();

        breakerPopUp.setInventory(new Vector2(0.07, 0.085), new Vector2(0.6, 0.6),  new Vector2(0.33, 0.33), 3, -1);

        var textures = new Array<String>();textures.push("savana");textures.push("grass");textures.push("swamp");textures.push("automn");
        for (i in 0...20) {
            var cell:Cell = breakerPopUp.inventory.addCell();
            var textName = textures[i % textures.length];

            cell.addBloc("darkGray", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
            cell.addBloc(textName, new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).setDraggable();
        }

        breakerPopUp.addBloc("dark", new Vector2(0.2, 0.7), new Vector2(-1, 0.18)).setDroppable();

        breakerPopUp.addBloc("dark", new Vector2(0.5, 0.7), new Vector2(-1, 0.18)).setDroppable();

        breakerPopUp.addButtonPattern("close").onClick(function () {
            breakerPopUp.hide();
        });

        breakerPopUp.addText(new Vector2(0.25, 0.02), new Vector2(0.5, 0.5), "Concasseur", {"font" : "bold 20px verdana", "fill" : "white", "align" : "center"});

	}
}

