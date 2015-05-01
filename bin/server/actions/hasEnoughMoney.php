<?php
	$returnObject = array();
	if ($returnObject["error"] = $player->hasEnoughCoins($datas)) {
        $returnObject["accepted"] = true;
        $returnObject["error"]    = false;
    }
    else {
        $returnObject["accepted"] = false;
    }
    echo json_encode($returnObject);
?>