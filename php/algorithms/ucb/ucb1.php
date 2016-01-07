<?php

class UCB1 {

    private $counts;
    private $values;
    
    public function __construct($counts, $values) {
        $this->counts = $counts;
        $this->values = $values;
    }

    public function initialize($n_arms) {
        $this->counts = $this->__init_counts($n_arms);
        $this->values = $this->__init_values($n_arms);
    }

    public function selectArm() {
        $n_arms = count($this->counts);

        # play each arm once
        foreach (range(0, $n_arms - 1) as $arm) {
            if ($this->counts[$arm] === 0) {
                return $arm;
            }
        }

        $ucb_values = $this->__init_values($n_arms);
        $total_counts = array_sum($this->counts);

        foreach (range(0, $n_arms - 1) as $arm) {
            $bonus = sqrt((2.0 * log($total_counts)) / (float) $this->counts[$arm]);
            $ucb_values[$arm] = $this->values[$arm] + $bonus;
        }

        return array_keys($ucb_values, max($ucb_values))[0];
    }

    public function update($chosen_arm, $reward) {
        $this->counts[$chosen_arm] += 1;
        $n = $this->counts[$chosen_arm];
        $value = $this->values[$chosen_arm];
        $new_value = (($n - 1.0) / (float) $n) * $value + (1.0 / (float) $n) * $reward;
        $this->values[$chosen_arm] = $new_value;
    }

    private function __init_counts($n_arms) {
        return array_map(
            function () { return 0; },
            range(0, $n_arms - 1)
        );
    }

    private function __init_values($n_arms) {
        return array_map(
            function () { return (float) 0; },
            range(0, $n_arms - 1)
        );
    }
}

?>
