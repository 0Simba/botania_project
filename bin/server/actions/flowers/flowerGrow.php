<?php
    $returnObject = array();

    if ($player->flowers->isIt($datas->position)) {
        if ($returnObject["error"] = $player->flowers->grow($datas->position, $datas->stateIndex)){
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
