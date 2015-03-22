package manager.circlesHud.ecosystemBuildings;

import engine.popUpEngine.PopUpEngineMain;

class ButterflyTree extends manager.circlesHud.EcosystemBuilding
{
    public function new (name:String) {
        super(name);
        managedHud.addOnce("sevePlus" , "ecoSevePlus" + prodLvl, upgradeProduction);
    }

    public function upgradeProduction(target:entities.Building){
        if(prodLvl == 3)return;
        prodLvl++;
        managedHud.elements.get("sevePlus").hudButton.changeTexture("ecoSevePlus" + prodLvl);
    }
}
