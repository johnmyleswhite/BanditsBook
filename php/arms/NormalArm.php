<?php

require_once '/helpers/random.php';

class NormalArm {

    private $mu;
    private $sigma;
    
    public function __construct($mu, $sigma) {
        $this->mu = $mu;
        $this->sigma = $sigma;
    }

    public function __destruct() {}

    public function draw () {
        return random_gauss($this->mu, $this->sigma);
    }
}

?>
