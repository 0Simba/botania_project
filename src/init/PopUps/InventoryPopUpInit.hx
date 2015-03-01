package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import entities.Seed;
import engine.isoEngine.components.Button;
import engine.popUpEngine.PopUp;
import engine.popUpEngine.Inventory;

class InventoryPopUpInit
{

    private static var pickButton:Button;
    private static var trashButton:Button;
    private static var selectedSeed:Seed;
    private static var inventoryPopUp:PopUp;
    private static var inventory:Inventory;


	public static function init () {
        var popUpEngine = PopUpEngineMain.getInstance();

        inventoryPopUp = popUpEngine.createPopUp("inventoryInterface", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        inventoryPopUp.addBlocPattern("background");
        inventoryPopUp.addBlocPattern("border");

        inventory = inventoryPopUp.setInventory(new Vector2(0.1, 0.08), new Vector2(0.8, 0.6), new Vector2(0.25, 0.5, "%", "%x"), 4, -1);

        pickButton  = inventoryPopUp.addButton(new Vector2(0.7, 0.8), new Vector2(0.1, 0.1), "inventoryBtn", "inventoryBtn", "inventoryBtn", pickButtonClick);
        pickButton.hide();
        trashButton = inventoryPopUp.addButton(new Vector2(0.8, 0.8), new Vector2(0.1, 0.1), "inventoryBtn", "inventoryBtn", "inventoryBtn", function(){});
        trashButton.hide();

        inventoryPopUp.addButtonPattern("close").onClick(function () {
            inventoryPopUp.hide();
            pickButton.hide();
            trashButton.hide();
        });

        inventoryPopUp.addText(new Vector2(0.5, 0.02), new Vector2(0.5, 0.5), "Inventaire", {font : "bold 20px verdana", fill : "white", align : "center"});
        inventoryPopUp.onShow = onShow;
    }

    private static function showInteractiveButtons (seed:Seed) {
        selectedSeed = seed;
        pickButton.show();
        trashButton.show();
    }

    private static function pickButtonClick(){
        trace("Coucu");
    }

    private static function displaySeeds () {
        inventory.clear();

        for (i in 0...Seed.list.length) {
            var cell:Cell = inventoryPopUp.inventory.addCell();
            cell.addBloc("darkGray", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
            cell.addBloc(Seed.list[i].appearanceName, new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8));
            cell.addButton(new Vector2(0, 0), new Vector2(1, 1), Seed.list[i].appearanceName, Seed.list[i].appearanceName, Seed.list[i].appearanceName, function () {
                showInteractiveButtons(Seed.list[i]);
            });
        }
    }

    public static function onShow () {
        displaySeeds();
    }
}

