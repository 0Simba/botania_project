package init;

/*import engine.circleHud.CirclesHudEngine;
import utils.Vector2;
import manager.Map;
import entities.genetic.Genome;
import entities.popUps.HeaderPopUp;*/
import entities.popUps.ShopPopUp;

class ShopDatas
{
    static public var buildings:Dynamic;
    static public var gold:Int;
    static public function load () {
        utils.AjaxRequest.exec("shopDatas", null, callback);
    }

    static public function callback (response:Dynamic) {
    	buildings = response.buildings;
        ShopPopUp.getInstance().updateBuildingInventory();
    }

    static public function getBuildingByName (name:String):Dynamic {
    	for(i in 0...buildings.length){
    		var b = buildings[i];
    		if(b.texture == name){
    			return b;
    		}
    	}
    	return {};
    }
}