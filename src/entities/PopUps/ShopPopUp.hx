package entities.popUps;

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
import engine.popUpEngine.Container;
import entities.popUps.PopUpMain;
import entities.Fruit;
import pixi.text.Text.TextStyle;

class ShopPopUp extends PopUpMain
{

    private var background:Hud;

    private var tabsNames      :Array<String>    = ["seeds", "fruits", "product", "building"];
    private var tabIcons       :Array<Dynamic>   = [];
    private var tabButtons     :Array<Dynamic>   = [];
    private var inventories    :Array<Inventory> = [];
    private var tabs           :Array<Container>;
    private var activeTabIndex :Int;
    private static var instance:Dynamic;


	public function new () {
        super("shopInterface", new Vector2(0.5, 0.6), new Vector2(1.33, 0.7, "%y", "%"));
        // applyAnchor(0.5, 0.5);

        background = addBloc("shopBGFR", new Vector2(0, 0), new Vector2(1, 1, "%", "%"));
        tabInit();

        /* MAIN CLOSE BUTTON */
        addButton(new Vector2(0.95, 0), new Vector2(61, 61, "px", "px"), Vector2.zero, "close", function () {
            tweenHide();
        });

        onShow = setInventorysThenTween;
        instance = this;
    }


    public function setInventorysThenTween () {
        Selection.setNull();
        tweenShow();
    }





/*============================
=            TABS            =
============================*/

    private function tabInit () {
        activeTabIndex = 0;
        tabs = [];
        for(i in 0...tabsNames.length){
            drawTab(i);
            createTabInterface(i);
            inventories[i].hide();
        }
        selectTab(activeTabIndex);
    }


    private function drawTab (i:Int) {
        var activeTabName = tabsNames[activeTabIndex];
        var y:Float       = (0.8 / tabsNames.length) * i + 0.1;
        var tab           = addContainer(new Vector2(1, 1));
        var extendName    = (tabsNames[i] == activeTabName) ? "Light" : "Dark";
        var imageSize     = assets.getSize(tabsNames[i] + extendName);
        var ratio:Float   = imageSize.y / imageSize.x;

        var seedsTabBg = tab.addButton(new Vector2(-0.06, y, "%"), new Vector2(0.12, 0.7, "%", "%x"), Vector2.zero, "tab" + extendName, function () {
            unselectActiveTab();
            selectTab(i);
        });

        var tabIcon = tab.addBloc(tabsNames[i] + extendName, new Vector2(0, y), new Vector2(0.06, ratio, "%", "%x"));
        tabIcon.displayObject.interactive = false;
        tabIcon.setAnchor(1.2, 0.5);
        seedsTabBg.setAnchor(0.5, 0.5);

        tabIcons.push(tabIcon);
        tabButtons.push(seedsTabBg);
    }


    private function createTabInterface (i:Int) {
        switch (tabsNames[i]) {
            case "seeds"  : createSeedsInventory();
            case "fruits" : createFruitsInventory();
            case "building" : createBuildingInventory();
            default: createBlankInventory();
        }
    }


    private function selectTab (index:Int) {
        activeTabIndex = index;
        tabIcons[activeTabIndex].changeTexture(tabsNames[activeTabIndex] + "Light");
        tabButtons[activeTabIndex].changeTexture("tabLight");
        inventories[index].show();
    }


    private function unselectActiveTab(){
        tabIcons[activeTabIndex].changeTexture(tabsNames[activeTabIndex] + "Dark");
        tabButtons[activeTabIndex].changeTexture("tabDark");
        inventories[activeTabIndex].hide();
    }





/*=================================
=            INVENTORY            =
=================================*/

  /*==========  SEEDS  ==========*/

    private var seedsInventory:Inventory;


    private function createSeedsInventory () {
        seedsInventory = createEntitiesInventoryContainer();
        inventories.push(seedsInventory);

        updateSeedsInventory();
    }


    private function updateSeedsInventory () {
        for (i in 0...Seed.list.length) {

            var name = Seed.list[i].appearanceName;
            /*var cont = createCellEntitieIn(seedsInventory, function () {
                pick(Seed.list[i]);
            });

            cont.addBloc("colo"  + name.charAt(0) + name.charAt(2), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%")).displayObject.interactive = false;
            cont.addBloc("motif" + name.charAt(0) + name.charAt(1), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%")).displayObject.interactive = false;
        */}
    }


