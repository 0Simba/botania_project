
<?php

function flowerGenomeToName ($genome) {
    $stalk = ["Gîrda",  "Cléopatra", "Dinna",   "Arïa",    "Brogeka"];
    $sheet = ["Sîgrid", "Pépi",      "Dilo",    "Amalïel", "Tarkeni"];
    $head  = ["Sîlke",  "Arsinoé",   "Dimilce", "Elillë",  "Orroke"];

    $letterToInt = array(
        "a" => 0,
        "b" => 1,
        "c" => 2,
        "d" => 3,
        "e" => 4
    );

    $stalkName = $stalk[$letterToInt[substr($genome, 0, 1)]];
    $sheetName = $sheet[$letterToInt[substr($genome, 1, 1)]];
    $headName  = $head[$letterToInt[substr($genome, 2, 2)]];

    return $stalkName . " " . $sheetName . " " . $headName;
}


?>
