library("plyr")
library("ggplot2")

exp3.results <- read.csv("julia/env_demo.csv", header = FALSE)
names(exp3.results) <- c("Gamma", "Sim", "T", "ChosenArm", "Reward", "CumulativeReward")
exp3.results <- transform(exp3.results, Algorithm = paste(Gamma, "-Exp3", sep = ""))

# Plot average reward as a function of time.
stats <- ddply(exp3.results,
               c("Algorithm", "T"),
               function (df) {mean(df$Reward)})
ggplot(stats, aes(x = T, y = V1, group = Algorithm, color = Algorithm)) +
  geom_line() +
  ylim(0, 1) +
  xlab("Time") +
  ylab("Average Reward") +
  ggtitle("Performance of Different Algorithms")
ggsave("r/graphs/env_demo_average_reward.pdf")

# Plot cumulative reward as a function of time.
stats <- ddply(exp3.results,
               c("Algorithm", "T"),
               function (df) {mean(df$CumulativeReward)})
ggplot(stats, aes(x = T, y = V1, group = Algorithm, color = Algorithm)) +
  geom_line() +
  xlab("Time") +
  ylab("Cumulative Reward of Chosen Arm") +
  ggtitle("Cumulative Reward of Different Algorithms")
ggsave("r/graphs/env_demo_cumulative_reward.pdf")
