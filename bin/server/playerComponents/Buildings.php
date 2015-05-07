<?php

    class Buildings extends PlayerGeneric {

        public $player;

        function __construct ($player) {
            parent::__construct();
            $this->player = $player;
        }

        function getBuildingPrice ($name) {
            $id   = $this->id;
            $name = $this->db->real_escape_string($name);

            $response = $this->db->query("SELECT price FROM typebuildings WHERE texture = '$name'");
            if ($err = $this->noError() && $response->num_rows) {
                //$data = $response->fetch_array(MYSQL_ASSOC)[0]["price"];
                $datas = $response->fetch_array(MYSQL_ASSOC);
                return $datas["price"];
            }
            return $err;
        }

        function add ($position, $type) {
            $this->escapePosition($position);
            $type = $this->db->real_escape_string($type);

            $this->db->query("INSERT INTO playersbuildings VALUES (NULL, '$this->id', '$type', '$position->x', '$position->y', '', '', '', '', '', '')");

            return $this->noError();
        }

        function destroy ($position) {
            $response = $this->db->query("DELETE FROM playersbuildings " . $this->getWhereForPosition($position));
            if ($err = $this->noError() != true) {
                return $this->noError();
            }
            return ($response == 1);
        }


        function getAll () {
            $id = $this->id;
            $response = $this->db->query("SELECT Type, X, Y, Attribute1, Attribute2, Attribute3, Attribute1Lvl, Attribute2Lvl, Attribute3Lvl FROM playersbuildings WHERE PlayerID = '$id'");

            echo ($this->db->error);
            if ($response->num_rows) {
                $buildings = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($buildings, $data);
                }
                return $buildings;
            }
            else {
                return null;
            }
        }
    }
?>