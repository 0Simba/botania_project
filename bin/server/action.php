
<?php
    $action   = mysqli_real_escape_string($mysqli, htmlspecialchars($_GET["action"]));
    $datas    = isset($_GET["datas"]) ? json_decode(urldecode($_GET["datas"])) : null;
    $player   = new Player ();
    $shop   = new Shop ();



    if      ($action == "buildBuilding")   include "server/buildBuilding.php";
    else if ($action == "buildFlower")     include "server/buildFlower.php";
    else if ($action == "flowerGrow")      include "server/flowerGrow.php";
    else if ($action == "destroyBuilding") include "server/destroyBuilding.php";
    else if ($action == "destroyFlower")   include "server/destroyFlower.php";
    else if ($action == "allDatas")        include "server/sendAllDatas.php";
    else if ($action == "addSeed")         include "server/addSeed.php";
    else if ($action == "removeSeed")      include "server/removeSeed.php";
    else if ($action == "addFruit")        include "server/addFruit.php";
    else if ($action == "removeFruit")     include "server/removeFruit.php";
    else if ($action == "shopDatas")       include "server/shopDatas.php";
	else if ($action == "hasEnoughMoney")  include "server/hasEnoughMoney.php";
?>
