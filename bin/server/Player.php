
<?php
    include "PlayerGeneric.php";
    include "playerComponents/Seeds.php";
    include "playerComponents/Fruits.php";
    include "playerComponents/Buildings.php";
    include "playerComponents/Flowers.php";


    class Player extends PlayerGeneric {

        public $seeds;
        public $fruits;
        public $buildings;
        public $flowers;

        function __construct () {
            parent::__construct();
            $this->seeds     = new Seeds($this);
            $this->fruits    = new Fruits($this);
            $this->buildings = new Buildings($this);
            $this->flowers   = new Flowers($this);
        }


        function getDatas () {
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




        /*=============================
        =            Money            =
        =============================*/

        function hasEnoughCoins($price){
            return $price <= $this->getDatas()[0]["Gold"];
        }
    }
?>
