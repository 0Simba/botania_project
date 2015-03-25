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
    $id    = $mysqli->insert_id;
    $level = 1;

    $genome = "AAA#1"; $mysqli->query("INSERT INTO playersseeds VALUES (NULL, '$id', '$genome', '$level')");
    $genome = "AAA#1"; $mysqli->query("INSERT INTO playersseeds VALUES (NULL, '$id', '$genome', '$level')");
    $genome = "AAB#1"; $mysqli->query("INSERT INTO playersseeds VALUES (NULL, '$id', '$genome', '$level')");
    $genome = "AAD#1"; $mysqli->query("INSERT INTO playersseeds VALUES (NULL, '$id', '$genome', '$level')");
    $genome = "ABA#1"; $mysqli->query("INSERT INTO playersseeds VALUES (NULL, '$id', '$genome', '$level')");
    echo $mysqli->error;

    $_SESSION["playerID"] = $data["id"];
}
include "game.html";

?>