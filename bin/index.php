<?php
    if (isset($_GET["displayFlower"])) {
        include "displayFlower.php";
    }
    else {
        ini_set("display_errors", 1);
        include "server/connection/bdd.php";
        include "server/Player.php";
        include "server/shop.php";


        // echo "-------------------------------------------------------<br />";

        if (isset($_SESSION["playerID"])) {
            include (isset($_GET["action"])) ? "server/action.php" : "game.html";
        }
        else if (isset($_GET["loghack"])) {
            $_SESSION["playerID"] = $_GET["loghack"];
        }
        else {
            include "matthias.php";
            include "server/connection/player.php";
        }
    }
?>