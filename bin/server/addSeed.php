
<?php
    $returnObject = array();

    $res = $player->addSeed($datas->genome, $datas->level);
    $returnObject["accepted"] = true;
    $returnObject["error"]    = false;
    $returnObject["seedId"]   = $res;

    echo json_encode($returnObject);
?>