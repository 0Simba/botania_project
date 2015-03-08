package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import entities.Seed;
import engine.isoEngine.components.Button;
import engine.popUpEngine.PopUp;
import engine.popUpEngine.Inventory;
import engine.isoEngine.IsoEngine;
import manager.Selection;
import engine.popUpEngine.Bloc;
import engine.isoEngine.components.Hud;

class InventoryPopUpInit
{

    private static var pickButton:Button;
    private static var trashButton:Button;
    private static var selectedSeed:Seed;
    private static var inventoryPopUp:PopUp;
    private static var buildingInventory:Inventory;
    private static var background:Hud;


	public static function init () {
        var assets = IsoEngine.getInstance().assets;
        var popUpEngine = PopUpEngineMain.getInstance();

        inventoryPopUp = popUpEngine.createPopUp("inventoryInterface", new Vector2(0.5, 0.5), new Vector2(0.8, 0.8));
        inventoryPopUp.applyAnchor(0.5, 0.5);
        background = inventoryPopUp.addBloc("mainFR", new Vector2(0.2, 0.1), new Vector2(1.14, 1, "%y", "%"));
        var buildingContainer = inventoryPopUp.addContainer(new Vector2(1, 1));
        buildingInventory = buildingContainer.setInventory(new Vector2(0.23, 0.2), new Vector2(0.55, 0.63), new Vector2(0.25, 0.5, "%", "%x"), 4, -1);

        pickButton  = inventoryPopUp.addButton(new Vector2(0.2, 0.4), new Vector2(0.1, 0.7, "%", "%x"), "tabDark", pickButtonClick);
        pickButton.setAnchor(1, 0.5);

         
        /*inventory = inventoryPopUp.setInventory(new Vector2(0.1, 0.08), new Vector2(0.8, 0.6), new Vector2(0.25, 0.5, "%", "%x"), 4, -1);

        pickButton.hide();
        trashButton = inventoryPopUp.addButton(new Vector2(0.8, 0.8), new Vector2(0.1, 0.1), "inventoryBtn", function(){});
        trashButton.hide();


        inventoryPopUp.addText(new Vector2(0.5, 0.02), new Vector2(0.5, 0.5), "Inventaire", {font : "bold 20px verdana", fill : "white", align : "center"});*/
        inventoryPopUp.addButtonPattern("close").onClick(closePopUp);
        inventoryPopUp.onShow = onShow;
    }

    private static function showInteractiveButtons (seed:Seed) {
        selectedSeed = seed;
        pickButton.show();
        trashButton.show();
    }

    private static function pickButtonClick () {
        Selection.setNew("plant", "seed", selectedSeed);
        closePopUp();
    }

    private static function displaySeeds () {
        buildingInventory.clear();
        trace(Seed.list.length);
        for (i in 0...Seed.list.length) {
            var cell:Cell = buildingInventory.addCell();
            cell.addBloc("objectBackground", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));

            var name = Seed.list[i].appearanceName;
            var cont = cell.addContainer(new Vector2(1, 1));
            cont.addButton(new Vector2(0, 0), new Vector2(1, 1), "objectBackground", function () {
                showInteractiveButtons(Seed.list[i]);
            });

            cont.addBloc("G" + name.charAt(2), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("F" + name.charAt(0), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("O" + name.charAt(1), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
        }
    }

    public static function onShow () {
        Selection.setNull();
        displaySeeds();
    }

    private static function closePopUp () {
        inventoryPopUp.hide();
        pickButton.hide();
        trashButton.hide();
    }
}

