
<?php
    $returnObject = array();

    if ($player->tileFree($datas->position)) {
        if ($returnObject["error"] = $player->flowers->add($datas->position, $datas->genome)) {
            $returnObject["flowerId"] = $player->flowers->lastId();
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
