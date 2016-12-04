<?php

class UCB2 {
    
    private $alpha;
    private $counts;
    private $values;
    private $r;
    private $current_arm;
    private $next_update;

    public function __construct($alpha, $counts, $values) {
        $this->alpha = $alpha;
        $this->counts = $counts;
        $this->values = $values;
        $this->current_arm = 0;
        $this->next_update = 0;
    }

    public function initialize($n_arms) {
        $this->counts = $this->__init_counts($n_arms);
        $this->values = $this->__init_values($n_arms);
        $this->r = array_map(
            function () { return 0; },
            range(0, $n_arms - 1)
        );
        $this->current_arm = 0;
        $this->next_update = 0;
    }

    public function selectArm() {
        $n_arms = count($this->counts);

        # play each arm once
        foreach (range(0, $n_arms - 1) as $arm) {
            if ($this->counts[$arm] === 0) {
                $this->__set_arm($arm);
                return $arm;
            }
        }

        # make sure we aren't still playing the previous arm.
        if ($this->next_update > array_sum($this->counts)) {
            return $this->current_arm;
        }

        $ucb_values = $this->__init_values($n_arms);
        $total_counts = array_sum($this->counts);

        foreach (range(0, $n_arms - 1) as $arm) {
            $bonus = $this->__bonus($total_counts, $this->r[$arm]);
            $ucb_values[$arm] = $this->values[$arm] + $bonus;
        }

        $chosen_arm = array_keys($ucb_values, max($ucb_values))[0];
        $this->__set_arm($chosen_arm);
        return $chosen_arm;
    }

    public function update($chosen_arm, $reward) {
        $this->counts[$chosen_arm] += 1;
        $n = $this->counts[$chosen_arm];
        $value = $this->values[$chosen_arm];
        $new_value = (($n - 1.0) / (float) $n) * $value + (1.0 / (float) $n) * $reward;
        $this->values[$chosen_arm] = $new_value;
    }

    private function __bonus($n, $r) {
        $tau = $this->__tau($r);
        $bonus = sqrt((1.0 + $this->alpha) * log(exp(1.0) * (float) $n / $tau) / (2.0 * $tau));
        return $bonus;
    }

    private function __tau($r) {
        return (int) ceil(pow(1.0 + $this->alpha, $r));
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

    private function __set_arm($arm) {
        # When choosing a new arm, make sure we play that arm for
        # tau(r+1) - tau(r) episodes.
        $this->current_arm = $arm;
        $this->next_update += max(1.0, $this->__tau($this->r[$arm] + 1.0) - $this->__tau($this->r[$arm]));
        $this->r[$arm] += 1;
    }
}

?>
