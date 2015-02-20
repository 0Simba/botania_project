<?php
session_start();

$config = array(
    "host"     => "localhost",
    "user"     => "root",
    "password" => "",
    "database" => "botania",
);

if (file_exists("server/config.php")) include "server/config.php";

$mysqli = new mysqli($config["host"],
                     $config["user"],
                     $config["password"],
                     $config["database"]);

?>