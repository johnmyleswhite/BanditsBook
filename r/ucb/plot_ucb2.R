library("plyr")
library("ggplot2")

data.files <- c(
  "python/algorithms/ucb/ucb2_results_0.1.tsv",
  "python/algorithms/ucb/ucb2_results_0.3.tsv",
  "python/algorithms/ucb/ucb2_results_0.5.tsv",
  "python/algorithms/ucb/ucb2_results_0.9.tsv",
  "python/algorithms/ucb/ucb2_results_0.9.tsv"
)

results <- llply(data.files, function(x){z <- read.csv(x, header=F, sep="\t"); names(z)=c("Sim", "T", "ChosenArm", "Reward", "CumulativeReward", "Alpha"); return(z)})
results <- ldply(results)

results$Alpha <- factor(results$Alpha)

# Plot average reward as a function of time.
stats <- ddply(idata.frame(results),
               c("T", "Alpha"),
               function (df) {mean(df$Reward)})
ggplot(stats, aes(x = T, y = V1, color=Alpha)) +
    geom_line() +
    ylim(0, 1) +
    xlab("Time") +
    ylab("Average Reward") +
    opts(title="Performance of the UCB2 Algorithm")
ggsave("r/graphs/ucb2_average_reward.pdf")

# Plot frequency of selecting correct arm as a function of time.
# In this instance, 1 is the correct arm.
stats <- ddply(idata.frame(results),
               c("T", "Alpha"),
               function (df) {mean(df$ChosenArm == 1)})
ggplot(stats, aes(x = T, y = V1, color=Alpha)) +
    geom_line() +
    ylim(0, 1) +
    xlab("Time") +
    ylab("Probability of Selecting Best Arm") +
    opts(title="Accuracy of the UCB2 Algorithm")
ggsave("r/graphs/ucb2_average_accuracy.pdf")

# Plot variance of chosen arms as a function of time.
stats <- ddply(idata.frame(results),
               c("T", "Alpha"),
               function (df) {var(df$ChosenArm)})
ggplot(stats, aes(x = T, y = V1, color=Alpha)) +
    geom_line() +
    xlab("Time") +
    ylab("Variance of Chosen Arm") +
    opts(title="Variability of the UCB2 Algorithm")
ggsave("r/graphs/ucb2_variance_choices.pdf")

# Plot cumulative reward as a function of time.
stats <- ddply(idata.frame(results),
               c("T", "Alpha"),
               function (df) {mean(df$CumulativeReward)})
ggplot(stats, aes(x = T, y = V1, color=Alpha)) +
    geom_line() +
    xlab("Time") +
    ylab("Cumulative Reward of Chosen Arm") +
    opts(title="Cumulative Reward of the UCB2 Algorithm")
ggsave("r/graphs/ucb2_cumulative_reward.pdf")
