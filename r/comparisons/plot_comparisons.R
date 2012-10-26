library("plyr")
library("ggplot2")

annealing.results <- read.csv("julia/algorithms/epsilon_greedy/annealing_results.csv", header = FALSE)
names(annealing.results) <- c("Sim", "T", "ChosenArm", "Reward", "CumulativeReward")
annealing.results <- transform(annealing.results, Algorithm = "Annealing epsilon-Greedy")

epsilon.results <- read.csv("julia/algorithms/epsilon_greedy/standard_results.csv", header = FALSE)
names(epsilon.results) <- c("Epsilon", "Sim", "T", "ChosenArm", "Reward", "CumulativeReward")
epsilon.results <- transform(epsilon.results, Algorithm = paste(Epsilon, "-Greedy", sep = ""))
epsilon.results <- epsilon.results[, c("Sim", "T", "ChosenArm", "Reward", "CumulativeReward", "Algorithm")]

ucb1.results <- read.csv("julia/algorithms/ucb/ucb1_results.csv", header = FALSE)
names(ucb1.results) <- c("Sim", "T", "ChosenArm", "Reward", "CumulativeReward")
ucb1.results <- transform(ucb1.results, Algorithm = "UCB1")

# Annealing Softmax
annealing.softmax.results <- read.csv("julia/algorithms/softmax/annealing_softmax_results.csv", header = FALSE)
names(annealing.softmax.results) <- c("Sim", "T", "ChosenArm", "Reward", "CumulativeReward")
annealing.softmax.results <- transform(annealing.softmax.results, Algorithm = "Annealing Softmax")

# Softmax

# Exp3
exp3.results <- read.csv("julia/algorithms/exp3/exp3_results.csv", header = FALSE)
names(exp3.results) <- c("Gamma", "Sim", "T", "ChosenArm", "Reward", "CumulativeReward")
exp3.results <- transform(exp3.results, Algorithm = paste(Gamma, "-Exp3", sep = ""))
exp3.results <- exp3.results[, c("Sim", "T", "ChosenArm", "Reward", "CumulativeReward", "Algorithm")]

#results <- rbind(annealing.results, epsilon.results, ucb1.results, annealing.softmax.results, softmax.results, exp3.results)
results <- rbind(annealing.results, ucb1.results, annealing.softmax.results, exp3.results)

# Only keep 0.1 and 0.5 epsilon-Greedy and Exp3

# Plot average reward as a function of time.
stats <- ddply(results,
               c("Algorithm", "T"),
               function (df) {mean(df$Reward)})
ggplot(stats, aes(x = T, y = V1, group = Algorithm, color = Algorithm)) +
  geom_line() +
  ylim(0, 1) +
  xlab("Time") +
  ylab("Average Reward") +
  ggtitle("Performance of Different Algorithms")
ggsave("r/graphs/comparisons_average_reward.pdf")

# Plot frequency of selecting correct arm as a function of time.
# In this instance, 5 is the correct arm.
stats <- ddply(results,
               c("Algorithm", "T"),
               function (df) {mean(df$ChosenArm == 5)})
ggplot(stats, aes(x = T, y = V1, group = Algorithm, color = Algorithm)) +
  geom_line() +
  ylim(0, 1) +
  xlab("Time") +
  ylab("Probability of Selecting Best Arm") +
  ggtitle("Accuracy of Different Algorithms")
ggsave("r/graphs/comparisons_average_accuracy.pdf")

# Plot variance of chosen arms as a function of time.
stats <- ddply(results,
               c("Algorithm", "T"),
               function (df) {var(df$ChosenArm)})
ggplot(stats, aes(x = T, y = V1, group = Algorithm, color = Algorithm)) +
  geom_line() +
  xlab("Time") +
  ylab("Variance of Chosen Arm") +
  ggtitle("Variability of Different Algorithms")
ggsave("r/graphs/comparisons_variance_choices.pdf")

# Plot cumulative reward as a function of time.
stats <- ddply(results,
               c("Algorithm", "T"),
               function (df) {mean(df$CumulativeReward)})
ggplot(stats, aes(x = T, y = V1, group = Algorithm, color = Algorithm)) +
  geom_line() +
  xlab("Time") +
  ylab("Cumulative Reward of Chosen Arm") +
  ggtitle("Cumulative Reward of Different Algorithms")
ggsave("r/graphs/comparisons_cumulative_reward.pdf")
