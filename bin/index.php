<?php
    include "server/log.php";
    include "server/connection/bdd.php";
    include "server/Player.php";
    // include "matthias.php";


    // echo "Abandon... log id ici";
    // echo "print_r($graphObject->id)"


    if (isset($_SESSION["playerID"])) {
        logMessage("Connexion avec ID : " . $_SESSION["playerID"]);
        include (isset($_GET["action"])) ? "server/action.php" : "game.html";
    }
    else if (isset($_POST["ID"])) {
        logMessage("Reception de connexion " . $_POST["ID"] . "...");
        include "server/connection/player.php";
    }
    else {
        logMessage("Demande de connexion...");
        include "connection.html";
    }
?>