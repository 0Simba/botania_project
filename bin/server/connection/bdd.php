<?php
session_start();

$config = [
    "host"     => "localhost",
    "user"     => "root",
    "password" => "",
    "database" => "botania",
];

$mysqli = new mysqli($config["host"],
                     $config["user"],
                     $config["password"],
                     $config["database"]);

?>