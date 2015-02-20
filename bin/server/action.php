
<?php
    $action   = mysqli_real_escape_string($mysqli, htmlspecialchars($_GET["action"]));
    $datas    = isset($_GET["datas"]) ? urldecode($_GET["datas"]) : "null";
    $playerID = $_SESSION["playerID"];

    if ($action == "test") {
        echo "coucou les copain";
    }
    else if ($action == "buildBreaker") {
        include "server/buildBreaker.php";
    }
?>
