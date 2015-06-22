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
                entities.popUps.FtuePopUp.setTitleAndShow("Je vous propose de planter votre premiere fleur. Pour ce faire, ouvrez votre inventaire (Icône Coffre)");
                gameState ++;
            }
            if (gameState == 6 && popUpName == "openFruit") {
                entities.popUps.FtuePopUp.setTitleAndShow("Vous avez ouvert votre fruit ! Bien jouer.
                    Maintenant vous pouvez couper votre fleur afin de gagner un peu d'argent.");
                gameState ++;
            }
            if (gameState == 2 && popUpName == "inventoryInterface") {
                entities.popUps.FtuePopUp.setTitleAndShow("Bien maintenant, plantez la graine sur votre terrain.");
                gameState ++;
            }

        });
        popUpEvents.on("inventory", function (popUpName:String) {
            if (gameState == 1) {
                entities.popUps.FtuePopUp.setTitleAndShow("Bien ! Sélectionnez la graine que vous voulez planter.");
                gameState ++;
            }
            if (gameState >= 4 && breakerGameState == 0) {
                entities.popUps.FtuePopUp.setTitleAndShow("Cliquez sur le bouton bâtiment, puis sélectionnez votre concasseur.");
                breakerGameState ++;
            }

        });
        popUpEvents.on("open", function (popUpName:String) {
            if (gameState >= 4 && popUpName == "breaker" && breakerGameState == 2) {
                entities.popUps.FtuePopUp.setTitleAndShow("Tres bien, vous pouvez ici selectionner deux graines afin de les mélanger et de trouver une graine unique pour une nouvelle plante.");
                breakerGameState ++;
            }
            if (popUpName == "product" && !product) {
                entities.popUps.FtuePopUp.setTitleAndShow("Ici vous pouvez choisir un produit pour améliorer un composant d'une graine, les composant sont représenté par la forme, la couleur ou le motif de la graine, les produits ont les mêmes codes.");
                product = true;
            }

        });
        isoEvents.on("builded", function (popUpName:String) {
            if (gameState >= 4 && breakerGameState == 1 && popUpName == "breaker") {
                entities.popUps.FtuePopUp.setTitleAndShow("C'est excellent, vous avez construit votre concasseur ! entrez dedans que nous voyons ensemble la création de graines.");
                breakerGameState ++;
            }
        });
        isoEvents.on("bloom", function (popUpName:String) {
            if (gameState == 4) {
                entities.popUps.FtuePopUp.setTitleAndShow("Votre fleur a produit un fruit !
                    Vous pouvez le voir aux rayons de lumière qu'elle fait.
                    Pour récolter le fruit, cliquez sur la fleur puis sur le bouton récoler (icone de main)");
                gameState ++;
            }

        });
        isoEvents.on("plant", function (popUpName:String) {
            if (gameState == 3) {
                entities.popUps.FtuePopUp.setTitleAndShow("Votre fleur est plantée !
                    vous pouvez soit attendre que le fruit pousse ou l'arroser jusqu'à ce qu'elle soit mature.
                    Attention arroser une plante vous coute des soleils.
                    Vous pouvez aussi construire un concasseur pour que nous voyons une autre partie de vos possibilités. Ouvrez votre inventaire pour ceci.");
                gameState ++;
            }

        });
        isoEvents.on("harvested", function (popUpName:String) {
            if (gameState == 5) {
                entities.popUps.FtuePopUp.setTitleAndShow("Vous avez récolté votre premier fruit, aller donc découvrir les graines qu'il contient !
                    Pour ce faire ouvrez votre inventaire et aller chercher les fruits. Puis cliquez sur votre fruit pour l'ouvrir.");
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