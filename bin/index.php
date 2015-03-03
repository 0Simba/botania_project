<?php
    ini_set("display_errors", 1);
    include "server/connection/bdd.php";
    include "server/Player.php";
    // include "matthias.php";


    // echo "Abandon... log id ici";
    // echo "print_r($graphObject->id)"

    if (isset($_SESSION["playerID"])) {
        include (isset($_GET["action"])) ? "server/action.php" : "game.html";
    }
    else if (isset($_POST["ID"])) {
        include "server/connection/player.php";
    }
    else {
        include "connection.html";
    }
?>