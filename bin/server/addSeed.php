
<?php
    $returnObject = array();

    if ($returnObject["error"] = $player->addSeed($datas->genome, $datas->level)) {
        $returnObject["accepted"] = true;
        $returnObject["error"]    = false;
    }
    else {
        $returnObject["accepted"] = false;
    }

    echo json_encode($returnObject);
?>