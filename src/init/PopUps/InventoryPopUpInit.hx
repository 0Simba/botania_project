package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import entities.Seed;

class InventoryPopUpInit
{
	public static function init () {
        var popUpEngine = PopUpEngineMain.getInstance();

        var inventoryPopUp = popUpEngine.createPopUp("inventoryInterface", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        inventoryPopUp.addBlocPattern("background");
        inventoryPopUp.addBlocPattern("border");

        inventoryPopUp.setInventory(new Vector2(0.1, 0.08), new Vector2(0.8, 0.6), new Vector2(0.25, 0.5, "%", "%x"), 4, -1);

        // var textures = new Array<String>();textures.push("savana");textures.push("grass");textures.push("swamp");textures.push("automn");
        // for (i in 0...20) {
        //     var cell:Cell = inventoryPopUp.inventory.addCell();
        //     var textName = textures[i % textures.length];

        //     cell.addBloc("darkGray", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
        //     cell.addBloc(textName, new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).setDraggable();
        // }
        for (i in 0...Seed.list.length) {
            trace(Seed.list[i].appearanceName);

            var cell:Cell = inventoryPopUp.inventory.addCell();

            cell.addBloc("darkGray", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
            cell.addBloc(Seed.list[i].appearanceName, new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8));
        }

        inventoryPopUp.addButtonPattern("close").onClick(function () {
            inventoryPopUp.hide();
        });

        inventoryPopUp.addText(new Vector2(0.25, 0.02), new Vector2(0.5, 0.5), "Concasseur", {"font" : "bold 20px verdana", "fill" : "white", "align" : "center"});
	}
}

