
<?php
    $action = mysqli_real_escape_string($mysqli, htmlspecialchars($_GET["action"]));
    $datas  = isset($_GET["datas"]) ? urldecode($_GET["datas"]) : "null";

    if ($action == "test") {
        echo "coucou les copain";
    }
    else if ($action == "buildBreaker") {
        echo $datas;
    }
?>
