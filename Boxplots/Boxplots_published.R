#Script for the boxplots
library(ggplot2)
library(tidyverse)

#load the data
test <- read.csv("test.csv", header=T)
#normal values for the parameters
hline.d <- read.csv("hline.csv", header = FALSE) 
colnames(hline.d)[1]<- c("biologic_exam_label")

#three boxplots with boundaries for the "normal values"
ggplot(test, aes(y = raw_value, fill = sex)) +
  geom_boxplot(alpha=0.6) +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_blank(), strip.background = element_blank(),
        strip.placement = "outside") +
  labs(
    x = NULL,
    y = NULL,
    fill = "Gender",
    subtitle = "Distribution of top three most common blood tests result by gender",
    caption = "Data: Cegedim Health Data; Illustration: Olena Thomson"
  ) +
  facet_wrap(~ biologic_exam_label, scales = "free_y",
             labeller = as_labeller(
               c(Potassium = "Potassium (mmol/L)",  `Serum creatinine` = "Serum creatinine (µmol/L)", Sodium = "Sodium (mmol/L)")), 
             strip.position = "left") +
  geom_hline(data= hline.d, aes(yintercept=V2), 
             linetype="dashed", colour = "grey", size = 0.8)