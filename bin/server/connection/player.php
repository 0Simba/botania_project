<?php

$id = mysqli_real_escape_string($mysqli, htmlspecialchars($_POST["ID"]));

$request = $mysqli->query("SELECT id FROM players WHERE IDFacebook = '$id'");
$data    = $request->fetch_assoc();

if (isset($data["id"])) {
    $_SESSION["playerID"] = $data["id"];
    include "index.html";
}
else {
    echo "Pas d'id facebook sous ce numéro";
    include "connection.html";
}

?>