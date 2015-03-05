<?php
    $returnObject = array();
    $returnObject['serverTimeStamp'] = time() * 1000;
    $returnObject['buildings'] = $player->getBuidings();
    $returnObject['flowers']   = $player->getFlowers();
    $returnObject['accepted']  = true;
    echo json_encode($returnObject);
?>