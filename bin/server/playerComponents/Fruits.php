<?php

    class Fruits extends PlayerGeneric {

        public $player;

        function __construct ($player) {
            parent::__construct();
            $this->player = $player;
        }


        function getAll () {
            $id = $this->id;
            $response = $this->db->query("SELECT ID, Genome, Quality FROM playersfruits WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($response->num_rows) {
                $fruits = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($fruits, $data);
                }
                return $fruits;
            }
            return $err;

        }


        function add ($genome, $quality) {
            $genome  = $this->db->real_escape_string($genome);
            $quality = $this->db->real_escape_string($quality);
            $this->db->query("INSERT INTO playersfruits VALUES (NULL, '$this->id', '$genome', '$quality')");
            return $this->noError();
        }


        function remove ($id) {
            $this->db->query("DELETE FROM playersfruits WHERE ID='$id'");
        }
    }
?>