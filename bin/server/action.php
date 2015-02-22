
<?php
    $action   = mysqli_real_escape_string($mysqli, htmlspecialchars($_GET["action"]));
    $datas    = isset($_GET["datas"]) ? json_decode(urldecode($_GET["datas"])) : null;
    $playerID = $_SESSION["playerID"];

    if ($action == "test") {
        echo "coucou les copain";
    }
    else if ($action == "buildBreaker") {
        include "server/buildBreaker.php";
    }
    else if ($action == "destroyBuilding") {
        include "server/destroyBuilding.php";
    }
    else if ($action == "allDatas") {
        include "server/sendAllDatas.php";
    }

?>
