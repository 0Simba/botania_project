package manager;

import engine.events.Events; 
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Button;
import engine.popUpEngine.PopUpEngineMain;


class FTUEController
{

    static private var instance:FTUEController;
    private var isoEvents:Events;
    private var popUpEvents:Events;
    private var gameState:Int = 0;
    private var breakerGameState:Int = 0;
    private var product:Bool = false;
    
    
    private function new () {
        instance    = this;
        var a = IsoEngine.getInstance();
        isoEvents   = a.events;
        var b = PopUpEngineMain.getInstance();
        popUpEvents = b.events;

        popUpEvents.on("close", function (popUpName:String) {
            if (gameState == 0 && popUpName == "ftuePopUp") {
                entities.popUps.FtuePopUp.setTitleAndShow("Je vous propose de planter votre premiere fleure. Pour ce faire, ouvrez votre inventaire (Icone Coffre)");
                gameState ++;
            }
            if (gameState == 6 && popUpName == "openFruit") {
                entities.popUps.FtuePopUp.setTitleAndShow("Vous avez ouvers votre fruit ! Bien jouer. 
                    Maintenant vous pouvez couper votre fleure afin de gagner un peu d'argent.");
                gameState ++;
            }
            if (gameState == 2 && popUpName == "inventoryInterface") {
                entities.popUps.FtuePopUp.setTitleAndShow("Bien maintenant, plantez la graine sur votre terrain.");
                gameState ++;
            }

        });
        popUpEvents.on("inventory", function (popUpName:String) {
            if (gameState == 1) {
                entities.popUps.FtuePopUp.setTitleAndShow("Bien selectionnez la graine que vous voulez plantez.");
                gameState ++;
            }
            if (gameState >= 4 && breakerGameState == 0) {
                entities.popUps.FtuePopUp.setTitleAndShow("Cliquez sur le bouton batiment, puis sélectionnez votre concasseur.");
                breakerGameState ++;
            }

        });
        popUpEvents.on("open", function (popUpName:String) {
            if (gameState >= 4 && popUpName == "breaker" && breakerGameState == 2) {
                entities.popUps.FtuePopUp.setTitleAndShow("Tres bien, vous pouvez ici selectionnez deux graines afin de les mélanger et de trouver une graine unique pour une nouvelle plante.");
                breakerGameState ++;
            }
            if (popUpName == "product" && !product) {
                entities.popUps.FtuePopUp.setTitleAndShow("Ici vous pouvez choisir un produit pour amméliorer un composant d'une graine, les composant sont représenter par la forme, la couleur ou le motif de la graine, les produits ont les memes codes.");
                product = true;
            }

        });
        isoEvents.on("builded", function (popUpName:String) {
            if (gameState >= 4 && breakerGameState == 1 && popUpName == "breaker") {
                entities.popUps.FtuePopUp.setTitleAndShow("C'est excellant, vous avez construit votre concasseur ! entrez dedans que nous voyons ensemble la creation de graines.");
                breakerGameState ++;
            }
        });
        isoEvents.on("bloom", function (popUpName:String) {
            if (gameState == 4) {
                entities.popUps.FtuePopUp.setTitleAndShow("Votre fleure a produit un fruit ! 
                    Vous pouvez le voir aux rayon de lumiere qu'elle fais. 
                    Pour récolter le fruit, cliquez sur la fleure puis sur le bouton récoler (icone de main)");
                gameState ++;
            }

        });
        isoEvents.on("plant", function (popUpName:String) {
            if (gameState == 3) {
                entities.popUps.FtuePopUp.setTitleAndShow("Votre fleure est plantée !
                    vous pouvez soit attendre que le fruit pousse ou l'arroser jusqu'a ce qu'elle soit mature.
                    Attention arroser une plante vous coute des soleils.
                    Vous pouvez aussi contruire un Concasseur pour que nous voyons une autre partie de vos possibilité. Ouvrez votre inventaire pour ceci.");
                gameState ++;
            }

        });
        isoEvents.on("harvested", function (popUpName:String) {
            if (gameState == 5) {
                entities.popUps.FtuePopUp.setTitleAndShow("Vous avez récoler votre premier fruit, aller donc découvrir les graines qu'il contient !
                    Pour ce faire ouvrez votre inventaire et aller chercher les fruit. Puis cliquez sur votre fruit pour l'ouvrir.");
                gameState ++;
            }

        });
    }
    
    
    static public function getInstance () {
        if (instance != null) {
            return instance;
        }
        else {
            return new FTUEController(); 
        }
    }

     
    


    
}