
<?php
    include "PlayerGeneric.php";
    include "playerComponents/Seeds.php";
    include "playerComponents/Fruits.php";
    include "playerComponents/Buildings.php";

    class Player extends PlayerGeneric {

        public $seeds;
        public $fruits;

        function __construct () {
            parent::__construct();
            $this->seeds     = new Seeds($this);
            $this->fruits    = new Fruits($this);
            $this->buildings = new Buildings($this);
        }


        function getDatas(){
            $id = $this->id;
            $response = $this->db->query("SELECT * FROM players WHERE ID = '$id'");

            if ($err = $this->noError() && $response->num_rows) {
                $datas = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($datas, $data);
                }
                return $datas;
            }
            return $err;
        }





        /*===============================
        =            Flowers            =
        ===============================*/

        function getFlowers () {
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


        function addFlower ($position, $genome) {
            $this->escapePosition($position);
            $ts = time() * 1000;

            $this->db->query("INSERT INTO playersflowers VALUES (NULL, '$this->id', '$position->x', '$position->y', '$genome', '$ts', 0, 0, 0, 0, 0, false, false, false)");

            return $this->noError();
        }


        function lastFlowerId () {
            return $this->db->insert_id;
        }


        function destroyFlower ($position) {
            $response = $this->db->query("DELETE FROM playersflowers " . $this->getWhereForPosition($position));
            if ($err = $this->noError() != true) {
                return $this->noError();
            }
            return ($response == 1);
        }


        function isFlower ($position) {
            $response = $this->db->query("SELECT ID FROM playersflowers " . $this->getWhereForPosition($position));

            if (($err = $this->noError()) != true) return $err;

            return ($response->num_rows == 1);
        }


        function growFlower ($position, $index) {
            if ($index >= 5) return "Impossible state index";
            $timeStamp = time() * 1000;

            $this->db->query("UPDATE playersflowers SET StateIndex = '$index', LastTimeStamp = '$timeStamp'" . $this->getWhereForPosition($position));

            return $this->noError();
        }



        /*=============================
        =            Money            =
        =============================*/

        function hasEnoughCoins($price){
            return $price <= $this->getDatas()[0]["Gold"];
        }
    }
?>
