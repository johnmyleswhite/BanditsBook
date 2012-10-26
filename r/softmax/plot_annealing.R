library("plyr")
library("ggplot2")

results <- read.csv("julia/algorithms/softmax/annealing_softmax_results.csv", header = FALSE)
names(results) <- c("Sim", "T", "ChosenArm", "Reward", "CumulativeReward")

# Plot average reward as a function of time.
stats <- ddply(results,
               c("T"),
               function (df) {mean(df$Reward)})
ggplot(stats, aes(x = T, y = V1)) +
  geom_line() +
  ylim(0, 1) +
  xlab("Time") +
  ylab("Average Reward") +
  ggtitle("Performance of the Annealing Softmax Algorithm")
ggsave("r/graphs/annealing_softmax_average_reward.pdf")

# Plot frequency of selecting correct arm as a function of time.
# In this instance, 5 is the correct arm.
stats <- ddply(results,
               c("T"),
               function (df) {mean(df$ChosenArm == 5)})
ggplot(stats, aes(x = T, y = V1)) +
  geom_line() +
  ylim(0, 1) +
  xlab("Time") +
  ylab("Probability of Selecting Best Arm") +
  ggtitle("Accuracy of the Annealing Softmax Algorithm")
ggsave("r/graphs/annealing_softmax_average_accuracy.pdf")

# Plot variance of chosen arms as a function of time.
stats <- ddply(results,
               c("T"),
               function (df) {var(df$ChosenArm)})
ggplot(stats, aes(x = T, y = V1)) +
  geom_line() +
  xlab("Time") +
  ylab("Variance of Chosen Arm") +
  ggtitle("Variability of the Annealing Softmax Algorithm")
ggsave("r/graphs/annealing_softmax_variance_choices.pdf")

# Plot cumulative reward as a function of time.
stats <- ddply(results,
               c("T"),
               function (df) {mean(df$CumulativeReward)})
ggplot(stats, aes(x = T, y = V1)) +
  geom_line() +
  xlab("Time") +
  ylab("Cumulative Reward of Chosen Arm") +
  ggtitle("Cumulative Reward of the Annealing Softmax Algorithm")
ggsave("r/graphs/annealing_softmax_cumulative_reward.pdf")
