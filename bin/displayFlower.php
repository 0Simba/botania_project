<?php
    include "server/flowerGenomeToName.php";
    $genome     = $_GET["displayFlower"];
    $flowerName = flowerGenomeToName($genome);
?>

<html>
<head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# botania: http://ogp.me/ns/fb/botania#">
  <meta property="fb:app_id" content="1406243513020941" />
  <meta property="og:type"   content="botania:flower" />
  <meta property="og:title"  content="Get <?=$flowerName?>" />
  <meta property="og:url"    content="https://fbgame.isartdigital.com/isartdigital/botaniaproject/bin/index.php?displayFlower=<?=$genome?>" />
  <meta property="og:image"  content="https://fbgame.isartdigital.com/isartdigital/botaniaproject/bin/assets/allFlowers/flower<?=$genome?>.png" />
    <title></title>
</head>
<body>

<!-- 600px * 600px -->
</body>
</html>