<?php

    class Money extends PlayerGeneric {

        public $player;

        function __construct ($player) {
            parent::__construct();
            $this->player = $player;
        }


        function hasEnoughCoins ($price) {
            return $price <= $this->player->getDatas()[0]["Gold"];
        }


        function hasEnoughSuns ($price) {
            return $price <= $this->player->getDatas()[0]["Sun"];
        }


        function getNbSuns () {
            return $this->player->getDatas()[0]["Sun"];
        }

        function lostSun ($price) {
            $sun      = $this->player->getDatas()[0]["Sun"] - $price;
            $response = $this->db->query("UPDATE players SET Sun = '$sun' WHERE ID = '$this->id'");

            return $this->noError();
        }

    }
?>