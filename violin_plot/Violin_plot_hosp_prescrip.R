#Code for the violin plot using prescription data from the hospital
#prescription in January 2022
#source file is here https://www.nhsbsa.nhs.uk/prescription-data/prescribing-data/hospital-prescribing-dispensed-community

#I made the data transformation before obtaining final data set for plotting
#I have found which prescriptions are the most common this month grouped by BNF chapter

# LIBRARIES ----

library(ggdist)
library(tidyquant)
library(tidyverse)

# DATA -----
bnf_chapter_cost_3_top_tbl <-   read.csv("3top_prescribe_chapt_01_2022")

# VIOLIN PLOT ----
p <- bnf_chapter_cost_3_top_tbl%>% 
    #I want to plot the violin plot and the boxplot of the distribution for the actual cost in those categories
    ggplot(aes(x = factor(BNF.CHAPTER.CODE), y = TOTAL.ACTUAL.COST, fill = factor(BNF.CHAPTER.DESCRPT))) +
    
    geom_violin(trim=FALSE, alpha = 0.25) +
    scale_y_continuous(trans='log2') 

p +    geom_boxplot(width=0.1) +
    
    # Adjust theme
    scale_fill_tq() +
    theme_tq() +
    labs(
        title = "Violin Plot",
        subtitle = "Showing the distribution of actual cost of prescribed items by BNF chapter code",
        x = "BNF Chapter (3 top categories)",
        y = "Actual cost per item (£)",
        fill = "BNF Chapter"
    ) +
    
    geom_boxplot(
        width = .12,
        ## remove outliers
        outlier.color = NA,
        alpha = 0.5
    ) 