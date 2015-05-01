<?php

    class Seeds extends PlayerGeneric {

        public $player;

        function __construct ($player) {
            parent::__construct();
            $this->player = $player;
        }

        function add ($genome, $level) {
            $query = "INSERT INTO playersseeds VALUES (NULL, '$this->id', '$genome', '$level')";
            $this->db->query($query);
            return $this->db->insert_id;
        }


        function remove ($id) {
            $this->db->query("DELETE FROM playersseeds WHERE ID='$id'");

        }


        function getAll () {
            $id = $this->id;
            $response = $this->db->query("SELECT ID, Genome, Level FROM playersseeds WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($response->num_rows) {
                $seeds = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($seeds, $data);
                }
                return $seeds;
            }
        }
    }
?>