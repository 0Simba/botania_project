<?php

// $id = mysqli_real_escape_string($mysqli, htmlspecialchars($_POST["ID"]));
$id = $graphObject->getId();


$request = $mysqli->query("SELECT id FROM players WHERE IDFacebook = '$id'");
$data    = $request->fetch_assoc();


if (isset($data["id"])) {
    $_SESSION["playerID"] = $data["id"];
}
else {
    $mysqli->query("INSERT INTO players VALUES (NULL, '$id', '', '', '', '', '', '', '', '')");
    echo $mysqli->error;

    $_SESSION["playerID"] = $data["id"];
}
include "game.html";

?>