#How to generate a wordcloud
#idea and script from here https://www.youtube.com/watch?v=Igsvev-fr_k

# Install packages ----
install.packages( "wordcloud")
install.packages( "RColorBrewer")

# Load libraries ----

library(wordcloud)
library(RColorBrewer)

# Text data for word cloud ----
words <-  c("R ", "Python", "Data Science", "Machine Learning", "Data",
           "Daft", "Visualization", "Plot", "Keywords", "Fun",
           "Colour", "ggplot2", "YouTube", "Channel", "Text",
           "NLP", "Deep Learning", "Predictive Modeling", "Analytics",
           "Learn", "Video", "Teach", "Help", "Interesting", "Word", "Cloud",
           "Histogram", "Scatterplot", "Bar Plot", "Density", "Lollipop Chart", 
           "tidyverse ", "tidyquant", "tidyr", "forcats", "readr", "stringr", "purr", "tibble")

# Word frequencies -----
freqs <-  c(100, 60, 90, 50, 80, 20, 30, 30, 
           10, 70, 40, 20, 15, 15,  5, 20,
           15, 25, 35, 50, 30, 20, 30, 50, 
           20, 20, 15, 25, 25, 5, 10, 
           50, 25, 65, 45, 15, 35, 40, 20)

set.seed(3)

# Generate word cloud ----

wordcloud(words = words,
          freq = freqs,
          max.words = 100,
          colors = brewer.pal(8,"Dark2"))