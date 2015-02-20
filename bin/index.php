<?php
    include "server/connection/bdd.php";
    include "server/utils.php";


    if (isset($_SESSION["playerID"])) {
        include (isset($_GET["action"])) ? "server/action.php" : "index.html";
    }
    else if (isset($_POST["ID"])) {
        include "server/connection/player.php";
    }
    else {
        include "connection.html";
    }
?>
