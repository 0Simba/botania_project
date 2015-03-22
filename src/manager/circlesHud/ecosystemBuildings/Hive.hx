package manager.circlesHud.ecosystemBuildings;

import engine.popUpEngine.PopUpEngineMain;

class Hive extends manager.circlesHud.EcosystemBuilding
{
public function new (name:String) {
        super(name);
        managedHud.addOnce("honeyPlus", "ecoHoneyPlus" + prodLvl, upgradeProduction);
    }

    public function upgradeProduction(target:entities.Building){
        if(prodLvl == 3)return;
        prodLvl++;
        managedHud.elements.get("honeyPlus").hudButton.changeTexture("ecoHoneyPlus" + prodLvl);
    }
}