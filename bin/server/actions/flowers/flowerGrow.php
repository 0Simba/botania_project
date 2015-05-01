<?php
    $returnObject = array();

    if ($player->isFlower($datas->position)) {
        if ($returnObject["error"] = $player->growFlower($datas->position, $datas->stateIndex)){
            $returnObject["accepted"] = true;
            $returnObject["error"]    = false;
        }
        else {
            $returnObject["accepted"] = false;
        }
    }
    else {
        $returnObject["accepted"] = false;
    }
    echo json_encode($returnObject);
?>
