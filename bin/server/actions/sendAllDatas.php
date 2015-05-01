<?php
    $returnObject = array();
    $returnObject['serverTimeStamp'] = time() * 1000;
    $returnObject['buildings'] = $player->buildings->getAll();
    $returnObject['flowers']   = $player->flowers->getAll();
    $returnObject['seeds']     = $player->seeds->getAll();
    $returnObject['fruits']    = $player->fruits->getAll();
    $returnObject['datas']     = $player->getDatas();
    $returnObject['accepted']  = true;
    echo json_encode($returnObject);
?>