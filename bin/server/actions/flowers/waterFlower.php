<?php
    $returnObject = array();
    $flowerConfig = json_decode(file_get_contents("./assets/config/json/flower.json"));

    if ($player->flowers->isIt($datas->position)) {
        if ($player->money->hasEnoughSuns($flowerConfig->waterSuns)) {
            if ($returnObject["error"] = $player->flowers->grow($datas->position, null)) {
                $returnObject["accepted"] = true;
                $returnObject["error"]    = false;
            }
            else {
                $returnObject["accepted"] = false;
            }
        }
        else {
            $returnObject["accepted"] = false;
            $returnObject["reason"]   = "noEnoughtSuns";
        }
    }
    else {
        $returnObject["accepted"] = false;
    }
    echo json_encode($returnObject);
?>
