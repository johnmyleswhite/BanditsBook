<?php

function test_algorithm($algo, $arms, $num_sims, $horizon) {
    
    $chosen_arms        = range(0, $num_sims * $horizon - 1);
    $rewards            = range(0, $num_sims * $horizon - 1);
    $cumulative_rewards = range(0, $num_sims * $horizon - 1);
    $sim_nums           = range(0, $num_sims * $horizon - 1);
    $times              = range(0, $num_sims * $horizon - 1);

    foreach (range(0, $num_sims - 1) as $sim) {
        $sim += 1;
        $algo->initialize(count($arms));

        foreach (range(0, $horizon) as $t) {
            $t += 1;
            $index = ($sim - 1) * $horizon + $t - 1;
            $sim_nums[$index] = $sim;
            $times[$index] = $t;

            $chosen_arm = $algo->selectArm();
            $chosen_arms[$index] = $chosen_arm;

            $reward = $arms[$chosen_arms[$index]]->draw();
            $rewards[$index] = $reward;

            if ($t === 1) {
                $cumulative_rewards[$index] = $reward;
            } else {
                $cumulative_rewards[$index] = $cumulative_rewards[$index - 1] + $reward;
            }

            $algo->update($chosen_arm, $reward);
        }
    }

    return [$sim_nums, $times, $chosen_arms, $rewards, $cumulative_rewards];
}

?>
