
<?php
    $action   = mysqli_real_escape_string($mysqli, htmlspecialchars($_GET["action"]));
    $datas    = isset($_GET["datas"]) ? json_decode(urldecode($_GET["datas"])) : null;
    $player   = new Player ($_SESSION["playerID"]);



    if      ($action == "buildBreaker")    include "server/buildBreaker.php";
    else if ($action == "buildFlower")     include "server/buildFlower.php";
    else if ($action == "destroyBuilding") include "server/destroyBuilding.php";
    else if ($action == "allDatas")        include "server/sendAllDatas.php";

?>
