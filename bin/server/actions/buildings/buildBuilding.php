
<?php
    $returnObject = array();

    if ($player->tileFree($datas->position)) {
        if ($returnObject["error"] = $player->buildings->add($datas->position, $datas->type)){
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