    private function pick (seed) {
        Selection.setNew("plant", "seed", seed);
        tweenHide();
    }



  /*==========  FRUITS  ==========*/

    private var fruitsInventory:Inventory;


    private function createFruitsInventory () {
        fruitsInventory = createEntitiesInventoryContainer();
        inventories.push(fruitsInventory);

        updateFruitsInventory();
    }


    private function updateFruitsInventory () {
        for (i in 0...Fruit.list.length) {

            var name = Fruit.list[i].appearanceName;
            /*var cont = createCellEntitieIn(fruitsInventory, function () {
                popUpEngine.show("openFruit");
            });

            cont.addBloc("fColo"  + name.charAt(0) + name.charAt(2), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%")).displayObject.interactive = false;
            cont.addBloc("fMotif" + name.charAt(0) + name.charAt(1), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%")).displayObject.interactive = false;
        */}
    }

  /*========  BUILDINGS  ==========*/
  private var buildingInventory:Inventory;
  private function createBuildingInventory(){
    buildingInventory = createEntitiesInventoryContainer();
    inventories.push(buildingInventory);
  }

  public function updateBuildingInventory(){
    createBuildingCells(init.ShopDatas.buildings, "ecoBuild");
  }
    private function createBuildingCells(b:Dynamic, s:String){
        for(i in 0...b.length){
            var n = b[i].texture;
            var cont = createCellEntitieIn(buildingInventory, b[i], function () {
                //entities.popUps.ShopConfirmationPopUp.open(b[i], s);
                Selection.setNew(b[i].actionName, b[i].texture);
                tweenHide();
            });
            var img = cont.addBloc(n, new Vector2 (0.5, 0.5, "%", "%"), new Vector2 (.86, 1, "%y", "%"));
            img.displayObject.interactive = false;
            img.setAnchor(.5, .5);
        }
  }

  private function place(b:String, s:String){
    tweenHide();
    Selection.setNew(s, b);
  }

  /*==========  BLANK  ==========*/

    private function createBlankInventory(){
        var blankContainer = addContainer(new Vector2(1, 1));
        var blankInventory = blankContainer.setInventory(new Vector2(0.23, 0.2), new Vector2(0.55, 0.63), new Vector2(0.25, 0.35, "%", "%x"), 4, -1);
        inventories.push(blankInventory);
        blankInventory.hide();
    }



  /*==========  UTILS  ==========*/

    private function createCellEntitieIn (inventory:Inventory, element:Dynamic, callback:Dynamic):Container {
        var cell:Cell = inventory.addCell();
        var cont = cell.addContainer(new Vector2(1, 1));
        var bg = cont.addButton(new Vector2 (.5, .5), new Vector2 (.5, 1, "%", "%x"), Vector2.zero, "objectBackground", callback);
        bg.setAnchor(0.5, .5);
        cell.addButton(new Vector2(0.65, 0.1), new Vector2(0.2, 1, "%", "%x"), Vector2.zero, "miniClose", tweenHide);
        var curr = cont.addBloc("shopBGCurrencies", new Vector2 (0.5, .97, "%", "%"), new Vector2 (.5, .3, "%", "%x"));
        curr.setAnchor(0.5, .5);

        var style:TextStyle = {
            fill : "white",
            font : "bold 16px arial",
            wordWrap : true
        };
        cont.addText(new Vector2(0.4, 0.93), new Vector2(1, 1), cast element.price, style);
        return cont;
    }

    private function createEntitiesInventoryContainer ():Inventory {
        var container = addContainer(new Vector2(0.75, 1));
        inventory = container.setInventory(new Vector2(0.09, 0.11), new Vector2(0.79, 0.6), new Vector2(0.33, 0.33, "%", "%"), 3, -1);

        inventory.clear();
        inventory.hide();

        return inventory;
    }

    static public function getInstance():Dynamic {
        if(instance == null)return null;
        return instance;
    }
}
