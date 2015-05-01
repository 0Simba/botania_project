<?php
    $returnObject = array();

    if ($returnObject["error"] = $player->fruits->add($datas->genome, $datas->quality)) {
        $returnObject["accepted"] = true;
        $returnObject["error"]    = false;
    }
    else {
        $returnObject["accepted"] = false;
    }

    echo json_encode($returnObject);
?>