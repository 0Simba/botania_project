
<?php
    $action = mysqli_real_escape_string($mysqli, htmlspecialchars($_GET["action"]));

    if ($action == "test") {
        echo "coucou les copain";
    }
?>
