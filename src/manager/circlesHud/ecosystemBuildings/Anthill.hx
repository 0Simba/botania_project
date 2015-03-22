package manager.circlesHud.ecosystemBuildings;

import engine.popUpEngine.PopUpEngineMain;

class Anthill extends manager.circlesHud.EcosystemBuilding
{
    public function new (name:String) {
        super(name);
        managedHud.addOnce("propolisPlus" , "ecoPropolisPlus" + prodLvl, upgradeProduction);
    }

    public function upgradeProduction(target:entities.Building){
    	if(prodLvl == 3)return;
        prodLvl++;
        managedHud.elements.get("propolisPlus").hudButton.changeTexture("ecoPropolisPlus" + prodLvl);
    }
}
