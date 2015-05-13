<?php
    $returnObject = array();

    if ($returnObject["error"] = $player->money->hasEnoughCoins($datas->coins)) {
        if ($returnObject["error"] = $player->money->hasEnoughSuns($datas->suns)) {

            $player->money->lostSun($datas->suns);
            $player->money->lostCoins($datas->coins);

            $returnObject["accepted"] = true;
            $returnObject["error"]    = false;
            $returnObject["suns"]     = $player->money->getNbSuns();
            $returnObject["coins"]    = $player->money->getNbGolds();
        }
        else {
            $returnObject["accepted"] = false;
            $returnObject["reason"]   = "noEnoughtSuns";
        }
    }
    else {
        $returnObject["accepted"] = false;
        $returnObject["reason"]   = "noEnoughtCoins";
    }

    echo json_encode($returnObject);
?>