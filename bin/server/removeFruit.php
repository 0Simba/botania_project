<?php
    $returnObject = array();

    $player->removeFruit($datas->id);
    $returnObject["accepted"] = true;
    $returnObject["error"]    = false;

    echo json_encode($returnObject);
?>