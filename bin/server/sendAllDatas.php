<?php
    $returnObject = array();
    $returnObject['serverTimeStamp'] = time();
    $returnObject['buildings'] = $player->getBuidings();
    $returnObject['flowers']   = $player->getFlowers();
    $returnObject['accepted']  = true;
    echo json_encode($returnObject);
?>