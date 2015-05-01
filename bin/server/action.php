
<?php
    $action   = mysqli_real_escape_string($mysqli, htmlspecialchars($_GET["action"]));
    $datas    = isset($_GET["datas"]) ? json_decode(urldecode($_GET["datas"])) : null;
    $player   = new Player ();
    $shop   = new Shop ();



    if      ($action == "buildBuilding")   include "server/actions/buildings/buildBuilding.php";
    else if ($action == "destroyBuilding") include "server/actions/buildings/destroyBuilding.php";

    else if ($action == "addSeed")         include "server/actions/seeds/addSeed.php";
    else if ($action == "removeSeed")      include "server/actions/seeds/removeSeed.php";

    else if ($action == "addFruit")        include "server/actions/fruits/addFruit.php";
    else if ($action == "removeFruit")     include "server/actions/fruits/removeFruit.php";


    else if ($action == "buildFlower")     include "server/actions/flowers/buildFlower.php";
    else if ($action == "flowerGrow")      include "server/actions/flowers/flowerGrow.php";
    else if ($action == "destroyFlower")   include "server/actions/flowers/destroyFlower.php";

    else if ($action == "allDatas")        include "server/actions/sendAllDatas.php";
    else if ($action == "shopDatas")       include "server/actions/shopDatas.php";
    else if ($action == "hasEnoughMoney")  include "server/actions/hasEnoughMoney.php";


?>
