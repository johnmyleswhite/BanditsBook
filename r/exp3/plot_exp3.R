library("plyr")
library("ggplot2")

results <- read.csv("julia/algorithms/exp3/exp3_results.csv", header = FALSE)
names(results) <- c("Gamma", "Sim", "T", "ChosenArm", "Reward", "CumulativeReward")
results <- transform(results, Gamma = factor(Gamma))

# Plot average reward as a function of time.
stats <- ddply(results,
               c("Gamma", "T"),
               function (df) {mean(df$Reward)})
ggplot(stats, aes(x = T, y = V1, group = Gamma, color = Gamma)) +
  geom_line() +
  ylim(0, 1) +
  xlab("Time") +
  ylab("Average Reward") +
  ggtitle("Performance of the Exp3 Algorithm")
ggsave("r/graphs/exp3_average_reward.pdf")

# Plot frequency of selecting correct arm as a function of time.
# In this instance, 5 is the correct arm.
stats <- ddply(results,
               c("Gamma", "T"),
               function (df) {mean(df$ChosenArm == 5)})
ggplot(stats, aes(x = T, y = V1, group = Gamma, color = Gamma)) +
  geom_line() +
  ylim(0, 1) +
  xlab("Time") +
  ylab("Probability of Selecting Best Arm") +
  ggtitle("Accuracy of the Exp3 Algorithm")
ggsave("r/graphs/exp3_average_accuracy.pdf")

# Plot variance of chosen arms as a function of time.
stats <- ddply(results,
               c("Gamma", "T"),
               function (df) {var(df$ChosenArm)})
ggplot(stats, aes(x = T, y = V1, group = Gamma, color = Gamma)) +
  geom_line() +
  xlab("Time") +
  ylab("Variance of Chosen Arm") +
  ggtitle("Variability of the Exp3 Algorithm")
ggsave("r/graphs/exp3_variance_choices.pdf")

# Plot cumulative reward as a function of time.
stats <- ddply(results,
               c("Gamma", "T"),
               function (df) {mean(df$CumulativeReward)})
ggplot(stats, aes(x = T, y = V1, group = Gamma, color = Gamma)) +
  geom_line() +
  xlab("Time") +
  ylab("Cumulative Reward of Chosen Arm") +
  ggtitle("Cumulative Reward of the Exp3 Algorithm")
ggsave("r/graphs/exp3_cumulative_reward.pdf")
