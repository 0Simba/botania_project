
<?php

    class Flowers extends PlayerGeneric {

        public $player;

        function __construct ($player) {
            parent::__construct();

            $this->player       = $player;
        }


        function getAll () {
            $id = $this->id;
            $response = $this->db->query("SELECT ID, X, Y, Genome, LastTimeStamp, StateIndex, Attribute1, Attribute2, Attribute3, Attribute4, Bonus1, Bonus2, Bonus3 FROM playersflowers WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $flowers = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($flowers, $data);
                }
                return $flowers;
            }
            return $err;

        }


        function add ($position, $genome) {
            $this->escapePosition($position);

            $ts     = time() * 1000;
            $genome = $this->db->real_escape_string($genome);

            $this->db->query("INSERT INTO playersflowers VALUES (NULL, '$this->id', '$position->x', '$position->y', '$genome', '$ts', 0, 0, 0, 0, 0, false, false, false)");

            return $this->noError();
        }


        function lastId () {
            return $this->db->insert_id;
        }


        function destroy ($position) {
            $response = $this->db->query("DELETE FROM playersflowers " . $this->getWhereForPosition($position));
            if ($err = $this->noError() != true) {
                return $this->noError();
            }
            return ($response == 1);
        }


        function isIt ($position) {
            $response = $this->db->query("SELECT ID FROM playersflowers " . $this->getWhereForPosition($position));

            if (($err = $this->noError()) != true) return $err;

            return ($response->num_rows == 1);
        }


        function grow ($position, $index) {
            if ($index == null) {
                $flower = $this->getFlowerFromPosition($position);
                echo '<br /> <br />';
                print_r($flower);
                $index  = $flower["StateIndex"];
            }
            else {
                $index = $this->db->real_escape_string($index);
            }

            $index     = min($index, 4);
            $timeStamp = time() * 1000;

            $this->db->query("UPDATE playersflowers SET StateIndex = '$index', LastTimeStamp = '$timeStamp'" . $this->getWhereForPosition($position));

            return $this->noError();
        }


        function getFlowerFromPosition ($position) {
            $response = $this->db->query("SELECT * FROM playersflowers " . $this->getWhereForPosition($position));
            return $response->fetch_assoc();
        }
    }
?>
