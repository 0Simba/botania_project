
<?php
    $returnObject = array();

    if (!$player->tileFree($datas->position)) {
        if ($returnObject["error"] = $player->buildings->destroy($datas->position)){
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
